.section __DATA,__data
.p2align 3
__str_0:
    .asciz ""
__str_0_len:
    .quad 0
.p2align 3
__str_1:
    .asciz "0"
__str_1_len:
    .quad 1
.p2align 3
__str_2:
    .asciz "1"
__str_2_len:
    .quad 1
.p2align 3
__str_3:
    .asciz "2"
__str_3_len:
    .quad 1
.p2align 3
__str_4:
    .asciz "3"
__str_4_len:
    .quad 1
.p2align 3
__str_5:
    .asciz "4"
__str_5_len:
    .quad 1
.p2align 3
__str_6:
    .asciz "5"
__str_6_len:
    .quad 1
.p2align 3
__str_7:
    .asciz "6"
__str_7_len:
    .quad 1
.p2align 3
__str_8:
    .asciz "7"
__str_8_len:
    .quad 1
.p2align 3
__str_9:
    .asciz "8"
__str_9_len:
    .quad 1
.p2align 3
__str_10:
    .asciz "9"
__str_10_len:
    .quad 1
.p2align 3
__str_11:
    .asciz "-"
__str_11_len:
    .quad 1
.p2align 3
__str_12:
    .asciz "\n"
__str_12_len:
    .quad 1
.p2align 3
__str_13:
    .asciz "0123456789abcdef"
__str_13_len:
    .quad 16
.p2align 3
__str_14:
    .asciz " "
__str_14_len:
    .quad 1
.p2align 3
__str_15:
    .asciz "Height range: ["
__str_15_len:
    .quad 15
.p2align 3
__str_16:
    .asciz ", "
__str_16_len:
    .quad 2
.p2align 3
__str_17:
    .asciz "]\n"
__str_17_len:
    .quad 2
.p2align 3
__str_18:
    .asciz "Max adjacent diff: "
__str_18_len:
    .quad 19
.p2align 3
__str_19:
    .asciz " at x="
__str_19_len:
    .quad 6
.p2align 3
__str_20:
    .asciz "\nHeights every 4 blocks (x=-48..48, z=0, seed=12345):\n"
__str_20_len:
    .quad 54
.p2align 3
__str_21:
    .asciz "\nseed=12345: "
__str_21_len:
    .quad 13
.p2align 3
__str_22:
    .asciz "\nseed=99999: "
__str_22_len:
    .quad 13
.p2align 3
__str_23:
    .asciz "\nseed=42:    "
__str_23_len:
    .quad 13
.p2align 3
__str_24:
    .asciz "\nHeights at different Z (x=0, z=-48..48, seed=12345):\n"
__str_24_len:
    .quad 54

.lcomm __novus_heap_ptr, 8
.lcomm __novus_heap_end, 8

.section __TEXT,__text
.globl _main
.p2align 2

_str_repeat:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #144
    // function str_repeat
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-24]
    mov x10, #0
    stur x10, [x29, #-32]
.Lwhile_cond_0:
    ldur x10, [x29, #-32]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-48]
    ldur x11, [x29, #-40]
    ldur x12, [x29, #-48]
    cmp x11, x12
    b.ge .Lwhile_end_2
.Lwhile_body_1:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-72]
    ldur x13, [x29, #-64]
    ldur x14, [x29, #-72]
    mov x15, #0
.Lscl1_1:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_1
    add x15, x15, #1
    b .Lscl1_1
.Lscl1d_1:
    mov x9, x15
    mov x15, #0
.Lscl2_1:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_1
    add x15, x15, #1
    b .Lscl2_1
.Lscl2d_1:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_1:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_1
    strb w16, [x11], #1
    b .Lsc1_1
.Lsc2_1:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_1
    mov x10, x12
    stur x10, [x29, #-80]
    stur x10, [x29, #-24]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-88]
    mov x11, x10
    add x10, x11, #1
    stur x10, [x29, #-96]
    stur x10, [x29, #-32]
    b .Lwhile_cond_0
.Lwhile_end_2:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-104]
    mov x0, x10
    add sp, sp, #144
    ldp x29, x30, [sp], #16
    ret

_char_eq:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #112
    // function char_eq
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-32]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-40]
    ldur x13, [x29, #-32]
    ldur x14, [x29, #-40]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-56]
    mov x13, x10
    mov x14, #0
    ldrb w10, [x13, x14]
    stur x10, [x29, #-64]
    ldur x11, [x29, #-48]
    ldur x12, [x29, #-64]
    cmp x11, x12
    cset x10, eq
    stur x10, [x29, #-72]
    mov x0, x10
    add sp, sp, #112
    ldp x29, x30, [sp], #16
    ret

_len:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #128
    // function len
    stur x0, [x29, #-8]
    mov x10, #0
    stur x10, [x29, #-16]
    mov x10, #0
    stur x10, [x29, #-24]
.Lwhile_cond_3:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-32]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-40]
    ldur x13, [x29, #-32]
    ldur x14, [x29, #-40]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-48]
    mov x11, x10
    cmp x11, #0
    b.eq .Lwhile_end_5
.Lwhile_body_4:
    ldur x10, [x29, #-16]
    stur x10, [x29, #-64]
    mov x11, x10
    add x10, x11, #1
    stur x10, [x29, #-72]
    stur x10, [x29, #-16]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-80]
    mov x11, x10
    add x10, x11, #1
    stur x10, [x29, #-88]
    stur x10, [x29, #-24]
    b .Lwhile_cond_3
.Lwhile_end_5:
    ldur x10, [x29, #-16]
    stur x10, [x29, #-96]
    mov x0, x10
    add sp, sp, #128
    ldp x29, x30, [sp], #16
    ret

_str_to_i32:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1024
    // function str_to_i32
    stur x0, [x29, #-8]
    mov x10, #0
    stur x10, [x29, #-16]
.Lwhile_cond_6:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-72]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-80]
    ldur x13, [x29, #-72]
    ldur x14, [x29, #-80]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-88]
    mov x11, x10
    cmp x11, #32
    cset x10, eq
    stur x10, [x29, #-96]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-104]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-112]
    ldur x13, [x29, #-104]
    ldur x14, [x29, #-112]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-120]
    mov x11, x10
    cmp x11, #9
    cset x10, eq
    stur x10, [x29, #-128]
    ldur x11, [x29, #-96]
    ldur x12, [x29, #-128]
    orr x10, x11, x12
    stur x10, [x29, #-136]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-144]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-152]
    ldur x13, [x29, #-144]
    ldur x14, [x29, #-152]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-160]
    mov x11, x10
    cmp x11, #10
    cset x10, eq
    stur x10, [x29, #-168]
    ldur x11, [x29, #-136]
    ldur x12, [x29, #-168]
    orr x10, x11, x12
    stur x10, [x29, #-176]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-184]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-192]
    ldur x13, [x29, #-184]
    ldur x14, [x29, #-192]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-200]
    mov x11, x10
    cmp x11, #13
    cset x10, eq
    stur x10, [x29, #-208]
    ldur x11, [x29, #-176]
    ldur x12, [x29, #-208]
    orr x10, x11, x12
    stur x10, [x29, #-216]
    cbz x10, .Lwhile_end_8
.Lwhile_body_7:
    ldur x10, [x29, #-16]
    stur x10, [x29, #-224]
    mov x11, x10
    add x10, x11, #1
    stur x10, [x29, #-232]
    stur x10, [x29, #-16]
    b .Lwhile_cond_6
.Lwhile_end_8:
    mov x10, #1
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-240]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-248]
    ldur x13, [x29, #-240]
    ldur x14, [x29, #-248]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-256]
    mov x11, x10
    cmp x11, #45
    b.ne .Lelse_9
    mov x11, #0
    sub x10, x11, #1
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x10, [x29, x17]
    stur x10, [x29, #-24]
    ldur x10, [x29, #-16]
    mov x17, #-280
    str x10, [x29, x17]
    mov x17, #-280
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x10, [x29, x17]
    stur x10, [x29, #-16]
    b .Lendif_10
.Lelse_9:
    ldur x10, [x29, #-8]
    mov x17, #-296
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-296
    ldr x13, [x29, x17]
    mov x17, #-304
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-312
    str x10, [x29, x17]
    mov x17, #-312
    ldr x11, [x29, x17]
    cmp x11, #43
    b.ne .Lendif_12
    ldur x10, [x29, #-16]
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x10, [x29, x17]
    stur x10, [x29, #-16]
.Lendif_12:
.Lendif_10:
    mov x10, #0
    stur x10, [x29, #-32]
    mov x10, #0
    stur x10, [x29, #-40]
    movz x10, #65535, lsl #0
    movk x10, #32767, lsl #16
    stur x10, [x29, #-48]
    mov x11, #0
    movz x12, #65535, lsl #0
    movk x12, #32767, lsl #16
    sub x10, x11, x12
    mov x17, #-344
    str x10, [x29, x17]
    mov x17, #-344
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
.Lwhile_cond_13:
    ldur x10, [x29, #-8]
    mov x17, #-360
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-360
    ldr x13, [x29, x17]
    mov x17, #-368
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-376
    str x10, [x29, x17]
    mov x17, #-376
    ldr x11, [x29, x17]
    cmp x11, #0
    b.eq .Lwhile_end_15
.Lwhile_body_14:
    mov x11, #0
    sub x10, x11, #1
    mov x17, #-392
    str x10, [x29, x17]
    mov x17, #-392
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-8]
    mov x17, #-400
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-408
    str x10, [x29, x17]
    mov x17, #-400
    ldr x13, [x29, x17]
    mov x17, #-408
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x11, [x29, x17]
    cmp x11, #48
    b.ne .Lelse_16
    mov x10, #0
    stur x10, [x29, #-64]
    b .Lendif_17
.Lelse_16:
    ldur x10, [x29, #-8]
    mov x17, #-432
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-440
    str x10, [x29, x17]
    mov x17, #-432
    ldr x13, [x29, x17]
    mov x17, #-440
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-448
    ldr x11, [x29, x17]
    cmp x11, #49
    b.ne .Lelse_18
    mov x10, #1
    stur x10, [x29, #-64]
    b .Lendif_19
.Lelse_18:
    ldur x10, [x29, #-8]
    mov x17, #-464
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-464
    ldr x13, [x29, x17]
    mov x17, #-472
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-480
    ldr x11, [x29, x17]
    cmp x11, #50
    b.ne .Lelse_20
    mov x10, #2
    stur x10, [x29, #-64]
    b .Lendif_21
.Lelse_20:
    ldur x10, [x29, #-8]
    mov x17, #-496
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-496
    ldr x13, [x29, x17]
    mov x17, #-504
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-512
    ldr x11, [x29, x17]
    cmp x11, #51
    b.ne .Lelse_22
    mov x10, #3
    stur x10, [x29, #-64]
    b .Lendif_23
.Lelse_22:
    ldur x10, [x29, #-8]
    mov x17, #-528
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-528
    ldr x13, [x29, x17]
    mov x17, #-536
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-544
    str x10, [x29, x17]
    mov x17, #-544
    ldr x11, [x29, x17]
    cmp x11, #52
    b.ne .Lelse_24
    mov x10, #4
    stur x10, [x29, #-64]
    b .Lendif_25
.Lelse_24:
    ldur x10, [x29, #-8]
    mov x17, #-560
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-560
    ldr x13, [x29, x17]
    mov x17, #-568
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-576
    ldr x11, [x29, x17]
    cmp x11, #53
    b.ne .Lelse_26
    mov x10, #5
    stur x10, [x29, #-64]
    b .Lendif_27
.Lelse_26:
    ldur x10, [x29, #-8]
    mov x17, #-592
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-592
    ldr x13, [x29, x17]
    mov x17, #-600
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-608
    str x10, [x29, x17]
    mov x17, #-608
    ldr x11, [x29, x17]
    cmp x11, #54
    b.ne .Lelse_28
    mov x10, #6
    stur x10, [x29, #-64]
    b .Lendif_29
.Lelse_28:
    ldur x10, [x29, #-8]
    mov x17, #-624
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-632
    str x10, [x29, x17]
    mov x17, #-624
    ldr x13, [x29, x17]
    mov x17, #-632
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-640
    str x10, [x29, x17]
    mov x17, #-640
    ldr x11, [x29, x17]
    cmp x11, #55
    b.ne .Lelse_30
    mov x10, #7
    stur x10, [x29, #-64]
    b .Lendif_31
.Lelse_30:
    ldur x10, [x29, #-8]
    mov x17, #-656
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-664
    str x10, [x29, x17]
    mov x17, #-656
    ldr x13, [x29, x17]
    mov x17, #-664
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-672
    str x10, [x29, x17]
    mov x17, #-672
    ldr x11, [x29, x17]
    cmp x11, #56
    b.ne .Lelse_32
    mov x10, #8
    stur x10, [x29, #-64]
    b .Lendif_33
.Lelse_32:
    ldur x10, [x29, #-8]
    mov x17, #-688
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-696
    str x10, [x29, x17]
    mov x17, #-688
    ldr x13, [x29, x17]
    mov x17, #-696
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-704
    str x10, [x29, x17]
    mov x17, #-704
    ldr x11, [x29, x17]
    cmp x11, #57
    b.ne .Lelse_34
    mov x10, #9
    stur x10, [x29, #-64]
    b .Lendif_35
.Lelse_34:
    b .Lwhile_end_15
.Lendif_35:
.Lendif_33:
.Lendif_31:
.Lendif_29:
.Lendif_27:
.Lendif_25:
.Lendif_23:
.Lendif_21:
.Lendif_19:
.Lendif_17:
    mov x10, #1
    stur x10, [x29, #-32]
    ldur x10, [x29, #-24]
    mov x17, #-720
    str x10, [x29, x17]
    mov x17, #-720
    ldr x11, [x29, x17]
    cmp x11, #1
    b.ne .Lelse_36
    ldur x10, [x29, #-40]
    mov x17, #-736
    str x10, [x29, x17]
    mov x17, #-736
    ldr x11, [x29, x17]
    movz x12, #52428, lsl #0
    movk x12, #3276, lsl #16
    cmp x11, x12
    b.le .Lendif_39
    ldur x10, [x29, #-48]
    mov x17, #-752
    str x10, [x29, x17]
    mov x17, #-752
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1024
    ldp x29, x30, [sp], #16
    ret
.Lendif_39:
    ldur x10, [x29, #-40]
    mov x17, #-760
    str x10, [x29, x17]
    mov x17, #-760
    ldr x11, [x29, x17]
    movz x12, #52428, lsl #0
    movk x12, #3276, lsl #16
    cmp x11, x12
    cset x10, eq
    mov x17, #-768
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-776
    str x10, [x29, x17]
    mov x17, #-776
    ldr x11, [x29, x17]
    cmp x11, #7
    cset x10, gt
    mov x17, #-784
    str x10, [x29, x17]
    mov x17, #-768
    ldr x11, [x29, x17]
    mov x17, #-784
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-792
    str x10, [x29, x17]
    mov x17, #-792
    ldr x10, [x29, x17]
    cbz x10, .Lendif_41
    ldur x10, [x29, #-48]
    mov x17, #-800
    str x10, [x29, x17]
    mov x17, #-800
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1024
    ldp x29, x30, [sp], #16
    ret
.Lendif_41:
    ldur x10, [x29, #-40]
    mov x17, #-808
    str x10, [x29, x17]
    mov x17, #-808
    ldr x11, [x29, x17]
    mov x12, #10
    mul x10, x11, x12
    mov x17, #-816
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-824
    str x10, [x29, x17]
    mov x17, #-816
    ldr x11, [x29, x17]
    mov x17, #-824
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-832
    str x10, [x29, x17]
    mov x17, #-832
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
    b .Lendif_37
.Lelse_36:
    ldur x10, [x29, #-40]
    mov x17, #-840
    str x10, [x29, x17]
    mov x11, #0
    movz x12, #52428, lsl #0
    movk x12, #3276, lsl #16
    sub x10, x11, x12
    mov x17, #-848
    str x10, [x29, x17]
    mov x17, #-840
    ldr x11, [x29, x17]
    mov x17, #-848
    ldr x12, [x29, x17]
    cmp x11, x12
    b.ge .Lendif_43
    ldur x10, [x29, #-56]
    mov x17, #-864
    str x10, [x29, x17]
    mov x17, #-864
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1024
    ldp x29, x30, [sp], #16
    ret
.Lendif_43:
    ldur x10, [x29, #-40]
    mov x17, #-872
    str x10, [x29, x17]
    mov x11, #0
    movz x12, #52428, lsl #0
    movk x12, #3276, lsl #16
    sub x10, x11, x12
    mov x17, #-880
    str x10, [x29, x17]
    mov x17, #-872
    ldr x11, [x29, x17]
    mov x17, #-880
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-888
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-896
    str x10, [x29, x17]
    mov x17, #-896
    ldr x11, [x29, x17]
    cmp x11, #8
    cset x10, gt
    mov x17, #-904
    str x10, [x29, x17]
    mov x17, #-888
    ldr x11, [x29, x17]
    mov x17, #-904
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-912
    str x10, [x29, x17]
    mov x17, #-912
    ldr x10, [x29, x17]
    cbz x10, .Lendif_45
    ldur x10, [x29, #-56]
    mov x17, #-920
    str x10, [x29, x17]
    mov x17, #-920
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1024
    ldp x29, x30, [sp], #16
    ret
.Lendif_45:
    ldur x10, [x29, #-40]
    mov x17, #-928
    str x10, [x29, x17]
    mov x17, #-928
    ldr x11, [x29, x17]
    mov x12, #10
    mul x10, x11, x12
    mov x17, #-936
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-944
    str x10, [x29, x17]
    mov x17, #-936
    ldr x11, [x29, x17]
    mov x17, #-944
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-952
    str x10, [x29, x17]
    mov x17, #-952
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
.Lendif_37:
    ldur x10, [x29, #-16]
    mov x17, #-960
    str x10, [x29, x17]
    mov x17, #-960
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-968
    str x10, [x29, x17]
    mov x17, #-968
    ldr x10, [x29, x17]
    stur x10, [x29, #-16]
    b .Lwhile_cond_13
.Lwhile_end_15:
    ldur x10, [x29, #-32]
    mov x17, #-976
    str x10, [x29, x17]
    mov x17, #-976
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ne .Lendif_47
    mov x0, #0
    add sp, sp, #1024
    ldp x29, x30, [sp], #16
    ret
.Lendif_47:
    ldur x10, [x29, #-40]
    mov x17, #-992
    str x10, [x29, x17]
    mov x17, #-992
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1024
    ldp x29, x30, [sp], #16
    ret

_int_to_str.i32:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #656
    // function int_to_str
    stur x0, [x29, #-8]
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-16]
    mov x10, #0
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_49
    adrp x10, __str_1@PAGE
    add x10, x10, __str_1@PAGEOFF
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret
.Lendif_49:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-80]
    mov x11, x10
    cmp x11, #0
    b.ge .Lendif_51
    mov x10, #1
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-96]
    mov x11, #0
    ldur x12, [x29, #-96]
    sub x10, x11, x12
    stur x10, [x29, #-104]
    stur x10, [x29, #-8]
.Lendif_51:
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-32]
.Lwhile_cond_52:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-112]
    mov x11, x10
    cmp x11, #0
    b.le .Lwhile_end_54
.Lwhile_body_53:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-128]
    mov x11, x10
    mov x12, #10
    sdiv x13, x11, x12
    msub x10, x13, x12, x11
    stur x10, [x29, #-136]
    stur x10, [x29, #-40]
    stur x10, [x29, #-144]
    mov x11, x10
    cmp x11, #0
    b.ne .Lelse_55
    ldur x10, [x29, #-32]
    stur x10, [x29, #-160]
    mov x13, x10
    adrp x14, __str_1@PAGE
    add x14, x14, __str_1@PAGEOFF
    mov x15, #0
.Lscl1_2:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_2
    add x15, x15, #1
    b .Lscl1_2
.Lscl1d_2:
    mov x9, x15
    mov x15, #0
.Lscl2_2:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_2
    add x15, x15, #1
    b .Lscl2_2
.Lscl2d_2:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_2:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_2
    strb w16, [x11], #1
    b .Lsc1_2
.Lsc2_2:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_2
    mov x10, x12
    stur x10, [x29, #-168]
    stur x10, [x29, #-32]
    b .Lendif_56
.Lelse_55:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-176]
    mov x11, x10
    cmp x11, #1
    b.ne .Lelse_57
    ldur x10, [x29, #-32]
    stur x10, [x29, #-192]
    mov x13, x10
    adrp x14, __str_2@PAGE
    add x14, x14, __str_2@PAGEOFF
    mov x15, #0
.Lscl1_3:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_3
    add x15, x15, #1
    b .Lscl1_3
.Lscl1d_3:
    mov x9, x15
    mov x15, #0
.Lscl2_3:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_3
    add x15, x15, #1
    b .Lscl2_3
.Lscl2d_3:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_3:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_3
    strb w16, [x11], #1
    b .Lsc1_3
.Lsc2_3:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_3
    mov x10, x12
    stur x10, [x29, #-200]
    stur x10, [x29, #-32]
    b .Lendif_58
.Lelse_57:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-208]
    mov x11, x10
    cmp x11, #2
    b.ne .Lelse_59
    ldur x10, [x29, #-32]
    stur x10, [x29, #-224]
    mov x13, x10
    adrp x14, __str_3@PAGE
    add x14, x14, __str_3@PAGEOFF
    mov x15, #0
.Lscl1_4:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_4
    add x15, x15, #1
    b .Lscl1_4
.Lscl1d_4:
    mov x9, x15
    mov x15, #0
.Lscl2_4:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_4
    add x15, x15, #1
    b .Lscl2_4
.Lscl2d_4:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_4:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_4
    strb w16, [x11], #1
    b .Lsc1_4
.Lsc2_4:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_4
    mov x10, x12
    stur x10, [x29, #-232]
    stur x10, [x29, #-32]
    b .Lendif_60
.Lelse_59:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-240]
    mov x11, x10
    cmp x11, #3
    b.ne .Lelse_61
    ldur x10, [x29, #-32]
    stur x10, [x29, #-256]
    mov x13, x10
    adrp x14, __str_4@PAGE
    add x14, x14, __str_4@PAGEOFF
    mov x15, #0
.Lscl1_5:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_5
    add x15, x15, #1
    b .Lscl1_5
.Lscl1d_5:
    mov x9, x15
    mov x15, #0
.Lscl2_5:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_5
    add x15, x15, #1
    b .Lscl2_5
.Lscl2d_5:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_5:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_5
    strb w16, [x11], #1
    b .Lsc1_5
.Lsc2_5:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_5
    mov x10, x12
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_62
.Lelse_61:
    ldur x10, [x29, #-40]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    cmp x11, #4
    b.ne .Lelse_63
    ldur x10, [x29, #-32]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x13, [x29, x17]
    adrp x14, __str_5@PAGE
    add x14, x14, __str_5@PAGEOFF
    mov x15, #0
.Lscl1_6:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_6
    add x15, x15, #1
    b .Lscl1_6
.Lscl1d_6:
    mov x9, x15
    mov x15, #0
.Lscl2_6:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_6
    add x15, x15, #1
    b .Lscl2_6
.Lscl2d_6:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_6:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_6
    strb w16, [x11], #1
    b .Lsc1_6
.Lsc2_6:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_6
    mov x10, x12
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_64
.Lelse_63:
    ldur x10, [x29, #-40]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x11, [x29, x17]
    cmp x11, #5
    b.ne .Lelse_65
    ldur x10, [x29, #-32]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x13, [x29, x17]
    adrp x14, __str_6@PAGE
    add x14, x14, __str_6@PAGEOFF
    mov x15, #0
.Lscl1_7:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_7
    add x15, x15, #1
    b .Lscl1_7
.Lscl1d_7:
    mov x9, x15
    mov x15, #0
.Lscl2_7:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_7
    add x15, x15, #1
    b .Lscl2_7
.Lscl2d_7:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_7:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_7
    strb w16, [x11], #1
    b .Lsc1_7
.Lsc2_7:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_7
    mov x10, x12
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_66
.Lelse_65:
    ldur x10, [x29, #-40]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x11, [x29, x17]
    cmp x11, #6
    b.ne .Lelse_67
    ldur x10, [x29, #-32]
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x13, [x29, x17]
    adrp x14, __str_7@PAGE
    add x14, x14, __str_7@PAGEOFF
    mov x15, #0
.Lscl1_8:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_8
    add x15, x15, #1
    b .Lscl1_8
.Lscl1d_8:
    mov x9, x15
    mov x15, #0
.Lscl2_8:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_8
    add x15, x15, #1
    b .Lscl2_8
.Lscl2d_8:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_8:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_8
    strb w16, [x11], #1
    b .Lsc1_8
.Lsc2_8:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_8
    mov x10, x12
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_68
.Lelse_67:
    ldur x10, [x29, #-40]
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-368
    ldr x11, [x29, x17]
    cmp x11, #7
    b.ne .Lelse_69
    ldur x10, [x29, #-32]
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-384
    ldr x13, [x29, x17]
    adrp x14, __str_8@PAGE
    add x14, x14, __str_8@PAGEOFF
    mov x15, #0
.Lscl1_9:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_9
    add x15, x15, #1
    b .Lscl1_9
.Lscl1d_9:
    mov x9, x15
    mov x15, #0
.Lscl2_9:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_9
    add x15, x15, #1
    b .Lscl2_9
.Lscl2d_9:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_9:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_9
    strb w16, [x11], #1
    b .Lsc1_9
.Lsc2_9:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_9
    mov x10, x12
    mov x17, #-392
    str x10, [x29, x17]
    mov x17, #-392
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_70
.Lelse_69:
    ldur x10, [x29, #-40]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-400
    ldr x11, [x29, x17]
    cmp x11, #8
    b.ne .Lelse_71
    ldur x10, [x29, #-32]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x13, [x29, x17]
    adrp x14, __str_9@PAGE
    add x14, x14, __str_9@PAGEOFF
    mov x15, #0
.Lscl1_10:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_10
    add x15, x15, #1
    b .Lscl1_10
.Lscl1d_10:
    mov x9, x15
    mov x15, #0
.Lscl2_10:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_10
    add x15, x15, #1
    b .Lscl2_10
.Lscl2d_10:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_10:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_10
    strb w16, [x11], #1
    b .Lsc1_10
.Lsc2_10:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_10
    mov x10, x12
    mov x17, #-424
    str x10, [x29, x17]
    mov x17, #-424
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_72
.Lelse_71:
    ldur x10, [x29, #-40]
    mov x17, #-432
    str x10, [x29, x17]
    mov x17, #-432
    ldr x11, [x29, x17]
    cmp x11, #9
    b.ne .Lendif_74
    ldur x10, [x29, #-32]
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-448
    ldr x13, [x29, x17]
    adrp x14, __str_10@PAGE
    add x14, x14, __str_10@PAGEOFF
    mov x15, #0
.Lscl1_11:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_11
    add x15, x15, #1
    b .Lscl1_11
.Lscl1d_11:
    mov x9, x15
    mov x15, #0
.Lscl2_11:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_11
    add x15, x15, #1
    b .Lscl2_11
.Lscl2d_11:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_11:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_11
    strb w16, [x11], #1
    b .Lsc1_11
.Lsc2_11:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_11
    mov x10, x12
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-456
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_74:
.Lendif_72:
.Lendif_70:
.Lendif_68:
.Lendif_66:
.Lendif_64:
.Lendif_62:
.Lendif_60:
.Lendif_58:
.Lendif_56:
    ldur x10, [x29, #-8]
    mov x17, #-464
    str x10, [x29, x17]
    mov x17, #-464
    ldr x11, [x29, x17]
    mov x12, #10
    sdiv x10, x11, x12
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x10, [x29, x17]
    stur x10, [x29, #-8]
    b .Lwhile_cond_52
.Lwhile_end_54:
    ldur x10, [x29, #-24]
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-480
    ldr x11, [x29, x17]
    cmp x11, #1
    b.ne .Lendif_76
    ldur x10, [x29, #-32]
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-496
    ldr x13, [x29, x17]
    adrp x14, __str_11@PAGE
    add x14, x14, __str_11@PAGEOFF
    mov x15, #0
.Lscl1_12:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_12
    add x15, x15, #1
    b .Lscl1_12
.Lscl1d_12:
    mov x9, x15
    mov x15, #0
.Lscl2_12:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_12
    add x15, x15, #1
    b .Lscl2_12
.Lscl2d_12:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_12:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_12
    strb w16, [x11], #1
    b .Lsc1_12
.Lsc2_12:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_12
    mov x10, x12
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-504
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_76:
    ldur x10, [x29, #-32]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-512
    ldr x13, [x29, x17]
    mov x14, x13
    mov x15, #0
.Lstrlen_s_13:
    ldrb w16, [x14, x15]
    cbz w16, .Lstrlen_d_13
    add x15, x15, #1
    b .Lstrlen_s_13
.Lstrlen_d_13:
    mov x10, x15
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
.Lwhile_cond_77:
    ldur x10, [x29, #-48]
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x11, [x29, x17]
    cmp x11, #0
    b.lt .Lwhile_end_79
.Lwhile_body_78:
    ldur x10, [x29, #-16]
    mov x17, #-552
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-560
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-560
    ldr x13, [x29, x17]
    mov x17, #-568
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-576
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    sub x10, x29, #56
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-552
    ldr x13, [x29, x17]
    mov x17, #-584
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_14:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_14
    add x15, x15, #1
    b .Lscl1_14
.Lscl1d_14:
    mov x9, x15
    mov x15, #0
.Lscl2_14:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_14
    add x15, x15, #1
    b .Lscl2_14
.Lscl2d_14:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_14:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_14
    strb w16, [x11], #1
    b .Lsc1_14
.Lsc2_14:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_14
    mov x10, x12
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-592
    ldr x10, [x29, x17]
    stur x10, [x29, #-16]
    ldur x10, [x29, #-48]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-600
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-608
    str x10, [x29, x17]
    mov x17, #-608
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    b .Lwhile_cond_77
.Lwhile_end_79:
    ldur x10, [x29, #-16]
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-616
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret

_int_to_str.i64:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #656
    // function int_to_str
    stur x0, [x29, #-8]
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-16]
    mov x10, #0
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_81
    adrp x10, __str_1@PAGE
    add x10, x10, __str_1@PAGEOFF
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret
.Lendif_81:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-80]
    mov x11, x10
    cmp x11, #0
    b.ge .Lendif_83
    mov x10, #1
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-96]
    mov x11, #0
    ldur x12, [x29, #-96]
    sub x10, x11, x12
    stur x10, [x29, #-104]
    stur x10, [x29, #-8]
.Lendif_83:
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-32]
.Lwhile_cond_84:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-112]
    mov x11, x10
    cmp x11, #0
    b.le .Lwhile_end_86
.Lwhile_body_85:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-128]
    mov x11, x10
    mov x12, #10
    sdiv x13, x11, x12
    msub x10, x13, x12, x11
    stur x10, [x29, #-136]
    stur x10, [x29, #-40]
    stur x10, [x29, #-144]
    mov x11, x10
    cmp x11, #0
    b.ne .Lelse_87
    ldur x10, [x29, #-32]
    stur x10, [x29, #-160]
    mov x13, x10
    adrp x14, __str_1@PAGE
    add x14, x14, __str_1@PAGEOFF
    mov x15, #0
.Lscl1_15:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_15
    add x15, x15, #1
    b .Lscl1_15
.Lscl1d_15:
    mov x9, x15
    mov x15, #0
.Lscl2_15:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_15
    add x15, x15, #1
    b .Lscl2_15
.Lscl2d_15:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_15:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_15
    strb w16, [x11], #1
    b .Lsc1_15
.Lsc2_15:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_15
    mov x10, x12
    stur x10, [x29, #-168]
    stur x10, [x29, #-32]
    b .Lendif_88
.Lelse_87:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-176]
    mov x11, x10
    cmp x11, #1
    b.ne .Lelse_89
    ldur x10, [x29, #-32]
    stur x10, [x29, #-192]
    mov x13, x10
    adrp x14, __str_2@PAGE
    add x14, x14, __str_2@PAGEOFF
    mov x15, #0
.Lscl1_16:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_16
    add x15, x15, #1
    b .Lscl1_16
.Lscl1d_16:
    mov x9, x15
    mov x15, #0
.Lscl2_16:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_16
    add x15, x15, #1
    b .Lscl2_16
.Lscl2d_16:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_16:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_16
    strb w16, [x11], #1
    b .Lsc1_16
.Lsc2_16:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_16
    mov x10, x12
    stur x10, [x29, #-200]
    stur x10, [x29, #-32]
    b .Lendif_90
.Lelse_89:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-208]
    mov x11, x10
    cmp x11, #2
    b.ne .Lelse_91
    ldur x10, [x29, #-32]
    stur x10, [x29, #-224]
    mov x13, x10
    adrp x14, __str_3@PAGE
    add x14, x14, __str_3@PAGEOFF
    mov x15, #0
.Lscl1_17:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_17
    add x15, x15, #1
    b .Lscl1_17
.Lscl1d_17:
    mov x9, x15
    mov x15, #0
.Lscl2_17:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_17
    add x15, x15, #1
    b .Lscl2_17
.Lscl2d_17:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_17:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_17
    strb w16, [x11], #1
    b .Lsc1_17
.Lsc2_17:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_17
    mov x10, x12
    stur x10, [x29, #-232]
    stur x10, [x29, #-32]
    b .Lendif_92
.Lelse_91:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-240]
    mov x11, x10
    cmp x11, #3
    b.ne .Lelse_93
    ldur x10, [x29, #-32]
    stur x10, [x29, #-256]
    mov x13, x10
    adrp x14, __str_4@PAGE
    add x14, x14, __str_4@PAGEOFF
    mov x15, #0
.Lscl1_18:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_18
    add x15, x15, #1
    b .Lscl1_18
.Lscl1d_18:
    mov x9, x15
    mov x15, #0
.Lscl2_18:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_18
    add x15, x15, #1
    b .Lscl2_18
.Lscl2d_18:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_18:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_18
    strb w16, [x11], #1
    b .Lsc1_18
.Lsc2_18:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_18
    mov x10, x12
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_94
.Lelse_93:
    ldur x10, [x29, #-40]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    cmp x11, #4
    b.ne .Lelse_95
    ldur x10, [x29, #-32]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x13, [x29, x17]
    adrp x14, __str_5@PAGE
    add x14, x14, __str_5@PAGEOFF
    mov x15, #0
.Lscl1_19:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_19
    add x15, x15, #1
    b .Lscl1_19
.Lscl1d_19:
    mov x9, x15
    mov x15, #0
.Lscl2_19:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_19
    add x15, x15, #1
    b .Lscl2_19
.Lscl2d_19:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_19:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_19
    strb w16, [x11], #1
    b .Lsc1_19
.Lsc2_19:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_19
    mov x10, x12
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_96
.Lelse_95:
    ldur x10, [x29, #-40]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x11, [x29, x17]
    cmp x11, #5
    b.ne .Lelse_97
    ldur x10, [x29, #-32]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x13, [x29, x17]
    adrp x14, __str_6@PAGE
    add x14, x14, __str_6@PAGEOFF
    mov x15, #0
.Lscl1_20:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_20
    add x15, x15, #1
    b .Lscl1_20
.Lscl1d_20:
    mov x9, x15
    mov x15, #0
.Lscl2_20:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_20
    add x15, x15, #1
    b .Lscl2_20
.Lscl2d_20:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_20:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_20
    strb w16, [x11], #1
    b .Lsc1_20
.Lsc2_20:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_20
    mov x10, x12
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_98
.Lelse_97:
    ldur x10, [x29, #-40]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x11, [x29, x17]
    cmp x11, #6
    b.ne .Lelse_99
    ldur x10, [x29, #-32]
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x13, [x29, x17]
    adrp x14, __str_7@PAGE
    add x14, x14, __str_7@PAGEOFF
    mov x15, #0
.Lscl1_21:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_21
    add x15, x15, #1
    b .Lscl1_21
.Lscl1d_21:
    mov x9, x15
    mov x15, #0
.Lscl2_21:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_21
    add x15, x15, #1
    b .Lscl2_21
.Lscl2d_21:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_21:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_21
    strb w16, [x11], #1
    b .Lsc1_21
.Lsc2_21:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_21
    mov x10, x12
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_100
.Lelse_99:
    ldur x10, [x29, #-40]
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-368
    ldr x11, [x29, x17]
    cmp x11, #7
    b.ne .Lelse_101
    ldur x10, [x29, #-32]
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-384
    ldr x13, [x29, x17]
    adrp x14, __str_8@PAGE
    add x14, x14, __str_8@PAGEOFF
    mov x15, #0
.Lscl1_22:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_22
    add x15, x15, #1
    b .Lscl1_22
.Lscl1d_22:
    mov x9, x15
    mov x15, #0
.Lscl2_22:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_22
    add x15, x15, #1
    b .Lscl2_22
.Lscl2d_22:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_22:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_22
    strb w16, [x11], #1
    b .Lsc1_22
.Lsc2_22:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_22
    mov x10, x12
    mov x17, #-392
    str x10, [x29, x17]
    mov x17, #-392
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_102
.Lelse_101:
    ldur x10, [x29, #-40]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-400
    ldr x11, [x29, x17]
    cmp x11, #8
    b.ne .Lelse_103
    ldur x10, [x29, #-32]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x13, [x29, x17]
    adrp x14, __str_9@PAGE
    add x14, x14, __str_9@PAGEOFF
    mov x15, #0
.Lscl1_23:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_23
    add x15, x15, #1
    b .Lscl1_23
.Lscl1d_23:
    mov x9, x15
    mov x15, #0
.Lscl2_23:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_23
    add x15, x15, #1
    b .Lscl2_23
.Lscl2d_23:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_23:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_23
    strb w16, [x11], #1
    b .Lsc1_23
.Lsc2_23:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_23
    mov x10, x12
    mov x17, #-424
    str x10, [x29, x17]
    mov x17, #-424
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_104
.Lelse_103:
    ldur x10, [x29, #-40]
    mov x17, #-432
    str x10, [x29, x17]
    mov x17, #-432
    ldr x11, [x29, x17]
    cmp x11, #9
    b.ne .Lendif_106
    ldur x10, [x29, #-32]
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-448
    ldr x13, [x29, x17]
    adrp x14, __str_10@PAGE
    add x14, x14, __str_10@PAGEOFF
    mov x15, #0
.Lscl1_24:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_24
    add x15, x15, #1
    b .Lscl1_24
.Lscl1d_24:
    mov x9, x15
    mov x15, #0
.Lscl2_24:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_24
    add x15, x15, #1
    b .Lscl2_24
.Lscl2d_24:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_24:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_24
    strb w16, [x11], #1
    b .Lsc1_24
.Lsc2_24:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_24
    mov x10, x12
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-456
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_106:
.Lendif_104:
.Lendif_102:
.Lendif_100:
.Lendif_98:
.Lendif_96:
.Lendif_94:
.Lendif_92:
.Lendif_90:
.Lendif_88:
    ldur x10, [x29, #-8]
    mov x17, #-464
    str x10, [x29, x17]
    mov x17, #-464
    ldr x11, [x29, x17]
    mov x12, #10
    sdiv x10, x11, x12
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x10, [x29, x17]
    stur x10, [x29, #-8]
    b .Lwhile_cond_84
.Lwhile_end_86:
    ldur x10, [x29, #-24]
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-480
    ldr x11, [x29, x17]
    cmp x11, #1
    b.ne .Lendif_108
    ldur x10, [x29, #-32]
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-496
    ldr x13, [x29, x17]
    adrp x14, __str_11@PAGE
    add x14, x14, __str_11@PAGEOFF
    mov x15, #0
.Lscl1_25:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_25
    add x15, x15, #1
    b .Lscl1_25
.Lscl1d_25:
    mov x9, x15
    mov x15, #0
.Lscl2_25:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_25
    add x15, x15, #1
    b .Lscl2_25
.Lscl2d_25:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_25:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_25
    strb w16, [x11], #1
    b .Lsc1_25
.Lsc2_25:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_25
    mov x10, x12
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-504
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_108:
    ldur x10, [x29, #-32]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-512
    ldr x13, [x29, x17]
    mov x14, x13
    mov x15, #0
.Lstrlen_s_26:
    ldrb w16, [x14, x15]
    cbz w16, .Lstrlen_d_26
    add x15, x15, #1
    b .Lstrlen_s_26
.Lstrlen_d_26:
    mov x10, x15
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
.Lwhile_cond_109:
    ldur x10, [x29, #-48]
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x11, [x29, x17]
    cmp x11, #0
    b.lt .Lwhile_end_111
.Lwhile_body_110:
    ldur x10, [x29, #-16]
    mov x17, #-552
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-560
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-560
    ldr x13, [x29, x17]
    mov x17, #-568
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-576
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    sub x10, x29, #56
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-552
    ldr x13, [x29, x17]
    mov x17, #-584
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_27:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_27
    add x15, x15, #1
    b .Lscl1_27
.Lscl1d_27:
    mov x9, x15
    mov x15, #0
.Lscl2_27:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_27
    add x15, x15, #1
    b .Lscl2_27
.Lscl2d_27:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_27:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_27
    strb w16, [x11], #1
    b .Lsc1_27
.Lsc2_27:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_27
    mov x10, x12
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-592
    ldr x10, [x29, x17]
    stur x10, [x29, #-16]
    ldur x10, [x29, #-48]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-600
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-608
    str x10, [x29, x17]
    mov x17, #-608
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    b .Lwhile_cond_109
.Lwhile_end_111:
    ldur x10, [x29, #-16]
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-616
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret

_u64_to_i32:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #320
    // function u64_to_i32
    stur x0, [x29, #-8]
    movz x10, #0, lsl #0
    movk x10, #1, lsl #32
    stur x10, [x29, #-16]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-80]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-88]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-96]
    ldur x11, [x29, #-88]
    ldur x12, [x29, #-96]
    sdiv x10, x11, x12
    stur x10, [x29, #-104]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-112]
    ldur x11, [x29, #-104]
    ldur x12, [x29, #-112]
    mul x10, x11, x12
    stur x10, [x29, #-120]
    ldur x11, [x29, #-80]
    ldur x12, [x29, #-120]
    sub x10, x11, x12
    stur x10, [x29, #-128]
    stur x10, [x29, #-24]
    mov x10, #0
    stur x10, [x29, #-32]
    mov x10, #1
    stur x10, [x29, #-40]
    mov x10, #1
    stur x10, [x29, #-48]
    mov x10, #0
    stur x10, [x29, #-56]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-136]
    stur x10, [x29, #-64]
.Lwhile_cond_112:
    ldur x10, [x29, #-56]
    stur x10, [x29, #-144]
    mov x11, x10
    cmp x11, #32
    b.ge .Lwhile_end_114
.Lwhile_body_113:
    ldur x10, [x29, #-64]
    stur x10, [x29, #-160]
    ldur x10, [x29, #-40]
    stur x10, [x29, #-168]
    ldur x11, [x29, #-160]
    ldur x12, [x29, #-168]
    sdiv x10, x11, x12
    stur x10, [x29, #-176]
    mov x11, x10
    mov x12, #2
    sdiv x13, x11, x12
    msub x10, x13, x12, x11
    stur x10, [x29, #-184]
    stur x10, [x29, #-72]
    stur x10, [x29, #-192]
    mov x11, x10
    cmp x11, #1
    b.ne .Lendif_116
    ldur x10, [x29, #-32]
    stur x10, [x29, #-208]
    ldur x10, [x29, #-48]
    stur x10, [x29, #-216]
    ldur x11, [x29, #-208]
    ldur x12, [x29, #-216]
    add x10, x11, x12
    stur x10, [x29, #-224]
    stur x10, [x29, #-32]
.Lendif_116:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-232]
    mov x11, x10
    mov x12, #2
    mul x10, x11, x12
    stur x10, [x29, #-240]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-48]
    stur x10, [x29, #-248]
    mov x11, x10
    mov x12, #2
    mul x10, x11, x12
    stur x10, [x29, #-256]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-56]
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    b .Lwhile_cond_112
.Lwhile_end_114:
    ldur x10, [x29, #-32]
    mov x17, #-280
    str x10, [x29, x17]
    mov x17, #-280
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #320
    ldp x29, x30, [sp], #16
    ret

_i32_to_str:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #656
    // function i32_to_str
    stur x0, [x29, #-8]
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-16]
    mov x10, #0
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_118
    adrp x10, __str_1@PAGE
    add x10, x10, __str_1@PAGEOFF
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret
.Lendif_118:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-80]
    mov x11, x10
    cmp x11, #0
    b.ge .Lendif_120
    mov x10, #1
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-96]
    mov x11, #0
    ldur x12, [x29, #-96]
    sub x10, x11, x12
    stur x10, [x29, #-104]
    stur x10, [x29, #-8]
.Lendif_120:
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-32]
.Lwhile_cond_121:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-112]
    mov x11, x10
    cmp x11, #0
    b.le .Lwhile_end_123
.Lwhile_body_122:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-128]
    mov x11, x10
    mov x12, #10
    sdiv x13, x11, x12
    msub x10, x13, x12, x11
    stur x10, [x29, #-136]
    stur x10, [x29, #-40]
    stur x10, [x29, #-144]
    mov x11, x10
    cmp x11, #0
    b.ne .Lelse_124
    ldur x10, [x29, #-32]
    stur x10, [x29, #-160]
    mov x13, x10
    adrp x14, __str_1@PAGE
    add x14, x14, __str_1@PAGEOFF
    mov x15, #0
.Lscl1_28:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_28
    add x15, x15, #1
    b .Lscl1_28
.Lscl1d_28:
    mov x9, x15
    mov x15, #0
.Lscl2_28:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_28
    add x15, x15, #1
    b .Lscl2_28
.Lscl2d_28:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_28:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_28
    strb w16, [x11], #1
    b .Lsc1_28
.Lsc2_28:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_28
    mov x10, x12
    stur x10, [x29, #-168]
    stur x10, [x29, #-32]
    b .Lendif_125
.Lelse_124:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-176]
    mov x11, x10
    cmp x11, #1
    b.ne .Lelse_126
    ldur x10, [x29, #-32]
    stur x10, [x29, #-192]
    mov x13, x10
    adrp x14, __str_2@PAGE
    add x14, x14, __str_2@PAGEOFF
    mov x15, #0
.Lscl1_29:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_29
    add x15, x15, #1
    b .Lscl1_29
.Lscl1d_29:
    mov x9, x15
    mov x15, #0
.Lscl2_29:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_29
    add x15, x15, #1
    b .Lscl2_29
.Lscl2d_29:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_29:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_29
    strb w16, [x11], #1
    b .Lsc1_29
.Lsc2_29:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_29
    mov x10, x12
    stur x10, [x29, #-200]
    stur x10, [x29, #-32]
    b .Lendif_127
.Lelse_126:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-208]
    mov x11, x10
    cmp x11, #2
    b.ne .Lelse_128
    ldur x10, [x29, #-32]
    stur x10, [x29, #-224]
    mov x13, x10
    adrp x14, __str_3@PAGE
    add x14, x14, __str_3@PAGEOFF
    mov x15, #0
.Lscl1_30:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_30
    add x15, x15, #1
    b .Lscl1_30
.Lscl1d_30:
    mov x9, x15
    mov x15, #0
.Lscl2_30:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_30
    add x15, x15, #1
    b .Lscl2_30
.Lscl2d_30:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_30:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_30
    strb w16, [x11], #1
    b .Lsc1_30
.Lsc2_30:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_30
    mov x10, x12
    stur x10, [x29, #-232]
    stur x10, [x29, #-32]
    b .Lendif_129
.Lelse_128:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-240]
    mov x11, x10
    cmp x11, #3
    b.ne .Lelse_130
    ldur x10, [x29, #-32]
    stur x10, [x29, #-256]
    mov x13, x10
    adrp x14, __str_4@PAGE
    add x14, x14, __str_4@PAGEOFF
    mov x15, #0
.Lscl1_31:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_31
    add x15, x15, #1
    b .Lscl1_31
.Lscl1d_31:
    mov x9, x15
    mov x15, #0
.Lscl2_31:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_31
    add x15, x15, #1
    b .Lscl2_31
.Lscl2d_31:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_31:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_31
    strb w16, [x11], #1
    b .Lsc1_31
.Lsc2_31:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_31
    mov x10, x12
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_131
.Lelse_130:
    ldur x10, [x29, #-40]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    cmp x11, #4
    b.ne .Lelse_132
    ldur x10, [x29, #-32]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x13, [x29, x17]
    adrp x14, __str_5@PAGE
    add x14, x14, __str_5@PAGEOFF
    mov x15, #0
.Lscl1_32:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_32
    add x15, x15, #1
    b .Lscl1_32
.Lscl1d_32:
    mov x9, x15
    mov x15, #0
.Lscl2_32:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_32
    add x15, x15, #1
    b .Lscl2_32
.Lscl2d_32:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_32:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_32
    strb w16, [x11], #1
    b .Lsc1_32
.Lsc2_32:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_32
    mov x10, x12
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_133
.Lelse_132:
    ldur x10, [x29, #-40]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x11, [x29, x17]
    cmp x11, #5
    b.ne .Lelse_134
    ldur x10, [x29, #-32]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x13, [x29, x17]
    adrp x14, __str_6@PAGE
    add x14, x14, __str_6@PAGEOFF
    mov x15, #0
.Lscl1_33:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_33
    add x15, x15, #1
    b .Lscl1_33
.Lscl1d_33:
    mov x9, x15
    mov x15, #0
.Lscl2_33:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_33
    add x15, x15, #1
    b .Lscl2_33
.Lscl2d_33:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_33:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_33
    strb w16, [x11], #1
    b .Lsc1_33
.Lsc2_33:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_33
    mov x10, x12
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_135
.Lelse_134:
    ldur x10, [x29, #-40]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x11, [x29, x17]
    cmp x11, #6
    b.ne .Lelse_136
    ldur x10, [x29, #-32]
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x13, [x29, x17]
    adrp x14, __str_7@PAGE
    add x14, x14, __str_7@PAGEOFF
    mov x15, #0
.Lscl1_34:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_34
    add x15, x15, #1
    b .Lscl1_34
.Lscl1d_34:
    mov x9, x15
    mov x15, #0
.Lscl2_34:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_34
    add x15, x15, #1
    b .Lscl2_34
.Lscl2d_34:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_34:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_34
    strb w16, [x11], #1
    b .Lsc1_34
.Lsc2_34:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_34
    mov x10, x12
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_137
.Lelse_136:
    ldur x10, [x29, #-40]
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-368
    ldr x11, [x29, x17]
    cmp x11, #7
    b.ne .Lelse_138
    ldur x10, [x29, #-32]
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-384
    ldr x13, [x29, x17]
    adrp x14, __str_8@PAGE
    add x14, x14, __str_8@PAGEOFF
    mov x15, #0
.Lscl1_35:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_35
    add x15, x15, #1
    b .Lscl1_35
.Lscl1d_35:
    mov x9, x15
    mov x15, #0
.Lscl2_35:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_35
    add x15, x15, #1
    b .Lscl2_35
.Lscl2d_35:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_35:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_35
    strb w16, [x11], #1
    b .Lsc1_35
.Lsc2_35:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_35
    mov x10, x12
    mov x17, #-392
    str x10, [x29, x17]
    mov x17, #-392
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_139
.Lelse_138:
    ldur x10, [x29, #-40]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-400
    ldr x11, [x29, x17]
    cmp x11, #8
    b.ne .Lelse_140
    ldur x10, [x29, #-32]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x13, [x29, x17]
    adrp x14, __str_9@PAGE
    add x14, x14, __str_9@PAGEOFF
    mov x15, #0
.Lscl1_36:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_36
    add x15, x15, #1
    b .Lscl1_36
.Lscl1d_36:
    mov x9, x15
    mov x15, #0
.Lscl2_36:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_36
    add x15, x15, #1
    b .Lscl2_36
.Lscl2d_36:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_36:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_36
    strb w16, [x11], #1
    b .Lsc1_36
.Lsc2_36:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_36
    mov x10, x12
    mov x17, #-424
    str x10, [x29, x17]
    mov x17, #-424
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_141
.Lelse_140:
    ldur x10, [x29, #-40]
    mov x17, #-432
    str x10, [x29, x17]
    mov x17, #-432
    ldr x11, [x29, x17]
    cmp x11, #9
    b.ne .Lendif_143
    ldur x10, [x29, #-32]
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-448
    ldr x13, [x29, x17]
    adrp x14, __str_10@PAGE
    add x14, x14, __str_10@PAGEOFF
    mov x15, #0
.Lscl1_37:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_37
    add x15, x15, #1
    b .Lscl1_37
.Lscl1d_37:
    mov x9, x15
    mov x15, #0
.Lscl2_37:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_37
    add x15, x15, #1
    b .Lscl2_37
.Lscl2d_37:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_37:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_37
    strb w16, [x11], #1
    b .Lsc1_37
.Lsc2_37:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_37
    mov x10, x12
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-456
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_143:
.Lendif_141:
.Lendif_139:
.Lendif_137:
.Lendif_135:
.Lendif_133:
.Lendif_131:
.Lendif_129:
.Lendif_127:
.Lendif_125:
    ldur x10, [x29, #-8]
    mov x17, #-464
    str x10, [x29, x17]
    mov x17, #-464
    ldr x11, [x29, x17]
    mov x12, #10
    sdiv x10, x11, x12
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x10, [x29, x17]
    stur x10, [x29, #-8]
    b .Lwhile_cond_121
.Lwhile_end_123:
    ldur x10, [x29, #-24]
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-480
    ldr x11, [x29, x17]
    cmp x11, #1
    b.ne .Lendif_145
    ldur x10, [x29, #-32]
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-496
    ldr x13, [x29, x17]
    adrp x14, __str_11@PAGE
    add x14, x14, __str_11@PAGEOFF
    mov x15, #0
.Lscl1_38:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_38
    add x15, x15, #1
    b .Lscl1_38
.Lscl1d_38:
    mov x9, x15
    mov x15, #0
.Lscl2_38:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_38
    add x15, x15, #1
    b .Lscl2_38
.Lscl2d_38:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_38:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_38
    strb w16, [x11], #1
    b .Lsc1_38
.Lsc2_38:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_38
    mov x10, x12
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-504
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_145:
    ldur x10, [x29, #-32]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-512
    ldr x13, [x29, x17]
    mov x14, x13
    mov x15, #0
.Lstrlen_s_39:
    ldrb w16, [x14, x15]
    cbz w16, .Lstrlen_d_39
    add x15, x15, #1
    b .Lstrlen_s_39
.Lstrlen_d_39:
    mov x10, x15
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
.Lwhile_cond_146:
    ldur x10, [x29, #-48]
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x11, [x29, x17]
    cmp x11, #0
    b.lt .Lwhile_end_148
.Lwhile_body_147:
    ldur x10, [x29, #-16]
    mov x17, #-552
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-560
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-560
    ldr x13, [x29, x17]
    mov x17, #-568
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-576
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    sub x10, x29, #56
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-552
    ldr x13, [x29, x17]
    mov x17, #-584
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_40:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_40
    add x15, x15, #1
    b .Lscl1_40
.Lscl1d_40:
    mov x9, x15
    mov x15, #0
.Lscl2_40:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_40
    add x15, x15, #1
    b .Lscl2_40
.Lscl2d_40:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_40:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_40
    strb w16, [x11], #1
    b .Lsc1_40
.Lsc2_40:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_40
    mov x10, x12
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-592
    ldr x10, [x29, x17]
    stur x10, [x29, #-16]
    ldur x10, [x29, #-48]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-600
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-608
    str x10, [x29, x17]
    mov x17, #-608
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    b .Lwhile_cond_146
.Lwhile_end_148:
    ldur x10, [x29, #-16]
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-616
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret

_i64_to_str:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #656
    // function i64_to_str
    stur x0, [x29, #-8]
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-16]
    mov x10, #0
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_150
    adrp x10, __str_1@PAGE
    add x10, x10, __str_1@PAGEOFF
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret
.Lendif_150:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-80]
    mov x11, x10
    cmp x11, #0
    b.ge .Lendif_152
    mov x10, #1
    stur x10, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-96]
    mov x11, #0
    ldur x12, [x29, #-96]
    sub x10, x11, x12
    stur x10, [x29, #-104]
    stur x10, [x29, #-8]
.Lendif_152:
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-32]
.Lwhile_cond_153:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-112]
    mov x11, x10
    cmp x11, #0
    b.le .Lwhile_end_155
.Lwhile_body_154:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-128]
    mov x11, x10
    mov x12, #10
    sdiv x13, x11, x12
    msub x10, x13, x12, x11
    stur x10, [x29, #-136]
    stur x10, [x29, #-40]
    stur x10, [x29, #-144]
    mov x11, x10
    cmp x11, #0
    b.ne .Lelse_156
    ldur x10, [x29, #-32]
    stur x10, [x29, #-160]
    mov x13, x10
    adrp x14, __str_1@PAGE
    add x14, x14, __str_1@PAGEOFF
    mov x15, #0
.Lscl1_41:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_41
    add x15, x15, #1
    b .Lscl1_41
.Lscl1d_41:
    mov x9, x15
    mov x15, #0
.Lscl2_41:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_41
    add x15, x15, #1
    b .Lscl2_41
.Lscl2d_41:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_41:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_41
    strb w16, [x11], #1
    b .Lsc1_41
.Lsc2_41:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_41
    mov x10, x12
    stur x10, [x29, #-168]
    stur x10, [x29, #-32]
    b .Lendif_157
.Lelse_156:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-176]
    mov x11, x10
    cmp x11, #1
    b.ne .Lelse_158
    ldur x10, [x29, #-32]
    stur x10, [x29, #-192]
    mov x13, x10
    adrp x14, __str_2@PAGE
    add x14, x14, __str_2@PAGEOFF
    mov x15, #0
.Lscl1_42:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_42
    add x15, x15, #1
    b .Lscl1_42
.Lscl1d_42:
    mov x9, x15
    mov x15, #0
.Lscl2_42:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_42
    add x15, x15, #1
    b .Lscl2_42
.Lscl2d_42:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_42:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_42
    strb w16, [x11], #1
    b .Lsc1_42
.Lsc2_42:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_42
    mov x10, x12
    stur x10, [x29, #-200]
    stur x10, [x29, #-32]
    b .Lendif_159
.Lelse_158:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-208]
    mov x11, x10
    cmp x11, #2
    b.ne .Lelse_160
    ldur x10, [x29, #-32]
    stur x10, [x29, #-224]
    mov x13, x10
    adrp x14, __str_3@PAGE
    add x14, x14, __str_3@PAGEOFF
    mov x15, #0
.Lscl1_43:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_43
    add x15, x15, #1
    b .Lscl1_43
.Lscl1d_43:
    mov x9, x15
    mov x15, #0
.Lscl2_43:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_43
    add x15, x15, #1
    b .Lscl2_43
.Lscl2d_43:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_43:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_43
    strb w16, [x11], #1
    b .Lsc1_43
.Lsc2_43:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_43
    mov x10, x12
    stur x10, [x29, #-232]
    stur x10, [x29, #-32]
    b .Lendif_161
.Lelse_160:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-240]
    mov x11, x10
    cmp x11, #3
    b.ne .Lelse_162
    ldur x10, [x29, #-32]
    stur x10, [x29, #-256]
    mov x13, x10
    adrp x14, __str_4@PAGE
    add x14, x14, __str_4@PAGEOFF
    mov x15, #0
.Lscl1_44:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_44
    add x15, x15, #1
    b .Lscl1_44
.Lscl1d_44:
    mov x9, x15
    mov x15, #0
.Lscl2_44:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_44
    add x15, x15, #1
    b .Lscl2_44
.Lscl2d_44:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_44:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_44
    strb w16, [x11], #1
    b .Lsc1_44
.Lsc2_44:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_44
    mov x10, x12
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_163
.Lelse_162:
    ldur x10, [x29, #-40]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    cmp x11, #4
    b.ne .Lelse_164
    ldur x10, [x29, #-32]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x13, [x29, x17]
    adrp x14, __str_5@PAGE
    add x14, x14, __str_5@PAGEOFF
    mov x15, #0
.Lscl1_45:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_45
    add x15, x15, #1
    b .Lscl1_45
.Lscl1d_45:
    mov x9, x15
    mov x15, #0
.Lscl2_45:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_45
    add x15, x15, #1
    b .Lscl2_45
.Lscl2d_45:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_45:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_45
    strb w16, [x11], #1
    b .Lsc1_45
.Lsc2_45:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_45
    mov x10, x12
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_165
.Lelse_164:
    ldur x10, [x29, #-40]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x11, [x29, x17]
    cmp x11, #5
    b.ne .Lelse_166
    ldur x10, [x29, #-32]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x13, [x29, x17]
    adrp x14, __str_6@PAGE
    add x14, x14, __str_6@PAGEOFF
    mov x15, #0
.Lscl1_46:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_46
    add x15, x15, #1
    b .Lscl1_46
.Lscl1d_46:
    mov x9, x15
    mov x15, #0
.Lscl2_46:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_46
    add x15, x15, #1
    b .Lscl2_46
.Lscl2d_46:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_46:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_46
    strb w16, [x11], #1
    b .Lsc1_46
.Lsc2_46:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_46
    mov x10, x12
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_167
.Lelse_166:
    ldur x10, [x29, #-40]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x11, [x29, x17]
    cmp x11, #6
    b.ne .Lelse_168
    ldur x10, [x29, #-32]
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x13, [x29, x17]
    adrp x14, __str_7@PAGE
    add x14, x14, __str_7@PAGEOFF
    mov x15, #0
.Lscl1_47:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_47
    add x15, x15, #1
    b .Lscl1_47
.Lscl1d_47:
    mov x9, x15
    mov x15, #0
.Lscl2_47:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_47
    add x15, x15, #1
    b .Lscl2_47
.Lscl2d_47:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_47:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_47
    strb w16, [x11], #1
    b .Lsc1_47
.Lsc2_47:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_47
    mov x10, x12
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_169
.Lelse_168:
    ldur x10, [x29, #-40]
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-368
    ldr x11, [x29, x17]
    cmp x11, #7
    b.ne .Lelse_170
    ldur x10, [x29, #-32]
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-384
    ldr x13, [x29, x17]
    adrp x14, __str_8@PAGE
    add x14, x14, __str_8@PAGEOFF
    mov x15, #0
.Lscl1_48:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_48
    add x15, x15, #1
    b .Lscl1_48
.Lscl1d_48:
    mov x9, x15
    mov x15, #0
.Lscl2_48:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_48
    add x15, x15, #1
    b .Lscl2_48
.Lscl2d_48:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_48:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_48
    strb w16, [x11], #1
    b .Lsc1_48
.Lsc2_48:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_48
    mov x10, x12
    mov x17, #-392
    str x10, [x29, x17]
    mov x17, #-392
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_171
.Lelse_170:
    ldur x10, [x29, #-40]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-400
    ldr x11, [x29, x17]
    cmp x11, #8
    b.ne .Lelse_172
    ldur x10, [x29, #-32]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x13, [x29, x17]
    adrp x14, __str_9@PAGE
    add x14, x14, __str_9@PAGEOFF
    mov x15, #0
.Lscl1_49:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_49
    add x15, x15, #1
    b .Lscl1_49
.Lscl1d_49:
    mov x9, x15
    mov x15, #0
.Lscl2_49:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_49
    add x15, x15, #1
    b .Lscl2_49
.Lscl2d_49:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_49:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_49
    strb w16, [x11], #1
    b .Lsc1_49
.Lsc2_49:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_49
    mov x10, x12
    mov x17, #-424
    str x10, [x29, x17]
    mov x17, #-424
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
    b .Lendif_173
.Lelse_172:
    ldur x10, [x29, #-40]
    mov x17, #-432
    str x10, [x29, x17]
    mov x17, #-432
    ldr x11, [x29, x17]
    cmp x11, #9
    b.ne .Lendif_175
    ldur x10, [x29, #-32]
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-448
    ldr x13, [x29, x17]
    adrp x14, __str_10@PAGE
    add x14, x14, __str_10@PAGEOFF
    mov x15, #0
.Lscl1_50:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_50
    add x15, x15, #1
    b .Lscl1_50
.Lscl1d_50:
    mov x9, x15
    mov x15, #0
.Lscl2_50:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_50
    add x15, x15, #1
    b .Lscl2_50
.Lscl2d_50:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_50:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_50
    strb w16, [x11], #1
    b .Lsc1_50
.Lsc2_50:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_50
    mov x10, x12
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-456
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_175:
.Lendif_173:
.Lendif_171:
.Lendif_169:
.Lendif_167:
.Lendif_165:
.Lendif_163:
.Lendif_161:
.Lendif_159:
.Lendif_157:
    ldur x10, [x29, #-8]
    mov x17, #-464
    str x10, [x29, x17]
    mov x17, #-464
    ldr x11, [x29, x17]
    mov x12, #10
    sdiv x10, x11, x12
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x10, [x29, x17]
    stur x10, [x29, #-8]
    b .Lwhile_cond_153
.Lwhile_end_155:
    ldur x10, [x29, #-24]
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-480
    ldr x11, [x29, x17]
    cmp x11, #1
    b.ne .Lendif_177
    ldur x10, [x29, #-32]
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-496
    ldr x13, [x29, x17]
    adrp x14, __str_11@PAGE
    add x14, x14, __str_11@PAGEOFF
    mov x15, #0
.Lscl1_51:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_51
    add x15, x15, #1
    b .Lscl1_51
.Lscl1d_51:
    mov x9, x15
    mov x15, #0
.Lscl2_51:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_51
    add x15, x15, #1
    b .Lscl2_51
.Lscl2d_51:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_51:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_51
    strb w16, [x11], #1
    b .Lsc1_51
.Lsc2_51:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_51
    mov x10, x12
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-504
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_177:
    ldur x10, [x29, #-32]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-512
    ldr x13, [x29, x17]
    mov x14, x13
    mov x15, #0
.Lstrlen_s_52:
    ldrb w16, [x14, x15]
    cbz w16, .Lstrlen_d_52
    add x15, x15, #1
    b .Lstrlen_s_52
.Lstrlen_d_52:
    mov x10, x15
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
.Lwhile_cond_178:
    ldur x10, [x29, #-48]
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x11, [x29, x17]
    cmp x11, #0
    b.lt .Lwhile_end_180
.Lwhile_body_179:
    ldur x10, [x29, #-16]
    mov x17, #-552
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-560
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-560
    ldr x13, [x29, x17]
    mov x17, #-568
    ldr x14, [x29, x17]
    ldrb w10, [x13, x14]
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-576
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    sub x10, x29, #56
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-552
    ldr x13, [x29, x17]
    mov x17, #-584
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_53:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_53
    add x15, x15, #1
    b .Lscl1_53
.Lscl1d_53:
    mov x9, x15
    mov x15, #0
.Lscl2_53:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_53
    add x15, x15, #1
    b .Lscl2_53
.Lscl2d_53:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_53:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_53
    strb w16, [x11], #1
    b .Lsc1_53
.Lsc2_53:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_53
    mov x10, x12
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-592
    ldr x10, [x29, x17]
    stur x10, [x29, #-16]
    ldur x10, [x29, #-48]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-600
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-608
    str x10, [x29, x17]
    mov x17, #-608
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    b .Lwhile_cond_178
.Lwhile_end_180:
    ldur x10, [x29, #-16]
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-616
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #656
    ldp x29, x30, [sp], #16
    ret

_i32_to_u64:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #64
    // function i32_to_u64
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-16]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-24]
    mov x0, x10
    add sp, sp, #64
    ldp x29, x30, [sp], #16
    ret

_i64_to_u64:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #64
    // function i64_to_u64
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-16]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-24]
    mov x0, x10
    add sp, sp, #64
    ldp x29, x30, [sp], #16
    ret

_u64_to_i64:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #64
    // function u64_to_i64
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-16]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-24]
    mov x0, x10
    add sp, sp, #64
    ldp x29, x30, [sp], #16
    ret

_array_len:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #96
    // function array_len
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-24]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-32]
    stur x10, [x29, #-16]
    stur x10, [x29, #-40]
    mov x11, x10
    add x10, x11, #8
    stur x10, [x29, #-48]
    ldr w11, [x10]
    stur x11, [x29, #-56]
    mov x10, x11
    mov x0, x10
    add sp, sp, #96
    ldp x29, x30, [sp], #16
    ret

_array_len_u64:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #96
    // function array_len_u64
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-24]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-32]
    stur x10, [x29, #-16]
    stur x10, [x29, #-40]
    mov x11, x10
    add x10, x11, #8
    stur x10, [x29, #-48]
    ldr w11, [x10]
    stur x11, [x29, #-56]
    mov x10, x11
    mov x0, x10
    add sp, sp, #96
    ldp x29, x30, [sp], #16
    ret

_print:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #80
    // function print
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-16]
    mov x13, x10
    adrp x14, __str_12@PAGE
    add x14, x14, __str_12@PAGEOFF
    mov x15, #0
.Lscl1_54:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_54
    add x15, x15, #1
    b .Lscl1_54
.Lscl1d_54:
    mov x9, x15
    mov x15, #0
.Lscl2_54:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_54
    add x15, x15, #1
    b .Lscl2_54
.Lscl2d_54:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_54:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_54
    strb w16, [x11], #1
    b .Lsc1_54
.Lsc2_54:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_54
    mov x10, x12
    stur x10, [x29, #-24]
    stur x10, [x29, #-8]
    mov x0, #1
    ldur x10, [x29, #-8]
    stur x10, [x29, #-32]
    mov x11, x10
    mov x1, x11
    ldur x10, [x29, #-8]
    stur x10, [x29, #-40]
    mov x13, x10
    mov x14, x13
    mov x15, #0
.Lstrlen_s_55:
    ldrb w16, [x14, x15]
    cbz w16, .Lstrlen_d_55
    add x15, x15, #1
    b .Lstrlen_s_55
.Lstrlen_d_55:
    mov x10, x15
    stur x10, [x29, #-48]
    mov x11, x10
    mov x2, x11
    movz x16, #4, lsl #0
    movk x16, #512, lsl #16
    svc #0x80
    add sp, sp, #80
    ldp x29, x30, [sp], #16
    ret

_exit:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #48
    // function exit
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-16]
    mov x11, x10
    mov x0, x11
    movz x16, #1, lsl #0
    movk x16, #512, lsl #16
    svc #0x80
    add sp, sp, #48
    ldp x29, x30, [sp], #16
    ret

_get_time_ns:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #176
    // function get_time_ns
    adrp x10, __str_13@PAGE
    add x10, x10, __str_13@PAGEOFF
    stur x10, [x29, #-8]
    stur x10, [x29, #-40]
    mov x11, x10
    mov x0, x11
    mov x1, #0
    movz x16, #116, lsl #0
    movk x16, #512, lsl #16
    svc #0x80
    ldur x10, [x29, #-8]
    stur x10, [x29, #-48]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-56]
    stur x10, [x29, #-16]
    stur x10, [x29, #-64]
    ldr x11, [x10]
    stur x11, [x29, #-72]
    mov x10, x11
    stur x10, [x29, #-24]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-80]
    mov x11, x10
    add x10, x11, #8
    stur x10, [x29, #-88]
    ldr x11, [x10]
    stur x11, [x29, #-96]
    mov x10, x11
    stur x10, [x29, #-32]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-104]
    mov x11, x10
    movz x12, #51712, lsl #0
    movk x12, #15258, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-112]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-120]
    mov x11, x10
    mov x12, #1000
    mul x10, x11, x12
    stur x10, [x29, #-128]
    ldur x11, [x29, #-112]
    ldur x12, [x29, #-128]
    add x10, x11, x12
    stur x10, [x29, #-136]
    mov x0, x10
    add sp, sp, #176
    ldp x29, x30, [sp], #16
    ret

_input:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #320
    // function input
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    mov x0, #1
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    mov x11, x10
    mov x1, x11
    ldur x10, [x29, #-8]
    stur x10, [x29, #-72]
    mov x13, x10
    mov x14, x13
    mov x15, #0
.Lstrlen_s_56:
    ldrb w16, [x14, x15]
    cbz w16, .Lstrlen_d_56
    add x15, x15, #1
    b .Lstrlen_s_56
.Lstrlen_d_56:
    mov x10, x15
    stur x10, [x29, #-80]
    mov x11, x10
    mov x2, x11
    movz x16, #4, lsl #0
    movk x16, #512, lsl #16
    svc #0x80
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-24]
.Lwhile_cond_181:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-88]
    mov x13, x10
    mov x14, x13
    mov x15, #0
.Lstrlen_s_57:
    ldrb w16, [x14, x15]
    cbz w16, .Lstrlen_d_57
    add x15, x15, #1
    b .Lstrlen_s_57
.Lstrlen_d_57:
    mov x10, x15
    stur x10, [x29, #-96]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-104]
    ldur x11, [x29, #-96]
    ldur x12, [x29, #-104]
    cmp x11, x12
    b.ge .Lwhile_end_183
.Lwhile_body_182:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-120]
    mov x13, x10
    adrp x14, __str_14@PAGE
    add x14, x14, __str_14@PAGEOFF
    mov x15, #0
.Lscl1_58:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_58
    add x15, x15, #1
    b .Lscl1_58
.Lscl1d_58:
    mov x9, x15
    mov x15, #0
.Lscl2_58:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_58
    add x15, x15, #1
    b .Lscl2_58
.Lscl2d_58:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_58:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_58
    strb w16, [x11], #1
    b .Lsc1_58
.Lsc2_58:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_58
    mov x10, x12
    stur x10, [x29, #-128]
    stur x10, [x29, #-24]
    b .Lwhile_cond_181
.Lwhile_end_183:
    mov x0, #0
    ldur x10, [x29, #-24]
    stur x10, [x29, #-136]
    mov x11, x10
    mov x1, x11
    ldur x10, [x29, #-16]
    stur x10, [x29, #-144]
    mov x11, x10
    mov x2, x11
    movz x16, #3, lsl #0
    movk x16, #512, lsl #16
    svc #0x80
    mov x10, x0
    stur x10, [x29, #-152]
    mov x0, x10
    bl _u64_to_i32
    mov x10, x0
    stur x10, [x29, #-160]
    stur x10, [x29, #-32]
    adrp x10, __str_0@PAGE
    add x10, x10, __str_0@PAGEOFF
    stur x10, [x29, #-40]
    mov x10, #0
    stur x10, [x29, #-48]
.Lwhile_cond_184:
    ldur x10, [x29, #-48]
    stur x10, [x29, #-168]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-176]
    ldur x11, [x29, #-168]
    ldur x12, [x29, #-176]
    cmp x11, x12
    b.ge .Lwhile_end_186
.Lwhile_body_185:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-192]
    ldur x10, [x29, #-48]
    stur x10, [x29, #-200]
    ldur x13, [x29, #-192]
    ldur x14, [x29, #-200]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-208]
    mov x11, x10
    cmp x11, #10
    b.ne .Lendif_188
    b .Lwhile_end_186
.Lendif_188:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-224]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-232]
    ldur x10, [x29, #-48]
    stur x10, [x29, #-240]
    ldur x13, [x29, #-232]
    ldur x14, [x29, #-240]
    ldrb w10, [x13, x14]
    stur x10, [x29, #-248]
    stur x10, [x29, #-56]
    sub x10, x29, #56
    stur x10, [x29, #-256]
    ldur x13, [x29, #-224]
    ldur x14, [x29, #-256]
    mov x15, #0
.Lscl1_59:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_59
    add x15, x15, #1
    b .Lscl1_59
.Lscl1d_59:
    mov x9, x15
    mov x15, #0
.Lscl2_59:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_59
    add x15, x15, #1
    b .Lscl2_59
.Lscl2d_59:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_59:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_59
    strb w16, [x11], #1
    b .Lsc1_59
.Lsc2_59:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_59
    mov x10, x12
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-48]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-280
    str x10, [x29, x17]
    mov x17, #-280
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    b .Lwhile_cond_184
.Lwhile_end_186:
    ldur x10, [x29, #-40]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #320
    ldp x29, x30, [sp], #16
    ret

_ptr:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #64
    // function ptr
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-16]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-24]
    mov x0, x10
    add sp, sp, #64
    ldp x29, x30, [sp], #16
    ret

_array_data_ptr_u64:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #80
    // function array_data_ptr_u64
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-24]
    mov x11, x10
    mov x9, x11
    mov x10, x9
    stur x10, [x29, #-32]
    stur x10, [x29, #-16]
    stur x10, [x29, #-40]
    ldr x11, [x10]
    stur x11, [x29, #-48]
    mov x10, x11
    mov x0, x10
    add sp, sp, #80
    ldp x29, x30, [sp], #16
    ret

_execve_raw:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #160
    // function execve_raw
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    mov x10, x1
    stur x10, [x29, #-48]
    mov x0, x10
    bl _array_data_ptr_u64
    mov x10, x0
    stur x10, [x29, #-56]
    stur x10, [x29, #-24]
    mov x0, #56
    bl __novus_heap_alloc
    mov x12, x0
    add x13, x0, #24
    str x13, [x12, #0]
    str xzr, [x12, #8]
    mov x14, #4
    str x14, [x12, #16]
    mov x10, x12
    stur x10, [x29, #-64]
    mov x11, x10
    mov x12, #0
    ldr x13, [x11, #8]
    ldr x14, [x11, #16]
    cmp x13, x14
    b.lt .Laang_60
    lsl x14, x14, #1
    cmp x14, #4
    b.ge .Laaco_60
    mov x14, #4
.Laaco_60:
    stp x11, x12, [sp, #-16]!
    stp x13, x14, [sp, #-16]!
    lsl x0, x14, #3
    bl __novus_heap_alloc
    mov x17, x0
    ldp x13, x14, [sp], #16
    ldp x11, x12, [sp], #16
    ldr x16, [x11, #0]
    mov x9, #0
.Laacp_60:
    cmp x9, x13
    b.ge .Laacd_60
    ldr x18, [x16, x9, lsl #3]
    str x18, [x17, x9, lsl #3]
    add x9, x9, #1
    b .Laacp_60
.Laacd_60:
    str x17, [x11, #0]
    str x14, [x11, #16]
.Laang_60:
    ldr x16, [x11, #0]
    str x12, [x16, x13, lsl #3]
    add x13, x13, #1
    str x13, [x11, #8]
    ldur x10, [x29, #-64]
    stur x10, [x29, #-32]
    stur x10, [x29, #-72]
    mov x0, x10
    bl _array_data_ptr_u64
    mov x10, x0
    stur x10, [x29, #-80]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-88]
    mov x11, x10
    mov x0, x11
    ldur x10, [x29, #-24]
    stur x10, [x29, #-96]
    mov x11, x10
    mov x1, x11
    ldur x10, [x29, #-40]
    stur x10, [x29, #-104]
    mov x11, x10
    mov x2, x11
    movz x11, #0, lsl #0
    movk x11, #512, lsl #16
    add x10, x11, #59
    stur x10, [x29, #-112]
    mov x11, x10
    mov x16, x11
    svc #0x80
    mov x10, x0
    stur x10, [x29, #-120]
    mov x0, x10
    bl _u64_to_i32
    mov x10, x0
    stur x10, [x29, #-128]
    mov x0, x10
    add sp, sp, #160
    ldp x29, x30, [sp], #16
    ret

_fork:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #128
    // function fork
    movz x11, #0, lsl #0
    movk x11, #512, lsl #16
    add x10, x11, #2
    stur x10, [x29, #-32]
    mov x11, x10
    mov x16, x11
    svc #0x80
    mov x10, x0
    stur x10, [x29, #-40]
    stur x10, [x29, #-8]
    mov x10, x1
    stur x10, [x29, #-48]
    stur x10, [x29, #-16]
    stur x10, [x29, #-56]
    mov x0, x10
    bl _u64_to_i32
    mov x10, x0
    stur x10, [x29, #-64]
    stur x10, [x29, #-24]
    stur x10, [x29, #-72]
    mov x11, x10
    cmp x11, #1
    b.ne .Lendif_190
    mov x0, #0
    add sp, sp, #128
    ldp x29, x30, [sp], #16
    ret
.Lendif_190:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-88]
    mov x0, x10
    bl _u64_to_i32
    mov x10, x0
    stur x10, [x29, #-96]
    mov x0, x10
    add sp, sp, #128
    ldp x29, x30, [sp], #16
    ret

_spawn_execve:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #128
    // function spawn_execve
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    bl _fork
    mov x10, x0
    stur x10, [x29, #-32]
    stur x10, [x29, #-24]
    stur x10, [x29, #-40]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_192
    ldur x10, [x29, #-8]
    stur x10, [x29, #-56]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-56]
    mov x0, x10
    ldur x10, [x29, #-64]
    mov x1, x10
    bl _execve_raw
    mov x10, x0
    stur x10, [x29, #-72]
    mov x0, #1
    bl _exit
    mov x10, x0
    stur x10, [x29, #-80]
    mov x0, #1
    add sp, sp, #128
    ldp x29, x30, [sp], #16
    ret
.Lendif_192:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-88]
    mov x0, x10
    add sp, sp, #128
    ldp x29, x30, [sp], #16
    ret

_BLOCK_AIR:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_AIR
    mov x0, #0
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_STONE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_STONE
    mov x0, #1
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_GRANITE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_GRANITE
    mov x0, #2
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_DIORITE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_DIORITE
    mov x0, #4
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_ANDESITE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_ANDESITE
    mov x0, #6
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_GRASS_BLOCK:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_GRASS_BLOCK
    mov x0, #9
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_DIRT:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_DIRT
    mov x0, #10
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_COARSE_DIRT:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_COARSE_DIRT
    mov x0, #11
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_COBBLESTONE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_COBBLESTONE
    mov x0, #14
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_BEDROCK:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_BEDROCK
    mov x0, #85
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_WATER:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_WATER
    mov x0, #86
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_SAND:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_SAND
    mov x0, #118
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_GRAVEL:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_GRAVEL
    mov x0, #124
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_COAL_ORE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_COAL_ORE
    mov x0, #133
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_IRON_ORE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_IRON_ORE
    mov x0, #131
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_GOLD_ORE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_GOLD_ORE
    mov x0, #129
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_DIAMOND_ORE:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_DIAMOND_ORE
    mov x0, #5106
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_OAK_LOG:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_OAK_LOG
    mov x0, #137
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_OAK_LEAVES:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_OAK_LEAVES
    mov x0, #279
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_BLOCK_SNOW_BLOCK:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function BLOCK_SNOW_BLOCK
    mov x0, #6727
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_SEA_LEVEL:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #32
    // function SEA_LEVEL
    mov x0, #62
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret

_trunc32:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #192
    // function trunc32
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-40]
    mov x11, x10
    mov x12, #65535
    and x10, x11, x12
    stur x10, [x29, #-48]
    stur x10, [x29, #-16]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-56]
    mov x11, x10
    mov x12, #16
    asr x10, x11, x12
    stur x10, [x29, #-64]
    mov x11, x10
    mov x12, #65535
    and x10, x11, x12
    stur x10, [x29, #-72]
    stur x10, [x29, #-24]
    stur x10, [x29, #-80]
    mov x11, x10
    mov x12, #16
    lsl x10, x11, x12
    stur x10, [x29, #-88]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-96]
    ldur x11, [x29, #-88]
    ldur x12, [x29, #-96]
    orr x10, x11, x12
    stur x10, [x29, #-104]
    stur x10, [x29, #-32]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-112]
    mov x11, x10
    mov x12, #32768
    cmp x11, x12
    b.lt .Lendif_194
    ldur x10, [x29, #-32]
    stur x10, [x29, #-128]
    mov x11, x10
    movz x12, #65535, lsl #0
    movk x12, #32767, lsl #16
    sub x10, x11, x12
    stur x10, [x29, #-136]
    mov x11, x10
    movz x12, #65535, lsl #0
    movk x12, #32767, lsl #16
    sub x10, x11, x12
    stur x10, [x29, #-144]
    mov x11, x10
    sub x10, x11, #2
    stur x10, [x29, #-152]
    stur x10, [x29, #-32]
.Lendif_194:
    ldur x10, [x29, #-32]
    stur x10, [x29, #-160]
    mov x0, x10
    add sp, sp, #192
    ldp x29, x30, [sp], #16
    ret

_terrain_hash:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #304
    // function terrain_hash
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    mov x10, x2
    stur x10, [x29, #-40]
    stur x10, [x29, #-32]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-56]
    mov x11, x10
    movz x12, #26545, lsl #0
    movk x12, #5718, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-64]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-72]
    ldur x11, [x29, #-48]
    ldur x12, [x29, #-72]
    add x10, x11, x12
    stur x10, [x29, #-80]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-88]
    stur x10, [x29, #-32]
    stur x10, [x29, #-96]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-104]
    mov x11, x10
    movz x12, #60207, lsl #0
    movk x12, #10196, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-112]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-120]
    ldur x11, [x29, #-96]
    ldur x12, [x29, #-120]
    add x10, x11, x12
    stur x10, [x29, #-128]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-136]
    stur x10, [x29, #-32]
    stur x10, [x29, #-144]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-152]
    mov x11, x10
    mov x12, #13
    asr x10, x11, x12
    stur x10, [x29, #-160]
    ldur x11, [x29, #-144]
    ldur x12, [x29, #-160]
    eor x10, x11, x12
    stur x10, [x29, #-168]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-176]
    mov x11, x10
    movz x12, #40801, lsl #0
    movk x12, #19441, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-184]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-192]
    stur x10, [x29, #-32]
    stur x10, [x29, #-200]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-208]
    mov x11, x10
    mov x12, #16
    asr x10, x11, x12
    stur x10, [x29, #-216]
    ldur x11, [x29, #-200]
    ldur x12, [x29, #-216]
    eor x10, x11, x12
    stur x10, [x29, #-224]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-232]
    stur x10, [x29, #-32]
    stur x10, [x29, #-240]
    mov x11, x10
    cmp x11, #0
    b.ge .Lendif_196
    ldur x10, [x29, #-32]
    stur x10, [x29, #-256]
    mov x11, #0
    ldur x12, [x29, #-256]
    sub x10, x11, x12
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-32]
.Lendif_196:
    ldur x10, [x29, #-32]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #304
    ldp x29, x30, [sp], #16
    ret

_terrain_hash3:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #368
    // function terrain_hash3
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    stur x3, [x29, #-32]
    mov x10, x3
    stur x10, [x29, #-48]
    stur x10, [x29, #-40]
    stur x10, [x29, #-56]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    mov x11, x10
    movz x12, #26545, lsl #0
    movk x12, #5718, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-72]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-80]
    ldur x11, [x29, #-56]
    ldur x12, [x29, #-80]
    add x10, x11, x12
    stur x10, [x29, #-88]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-96]
    stur x10, [x29, #-40]
    stur x10, [x29, #-104]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-112]
    mov x11, x10
    movz x12, #46219, lsl #0
    movk x12, #17555, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-120]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-128]
    ldur x11, [x29, #-104]
    ldur x12, [x29, #-128]
    add x10, x11, x12
    stur x10, [x29, #-136]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-144]
    stur x10, [x29, #-40]
    stur x10, [x29, #-152]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-160]
    mov x11, x10
    movz x12, #60207, lsl #0
    movk x12, #10196, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-168]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-176]
    ldur x11, [x29, #-152]
    ldur x12, [x29, #-176]
    add x10, x11, x12
    stur x10, [x29, #-184]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-192]
    stur x10, [x29, #-40]
    stur x10, [x29, #-200]
    ldur x10, [x29, #-40]
    stur x10, [x29, #-208]
    mov x11, x10
    mov x12, #13
    asr x10, x11, x12
    stur x10, [x29, #-216]
    ldur x11, [x29, #-200]
    ldur x12, [x29, #-216]
    eor x10, x11, x12
    stur x10, [x29, #-224]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-232]
    mov x11, x10
    movz x12, #40801, lsl #0
    movk x12, #19441, lsl #16
    mul x10, x11, x12
    stur x10, [x29, #-240]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    stur x10, [x29, #-248]
    stur x10, [x29, #-40]
    stur x10, [x29, #-256]
    ldur x10, [x29, #-40]
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x11, [x29, x17]
    mov x12, #16
    asr x10, x11, x12
    mov x17, #-272
    str x10, [x29, x17]
    ldur x11, [x29, #-256]
    mov x17, #-272
    ldr x12, [x29, x17]
    eor x10, x11, x12
    mov x17, #-280
    str x10, [x29, x17]
    mov x17, #-280
    ldr x10, [x29, x17]
    mov x0, x10
    bl _trunc32
    mov x10, x0
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ge .Lendif_198
    ldur x10, [x29, #-40]
    mov x17, #-312
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-312
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
.Lendif_198:
    ldur x10, [x29, #-40]
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #368
    ldp x29, x30, [sp], #16
    ret

_grad2d:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #176
    // function grad2d
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-40]
    mov x11, x10
    mov x12, #3
    and x10, x11, x12
    stur x10, [x29, #-48]
    stur x10, [x29, #-32]
    stur x10, [x29, #-56]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_200
    ldur x10, [x29, #-16]
    stur x10, [x29, #-72]
    mov x0, x10
    add sp, sp, #176
    ldp x29, x30, [sp], #16
    ret
.Lendif_200:
    ldur x10, [x29, #-32]
    stur x10, [x29, #-80]
    mov x11, x10
    cmp x11, #1
    b.ne .Lendif_202
    ldur x10, [x29, #-16]
    stur x10, [x29, #-96]
    mov x11, #0
    ldur x12, [x29, #-96]
    sub x10, x11, x12
    stur x10, [x29, #-104]
    mov x0, x10
    add sp, sp, #176
    ldp x29, x30, [sp], #16
    ret
.Lendif_202:
    ldur x10, [x29, #-32]
    stur x10, [x29, #-112]
    mov x11, x10
    cmp x11, #2
    b.ne .Lendif_204
    ldur x10, [x29, #-24]
    stur x10, [x29, #-128]
    mov x0, x10
    add sp, sp, #176
    ldp x29, x30, [sp], #16
    ret
.Lendif_204:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-136]
    mov x11, #0
    ldur x12, [x29, #-136]
    sub x10, x11, x12
    stur x10, [x29, #-144]
    mov x0, x10
    add sp, sp, #176
    ldp x29, x30, [sp], #16
    ret

_fade:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #160
    // function fade
    stur x0, [x29, #-8]
    mov x10, x0
    stur x10, [x29, #-32]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-40]
    ldur x11, [x29, #-32]
    ldur x12, [x29, #-40]
    mul x10, x11, x12
    stur x10, [x29, #-48]
    mov x11, x10
    mov x12, #256
    sdiv x10, x11, x12
    stur x10, [x29, #-56]
    stur x10, [x29, #-16]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-72]
    ldur x11, [x29, #-64]
    ldur x12, [x29, #-72]
    mul x10, x11, x12
    stur x10, [x29, #-80]
    mov x11, x10
    mov x12, #256
    sdiv x10, x11, x12
    stur x10, [x29, #-88]
    stur x10, [x29, #-24]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-96]
    mov x11, #3
    ldur x12, [x29, #-96]
    mul x10, x11, x12
    stur x10, [x29, #-104]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-112]
    mov x11, #2
    ldur x12, [x29, #-112]
    mul x10, x11, x12
    stur x10, [x29, #-120]
    ldur x11, [x29, #-104]
    ldur x12, [x29, #-120]
    sub x10, x11, x12
    stur x10, [x29, #-128]
    mov x0, x10
    add sp, sp, #160
    ldp x29, x30, [sp], #16
    ret

_lerp:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #128
    // function lerp
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-32]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-48]
    ldur x11, [x29, #-40]
    ldur x12, [x29, #-48]
    sub x10, x11, x12
    stur x10, [x29, #-56]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-64]
    ldur x11, [x29, #-56]
    ldur x12, [x29, #-64]
    mul x10, x11, x12
    stur x10, [x29, #-72]
    mov x11, x10
    mov x12, #256
    sdiv x10, x11, x12
    stur x10, [x29, #-80]
    ldur x11, [x29, #-32]
    ldur x12, [x29, #-80]
    add x10, x11, x12
    stur x10, [x29, #-88]
    mov x0, x10
    add sp, sp, #128
    ldp x29, x30, [sp], #16
    ret

_noise2d:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #736
    // function noise2d
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-160]
    mov x11, x10
    mov x12, #8
    asr x10, x11, x12
    stur x10, [x29, #-168]
    stur x10, [x29, #-32]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-176]
    mov x11, x10
    mov x12, #8
    asr x10, x11, x12
    stur x10, [x29, #-184]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-192]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-200]
    mov x11, x10
    mov x12, #256
    mul x10, x11, x12
    stur x10, [x29, #-208]
    ldur x11, [x29, #-192]
    ldur x12, [x29, #-208]
    sub x10, x11, x12
    stur x10, [x29, #-216]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-224]
    ldur x10, [x29, #-40]
    stur x10, [x29, #-232]
    mov x11, x10
    mov x12, #256
    mul x10, x11, x12
    stur x10, [x29, #-240]
    ldur x11, [x29, #-224]
    ldur x12, [x29, #-240]
    sub x10, x11, x12
    stur x10, [x29, #-248]
    stur x10, [x29, #-56]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-256]
    ldur x10, [x29, #-40]
    mov x17, #-264
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-272
    str x10, [x29, x17]
    ldur x10, [x29, #-256]
    mov x0, x10
    mov x17, #-264
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-272
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_hash
    mov x10, x0
    mov x17, #-280
    str x10, [x29, x17]
    mov x17, #-280
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-32]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-296
    str x10, [x29, x17]
    ldur x10, [x29, #-40]
    mov x17, #-304
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-312
    str x10, [x29, x17]
    mov x17, #-296
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-304
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-312
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_hash
    mov x10, x0
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x10, [x29, x17]
    stur x10, [x29, #-72]
    ldur x10, [x29, #-32]
    mov x17, #-328
    str x10, [x29, x17]
    ldur x10, [x29, #-40]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-344
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-328
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-344
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-352
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_hash
    mov x10, x0
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
    ldur x10, [x29, #-32]
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-368
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-376
    str x10, [x29, x17]
    ldur x10, [x29, #-40]
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-384
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-392
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-376
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-392
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-400
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_hash
    mov x10, x0
    mov x17, #-408
    str x10, [x29, x17]
    mov x17, #-408
    ldr x10, [x29, x17]
    stur x10, [x29, #-88]
    ldur x10, [x29, #-64]
    mov x17, #-416
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-424
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-432
    str x10, [x29, x17]
    mov x17, #-416
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-424
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-432
    ldr x10, [x29, x17]
    mov x2, x10
    bl _grad2d
    mov x10, x0
    mov x17, #-440
    str x10, [x29, x17]
    mov x17, #-440
    ldr x10, [x29, x17]
    stur x10, [x29, #-96]
    ldur x10, [x29, #-72]
    mov x17, #-448
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-456
    ldr x11, [x29, x17]
    sub x10, x11, #256
    mov x17, #-464
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-448
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-464
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-472
    ldr x10, [x29, x17]
    mov x2, x10
    bl _grad2d
    mov x10, x0
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-480
    ldr x10, [x29, x17]
    stur x10, [x29, #-104]
    ldur x10, [x29, #-80]
    mov x17, #-488
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-496
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-504
    ldr x11, [x29, x17]
    sub x10, x11, #256
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-488
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-496
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-512
    ldr x10, [x29, x17]
    mov x2, x10
    bl _grad2d
    mov x10, x0
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x10, [x29, x17]
    stur x10, [x29, #-112]
    ldur x10, [x29, #-88]
    mov x17, #-528
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x11, [x29, x17]
    sub x10, x11, #256
    mov x17, #-544
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-552
    str x10, [x29, x17]
    mov x17, #-552
    ldr x11, [x29, x17]
    sub x10, x11, #256
    mov x17, #-560
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-544
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-560
    ldr x10, [x29, x17]
    mov x2, x10
    bl _grad2d
    mov x10, x0
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-568
    ldr x10, [x29, x17]
    stur x10, [x29, #-120]
    ldur x10, [x29, #-48]
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-576
    ldr x10, [x29, x17]
    mov x0, x10
    bl _fade
    mov x10, x0
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-584
    ldr x10, [x29, x17]
    stur x10, [x29, #-128]
    ldur x10, [x29, #-56]
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-592
    ldr x10, [x29, x17]
    mov x0, x10
    bl _fade
    mov x10, x0
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-600
    ldr x10, [x29, x17]
    stur x10, [x29, #-136]
    ldur x10, [x29, #-96]
    mov x17, #-608
    str x10, [x29, x17]
    ldur x10, [x29, #-104]
    mov x17, #-616
    str x10, [x29, x17]
    ldur x10, [x29, #-128]
    mov x17, #-624
    str x10, [x29, x17]
    mov x17, #-608
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-616
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-624
    ldr x10, [x29, x17]
    mov x2, x10
    bl _lerp
    mov x10, x0
    mov x17, #-632
    str x10, [x29, x17]
    mov x17, #-632
    ldr x10, [x29, x17]
    stur x10, [x29, #-144]
    ldur x10, [x29, #-112]
    mov x17, #-640
    str x10, [x29, x17]
    ldur x10, [x29, #-120]
    mov x17, #-648
    str x10, [x29, x17]
    ldur x10, [x29, #-128]
    mov x17, #-656
    str x10, [x29, x17]
    mov x17, #-640
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-648
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-656
    ldr x10, [x29, x17]
    mov x2, x10
    bl _lerp
    mov x10, x0
    mov x17, #-664
    str x10, [x29, x17]
    mov x17, #-664
    ldr x10, [x29, x17]
    stur x10, [x29, #-152]
    ldur x10, [x29, #-144]
    mov x17, #-672
    str x10, [x29, x17]
    ldur x10, [x29, #-152]
    mov x17, #-680
    str x10, [x29, x17]
    ldur x10, [x29, #-136]
    mov x17, #-688
    str x10, [x29, x17]
    mov x17, #-672
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-680
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-688
    ldr x10, [x29, x17]
    mov x2, x10
    bl _lerp
    mov x10, x0
    mov x17, #-696
    str x10, [x29, x17]
    mov x17, #-696
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #736
    ldp x29, x30, [sp], #16
    ret

_octave_noise2d:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #800
    // function octave_noise2d
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    stur x3, [x29, #-32]
    mov x10, #0
    stur x10, [x29, #-40]
    mov x10, #256
    stur x10, [x29, #-48]
    mov x10, #1
    stur x10, [x29, #-56]
    mov x10, #0
    stur x10, [x29, #-64]
    mov x10, #5347
    stur x10, [x29, #-72]
    mov x10, #1731
    stur x10, [x29, #-80]
    mov x10, #5903
    stur x10, [x29, #-88]
    mov x10, #10337
    stur x10, [x29, #-96]
    mov x10, #17291
    stur x10, [x29, #-104]
    mov x10, #24571
    stur x10, [x29, #-112]
    mov x10, #2917
    stur x10, [x29, #-120]
    mov x10, #3557
    stur x10, [x29, #-128]
    mov x10, #7919
    stur x10, [x29, #-136]
    mov x10, #13177
    stur x10, [x29, #-144]
    mov x10, #19433
    stur x10, [x29, #-152]
    mov x10, #28657
    stur x10, [x29, #-160]
    mov x10, #0
    stur x10, [x29, #-168]
.Lwhile_cond_205:
    ldur x10, [x29, #-168]
    stur x10, [x29, #-216]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-224]
    ldur x11, [x29, #-216]
    ldur x12, [x29, #-224]
    cmp x11, x12
    b.ge .Lwhile_end_207
.Lwhile_body_206:
    mov x10, #0
    stur x10, [x29, #-176]
    mov x10, #0
    stur x10, [x29, #-184]
    ldur x10, [x29, #-168]
    stur x10, [x29, #-240]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_209
    ldur x10, [x29, #-72]
    stur x10, [x29, #-256]
    stur x10, [x29, #-176]
    ldur x10, [x29, #-120]
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-184]
.Lendif_209:
    ldur x10, [x29, #-168]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    cmp x11, #1
    b.ne .Lendif_211
    ldur x10, [x29, #-80]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-288
    ldr x10, [x29, x17]
    stur x10, [x29, #-176]
    ldur x10, [x29, #-128]
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x10, [x29, x17]
    stur x10, [x29, #-184]
.Lendif_211:
    ldur x10, [x29, #-168]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x11, [x29, x17]
    cmp x11, #2
    b.ne .Lendif_213
    ldur x10, [x29, #-88]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x10, [x29, x17]
    stur x10, [x29, #-176]
    ldur x10, [x29, #-136]
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x10, [x29, x17]
    stur x10, [x29, #-184]
.Lendif_213:
    ldur x10, [x29, #-168]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x11, [x29, x17]
    cmp x11, #3
    b.ne .Lendif_215
    ldur x10, [x29, #-96]
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x10, [x29, x17]
    stur x10, [x29, #-176]
    ldur x10, [x29, #-144]
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x10, [x29, x17]
    stur x10, [x29, #-184]
.Lendif_215:
    ldur x10, [x29, #-168]
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-368
    ldr x11, [x29, x17]
    cmp x11, #4
    b.ne .Lendif_217
    ldur x10, [x29, #-104]
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-384
    ldr x10, [x29, x17]
    stur x10, [x29, #-176]
    ldur x10, [x29, #-152]
    mov x17, #-392
    str x10, [x29, x17]
    mov x17, #-392
    ldr x10, [x29, x17]
    stur x10, [x29, #-184]
.Lendif_217:
    ldur x10, [x29, #-168]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-400
    ldr x11, [x29, x17]
    cmp x11, #5
    b.ne .Lendif_219
    ldur x10, [x29, #-112]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x10, [x29, x17]
    stur x10, [x29, #-176]
    ldur x10, [x29, #-160]
    mov x17, #-424
    str x10, [x29, x17]
    mov x17, #-424
    ldr x10, [x29, x17]
    stur x10, [x29, #-184]
.Lendif_219:
    ldur x10, [x29, #-8]
    mov x17, #-432
    str x10, [x29, x17]
    ldur x10, [x29, #-176]
    mov x17, #-440
    str x10, [x29, x17]
    mov x17, #-432
    ldr x11, [x29, x17]
    mov x17, #-440
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-448
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-448
    ldr x11, [x29, x17]
    mov x17, #-456
    ldr x12, [x29, x17]
    mul x10, x11, x12
    mov x17, #-464
    str x10, [x29, x17]
    mov x17, #-464
    ldr x11, [x29, x17]
    mov x12, #256
    mul x10, x11, x12
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x11, [x29, x17]
    mov x12, #128
    sdiv x10, x11, x12
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-480
    ldr x10, [x29, x17]
    stur x10, [x29, #-192]
    ldur x10, [x29, #-16]
    mov x17, #-488
    str x10, [x29, x17]
    ldur x10, [x29, #-184]
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-488
    ldr x11, [x29, x17]
    mov x17, #-496
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-504
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-504
    ldr x11, [x29, x17]
    mov x17, #-512
    ldr x12, [x29, x17]
    mul x10, x11, x12
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x11, [x29, x17]
    mov x12, #256
    mul x10, x11, x12
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x11, [x29, x17]
    mov x12, #128
    sdiv x10, x11, x12
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x10, [x29, x17]
    stur x10, [x29, #-200]
    ldur x10, [x29, #-192]
    mov x17, #-544
    str x10, [x29, x17]
    ldur x10, [x29, #-200]
    mov x17, #-552
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-560
    str x10, [x29, x17]
    ldur x10, [x29, #-168]
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-568
    ldr x11, [x29, x17]
    mov x12, #31337
    mul x10, x11, x12
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-560
    ldr x11, [x29, x17]
    mov x17, #-576
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-544
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-552
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-584
    ldr x10, [x29, x17]
    mov x2, x10
    bl _noise2d
    mov x10, x0
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-592
    ldr x10, [x29, x17]
    stur x10, [x29, #-208]
    ldur x10, [x29, #-40]
    mov x17, #-600
    str x10, [x29, x17]
    ldur x10, [x29, #-208]
    mov x17, #-608
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-608
    ldr x11, [x29, x17]
    mov x17, #-616
    ldr x12, [x29, x17]
    mul x10, x11, x12
    mov x17, #-624
    str x10, [x29, x17]
    mov x17, #-624
    ldr x11, [x29, x17]
    mov x12, #256
    sdiv x10, x11, x12
    mov x17, #-632
    str x10, [x29, x17]
    mov x17, #-600
    ldr x11, [x29, x17]
    mov x17, #-632
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-640
    str x10, [x29, x17]
    mov x17, #-640
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-64]
    mov x17, #-648
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-656
    str x10, [x29, x17]
    mov x17, #-648
    ldr x11, [x29, x17]
    mov x17, #-656
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-664
    str x10, [x29, x17]
    mov x17, #-664
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-48]
    mov x17, #-672
    str x10, [x29, x17]
    mov x17, #-672
    ldr x11, [x29, x17]
    mov x12, #2
    sdiv x10, x11, x12
    mov x17, #-680
    str x10, [x29, x17]
    mov x17, #-680
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-56]
    mov x17, #-688
    str x10, [x29, x17]
    mov x17, #-688
    ldr x11, [x29, x17]
    mov x12, #2
    mul x10, x11, x12
    mov x17, #-696
    str x10, [x29, x17]
    mov x17, #-696
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    ldur x10, [x29, #-168]
    mov x17, #-704
    str x10, [x29, x17]
    mov x17, #-704
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-712
    str x10, [x29, x17]
    mov x17, #-712
    ldr x10, [x29, x17]
    stur x10, [x29, #-168]
    b .Lwhile_cond_205
.Lwhile_end_207:
    ldur x10, [x29, #-64]
    mov x17, #-720
    str x10, [x29, x17]
    mov x17, #-720
    ldr x11, [x29, x17]
    cmp x11, #0
    b.le .Lendif_221
    ldur x10, [x29, #-40]
    mov x17, #-736
    str x10, [x29, x17]
    mov x17, #-736
    ldr x11, [x29, x17]
    mov x12, #256
    mul x10, x11, x12
    mov x17, #-744
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-752
    str x10, [x29, x17]
    mov x17, #-744
    ldr x11, [x29, x17]
    mov x17, #-752
    ldr x12, [x29, x17]
    sdiv x10, x11, x12
    mov x17, #-760
    str x10, [x29, x17]
    mov x17, #-760
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
.Lendif_221:
    ldur x10, [x29, #-40]
    mov x17, #-768
    str x10, [x29, x17]
    mov x17, #-768
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #800
    ldp x29, x30, [sp], #16
    ret

_noise3d_simple:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #400
    // function noise3d_simple
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    stur x3, [x29, #-32]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    mov x11, x10
    add x10, x11, #173
    stur x10, [x29, #-72]
    mov x11, x10
    mov x12, #256
    mul x10, x11, x12
    stur x10, [x29, #-80]
    mov x11, x10
    mov x12, #16
    sdiv x10, x11, x12
    stur x10, [x29, #-88]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-96]
    mov x11, x10
    add x10, x11, #491
    stur x10, [x29, #-104]
    mov x11, x10
    mov x12, #256
    mul x10, x11, x12
    stur x10, [x29, #-112]
    mov x11, x10
    mov x12, #16
    sdiv x10, x11, x12
    stur x10, [x29, #-120]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-128]
    ldur x10, [x29, #-88]
    mov x0, x10
    ldur x10, [x29, #-120]
    mov x1, x10
    ldur x10, [x29, #-128]
    mov x2, x10
    bl _noise2d
    mov x10, x0
    stur x10, [x29, #-136]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-144]
    mov x11, x10
    add x10, x11, #337
    stur x10, [x29, #-152]
    mov x11, x10
    mov x12, #256
    mul x10, x11, x12
    stur x10, [x29, #-160]
    mov x11, x10
    mov x12, #16
    sdiv x10, x11, x12
    stur x10, [x29, #-168]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-176]
    mov x11, x10
    add x10, x11, #619
    stur x10, [x29, #-184]
    mov x11, x10
    mov x12, #256
    mul x10, x11, x12
    stur x10, [x29, #-192]
    mov x11, x10
    mov x12, #16
    sdiv x10, x11, x12
    stur x10, [x29, #-200]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-208]
    mov x11, x10
    mov x12, #12345
    add x10, x11, x12
    stur x10, [x29, #-216]
    ldur x10, [x29, #-168]
    mov x0, x10
    ldur x10, [x29, #-200]
    mov x1, x10
    ldur x10, [x29, #-216]
    mov x2, x10
    bl _noise2d
    mov x10, x0
    stur x10, [x29, #-224]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-232]
    mov x11, x10
    add x10, x11, #251
    stur x10, [x29, #-240]
    mov x11, x10
    mov x12, #256
    mul x10, x11, x12
    stur x10, [x29, #-248]
    mov x11, x10
    mov x12, #16
    sdiv x10, x11, x12
    stur x10, [x29, #-256]
    ldur x10, [x29, #-24]
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x11, [x29, x17]
    add x10, x11, #773
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    mov x12, #256
    mul x10, x11, x12
    mov x17, #-280
    str x10, [x29, x17]
    mov x17, #-280
    ldr x11, [x29, x17]
    mov x12, #16
    sdiv x10, x11, x12
    mov x17, #-288
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x11, [x29, x17]
    movz x12, #2354, lsl #0
    movk x12, #1, lsl #16
    add x10, x11, x12
    mov x17, #-304
    str x10, [x29, x17]
    ldur x10, [x29, #-256]
    mov x0, x10
    mov x17, #-288
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-304
    ldr x10, [x29, x17]
    mov x2, x10
    bl _noise2d
    mov x10, x0
    mov x17, #-312
    str x10, [x29, x17]
    mov x17, #-312
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    ldur x10, [x29, #-40]
    mov x17, #-320
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-320
    ldr x11, [x29, x17]
    mov x17, #-328
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-336
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-344
    str x10, [x29, x17]
    mov x17, #-336
    ldr x11, [x29, x17]
    mov x17, #-344
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x11, [x29, x17]
    mov x12, #3
    sdiv x10, x11, x12
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #400
    ldp x29, x30, [sp], #16
    ret

_terrain_height:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #352
    // function terrain_height
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-72]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-80]
    ldur x10, [x29, #-64]
    mov x0, x10
    ldur x10, [x29, #-72]
    mov x1, x10
    ldur x10, [x29, #-80]
    mov x2, x10
    mov x3, #4
    bl _octave_noise2d
    mov x10, x0
    stur x10, [x29, #-88]
    stur x10, [x29, #-32]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-96]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-104]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-112]
    mov x11, x10
    movz x12, #34463, lsl #0
    movk x12, #1, lsl #16
    add x10, x11, x12
    stur x10, [x29, #-120]
    ldur x10, [x29, #-96]
    mov x0, x10
    ldur x10, [x29, #-104]
    mov x1, x10
    ldur x10, [x29, #-120]
    mov x2, x10
    mov x3, #3
    bl _octave_noise2d
    mov x10, x0
    stur x10, [x29, #-128]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-136]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-144]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-152]
    mov x11, x10
    movz x12, #12241, lsl #0
    movk x12, #1, lsl #16
    add x10, x11, x12
    stur x10, [x29, #-160]
    ldur x10, [x29, #-136]
    mov x0, x10
    ldur x10, [x29, #-144]
    mov x1, x10
    ldur x10, [x29, #-160]
    mov x2, x10
    mov x3, #2
    bl _octave_noise2d
    mov x10, x0
    stur x10, [x29, #-168]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-176]
    mov x11, x10
    mov x12, #64
    mul x10, x11, x12
    stur x10, [x29, #-184]
    mov x11, x10
    mov x12, #256
    sdiv x10, x11, x12
    stur x10, [x29, #-192]
    mov x11, #64
    ldur x12, [x29, #-192]
    add x10, x11, x12
    stur x10, [x29, #-200]
    ldur x10, [x29, #-40]
    stur x10, [x29, #-208]
    mov x11, x10
    mov x12, #20
    mul x10, x11, x12
    stur x10, [x29, #-216]
    mov x11, x10
    mov x12, #256
    sdiv x10, x11, x12
    stur x10, [x29, #-224]
    ldur x11, [x29, #-200]
    ldur x12, [x29, #-224]
    add x10, x11, x12
    stur x10, [x29, #-232]
    ldur x10, [x29, #-48]
    stur x10, [x29, #-240]
    mov x11, x10
    mov x12, #10
    mul x10, x11, x12
    stur x10, [x29, #-248]
    mov x11, x10
    mov x12, #256
    sdiv x10, x11, x12
    stur x10, [x29, #-256]
    ldur x11, [x29, #-232]
    ldur x12, [x29, #-256]
    add x10, x11, x12
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    mov x17, #-272
    str x10, [x29, x17]
    mov x11, #60
    neg x10, x11
    mov x17, #-280
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    mov x17, #-280
    ldr x12, [x29, x17]
    cmp x11, x12
    b.ge .Lendif_223
    mov x11, #60
    neg x10, x11
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-296
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
.Lendif_223:
    ldur x10, [x29, #-56]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x11, [x29, x17]
    cmp x11, #200
    b.le .Lendif_225
    mov x10, #200
    stur x10, [x29, #-56]
.Lendif_225:
    ldur x10, [x29, #-56]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #352
    ldp x29, x30, [sp], #16
    ret

_terrain_block_at:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1376
    // function terrain_block_at
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    stur x3, [x29, #-32]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-88]
    mov x11, #64
    neg x10, x11
    stur x10, [x29, #-96]
    ldur x11, [x29, #-88]
    ldur x12, [x29, #-96]
    cmp x11, x12
    b.ne .Lendif_227
    bl _BLOCK_BEDROCK
    mov x10, x0
    stur x10, [x29, #-112]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_227:
    ldur x10, [x29, #-16]
    stur x10, [x29, #-120]
    mov x11, #60
    neg x10, x11
    stur x10, [x29, #-128]
    ldur x11, [x29, #-120]
    ldur x12, [x29, #-128]
    cmp x11, x12
    b.ge .Lendif_229
    ldur x10, [x29, #-8]
    stur x10, [x29, #-144]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-152]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-160]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-168]
    mov x11, x10
    mov x12, #7
    mul x10, x11, x12
    stur x10, [x29, #-176]
    ldur x11, [x29, #-160]
    ldur x12, [x29, #-176]
    add x10, x11, x12
    stur x10, [x29, #-184]
    ldur x10, [x29, #-144]
    mov x0, x10
    ldur x10, [x29, #-152]
    mov x1, x10
    ldur x10, [x29, #-184]
    mov x2, x10
    bl _terrain_hash
    mov x10, x0
    stur x10, [x29, #-192]
    stur x10, [x29, #-40]
    stur x10, [x29, #-200]
    mov x11, x10
    mov x12, #3
    and x10, x11, x12
    stur x10, [x29, #-208]
    mov x11, x10
    cmp x11, #0
    b.ne .Lendif_231
    bl _BLOCK_BEDROCK
    mov x10, x0
    stur x10, [x29, #-224]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_231:
.Lendif_229:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-232]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-240]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-248]
    ldur x10, [x29, #-232]
    mov x0, x10
    ldur x10, [x29, #-240]
    mov x1, x10
    ldur x10, [x29, #-248]
    mov x2, x10
    bl _terrain_height
    mov x10, x0
    stur x10, [x29, #-256]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-16]
    mov x17, #-264
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-264
    ldr x11, [x29, x17]
    mov x17, #-272
    ldr x12, [x29, x17]
    cmp x11, x12
    b.le .Lendif_233
    ldur x10, [x29, #-16]
    mov x17, #-288
    str x10, [x29, x17]
    bl _SEA_LEVEL
    mov x10, x0
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-288
    ldr x11, [x29, x17]
    mov x17, #-296
    ldr x12, [x29, x17]
    cmp x11, x12
    b.gt .Lendif_235
    bl _BLOCK_WATER
    mov x10, x0
    mov x17, #-312
    str x10, [x29, x17]
    mov x17, #-312
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_235:
    bl _BLOCK_AIR
    mov x10, x0
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_233:
    ldur x10, [x29, #-16]
    mov x17, #-328
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-328
    ldr x11, [x29, x17]
    mov x17, #-336
    ldr x12, [x29, x17]
    cmp x11, x12
    b.ne .Lendif_237
    ldur x10, [x29, #-48]
    mov x17, #-352
    str x10, [x29, x17]
    bl _SEA_LEVEL
    mov x10, x0
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-352
    ldr x11, [x29, x17]
    mov x17, #-368
    ldr x12, [x29, x17]
    cmp x11, x12
    b.ge .Lendif_239
    ldur x10, [x29, #-8]
    mov x17, #-384
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-392
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-400
    ldr x11, [x29, x17]
    mov x12, #55555
    add x10, x11, x12
    mov x17, #-408
    str x10, [x29, x17]
    mov x17, #-384
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-392
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-408
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_hash
    mov x10, x0
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    mov x17, #-424
    str x10, [x29, x17]
    mov x17, #-424
    ldr x11, [x29, x17]
    mov x12, #3
    and x10, x11, x12
    mov x17, #-432
    str x10, [x29, x17]
    mov x17, #-432
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ne .Lendif_241
    bl _BLOCK_GRAVEL
    mov x10, x0
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-448
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_241:
    bl _BLOCK_SAND
    mov x10, x0
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-456
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_239:
    ldur x10, [x29, #-48]
    mov x17, #-464
    str x10, [x29, x17]
    bl _SEA_LEVEL
    mov x10, x0
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-464
    ldr x11, [x29, x17]
    mov x17, #-480
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-488
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-496
    str x10, [x29, x17]
    bl _SEA_LEVEL
    mov x10, x0
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-496
    ldr x11, [x29, x17]
    mov x17, #-504
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-488
    ldr x11, [x29, x17]
    mov x17, #-512
    ldr x12, [x29, x17]
    orr x10, x11, x12
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x10, [x29, x17]
    cbz x10, .Lendif_243
    bl _BLOCK_SAND
    mov x10, x0
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_243:
    bl _BLOCK_GRASS_BLOCK
    mov x10, x0
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_237:
    ldur x10, [x29, #-16]
    mov x17, #-544
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-552
    str x10, [x29, x17]
    mov x17, #-552
    ldr x11, [x29, x17]
    sub x10, x11, #4
    mov x17, #-560
    str x10, [x29, x17]
    mov x17, #-544
    ldr x11, [x29, x17]
    mov x17, #-560
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, gt
    mov x17, #-568
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-576
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-576
    ldr x11, [x29, x17]
    mov x17, #-584
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, lt
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-568
    ldr x11, [x29, x17]
    mov x17, #-592
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-600
    ldr x10, [x29, x17]
    cbz x10, .Lendif_245
    ldur x10, [x29, #-48]
    mov x17, #-608
    str x10, [x29, x17]
    bl _SEA_LEVEL
    mov x10, x0
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-608
    ldr x11, [x29, x17]
    mov x17, #-616
    ldr x12, [x29, x17]
    cmp x11, x12
    b.ge .Lendif_247
    bl _BLOCK_SAND
    mov x10, x0
    mov x17, #-632
    str x10, [x29, x17]
    mov x17, #-632
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_247:
    bl _BLOCK_DIRT
    mov x10, x0
    mov x17, #-640
    str x10, [x29, x17]
    mov x17, #-640
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_245:
    ldur x10, [x29, #-16]
    mov x17, #-648
    str x10, [x29, x17]
    mov x11, #60
    neg x10, x11
    mov x17, #-656
    str x10, [x29, x17]
    mov x17, #-648
    ldr x11, [x29, x17]
    mov x17, #-656
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, gt
    mov x17, #-664
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-672
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-680
    str x10, [x29, x17]
    mov x17, #-680
    ldr x11, [x29, x17]
    sub x10, x11, #4
    mov x17, #-688
    str x10, [x29, x17]
    mov x17, #-672
    ldr x11, [x29, x17]
    mov x17, #-688
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, lt
    mov x17, #-696
    str x10, [x29, x17]
    mov x17, #-664
    ldr x11, [x29, x17]
    mov x17, #-696
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-704
    str x10, [x29, x17]
    mov x17, #-704
    ldr x10, [x29, x17]
    cbz x10, .Lendif_249
    ldur x10, [x29, #-8]
    mov x17, #-712
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-720
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-728
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-736
    str x10, [x29, x17]
    mov x17, #-736
    ldr x11, [x29, x17]
    movz x12, #45575, lsl #0
    movk x12, #1, lsl #16
    add x10, x11, x12
    mov x17, #-744
    str x10, [x29, x17]
    mov x17, #-712
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-720
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-728
    ldr x10, [x29, x17]
    mov x2, x10
    mov x17, #-744
    ldr x10, [x29, x17]
    mov x3, x10
    bl _noise3d_simple
    mov x10, x0
    mov x17, #-752
    str x10, [x29, x17]
    mov x17, #-752
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    mov x17, #-760
    str x10, [x29, x17]
    mov x17, #-760
    ldr x11, [x29, x17]
    cmp x11, #180
    cset x10, gt
    mov x17, #-768
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-776
    str x10, [x29, x17]
    mov x11, #180
    neg x10, x11
    mov x17, #-784
    str x10, [x29, x17]
    mov x17, #-776
    ldr x11, [x29, x17]
    mov x17, #-784
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, lt
    mov x17, #-792
    str x10, [x29, x17]
    mov x17, #-768
    ldr x11, [x29, x17]
    mov x17, #-792
    ldr x12, [x29, x17]
    orr x10, x11, x12
    mov x17, #-800
    str x10, [x29, x17]
    mov x17, #-800
    ldr x10, [x29, x17]
    cbz x10, .Lendif_251
    ldur x10, [x29, #-16]
    mov x17, #-808
    str x10, [x29, x17]
    mov x11, #55
    neg x10, x11
    mov x17, #-816
    str x10, [x29, x17]
    mov x17, #-808
    ldr x11, [x29, x17]
    mov x17, #-816
    ldr x12, [x29, x17]
    cmp x11, x12
    b.gt .Lendif_253
    bl _BLOCK_AIR
    mov x10, x0
    mov x17, #-832
    str x10, [x29, x17]
    mov x17, #-832
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_253:
    bl _BLOCK_AIR
    mov x10, x0
    mov x17, #-840
    str x10, [x29, x17]
    mov x17, #-840
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_251:
.Lendif_249:
    ldur x10, [x29, #-16]
    mov x17, #-848
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-856
    str x10, [x29, x17]
    mov x17, #-856
    ldr x11, [x29, x17]
    sub x10, x11, #4
    mov x17, #-864
    str x10, [x29, x17]
    mov x17, #-848
    ldr x11, [x29, x17]
    mov x17, #-864
    ldr x12, [x29, x17]
    cmp x11, x12
    b.ge .Lendif_255
    ldur x10, [x29, #-8]
    mov x17, #-880
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-888
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-896
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-904
    str x10, [x29, x17]
    mov x17, #-904
    ldr x11, [x29, x17]
    movz x12, #25614, lsl #0
    movk x12, #3, lsl #16
    add x10, x11, x12
    mov x17, #-912
    str x10, [x29, x17]
    mov x17, #-880
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-888
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-896
    ldr x10, [x29, x17]
    mov x2, x10
    mov x17, #-912
    ldr x10, [x29, x17]
    mov x3, x10
    bl _terrain_hash3
    mov x10, x0
    mov x17, #-920
    str x10, [x29, x17]
    mov x17, #-920
    ldr x10, [x29, x17]
    stur x10, [x29, #-72]
    mov x17, #-928
    str x10, [x29, x17]
    mov x17, #-928
    ldr x11, [x29, x17]
    mov x12, #127
    and x10, x11, x12
    mov x17, #-936
    str x10, [x29, x17]
    mov x17, #-936
    ldr x11, [x29, x17]
    cmp x11, #3
    b.ge .Lendif_257
    bl _BLOCK_COAL_ORE
    mov x10, x0
    mov x17, #-952
    str x10, [x29, x17]
    mov x17, #-952
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_257:
    ldur x10, [x29, #-16]
    mov x17, #-960
    str x10, [x29, x17]
    mov x17, #-960
    ldr x11, [x29, x17]
    cmp x11, #64
    cset x10, lt
    mov x17, #-968
    str x10, [x29, x17]
    ldur x10, [x29, #-72]
    mov x17, #-976
    str x10, [x29, x17]
    mov x17, #-976
    ldr x11, [x29, x17]
    mov x12, #255
    and x10, x11, x12
    mov x17, #-984
    str x10, [x29, x17]
    mov x17, #-984
    ldr x11, [x29, x17]
    cmp x11, #4
    cset x10, lt
    mov x17, #-992
    str x10, [x29, x17]
    mov x17, #-968
    ldr x11, [x29, x17]
    mov x17, #-992
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-1000
    str x10, [x29, x17]
    mov x17, #-1000
    ldr x10, [x29, x17]
    cbz x10, .Lendif_259
    bl _BLOCK_IRON_ORE
    mov x10, x0
    mov x17, #-1008
    str x10, [x29, x17]
    mov x17, #-1008
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_259:
    ldur x10, [x29, #-16]
    mov x17, #-1016
    str x10, [x29, x17]
    mov x17, #-1016
    ldr x11, [x29, x17]
    cmp x11, #32
    cset x10, lt
    mov x17, #-1024
    str x10, [x29, x17]
    ldur x10, [x29, #-72]
    mov x17, #-1032
    str x10, [x29, x17]
    mov x17, #-1032
    ldr x11, [x29, x17]
    mov x12, #511
    and x10, x11, x12
    mov x17, #-1040
    str x10, [x29, x17]
    mov x17, #-1040
    ldr x11, [x29, x17]
    cmp x11, #2
    cset x10, lt
    mov x17, #-1048
    str x10, [x29, x17]
    mov x17, #-1024
    ldr x11, [x29, x17]
    mov x17, #-1048
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-1056
    str x10, [x29, x17]
    mov x17, #-1056
    ldr x10, [x29, x17]
    cbz x10, .Lendif_261
    bl _BLOCK_GOLD_ORE
    mov x10, x0
    mov x17, #-1064
    str x10, [x29, x17]
    mov x17, #-1064
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_261:
    ldur x10, [x29, #-16]
    mov x17, #-1072
    str x10, [x29, x17]
    mov x17, #-1072
    ldr x11, [x29, x17]
    cmp x11, #16
    cset x10, lt
    mov x17, #-1080
    str x10, [x29, x17]
    ldur x10, [x29, #-72]
    mov x17, #-1088
    str x10, [x29, x17]
    mov x17, #-1088
    ldr x11, [x29, x17]
    mov x12, #1023
    and x10, x11, x12
    mov x17, #-1096
    str x10, [x29, x17]
    mov x17, #-1096
    ldr x11, [x29, x17]
    cmp x11, #1
    cset x10, lt
    mov x17, #-1104
    str x10, [x29, x17]
    mov x17, #-1080
    ldr x11, [x29, x17]
    mov x17, #-1104
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-1112
    str x10, [x29, x17]
    mov x17, #-1112
    ldr x10, [x29, x17]
    cbz x10, .Lendif_263
    bl _BLOCK_DIAMOND_ORE
    mov x10, x0
    mov x17, #-1120
    str x10, [x29, x17]
    mov x17, #-1120
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_263:
    ldur x10, [x29, #-8]
    mov x17, #-1128
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-1136
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-1144
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-1152
    str x10, [x29, x17]
    mov x17, #-1152
    ldr x11, [x29, x17]
    movz x12, #5653, lsl #0
    movk x12, #5, lsl #16
    add x10, x11, x12
    mov x17, #-1160
    str x10, [x29, x17]
    mov x17, #-1128
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-1136
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-1144
    ldr x10, [x29, x17]
    mov x2, x10
    mov x17, #-1160
    ldr x10, [x29, x17]
    mov x3, x10
    bl _terrain_hash3
    mov x10, x0
    mov x17, #-1168
    str x10, [x29, x17]
    mov x17, #-1168
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
    mov x17, #-1176
    str x10, [x29, x17]
    mov x17, #-1176
    ldr x11, [x29, x17]
    mov x12, #63
    and x10, x11, x12
    mov x17, #-1184
    str x10, [x29, x17]
    mov x17, #-1184
    ldr x11, [x29, x17]
    cmp x11, #3
    b.ge .Lendif_265
    bl _BLOCK_GRANITE
    mov x10, x0
    mov x17, #-1200
    str x10, [x29, x17]
    mov x17, #-1200
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_265:
    ldur x10, [x29, #-80]
    mov x17, #-1208
    str x10, [x29, x17]
    mov x17, #-1208
    ldr x11, [x29, x17]
    mov x12, #63
    and x10, x11, x12
    mov x17, #-1216
    str x10, [x29, x17]
    mov x17, #-1216
    ldr x11, [x29, x17]
    cmp x11, #3
    cset x10, ge
    mov x17, #-1224
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-1232
    str x10, [x29, x17]
    mov x17, #-1232
    ldr x11, [x29, x17]
    mov x12, #63
    and x10, x11, x12
    mov x17, #-1240
    str x10, [x29, x17]
    mov x17, #-1240
    ldr x11, [x29, x17]
    cmp x11, #6
    cset x10, lt
    mov x17, #-1248
    str x10, [x29, x17]
    mov x17, #-1224
    ldr x11, [x29, x17]
    mov x17, #-1248
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-1256
    str x10, [x29, x17]
    mov x17, #-1256
    ldr x10, [x29, x17]
    cbz x10, .Lendif_267
    bl _BLOCK_DIORITE
    mov x10, x0
    mov x17, #-1264
    str x10, [x29, x17]
    mov x17, #-1264
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_267:
    ldur x10, [x29, #-80]
    mov x17, #-1272
    str x10, [x29, x17]
    mov x17, #-1272
    ldr x11, [x29, x17]
    mov x12, #63
    and x10, x11, x12
    mov x17, #-1280
    str x10, [x29, x17]
    mov x17, #-1280
    ldr x11, [x29, x17]
    cmp x11, #6
    cset x10, ge
    mov x17, #-1288
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-1296
    str x10, [x29, x17]
    mov x17, #-1296
    ldr x11, [x29, x17]
    mov x12, #63
    and x10, x11, x12
    mov x17, #-1304
    str x10, [x29, x17]
    mov x17, #-1304
    ldr x11, [x29, x17]
    cmp x11, #9
    cset x10, lt
    mov x17, #-1312
    str x10, [x29, x17]
    mov x17, #-1288
    ldr x11, [x29, x17]
    mov x17, #-1312
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-1320
    str x10, [x29, x17]
    mov x17, #-1320
    ldr x10, [x29, x17]
    cbz x10, .Lendif_269
    bl _BLOCK_ANDESITE
    mov x10, x0
    mov x17, #-1328
    str x10, [x29, x17]
    mov x17, #-1328
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret
.Lendif_269:
.Lendif_255:
    bl _BLOCK_STONE
    mov x10, x0
    mov x17, #-1336
    str x10, [x29, x17]
    mov x17, #-1336
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1376
    ldp x29, x30, [sp], #16
    ret

_tree_at:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #784
    // function tree_at
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-112]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-120]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-128]
    ldur x10, [x29, #-112]
    mov x0, x10
    ldur x10, [x29, #-120]
    mov x1, x10
    ldur x10, [x29, #-128]
    mov x2, x10
    bl _terrain_height
    mov x10, x0
    stur x10, [x29, #-136]
    stur x10, [x29, #-32]
    stur x10, [x29, #-144]
    bl _SEA_LEVEL
    mov x10, x0
    stur x10, [x29, #-152]
    ldur x11, [x29, #-144]
    ldur x12, [x29, #-152]
    cmp x11, x12
    b.gt .Lendif_271
    mov x0, #0
    add sp, sp, #784
    ldp x29, x30, [sp], #16
    ret
.Lendif_271:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-168]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-176]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-184]
    mov x11, x10
    movz x12, #51228, lsl #0
    movk x12, #6, lsl #16
    add x10, x11, x12
    stur x10, [x29, #-192]
    ldur x10, [x29, #-168]
    mov x0, x10
    ldur x10, [x29, #-176]
    mov x1, x10
    ldur x10, [x29, #-192]
    mov x2, x10
    bl _terrain_hash
    mov x10, x0
    stur x10, [x29, #-200]
    stur x10, [x29, #-40]
    stur x10, [x29, #-208]
    mov x11, x10
    mov x12, #100
    sdiv x13, x11, x12
    msub x10, x13, x12, x11
    stur x10, [x29, #-216]
    mov x11, x10
    cmp x11, #0
    b.eq .Lendif_273
    mov x0, #0
    add sp, sp, #784
    ldp x29, x30, [sp], #16
    ret
.Lendif_273:
    ldur x10, [x29, #-8]
    stur x10, [x29, #-232]
    mov x11, x10
    add x10, x11, #1
    stur x10, [x29, #-240]
    ldur x10, [x29, #-16]
    stur x10, [x29, #-248]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-256]
    ldur x10, [x29, #-240]
    mov x0, x10
    ldur x10, [x29, #-248]
    mov x1, x10
    ldur x10, [x29, #-256]
    mov x2, x10
    bl _terrain_height
    mov x10, x0
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    ldur x10, [x29, #-8]
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-280
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-288
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-280
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-288
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-296
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_height
    mov x10, x0
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    ldur x10, [x29, #-8]
    mov x17, #-312
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-328
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-312
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-328
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-336
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_height
    mov x10, x0
    mov x17, #-344
    str x10, [x29, x17]
    mov x17, #-344
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    ldur x10, [x29, #-8]
    mov x17, #-352
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-368
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-376
    str x10, [x29, x17]
    mov x17, #-352
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-368
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-376
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_height
    mov x10, x0
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-384
    ldr x10, [x29, x17]
    stur x10, [x29, #-72]
    ldur x10, [x29, #-48]
    mov x17, #-392
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-392
    ldr x11, [x29, x17]
    mov x17, #-400
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-408
    str x10, [x29, x17]
    mov x17, #-408
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ge .Lendif_275
    ldur x10, [x29, #-80]
    mov x17, #-432
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-432
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-440
    str x10, [x29, x17]
    mov x17, #-440
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
.Lendif_275:
    ldur x10, [x29, #-56]
    mov x17, #-448
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-448
    ldr x11, [x29, x17]
    mov x17, #-456
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-464
    str x10, [x29, x17]
    mov x17, #-464
    ldr x10, [x29, x17]
    stur x10, [x29, #-88]
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ge .Lendif_277
    ldur x10, [x29, #-88]
    mov x17, #-488
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-488
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-496
    ldr x10, [x29, x17]
    stur x10, [x29, #-88]
.Lendif_277:
    ldur x10, [x29, #-88]
    mov x17, #-504
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-504
    ldr x11, [x29, x17]
    mov x17, #-512
    ldr x12, [x29, x17]
    cmp x11, x12
    b.le .Lendif_279
    ldur x10, [x29, #-88]
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
.Lendif_279:
    ldur x10, [x29, #-64]
    mov x17, #-536
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-544
    str x10, [x29, x17]
    mov x17, #-536
    ldr x11, [x29, x17]
    mov x17, #-544
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-552
    str x10, [x29, x17]
    mov x17, #-552
    ldr x10, [x29, x17]
    stur x10, [x29, #-96]
    mov x17, #-560
    str x10, [x29, x17]
    mov x17, #-560
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ge .Lendif_281
    ldur x10, [x29, #-96]
    mov x17, #-576
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-576
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-584
    ldr x10, [x29, x17]
    stur x10, [x29, #-96]
.Lendif_281:
    ldur x10, [x29, #-96]
    mov x17, #-592
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-592
    ldr x11, [x29, x17]
    mov x17, #-600
    ldr x12, [x29, x17]
    cmp x11, x12
    b.le .Lendif_283
    ldur x10, [x29, #-96]
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-616
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
.Lendif_283:
    ldur x10, [x29, #-72]
    mov x17, #-624
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-632
    str x10, [x29, x17]
    mov x17, #-624
    ldr x11, [x29, x17]
    mov x17, #-632
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-640
    str x10, [x29, x17]
    mov x17, #-640
    ldr x10, [x29, x17]
    stur x10, [x29, #-104]
    mov x17, #-648
    str x10, [x29, x17]
    mov x17, #-648
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ge .Lendif_285
    ldur x10, [x29, #-104]
    mov x17, #-664
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-664
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-672
    str x10, [x29, x17]
    mov x17, #-672
    ldr x10, [x29, x17]
    stur x10, [x29, #-104]
.Lendif_285:
    ldur x10, [x29, #-104]
    mov x17, #-680
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-688
    str x10, [x29, x17]
    mov x17, #-680
    ldr x11, [x29, x17]
    mov x17, #-688
    ldr x12, [x29, x17]
    cmp x11, x12
    b.le .Lendif_287
    ldur x10, [x29, #-104]
    mov x17, #-704
    str x10, [x29, x17]
    mov x17, #-704
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
.Lendif_287:
    ldur x10, [x29, #-80]
    mov x17, #-712
    str x10, [x29, x17]
    mov x17, #-712
    ldr x11, [x29, x17]
    cmp x11, #2
    b.le .Lendif_289
    mov x0, #0
    add sp, sp, #784
    ldp x29, x30, [sp], #16
    ret
.Lendif_289:
    ldur x10, [x29, #-40]
    mov x17, #-728
    str x10, [x29, x17]
    mov x17, #-728
    ldr x11, [x29, x17]
    mov x12, #100
    sdiv x10, x11, x12
    mov x17, #-736
    str x10, [x29, x17]
    mov x17, #-736
    ldr x11, [x29, x17]
    mov x12, #3
    sdiv x13, x11, x12
    msub x10, x13, x12, x11
    mov x17, #-744
    str x10, [x29, x17]
    mov x11, #4
    mov x17, #-744
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-752
    str x10, [x29, x17]
    mov x17, #-752
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #784
    ldp x29, x30, [sp], #16
    ret

_terrain_block_with_trees:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #1040
    // function terrain_block_with_trees
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    stur x2, [x29, #-24]
    stur x3, [x29, #-32]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-136]
    mov x11, x10
    sub x10, x11, #2
    stur x10, [x29, #-144]
    stur x10, [x29, #-40]
.Lwhile_cond_290:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-152]
    ldur x10, [x29, #-8]
    stur x10, [x29, #-160]
    mov x11, x10
    add x10, x11, #2
    stur x10, [x29, #-168]
    ldur x11, [x29, #-152]
    ldur x12, [x29, #-168]
    cmp x11, x12
    b.gt .Lwhile_end_292
.Lwhile_body_291:
    ldur x10, [x29, #-24]
    stur x10, [x29, #-184]
    mov x11, x10
    sub x10, x11, #2
    stur x10, [x29, #-192]
    stur x10, [x29, #-48]
.Lwhile_cond_293:
    ldur x10, [x29, #-48]
    stur x10, [x29, #-200]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-208]
    mov x11, x10
    add x10, x11, #2
    stur x10, [x29, #-216]
    ldur x11, [x29, #-200]
    ldur x12, [x29, #-216]
    cmp x11, x12
    b.gt .Lwhile_end_295
.Lwhile_body_294:
    ldur x10, [x29, #-40]
    stur x10, [x29, #-232]
    ldur x10, [x29, #-48]
    stur x10, [x29, #-240]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-248]
    ldur x10, [x29, #-232]
    mov x0, x10
    ldur x10, [x29, #-240]
    mov x1, x10
    ldur x10, [x29, #-248]
    mov x2, x10
    bl _tree_at
    mov x10, x0
    stur x10, [x29, #-256]
    stur x10, [x29, #-56]
    mov x17, #-264
    str x10, [x29, x17]
    mov x17, #-264
    ldr x11, [x29, x17]
    cmp x11, #0
    b.le .Lendif_297
    ldur x10, [x29, #-40]
    mov x17, #-280
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-288
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-296
    str x10, [x29, x17]
    mov x17, #-280
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-288
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-296
    ldr x10, [x29, x17]
    mov x2, x10
    bl _terrain_height
    mov x10, x0
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    mov x17, #-312
    str x10, [x29, x17]
    mov x17, #-312
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x10, [x29, x17]
    stur x10, [x29, #-72]
    mov x17, #-328
    str x10, [x29, x17]
    ldur x10, [x29, #-56]
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-328
    ldr x11, [x29, x17]
    mov x17, #-336
    ldr x12, [x29, x17]
    add x10, x11, x12
    mov x17, #-344
    str x10, [x29, x17]
    mov x17, #-344
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-352
    str x10, [x29, x17]
    mov x17, #-352
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-368
    str x10, [x29, x17]
    mov x17, #-368
    ldr x10, [x29, x17]
    stur x10, [x29, #-88]
    ldur x10, [x29, #-40]
    mov x17, #-376
    str x10, [x29, x17]
    ldur x10, [x29, #-8]
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-376
    ldr x11, [x29, x17]
    mov x17, #-384
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-392
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-400
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-408
    str x10, [x29, x17]
    mov x17, #-400
    ldr x11, [x29, x17]
    mov x17, #-408
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-392
    ldr x11, [x29, x17]
    mov x17, #-416
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-424
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-432
    str x10, [x29, x17]
    ldur x10, [x29, #-72]
    mov x17, #-440
    str x10, [x29, x17]
    mov x17, #-432
    ldr x11, [x29, x17]
    mov x17, #-440
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, ge
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-424
    ldr x11, [x29, x17]
    mov x17, #-448
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-456
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-464
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-464
    ldr x11, [x29, x17]
    mov x17, #-472
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, le
    mov x17, #-480
    str x10, [x29, x17]
    mov x17, #-456
    ldr x11, [x29, x17]
    mov x17, #-480
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-488
    str x10, [x29, x17]
    mov x17, #-488
    ldr x10, [x29, x17]
    cbz x10, .Lendif_299
    bl _BLOCK_OAK_LOG
    mov x10, x0
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-496
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1040
    ldp x29, x30, [sp], #16
    ret
.Lendif_299:
    ldur x10, [x29, #-16]
    mov x17, #-504
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-512
    str x10, [x29, x17]
    mov x17, #-512
    ldr x11, [x29, x17]
    sub x10, x11, #1
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-504
    ldr x11, [x29, x17]
    mov x17, #-520
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, ge
    mov x17, #-528
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-536
    str x10, [x29, x17]
    ldur x10, [x29, #-88]
    mov x17, #-544
    str x10, [x29, x17]
    mov x17, #-536
    ldr x11, [x29, x17]
    mov x17, #-544
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, le
    mov x17, #-552
    str x10, [x29, x17]
    mov x17, #-528
    ldr x11, [x29, x17]
    mov x17, #-552
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-560
    str x10, [x29, x17]
    mov x17, #-560
    ldr x10, [x29, x17]
    cbz x10, .Lendif_301
    ldur x10, [x29, #-8]
    mov x17, #-568
    str x10, [x29, x17]
    ldur x10, [x29, #-40]
    mov x17, #-576
    str x10, [x29, x17]
    mov x17, #-568
    ldr x11, [x29, x17]
    mov x17, #-576
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-584
    str x10, [x29, x17]
    mov x17, #-584
    ldr x10, [x29, x17]
    stur x10, [x29, #-96]
    ldur x10, [x29, #-24]
    mov x17, #-592
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-592
    ldr x11, [x29, x17]
    mov x17, #-600
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-608
    str x10, [x29, x17]
    mov x17, #-608
    ldr x10, [x29, x17]
    stur x10, [x29, #-104]
    ldur x10, [x29, #-16]
    mov x17, #-616
    str x10, [x29, x17]
    ldur x10, [x29, #-80]
    mov x17, #-624
    str x10, [x29, x17]
    mov x17, #-616
    ldr x11, [x29, x17]
    mov x17, #-624
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-632
    str x10, [x29, x17]
    mov x17, #-632
    ldr x10, [x29, x17]
    stur x10, [x29, #-112]
    ldur x10, [x29, #-96]
    mov x17, #-640
    str x10, [x29, x17]
    mov x17, #-640
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ge .Lendif_303
    ldur x10, [x29, #-96]
    mov x17, #-656
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-656
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-664
    str x10, [x29, x17]
    mov x17, #-664
    ldr x10, [x29, x17]
    stur x10, [x29, #-96]
.Lendif_303:
    ldur x10, [x29, #-104]
    mov x17, #-672
    str x10, [x29, x17]
    mov x17, #-672
    ldr x11, [x29, x17]
    cmp x11, #0
    b.ge .Lendif_305
    ldur x10, [x29, #-104]
    mov x17, #-688
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-688
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-696
    str x10, [x29, x17]
    mov x17, #-696
    ldr x10, [x29, x17]
    stur x10, [x29, #-104]
.Lendif_305:
    mov x10, #2
    stur x10, [x29, #-120]
    ldur x10, [x29, #-112]
    mov x17, #-704
    str x10, [x29, x17]
    mov x17, #-704
    ldr x11, [x29, x17]
    cmp x11, #1
    b.lt .Lendif_307
    mov x10, #1
    stur x10, [x29, #-120]
.Lendif_307:
    ldur x10, [x29, #-96]
    mov x17, #-720
    str x10, [x29, x17]
    ldur x10, [x29, #-120]
    mov x17, #-728
    str x10, [x29, x17]
    mov x17, #-720
    ldr x11, [x29, x17]
    mov x17, #-728
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, le
    mov x17, #-736
    str x10, [x29, x17]
    ldur x10, [x29, #-104]
    mov x17, #-744
    str x10, [x29, x17]
    ldur x10, [x29, #-120]
    mov x17, #-752
    str x10, [x29, x17]
    mov x17, #-744
    ldr x11, [x29, x17]
    mov x17, #-752
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, le
    mov x17, #-760
    str x10, [x29, x17]
    mov x17, #-736
    ldr x11, [x29, x17]
    mov x17, #-760
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-768
    str x10, [x29, x17]
    mov x17, #-768
    ldr x10, [x29, x17]
    cbz x10, .Lendif_309
    ldur x10, [x29, #-40]
    mov x17, #-776
    str x10, [x29, x17]
    ldur x10, [x29, #-8]
    mov x17, #-784
    str x10, [x29, x17]
    mov x17, #-776
    ldr x11, [x29, x17]
    mov x17, #-784
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-792
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-800
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-808
    str x10, [x29, x17]
    mov x17, #-800
    ldr x11, [x29, x17]
    mov x17, #-808
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-816
    str x10, [x29, x17]
    mov x17, #-792
    ldr x11, [x29, x17]
    mov x17, #-816
    ldr x12, [x29, x17]
    and x10, x11, x12
    mov x17, #-824
    str x10, [x29, x17]
    mov x17, #-824
    ldr x11, [x29, x17]
    eor x10, x11, #1
    mov x17, #-832
    str x10, [x29, x17]
    mov x17, #-832
    ldr x10, [x29, x17]
    cbz x10, .Lendif_311
    ldur x10, [x29, #-8]
    mov x17, #-840
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-848
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-856
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-864
    str x10, [x29, x17]
    mov x17, #-840
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-848
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-856
    ldr x10, [x29, x17]
    mov x2, x10
    mov x17, #-864
    ldr x10, [x29, x17]
    mov x3, x10
    bl _terrain_block_at
    mov x10, x0
    mov x17, #-872
    str x10, [x29, x17]
    mov x17, #-872
    ldr x10, [x29, x17]
    stur x10, [x29, #-128]
    mov x17, #-880
    str x10, [x29, x17]
    bl _BLOCK_AIR
    mov x10, x0
    mov x17, #-888
    str x10, [x29, x17]
    mov x17, #-880
    ldr x11, [x29, x17]
    mov x17, #-888
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-896
    str x10, [x29, x17]
    ldur x10, [x29, #-128]
    mov x17, #-904
    str x10, [x29, x17]
    bl _BLOCK_WATER
    mov x10, x0
    mov x17, #-912
    str x10, [x29, x17]
    mov x17, #-904
    ldr x11, [x29, x17]
    mov x17, #-912
    ldr x12, [x29, x17]
    cmp x11, x12
    cset x10, eq
    mov x17, #-920
    str x10, [x29, x17]
    mov x17, #-896
    ldr x11, [x29, x17]
    mov x17, #-920
    ldr x12, [x29, x17]
    orr x10, x11, x12
    mov x17, #-928
    str x10, [x29, x17]
    mov x17, #-928
    ldr x10, [x29, x17]
    cbz x10, .Lendif_313
    bl _BLOCK_OAK_LEAVES
    mov x10, x0
    mov x17, #-936
    str x10, [x29, x17]
    mov x17, #-936
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1040
    ldp x29, x30, [sp], #16
    ret
.Lendif_313:
.Lendif_311:
.Lendif_309:
.Lendif_301:
.Lendif_297:
    ldur x10, [x29, #-48]
    mov x17, #-944
    str x10, [x29, x17]
    mov x17, #-944
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-952
    str x10, [x29, x17]
    mov x17, #-952
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
    b .Lwhile_cond_293
.Lwhile_end_295:
    ldur x10, [x29, #-40]
    mov x17, #-960
    str x10, [x29, x17]
    mov x17, #-960
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-968
    str x10, [x29, x17]
    mov x17, #-968
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
    b .Lwhile_cond_290
.Lwhile_end_292:
    ldur x10, [x29, #-8]
    mov x17, #-976
    str x10, [x29, x17]
    ldur x10, [x29, #-16]
    mov x17, #-984
    str x10, [x29, x17]
    ldur x10, [x29, #-24]
    mov x17, #-992
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-1000
    str x10, [x29, x17]
    mov x17, #-976
    ldr x10, [x29, x17]
    mov x0, x10
    mov x17, #-984
    ldr x10, [x29, x17]
    mov x1, x10
    mov x17, #-992
    ldr x10, [x29, x17]
    mov x2, x10
    mov x17, #-1000
    ldr x10, [x29, x17]
    mov x3, x10
    bl _terrain_block_at
    mov x10, x0
    mov x17, #-1008
    str x10, [x29, x17]
    mov x17, #-1008
    ldr x10, [x29, x17]
    mov x0, x10
    add sp, sp, #1040
    ldp x29, x30, [sp], #16
    ret

_main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #976
    // function main
    stur x0, [x29, #-8]
    stur x1, [x29, #-16]
    mov x10, #999
    stur x10, [x29, #-24]
    mov x11, #999
    neg x10, x11
    stur x10, [x29, #-96]
    stur x10, [x29, #-32]
    mov x10, #0
    stur x10, [x29, #-40]
    mov x10, #0
    stur x10, [x29, #-48]
    mov x11, #200
    neg x10, x11
    stur x10, [x29, #-104]
    mov x0, x10
    mov x1, #0
    mov x2, #12345
    bl _terrain_height
    mov x10, x0
    stur x10, [x29, #-112]
    stur x10, [x29, #-56]
    mov x11, #199
    neg x10, x11
    stur x10, [x29, #-120]
    stur x10, [x29, #-64]
.Lwhile_cond_314:
    ldur x10, [x29, #-64]
    stur x10, [x29, #-128]
    mov x11, x10
    cmp x11, #200
    b.gt .Lwhile_end_316
.Lwhile_body_315:
    ldur x10, [x29, #-64]
    stur x10, [x29, #-144]
    mov x0, x10
    mov x1, #0
    mov x2, #12345
    bl _terrain_height
    mov x10, x0
    stur x10, [x29, #-152]
    stur x10, [x29, #-72]
    stur x10, [x29, #-160]
    ldur x10, [x29, #-24]
    stur x10, [x29, #-168]
    ldur x11, [x29, #-160]
    ldur x12, [x29, #-168]
    cmp x11, x12
    b.ge .Lendif_318
    ldur x10, [x29, #-72]
    stur x10, [x29, #-184]
    stur x10, [x29, #-24]
.Lendif_318:
    ldur x10, [x29, #-72]
    stur x10, [x29, #-192]
    ldur x10, [x29, #-32]
    stur x10, [x29, #-200]
    ldur x11, [x29, #-192]
    ldur x12, [x29, #-200]
    cmp x11, x12
    b.le .Lendif_320
    ldur x10, [x29, #-72]
    stur x10, [x29, #-216]
    stur x10, [x29, #-32]
.Lendif_320:
    ldur x10, [x29, #-72]
    stur x10, [x29, #-224]
    ldur x10, [x29, #-56]
    stur x10, [x29, #-232]
    ldur x11, [x29, #-224]
    ldur x12, [x29, #-232]
    sub x10, x11, x12
    stur x10, [x29, #-240]
    stur x10, [x29, #-80]
    stur x10, [x29, #-248]
    mov x11, x10
    cmp x11, #0
    b.ge .Lendif_322
    ldur x10, [x29, #-80]
    mov x17, #-264
    str x10, [x29, x17]
    mov x11, #0
    mov x17, #-264
    ldr x12, [x29, x17]
    sub x10, x11, x12
    mov x17, #-272
    str x10, [x29, x17]
    mov x17, #-272
    ldr x10, [x29, x17]
    stur x10, [x29, #-80]
.Lendif_322:
    ldur x10, [x29, #-80]
    mov x17, #-280
    str x10, [x29, x17]
    ldur x10, [x29, #-40]
    mov x17, #-288
    str x10, [x29, x17]
    mov x17, #-280
    ldr x11, [x29, x17]
    mov x17, #-288
    ldr x12, [x29, x17]
    cmp x11, x12
    b.le .Lendif_324
    ldur x10, [x29, #-80]
    mov x17, #-304
    str x10, [x29, x17]
    mov x17, #-304
    ldr x10, [x29, x17]
    stur x10, [x29, #-40]
    ldur x10, [x29, #-64]
    mov x17, #-312
    str x10, [x29, x17]
    mov x17, #-312
    ldr x10, [x29, x17]
    stur x10, [x29, #-48]
.Lendif_324:
    ldur x10, [x29, #-72]
    mov x17, #-320
    str x10, [x29, x17]
    mov x17, #-320
    ldr x10, [x29, x17]
    stur x10, [x29, #-56]
    ldur x10, [x29, #-64]
    mov x17, #-328
    str x10, [x29, x17]
    mov x17, #-328
    ldr x11, [x29, x17]
    add x10, x11, #1
    mov x17, #-336
    str x10, [x29, x17]
    mov x17, #-336
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    b .Lwhile_cond_314
.Lwhile_end_316:
    ldur x10, [x29, #-24]
    mov x17, #-344
    str x10, [x29, x17]
    mov x17, #-344
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-352
    str x10, [x29, x17]
    adrp x13, __str_15@PAGE
    add x13, x13, __str_15@PAGEOFF
    mov x17, #-352
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_61:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_61
    add x15, x15, #1
    b .Lscl1_61
.Lscl1d_61:
    mov x9, x15
    mov x15, #0
.Lscl2_61:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_61
    add x15, x15, #1
    b .Lscl2_61
.Lscl2d_61:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_61:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_61
    strb w16, [x11], #1
    b .Lsc1_61
.Lsc2_61:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_61
    mov x10, x12
    mov x17, #-360
    str x10, [x29, x17]
    mov x17, #-360
    ldr x13, [x29, x17]
    adrp x14, __str_16@PAGE
    add x14, x14, __str_16@PAGEOFF
    mov x15, #0
.Lscl1_62:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_62
    add x15, x15, #1
    b .Lscl1_62
.Lscl1d_62:
    mov x9, x15
    mov x15, #0
.Lscl2_62:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_62
    add x15, x15, #1
    b .Lscl2_62
.Lscl2d_62:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_62:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_62
    strb w16, [x11], #1
    b .Lsc1_62
.Lsc2_62:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_62
    mov x10, x12
    mov x17, #-368
    str x10, [x29, x17]
    ldur x10, [x29, #-32]
    mov x17, #-376
    str x10, [x29, x17]
    mov x17, #-376
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-384
    str x10, [x29, x17]
    mov x17, #-368
    ldr x13, [x29, x17]
    mov x17, #-384
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_63:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_63
    add x15, x15, #1
    b .Lscl1_63
.Lscl1d_63:
    mov x9, x15
    mov x15, #0
.Lscl2_63:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_63
    add x15, x15, #1
    b .Lscl2_63
.Lscl2d_63:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_63:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_63
    strb w16, [x11], #1
    b .Lsc1_63
.Lsc2_63:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_63
    mov x10, x12
    mov x17, #-392
    str x10, [x29, x17]
    mov x17, #-392
    ldr x13, [x29, x17]
    adrp x14, __str_17@PAGE
    add x14, x14, __str_17@PAGEOFF
    mov x15, #0
.Lscl1_64:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_64
    add x15, x15, #1
    b .Lscl1_64
.Lscl1d_64:
    mov x9, x15
    mov x15, #0
.Lscl2_64:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_64
    add x15, x15, #1
    b .Lscl2_64
.Lscl2d_64:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_64:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_64
    strb w16, [x11], #1
    b .Lsc1_64
.Lsc2_64:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_64
    mov x10, x12
    mov x17, #-400
    str x10, [x29, x17]
    mov x17, #-400
    ldr x10, [x29, x17]
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-408
    str x10, [x29, x17]
    ldur x10, [x29, #-40]
    mov x17, #-416
    str x10, [x29, x17]
    mov x17, #-416
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-424
    str x10, [x29, x17]
    adrp x13, __str_18@PAGE
    add x13, x13, __str_18@PAGEOFF
    mov x17, #-424
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_65:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_65
    add x15, x15, #1
    b .Lscl1_65
.Lscl1d_65:
    mov x9, x15
    mov x15, #0
.Lscl2_65:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_65
    add x15, x15, #1
    b .Lscl2_65
.Lscl2d_65:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_65:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_65
    strb w16, [x11], #1
    b .Lsc1_65
.Lsc2_65:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_65
    mov x10, x12
    mov x17, #-432
    str x10, [x29, x17]
    mov x17, #-432
    ldr x13, [x29, x17]
    adrp x14, __str_19@PAGE
    add x14, x14, __str_19@PAGEOFF
    mov x15, #0
.Lscl1_66:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_66
    add x15, x15, #1
    b .Lscl1_66
.Lscl1d_66:
    mov x9, x15
    mov x15, #0
.Lscl2_66:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_66
    add x15, x15, #1
    b .Lscl2_66
.Lscl2d_66:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_66:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_66
    strb w16, [x11], #1
    b .Lsc1_66
.Lsc2_66:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_66
    mov x10, x12
    mov x17, #-440
    str x10, [x29, x17]
    ldur x10, [x29, #-48]
    mov x17, #-448
    str x10, [x29, x17]
    mov x17, #-448
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-456
    str x10, [x29, x17]
    mov x17, #-440
    ldr x13, [x29, x17]
    mov x17, #-456
    ldr x14, [x29, x17]
    mov x15, #0
.Lscl1_67:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_67
    add x15, x15, #1
    b .Lscl1_67
.Lscl1d_67:
    mov x9, x15
    mov x15, #0
.Lscl2_67:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_67
    add x15, x15, #1
    b .Lscl2_67
.Lscl2d_67:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_67:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_67
    strb w16, [x11], #1
    b .Lsc1_67
.Lsc2_67:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_67
    mov x10, x12
    mov x17, #-464
    str x10, [x29, x17]
    mov x17, #-464
    ldr x13, [x29, x17]
    adrp x14, __str_12@PAGE
    add x14, x14, __str_12@PAGEOFF
    mov x15, #0
.Lscl1_68:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_68
    add x15, x15, #1
    b .Lscl1_68
.Lscl1d_68:
    mov x9, x15
    mov x15, #0
.Lscl2_68:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_68
    add x15, x15, #1
    b .Lscl2_68
.Lscl2d_68:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_68:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_68
    strb w16, [x11], #1
    b .Lsc1_68
.Lsc2_68:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_68
    mov x10, x12
    mov x17, #-472
    str x10, [x29, x17]
    mov x17, #-472
    ldr x10, [x29, x17]
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-480
    str x10, [x29, x17]
    adrp x10, __str_20@PAGE
    add x10, x10, __str_20@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-488
    str x10, [x29, x17]
    mov x11, #48
    neg x10, x11
    mov x17, #-496
    str x10, [x29, x17]
    mov x17, #-496
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
.Lwhile_cond_325:
    ldur x10, [x29, #-64]
    mov x17, #-504
    str x10, [x29, x17]
    mov x17, #-504
    ldr x11, [x29, x17]
    cmp x11, #48
    b.gt .Lwhile_end_327
.Lwhile_body_326:
    ldur x10, [x29, #-64]
    mov x17, #-520
    str x10, [x29, x17]
    mov x17, #-520
    ldr x10, [x29, x17]
    mov x0, x10
    mov x1, #0
    mov x2, #12345
    bl _terrain_height
    mov x10, x0
    mov x17, #-528
    str x10, [x29, x17]
    mov x17, #-528
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-536
    str x10, [x29, x17]
    mov x17, #-536
    ldr x13, [x29, x17]
    adrp x14, __str_14@PAGE
    add x14, x14, __str_14@PAGEOFF
    mov x15, #0
.Lscl1_69:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_69
    add x15, x15, #1
    b .Lscl1_69
.Lscl1d_69:
    mov x9, x15
    mov x15, #0
.Lscl2_69:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_69
    add x15, x15, #1
    b .Lscl2_69
.Lscl2d_69:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_69:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_69
    strb w16, [x11], #1
    b .Lsc1_69
.Lsc2_69:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_69
    mov x10, x12
    mov x17, #-544
    str x10, [x29, x17]
    mov x17, #-544
    ldr x10, [x29, x17]
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-552
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-560
    str x10, [x29, x17]
    mov x17, #-560
    ldr x11, [x29, x17]
    add x10, x11, #4
    mov x17, #-568
    str x10, [x29, x17]
    mov x17, #-568
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    b .Lwhile_cond_325
.Lwhile_end_327:
    adrp x10, __str_12@PAGE
    add x10, x10, __str_12@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-576
    str x10, [x29, x17]
    adrp x10, __str_21@PAGE
    add x10, x10, __str_21@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-584
    str x10, [x29, x17]
    mov x11, #48
    neg x10, x11
    mov x17, #-592
    str x10, [x29, x17]
    mov x17, #-592
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
.Lwhile_cond_328:
    ldur x10, [x29, #-64]
    mov x17, #-600
    str x10, [x29, x17]
    mov x17, #-600
    ldr x11, [x29, x17]
    cmp x11, #48
    b.gt .Lwhile_end_330
.Lwhile_body_329:
    ldur x10, [x29, #-64]
    mov x17, #-616
    str x10, [x29, x17]
    mov x17, #-616
    ldr x10, [x29, x17]
    mov x0, x10
    mov x1, #0
    mov x2, #12345
    bl _terrain_height
    mov x10, x0
    mov x17, #-624
    str x10, [x29, x17]
    mov x17, #-624
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-632
    str x10, [x29, x17]
    mov x17, #-632
    ldr x13, [x29, x17]
    adrp x14, __str_14@PAGE
    add x14, x14, __str_14@PAGEOFF
    mov x15, #0
.Lscl1_70:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_70
    add x15, x15, #1
    b .Lscl1_70
.Lscl1d_70:
    mov x9, x15
    mov x15, #0
.Lscl2_70:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_70
    add x15, x15, #1
    b .Lscl2_70
.Lscl2d_70:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_70:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_70
    strb w16, [x11], #1
    b .Lsc1_70
.Lsc2_70:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_70
    mov x10, x12
    mov x17, #-640
    str x10, [x29, x17]
    mov x17, #-640
    ldr x10, [x29, x17]
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-648
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-656
    str x10, [x29, x17]
    mov x17, #-656
    ldr x11, [x29, x17]
    add x10, x11, #16
    mov x17, #-664
    str x10, [x29, x17]
    mov x17, #-664
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    b .Lwhile_cond_328
.Lwhile_end_330:
    adrp x10, __str_22@PAGE
    add x10, x10, __str_22@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-672
    str x10, [x29, x17]
    mov x11, #48
    neg x10, x11
    mov x17, #-680
    str x10, [x29, x17]
    mov x17, #-680
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
.Lwhile_cond_331:
    ldur x10, [x29, #-64]
    mov x17, #-688
    str x10, [x29, x17]
    mov x17, #-688
    ldr x11, [x29, x17]
    cmp x11, #48
    b.gt .Lwhile_end_333
.Lwhile_body_332:
    ldur x10, [x29, #-64]
    mov x17, #-704
    str x10, [x29, x17]
    mov x17, #-704
    ldr x10, [x29, x17]
    mov x0, x10
    mov x1, #0
    movz x2, #34463, lsl #0
    movk x2, #1, lsl #16
    bl _terrain_height
    mov x10, x0
    mov x17, #-712
    str x10, [x29, x17]
    mov x17, #-712
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-720
    str x10, [x29, x17]
    mov x17, #-720
    ldr x13, [x29, x17]
    adrp x14, __str_14@PAGE
    add x14, x14, __str_14@PAGEOFF
    mov x15, #0
.Lscl1_71:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_71
    add x15, x15, #1
    b .Lscl1_71
.Lscl1d_71:
    mov x9, x15
    mov x15, #0
.Lscl2_71:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_71
    add x15, x15, #1
    b .Lscl2_71
.Lscl2d_71:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_71:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_71
    strb w16, [x11], #1
    b .Lsc1_71
.Lsc2_71:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_71
    mov x10, x12
    mov x17, #-728
    str x10, [x29, x17]
    mov x17, #-728
    ldr x10, [x29, x17]
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-736
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-744
    str x10, [x29, x17]
    mov x17, #-744
    ldr x11, [x29, x17]
    add x10, x11, #16
    mov x17, #-752
    str x10, [x29, x17]
    mov x17, #-752
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    b .Lwhile_cond_331
.Lwhile_end_333:
    adrp x10, __str_23@PAGE
    add x10, x10, __str_23@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-760
    str x10, [x29, x17]
    mov x11, #48
    neg x10, x11
    mov x17, #-768
    str x10, [x29, x17]
    mov x17, #-768
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
.Lwhile_cond_334:
    ldur x10, [x29, #-64]
    mov x17, #-776
    str x10, [x29, x17]
    mov x17, #-776
    ldr x11, [x29, x17]
    cmp x11, #48
    b.gt .Lwhile_end_336
.Lwhile_body_335:
    ldur x10, [x29, #-64]
    mov x17, #-792
    str x10, [x29, x17]
    mov x17, #-792
    ldr x10, [x29, x17]
    mov x0, x10
    mov x1, #0
    mov x2, #42
    bl _terrain_height
    mov x10, x0
    mov x17, #-800
    str x10, [x29, x17]
    mov x17, #-800
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-808
    str x10, [x29, x17]
    mov x17, #-808
    ldr x13, [x29, x17]
    adrp x14, __str_14@PAGE
    add x14, x14, __str_14@PAGEOFF
    mov x15, #0
.Lscl1_72:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_72
    add x15, x15, #1
    b .Lscl1_72
.Lscl1d_72:
    mov x9, x15
    mov x15, #0
.Lscl2_72:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_72
    add x15, x15, #1
    b .Lscl2_72
.Lscl2d_72:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_72:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_72
    strb w16, [x11], #1
    b .Lsc1_72
.Lsc2_72:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_72
    mov x10, x12
    mov x17, #-816
    str x10, [x29, x17]
    mov x17, #-816
    ldr x10, [x29, x17]
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-824
    str x10, [x29, x17]
    ldur x10, [x29, #-64]
    mov x17, #-832
    str x10, [x29, x17]
    mov x17, #-832
    ldr x11, [x29, x17]
    add x10, x11, #16
    mov x17, #-840
    str x10, [x29, x17]
    mov x17, #-840
    ldr x10, [x29, x17]
    stur x10, [x29, #-64]
    b .Lwhile_cond_334
.Lwhile_end_336:
    adrp x10, __str_12@PAGE
    add x10, x10, __str_12@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-848
    str x10, [x29, x17]
    adrp x10, __str_24@PAGE
    add x10, x10, __str_24@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-856
    str x10, [x29, x17]
    mov x11, #48
    neg x10, x11
    mov x17, #-864
    str x10, [x29, x17]
    mov x17, #-864
    ldr x10, [x29, x17]
    stur x10, [x29, #-88]
.Lwhile_cond_337:
    ldur x10, [x29, #-88]
    mov x17, #-872
    str x10, [x29, x17]
    mov x17, #-872
    ldr x11, [x29, x17]
    cmp x11, #48
    b.gt .Lwhile_end_339
.Lwhile_body_338:
    ldur x10, [x29, #-88]
    mov x17, #-888
    str x10, [x29, x17]
    mov x0, #0
    mov x17, #-888
    ldr x10, [x29, x17]
    mov x1, x10
    mov x2, #12345
    bl _terrain_height
    mov x10, x0
    mov x17, #-896
    str x10, [x29, x17]
    mov x17, #-896
    ldr x10, [x29, x17]
    mov x0, x10
    bl _i32_to_str
    mov x10, x0
    mov x17, #-904
    str x10, [x29, x17]
    mov x17, #-904
    ldr x13, [x29, x17]
    adrp x14, __str_14@PAGE
    add x14, x14, __str_14@PAGEOFF
    mov x15, #0
.Lscl1_73:
    ldrb w16, [x13, x15]
    cbz w16, .Lscl1d_73
    add x15, x15, #1
    b .Lscl1_73
.Lscl1d_73:
    mov x9, x15
    mov x15, #0
.Lscl2_73:
    ldrb w16, [x14, x15]
    cbz w16, .Lscl2d_73
    add x15, x15, #1
    b .Lscl2_73
.Lscl2d_73:
    add x0, x9, x15
    add x0, x0, #1
    stp x13, x14, [sp, #-16]!
    stp x9, x15, [sp, #-16]!
    bl __novus_heap_alloc
    ldp x9, x15, [sp], #16
    ldp x13, x14, [sp], #16
    mov x12, x0
    mov x11, x0
.Lsc1_73:
    ldrb w16, [x13], #1
    cbz w16, .Lsc2_73
    strb w16, [x11], #1
    b .Lsc1_73
.Lsc2_73:
    ldrb w16, [x14], #1
    strb w16, [x11], #1
    cbnz w16, .Lsc2_73
    mov x10, x12
    mov x17, #-912
    str x10, [x29, x17]
    mov x17, #-912
    ldr x10, [x29, x17]
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-920
    str x10, [x29, x17]
    ldur x10, [x29, #-88]
    mov x17, #-928
    str x10, [x29, x17]
    mov x17, #-928
    ldr x11, [x29, x17]
    add x10, x11, #4
    mov x17, #-936
    str x10, [x29, x17]
    mov x17, #-936
    ldr x10, [x29, x17]
    stur x10, [x29, #-88]
    b .Lwhile_cond_337
.Lwhile_end_339:
    adrp x10, __str_12@PAGE
    add x10, x10, __str_12@PAGEOFF
    mov x0, x10
    bl _print
    mov x10, x0
    mov x17, #-944
    str x10, [x29, x17]
    mov x0, #0
    add sp, sp, #976
    ldp x29, x30, [sp], #16
    ret


// ---- Runtime: mmap-backed heap allocator ----
.p2align 2
__novus_heap_alloc:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    add x0, x0, #7
    bic x0, x0, #7
    adrp x9, __novus_heap_ptr@PAGE
    add x9, x9, __novus_heap_ptr@PAGEOFF
    ldr x10, [x9]
    cbz x10, .Lhalloc_init
.Lhalloc_try:
    add x11, x10, x0
    adrp x12, __novus_heap_end@PAGE
    add x12, x12, __novus_heap_end@PAGEOFF
    ldr x13, [x12]
    cmp x11, x13
    b.hi .Lhalloc_grow
    str x11, [x9]
    mov x0, x10
    ldp x29, x30, [sp], #16
    ret
.Lhalloc_init:
    stp x0, x9, [sp, #-16]!
    mov x0, #0
    mov x1, #256
    lsl x1, x1, #20
    mov x2, #3
    mov x3, #0x1002
    mov x4, #-1
    mov x5, #0
    mov x16, #197
    svc #0x80
    mov x10, x0
    ldp x0, x9, [sp], #16
    str x10, [x9]
    mov x14, #256
    lsl x14, x14, #20
    add x14, x10, x14
    adrp x12, __novus_heap_end@PAGE
    add x12, x12, __novus_heap_end@PAGEOFF
    str x14, [x12]
    b .Lhalloc_try
.Lhalloc_grow:
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, #256
    lsl x1, x1, #20
    mov x2, #3
    mov x3, #0x1002
    mov x4, #-1
    mov x5, #0
    mov x16, #197
    svc #0x80
    mov x10, x0
    ldr x0, [sp], #16
    adrp x9, __novus_heap_ptr@PAGE
    add x9, x9, __novus_heap_ptr@PAGEOFF
    str x10, [x9]
    mov x14, #256
    lsl x14, x14, #20
    add x14, x10, x14
    adrp x12, __novus_heap_end@PAGE
    add x12, x12, __novus_heap_end@PAGEOFF
    str x14, [x12]
    b .Lhalloc_try

