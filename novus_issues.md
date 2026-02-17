# novus compiler issues

a list of bugs and quirks ive found in the novus compiler while building golemmc. these are things that tripped me up and had to work around, figured id write em down so they can get fixed at some point.

## 1. overloaded functions dont link across modules

**STATUS: PARTIALLY FIXED in V0.1.1** - basic overloading works now (like `int_to_str(i32)` vs `int_to_str(i64)`), but calling `int_to_str()` with certain types still gives "undefined function". specifically, calling `int_to_str` with what the compiler considers a different type variant still fails.

**workaround**: still using unique names like `i32_to_str()` and `i64_to_str()` to be safe.

## 2. cross-module globals generate bad assembly

**STATUS: FIXED in V0.1.1** - globals in imported modules now generate proper memory load/store instructions. tested and confirmed working.

## 3. main module globals cant be used inside functions

**STATUS: FIXED in V0.1.1** - top-level `let` variables in the main module file are now accessible from functions. tested and confirmed working.

## 4. diamond imports can OOM the compiler

**STATUS: FIXED in V0.1.1** - same module imported from multiple paths no longer causes OOM. compiler properly deduplicates. compile time went from 20s+ (with eventual OOM) to ~0.7s.

## 5. syscall error codes not accessible on macOS ARM64

**STATUS: REPORTEDLY FIXED in V0.1.1** - `getflag()` should work now but i havent tested it yet. will update once confirmed.

this isnt really a compiler bug but more of a missing feature. on macOS ARM64, syscalls indicate errors by setting the carry flag in NZCV, and putting the errno in x0. the `getflag()` builtin exists in the docs but the ARM64 flag names werent recognised. so theres no way to check if a syscall failed or succeeded when the return value could be either a valid result or an errno.

**workaround**: use syscalls where success and failure return values dont overlap.

**expected behaviour**: `getflag(c)` or similar should work on ARM64 to read the carry flag after a syscall.

## 6. no bitwise operations

**STATUS: FIXED in V0.1.1** - `&`, `|`, `<<`, `>>` all work correctly now. tested with protocol code (VarInt encoding, binary packing, etc). massive W for systems programming.

## 7. no inline assembly

**STATUS: BY DESIGN** - the user confirmed this isnt a bug, its just not how novus is designed. assembly-level stuff should go in library files instead.

## 8. null bytes in strings get corrupted

**STATUS: OPEN** - when you build a string by concatenating null bytes (`buf = buf + "\0"`), the resulting string doesnt reliably contain zeroes at every position. the `net_make_buf()` function does `buf = buf + "\0"` in a loop to create a zero-filled buffer, but when you later index into it, some positions that should be zero read back as non-zero values (we saw them come back as 0x07 consistently). this caused every embedded binary payload in our server to be silently corrupted at null byte positions.

**workaround**: dont rely on zero-initialization. explicitly set EVERY byte in the buffer, including the ones that should be zero. this adds more lines of code but guarantees correctness.

## 9. string operations corrupt other buffers in memory

**STATUS: OPEN** - when you allocate a buffer with `net_make_buf()` and then later do string concatenation operations (like building a debug log message with `"prefix " + i32_to_str(x) + " suffix"`), the concatenation can overwrite memory belonging to previously allocated buffers. we found this when debug logging inside chunk data building - the log message text literally appeared inside our chunk data buffer, corrupting the binary data we were carefully constructing.

**workaround**: avoid ALL string operations (concatenation, `log_debug` with `+`, `i32_to_str`, etc) while you have live buffers that you're still writing to. do all your logging/string work BEFORE or AFTER the buffer building, never during. if you absolutely need debug output during buffer operations, use a separate pre-built static string instead of concatenation.

## 10. bit shift operations dont sign-extend on 64-bit architecture

**STATUS: OPEN** - when you do `(255 << 24)` in an i32 variable, the result should be `0xFF000000` which is `-16777216` as a signed 32-bit integer. but novus seems to treat this as `0x00000000FF000000` (unsigned 64-bit), giving `4278190080` instead. this means reconstructing signed 32-bit values from individual bytes using shifts and OR doesnt produce negative numbers - `0xFFFFFFFF` comes out as `4294967295` instead of `-1`.

**workaround**: after reconstructing a value from bytes, check if the high bit is set (byte 0 >= 128) and manually subtract 2^32 to get the correct signed value: `result = result - 2147483647 - 2147483647 - 2`.

## 11. net_make_buf corrupts previously allocated heap strings

**STATUS: OPEN** - calling `net_make_buf()` (which does O(n) string concatenations internally) can corrupt the memory of PREVIOUSLY allocated strings that are still in use. this is different from bug #9 - its not about concurrent string ops on the same buffer, its about allocating a NEW buffer corrupting OLD ones.

specifically: if you allocate a 262KB buffer A at startup, then later during gameplay allocate a 140KB buffer B with `net_make_buf()`, the intermediate strings created during B's allocation can overwrite bytes in A. we confirmed this by observing that the seed value (stored at bytes 8-11 of buffer A) was getting corrupted after buffer B was allocated, causing terrain generation to return wrong block types.

**workaround**: pre-allocate ALL large buffers at startup before any gameplay begins. pass them as function parameters instead of allocating inside functions. for values that must survive heap corruption (like world seed), store them in i32 stack variables instead of in heap buffers, since stack variables are immune to this corruption.

## 12. str_to_i32 doesnt handle overflow gracefully

**STATUS: OPEN** - when parsing a string like `"1771329710651061000"` which is way larger than INT32_MAX (2147483647), `str_to_i32` silently clamps or wraps to some value instead of returning an error. this means world seeds larger than ~2.1 billion all map to the same internal value, reducing the effective seed space.

**workaround**: document that world seeds should be kept within i32 range (-2147483648 to 2147483647). alternatively could hash the string to produce a valid i32 seed.

## 13. i32 arithmetic doesnt truncate to 32 bits

**STATUS: OPEN** - novus compiles i32 variables to 64-bit ARM64 registers (x0-x28). when you multiply two i32 values that would overflow 32 bits (like `x * 374761393`), the result is a full 64-bit value - it doesnt wrap/truncate at 32 bits like a real int32 would. this means hash functions and any math relying on 32-bit overflow wrapping produce completely wrong results.

for example: `terrain_hash(0, 0, 12345)` returned `15727716263813` (a 44-bit number) instead of the expected 32-bit result. right-shifting this 64-bit value by 13 or 16 bits operates on the wrong bit range, producing garbage.

**workaround**: manually truncate to 32 bits after every multiply that could overflow. we wrote a `trunc32()` function that extracts the lower 32 bits: `lo = val & 65535; hi = (val >> 16) & 65535; result = (hi << 16) | lo`. for sign extension when the result should be negative: `if (hi >= 32768) { result = result - 2147483647 - 2147483647 - 2; }`.

**expected behaviour**: i32 operations should automatically mask results to 32 bits, or the compiler should use w-registers (w0-w28) instead of x-registers for i32 values.

## 14. variable names collide with ARM64 register names

**STATUS: OPEN** - if you name a local variable `x1`, `x2`, etc (matching ARM64 register names x0-x30), the compiler silently uses the actual hardware register instead of allocating stack/register storage properly. this means the variable shares storage with whatever the compiler is using that register for, causing completely wrong computation results with no error message.

the compiler DOES reject `x1`/`x2` as variable names in the main module (gives "cannot declare variable with reserved name" error), but it SILENTLY ACCEPTS them inside functions in imported modules. the function compiles and runs but produces garbage results because reads/writes go to the raw register instead of proper variable storage.

we had `let x1: i32 = lerp(g00, g10, u);` inside `noise2d()` in an imported module. it compiled fine but `noise2d` returned wildly wrong values. renaming to `lp1` fixed it instantly.

**workaround**: never use register names (x0-x30, w0-w30, sp, lr, fp, etc) as variable names anywhere. if the compiler doesnt give you an error, that doesnt mean its safe - it might silently use the register.

**expected behaviour**: the compiler should ALWAYS reject reserved register names as variable names, in ALL modules and ALL scopes, with a clear error message.