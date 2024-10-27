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
        push    {r4, r5, r6, r7, lr}
        cmp     r0, #2
        vpush.64        {d8, d9, d10}
        sub     sp, sp, #36
        ble     .L16
        cmp     r0, #3
        bne     .L17
        mov     r4, r1
        movs    r0, #4
        add     r1, sp, #8
        bl      clock_getres
        cmp     r0, #0
        bne     .L6
        movw    r0, #:lower16:.LC2
        movt    r0, #:upper16:.LC2
        ldrd    r1, r2, [sp, #8]
        bl      printf
.L7:
        movs    r2, #10
        mov     r1, sp
        ldr     r0, [r4, #4]
        bl      strtol
        movs    r2, #10
        mov     r3, r0
        add     r1, sp, #4
        ldr     r0, [r4, #8]
        vmov    s16, r3 @ int
        bl      strtol
        ldr     r3, [sp]
        mov     r6, r0
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        bne     .L18
        ldr     r3, [sp, #4]
        ldrb    r5, [r3]        @ zero_extendqisi2
        cmp     r5, #0
        bne     .L19
        add     r1, sp, #16
        movs    r0, #4
        bl      clock_gettime
        vcvt.f64.s32    d7, s16
        vldr.64 d6, .L20
        asrs    r7, r6, #31
        adds    r6, r6, r6
        adcs    r7, r7, r7
        cmp     r6, #2
        vmul.f64        d7, d7, d6
        sbcs    r3, r7, #0
        blt     .L12
        vmul.f64        d10, d7, d7
        movs    r4, #1
        vldr.64 d8, .L20+8
.L11:
        adds    r0, r4, #1
        vnmul.f64       d9, d7, d10
        adc     r2, r5, #0
        adds    r4, r4, #2
        adc     r5, r5, #0
        vadd.f64        d8, d8, d7
        mul     r3, r0, r5
        mla     r3, r4, r2, r3
        umull   r0, r1, r0, r4
        add     r1, r1, r3
        bl      __aeabi_l2d
        vmov    d6, r0, r1
        cmp     r4, r6
        vdiv.f64        d7, d9, d6
        sbcs    r3, r5, r7
        blt     .L11
.L10:
        add     r1, sp, #24
        movs    r0, #4
        bl      clock_gettime
        vmov    r2, r3, d8
        movw    r0, #:lower16:.LC6
        movt    r0, #:upper16:.LC6
        bl      printf
        ldr     r2, [sp, #28]
        ldrd    r0, r3, [sp, #20]
        ldr     r1, [sp, #16]
        subs    r2, r2, r0
        vmov    s15, r2 @ int
        subs    r3, r3, r1
        vldr.64 d5, .L20+16
        vcvt.f64.s32    d6, s15
        vmov    s15, r3 @ int
        movw    r0, #:lower16:.LC7
        movt    r0, #:upper16:.LC7
        vcvt.f64.s32    d7, s15
        vmla.f64        d7, d6, d5
        vmov    r2, r3, d7
        bl      printf
        movs    r0, #0
.L1:
        add     sp, sp, #36
        vldm    sp!, {d8-d10}
        pop     {r4, r5, r6, r7, pc}
.L12:
        vldr.64 d8, .L20+8
        b       .L10
.L17:
        movw    r0, #:lower16:.LC1
        movt    r0, #:upper16:.LC1
        bl      printf
.L3:
        mov     r0, #-1
        b       .L1
.L19:
        ldr     r1, [r4, #8]
        movw    r0, #:lower16:.LC5
        movt    r0, #:upper16:.LC5
        bl      printf
        b       .L3
.L18:
        ldr     r1, [r4, #4]
        movw    r0, #:lower16:.LC4
        movt    r0, #:upper16:.LC4
        bl      printf
        b       .L3
.L16:
        movw    r0, #:lower16:.LC0
        movt    r0, #:upper16:.LC0
        bl      printf
        b       .L3
.L6:
        movw    r0, #:lower16:.LC3
        movt    r0, #:upper16:.LC3
        bl      perror
        b       .L7
.L20:
        .word   -1571644252
        .word   1066524486
        .word   0
        .word   0
        .word   -400107883
        .word   1041313291
CalcSin:
        vldr.64 d7, .L28
        push    {r3, r4, r5, r6, r7, lr}
        adds    r6, r0, r0
        adc     r7, r1, r1
        cmp     r6, #2
        vmul.f64        d7, d0, d7
        sbcs    r3, r7, #0
        vpush.64        {d8, d9, d10}
        blt     .L25
        vmul.f64        d10, d7, d7
        movs    r4, #1
        movs    r5, #0
        vldr.64 d8, .L28+8
.L24:
        adds    r0, r4, #1
        vnmul.f64       d9, d7, d10
        adc     r2, r5, #0
        adds    r4, r4, #2
        adc     r5, r5, #0
        vadd.f64        d8, d8, d7
        mul     r3, r0, r5
        mla     r3, r4, r2, r3
        umull   r0, r1, r0, r4
        add     r1, r1, r3
        bl      __aeabi_l2d
        vmov    d6, r0, r1
        cmp     r4, r6
        vdiv.f64        d7, d9, d6
        sbcs    r3, r5, r7
        blt     .L24
        vmov.f64        d0, d8
        vldm    sp!, {d8-d10}
        pop     {r3, r4, r5, r6, r7, pc}
.L25:
        vldr.64 d8, .L28+8
        vmov.f64        d0, d8
        vldm    sp!, {d8-d10}
        pop     {r3, r4, r5, r6, r7, pc}
.L28:
        .word   -1571644252
        .word   1066524486
        .word   0
        .word   0
        
