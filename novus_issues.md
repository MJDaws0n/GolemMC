# novus compiler issues

a list of bugs and quirks found in the novus compiler while building golemmc. these are things that tripped me up and had to work around, figured id write em down so they can get fixed at some point.

all issues were re-tested against **Novus V0.1.1** on 2026-02-25 using automated test suite (`tests/test_all.nov`).

---

## 1. overloaded functions dont link across modules

**STATUS: FIXED ✅** (confirmed V0.1.1) - basic overloading works now. `int_to_str(i32)` and `int_to_str(i64)` both dispatch correctly across modules. custom overloaded functions (`overload_test(i32)` vs `overload_test(i64)`) also work fine.

previously: calling `int_to_str()` with certain types gave "undefined function". seems to be resolved now.

## 2. cross-module globals generate bad assembly

**STATUS: FIXED ✅** (confirmed V0.1.1) - globals in imported modules now generate proper memory load/store instructions.

## 3. main module globals cant be used inside functions

**STATUS: FIXED ✅** (confirmed V0.1.1) - top-level `let` variables in the main module file are now accessible from functions.

## 4. diamond imports can OOM the compiler

**STATUS: FIXED ✅** (confirmed V0.1.1) - same module imported from multiple paths no longer causes OOM. compiler properly deduplicates. compile time went from 20s+ to ~0.7s.

## 5. syscall error codes not accessible on macOS ARM64

**STATUS: FIXED ✅** (confirmed V0.1.1) - `file_exists()` now correctly returns `false` for missing files and `true` for existing ones. the underlying syscall error detection (carry flag / errno) appears to be working.

previously: `getflag()` didnt work on ARM64 so there was no way to check if a syscall failed.

## 6. no bitwise operations

**STATUS: FIXED ✅** (confirmed V0.1.1) - `&`, `|`, `<<`, `>>` all work correctly. tested with `(255 & 15) | (3 << 8) = 783` and `256 >> 4 = 16`.

## 7. no inline assembly

**STATUS: BY DESIGN** - not a bug. assembly-level stuff should go in library files instead.

## 8. null bytes in strings get corrupted

**STATUS: FIXED ✅** (confirmed V0.1.1) - building strings with `"\0"` concatenation now correctly preserves zero bytes at all positions. `net_make_buf(16)` also returns a properly zeroed buffer. all 16 positions verified as zero.

previously: bytes came back as 0x07 instead of 0x00.

## 9. string operations corrupt other buffers in memory

**STATUS: FIXED ✅** (confirmed V0.1.1) - allocating a buffer, writing a pattern (0xAA), then doing heavy string concatenation (`i32_to_str`, multiple `+` chains) does NOT corrupt the buffer. all 8 sentinel bytes remained 170 after the concat.

previously: string concat would overwrite memory belonging to previously allocated buffers.

## 10. bit shift operations dont sign-extend on 64-bit architecture

**STATUS: STILL OPEN ❌**

test results:
- `255 << 24` = **4278190080** (expected -16777216)
- `255 | (255 << 8) | (255 << 16) | (255 << 24)` = **4294967295** (expected -1)

the compiler treats shift results as unsigned 64-bit values. `0xFF000000` comes out as `4278190080` instead of `-16777216`. reconstructing signed i32 values from individual bytes using shifts + OR doesnt produce negative numbers.

**workaround**: after reconstructing a value from bytes, check if bit 31 is set and manually subtract 2^32:
```
if (high_byte >= 128) { result = result - 2147483647 - 2147483647 - 2; }
```

**expected behaviour**: `i32` shift results should be sign-extended to maintain signed semantics, OR the compiler should use w-registers for i32 ops which naturally truncate to 32 bits.

## 11. net_make_buf corrupts previously allocated heap strings

**STATUS: FIXED ✅** (confirmed V0.1.1) - allocating bufA (256 bytes), writing a pattern, then allocating bufB (512 bytes) does NOT corrupt bufA. also tested with larger sizes (4KB + 8KB) - no corruption detected.

previously: allocating a new buffer would corrupt the memory of previously allocated strings.

## 12. str_to_i32 doesnt handle overflow gracefully

**STATUS: STILL OPEN ❌** (behaviour changed - now clamps)

test results:
- `str_to_i32("1771329710651061000")` = **2147483647** (INT32_MAX)
- `str_to_i32("9999999999")` = **2147483647** (INT32_MAX)
- `str_to_i32("2147483647")` = **2147483647** ✅ (correct)
- `str_to_i32("-123")` = **-123** ✅ (correct)

any string value exceeding INT32_MAX silently clamps to 2147483647. this means ALL oversized seeds map to the same value, which is worse than wrapping since it reduces the effective seed space to zero for large seeds.

**workaround**: keep values within i32 range. for world seeds, could hash the string to produce a valid i32, or use `str_to_i64()` instead and handle the range manually.

**expected behaviour**: either return an error/flag, or wrap around (modular arithmetic), or at minimum different overflow inputs should produce different outputs.

## 13. i32 arithmetic doesnt truncate to 32 bits

**STATUS: STILL OPEN ❌**

test results:
- `100000 * 100000` = **10000000000** (expected 1410065408 after 32-bit wrap)
- `12345 * 374761393` = **4626429396585** (expected 749618793 after 32-bit wrap)

novus compiles i32 to 64-bit ARM64 x-registers. multiplications produce full 64-bit results with no truncation. hash functions and any math relying on 32-bit overflow wrapping produce wrong results.

**workaround**: manually truncate after every overflow-prone multiply:
```novus
fn trunc32(val: i32) -> i32 {
    let lo: i32 = val & 65535;
    let hi: i32 = (val >> 16) & 65535;
    let result: i32 = (hi << 16) | lo;
    if (hi >= 32768) {
        result = result - 2147483647 - 2147483647 - 2;
    }
    return result;
}
```

**expected behaviour**: i32 operations should automatically mask results to 32 bits, or the compiler should use w-registers (w0-w28) instead of x-registers.

## 14. variable names collide with ARM64 register names

**STATUS: STILL OPEN ❌**

test results:
- function with `let x1: i32 = 10; let x2: i32 = 20; return x1 + x2;` returns **58** instead of 30

the compiler silently lets you use `x1`, `x2` etc as variable names inside imported module functions. it compiles without error but the variable reads/writes hit the actual hardware registers instead of proper stack storage. x1 and x2 happen to contain whatever values the calling code left there, so the result is garbage.

the compiler DOES reject these names in the main module but NOT in imported modules.

**workaround**: never use `x0`-`x30`, `w0`-`w30`, `sp`, `lr`, `fp`, `d0`-`d31`, `s0`-`s31`, `q0`-`q31`, `v0`-`v31` as variable names anywhere.

**expected behaviour**: the compiler should reject reserved register names as variable names in ALL modules and ALL scopes, with a clear error message.

## 15. 6th+ function parameter emitted as raw assembly symbol

**STATUS: FIXED ✅** (confirmed V0.1.1)

test results:
- `six_params(1,2,3,4,5,6)` = **21** ✅
- `seven_params(1,2,3,4,5,6,7)` = **28** ✅

both 6-param and 7-param functions now work correctly. the parameter names are properly resolved to their register/stack locations.

previously: the 6th+ parameter name was emitted raw into assembly, causing assembler errors.

**note**: the original GolemMC bug with `send_play_login` having 6 params may have been a different issue (possibly interaction with specific parameter names or types). the basic integer case now works fine.

---

## summary

| # | issue | status |
|---|-------|--------|
| 1 | overloaded functions across modules | **FIXED** ✅ |
| 2 | cross-module globals bad asm | **FIXED** ✅ |
| 3 | main module globals in functions | **FIXED** ✅ |
| 4 | diamond imports OOM | **FIXED** ✅ |
| 5 | syscall error flags | **FIXED** ✅ |
| 6 | bitwise operations | **FIXED** ✅ |
| 7 | inline assembly | **BY DESIGN** |
| 8 | null bytes in strings | **FIXED** ✅ |
| 9 | string ops corrupt buffers | **FIXED** ✅ |
| 10 | bit shift sign extension | **OPEN** ❌ |
| 11 | net_make_buf corrupts old allocs | **FIXED** ✅ |
| 12 | str_to_i32 overflow handling | **OPEN** ❌ |
| 13 | i32 arithmetic no 32-bit truncation | **OPEN** ❌ |
| 14 | variable names = ARM64 register names | **OPEN** ❌ |
| 15 | 6th+ function parameter | **FIXED** ✅ |

**11 fixed / 4 still open**

---

## 16. f64 type generates integer assembly (BROKEN)

**STATUS: FIXED ✅**

~~the `f64` type is accepted by the compiler syntax-wise but generates completely wrong code.~~

**fixed**: the compiler now generates proper ARM64 floating-point instructions. float literals store IEEE 754 bit patterns, arithmetic uses `fadd`/`fsub`/`fmul`/`fdiv` with `d` registers, comparisons use `fcmp`. new builtins added: `i64_to_f64()`, `f64_to_i64()`, `f64_bits()`, `f64_from_bits()`.

```novus
let a: f64 = 3.14;         // now: movz/movk with correct IEEE 754 bits
let b: f64 = 2.0;          // now: movz/movk 0x4000000000000000
let c: f64 = a + b;        // now: fmov d1,x11; fmov d2,x12; fadd d0,d1,d2
let d: f64 = a * b;        // now: fmul d0, d1, d2
let n: i64 = f64_to_i64(c); // now: fmov d0,x11; fcvtzs x10,d0
let f: f64 = i64_to_f64(42); // now: scvtf d0, x11; fmov x10, d0
```

**verified**: `3.14 * 100.0 = 314`, `3.14 + 2.0 = 5` (truncated), comparisons work, negation works.

still missing from stdlib: `f64_to_str()`, `sin()`, `cos()`, `sqrt()`, `floor()` — feature requests not bugs.

---

## updated summary

| # | issue | status |
|---|-------|--------|
| 1 | overloaded functions across modules | **FIXED** ✅ |
| 2 | cross-module globals bad asm | **FIXED** ✅ |
| 3 | main module globals in functions | **FIXED** ✅ |
| 4 | diamond imports OOM | **FIXED** ✅ |
| 5 | syscall error flags | **FIXED** ✅ |
| 6 | bitwise operations | **FIXED** ✅ |
| 7 | inline assembly | **BY DESIGN** |
| 8 | null bytes in strings | **FIXED** ✅ |
| 9 | string ops corrupt buffers | **FIXED** ✅ |
| 10 | bit shift sign extension | **OPEN** ❌ |
| 11 | net_make_buf corrupts old allocs | **FIXED** ✅ |
| 12 | str_to_i32 overflow handling | **OPEN** ❌ |
| 13 | i32 arithmetic no 32-bit truncation | **OPEN** ❌ |
| 14 | variable names = ARM64 register names | **OPEN** ❌ |
| 15 | 6th+ function parameter | **FIXED** ✅ |
| 16 | f64 generates integer assembly | **FIXED** ✅ |

**12 fixed / 4 still open**
