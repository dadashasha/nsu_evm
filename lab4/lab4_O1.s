CalcSin:
        push    {r3, r4, r5, r6, r7, r8, r9, lr}
        vpush.64        {d8, d9, d10}
        vldr.64 d7, .L7
        vmul.f64        d0, d0, d7
        vldr.64 d7, .L7+8
        vdiv.f64        d9, d0, d7
        adds    r8, r0, r0
        adc     r9, r1, r1
        cmp     r8, #2
        sbcs    r3, r9, #0
        blt     .L4
        vmov.f64        d7, d9
        movs    r4, #1
        movs    r7, #0
        vldr.64 d8, .L7+16
.L3:
        vadd.f64        d8, d8, d7
        vmul.f64        d7, d9, d7
        vnmul.f64       d10, d9, d7
        adds    r0, r4, #1
        adc     r2, r7, #0
        adds    r6, r4, #2
        adc     r5, r7, #0
        mov     r4, r6
        mov     r7, r5
        mul     r3, r0, r5
        mla     r3, r6, r2, r3
        umull   r0, r1, r0, r6
        add     r1, r1, r3
        bl      __aeabi_l2d
        vmov    d6, r0, r1
        vdiv.f64        d7, d10, d6
        cmp     r6, r8
        sbcs    r5, r5, r9
        blt     .L3
.L1:
        vmov.f64        d0, d8
        vldm    sp!, {d8-d10}
        pop     {r3, r4, r5, r6, r7, r8, r9, pc}
.L4:
        vldr.64 d8, .L7+16
        b       .L1
.L7:
        .word   1413753926
        .word   1074340347
        .word   0
        .word   1080459264
        .word   0
        .word   0
.LC0:
        .ascii  "Bad input! Few arguments. Enter x and n in command "
        .ascii  "line.\000"
.LC1:
        .ascii  "Bad input! A lot of arguments. Enter x and n in com"
        .ascii  "mand line.\000"
.LC2:
        .ascii  "Timer resolution: %ld sec, %ld nanosec.\012\000"
.LC3:
        .ascii  "Call error clock_getres!\000"
.LC4:
        .ascii  "Error: Invalid input for x: %s\012\000"
.LC5:
        .ascii  "Error: Invalid input for n: %s\012\000"
.LC6:
        .ascii  "%lf\012\000"
.LC7:
        .ascii  "Time takken: %lf sec.\012\000"
main:
        push    {r4, r5, r6, lr}
        vpush.64        {d8}
        sub     sp, sp, #32
        cmp     r0, #2
        ble     .L18
        mov     r4, r1
        cmp     r0, #3
        bgt     .L19
        add     r1, sp, #24
        movs    r0, #4
        bl      clock_getres
        cmp     r0, #0
        bne     .L13
        ldr     r2, [sp, #28]
        ldr     r1, [sp, #24]
        movw    r0, #:lower16:.LC2
        movt    r0, #:upper16:.LC2
        bl      printf
.L14:
        movs    r2, #10
        add     r1, sp, #4
        ldr     r0, [r4, #4]
        bl      strtol
        vmov    s16, r0 @ int
        movs    r2, #10
        mov     r1, sp
        ldr     r0, [r4, #8]
        bl      strtol
        mov     r5, r0
        asrs    r6, r0, #31
        ldr     r3, [sp, #4]
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        bne     .L20
        ldr     r3, [sp]
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        bne     .L21
        add     r1, sp, #16
        movs    r0, #4
        bl      clock_gettime
        mov     r0, r5
        mov     r1, r6
        vcvt.f64.s32    d0, s16
        bl      CalcSin
        vmov    r4, r5, d0
        add     r1, sp, #8
        movs    r0, #4
        bl      clock_gettime
        mov     r2, r4
        mov     r3, r5
        movw    r0, #:lower16:.LC6
        movt    r0, #:upper16:.LC6
        bl      printf
        ldr     r3, [sp, #12]
        ldr     r2, [sp, #20]
        subs    r3, r3, r2
        vmov    s15, r3 @ int
        vcvt.f64.s32    d6, s15
        ldr     r3, [sp, #8]
        ldr     r2, [sp, #16]
        subs    r3, r3, r2
        vmov    s15, r3 @ int
        vcvt.f64.s32    d7, s15
        vldr.64 d5, .L22
        vmla.f64        d7, d6, d5
        vmov    r2, r3, d7
        movw    r0, #:lower16:.LC7
        movt    r0, #:upper16:.LC7
        bl      printf
        movs    r0, #0
.L9:
        add     sp, sp, #32
        vldm    sp!, {d8}
        pop     {r4, r5, r6, pc}
.L18:
        movw    r0, #:lower16:.LC0
        movt    r0, #:upper16:.LC0
        bl      printf
        mov     r0, #-1
        b       .L9
.L19:
        movw    r0, #:lower16:.LC1
        movt    r0, #:upper16:.LC1
        bl      printf
        mov     r0, #-1
        b       .L9
.L13:
        movw    r0, #:lower16:.LC3
        movt    r0, #:upper16:.LC3
        bl      perror
        b       .L14
.L20:
        ldr     r1, [r4, #4]
        movw    r0, #:lower16:.LC4
        movt    r0, #:upper16:.LC4
        bl      printf
        mov     r0, #-1
        b       .L9
.L21:
        ldr     r1, [r4, #8]
        movw    r0, #:lower16:.LC5
        movt    r0, #:upper16:.LC5
        bl      printf
        mov     r0, #-1
        b       .L9
.L22:
        .word   -400107883
        .word   1041313291
        
