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