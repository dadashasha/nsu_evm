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
        push    {r4, r5, r7, lr}
        sub     sp, sp, #64
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        ldr     r3, [r7, #4]
        cmp     r3, #2
        bgt     .L2
        movw    r0, #:lower16:.LC0
        movt    r0, #:upper16:.LC0
        bl      printf
        mov     r3, #-1
        b       .L9
.L2:
        ldr     r3, [r7, #4]
        cmp     r3, #3
        ble     .L4
        movw    r0, #:lower16:.LC1
        movt    r0, #:upper16:.LC1
        bl      printf
        mov     r3, #-1
        b       .L9
.L4:
        add     r3, r7, #32
        mov     r1, r3
        movs    r0, #4
        bl      clock_getres
        mov     r3, r0
        cmp     r3, #0
        bne     .L5
        ldr     r3, [r7, #32]
        ldr     r2, [r7, #36]
        mov     r1, r3
        movw    r0, #:lower16:.LC2
        movt    r0, #:upper16:.LC2
        bl      printf
        b       .L6
.L5:
        movw    r0, #:lower16:.LC3
        movt    r0, #:upper16:.LC3
        bl      perror
.L6:
        ldr     r3, [r7]
        adds    r3, r3, #4
        ldr     r3, [r3]
        add     r1, r7, #12
        movs    r2, #10
        mov     r0, r3
        bl      strtol
        str     r0, [r7, #60]
        ldr     r3, [r7]
        adds    r3, r3, #8
        ldr     r3, [r3]
        add     r1, r7, #8
        movs    r2, #10
        mov     r0, r3
        bl      strtol
        mov     r3, r0
        asrs    r2, r3, #31
        mov     r4, r3
        mov     r5, r2
        strd    r4, [r7, #48]
        ldr     r3, [r7, #12]
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        beq     .L7
        ldr     r3, [r7]
        adds    r3, r3, #4
        ldr     r3, [r3]
        mov     r1, r3
        movw    r0, #:lower16:.LC4
        movt    r0, #:upper16:.LC4
        bl      printf
        mov     r3, #-1
        b       .L9
.L7:
        ldr     r3, [r7, #8]
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        beq     .L8
        ldr     r3, [r7]
        adds    r3, r3, #8
        ldr     r3, [r3]
        mov     r1, r3
        movw    r0, #:lower16:.LC5
        movt    r0, #:upper16:.LC5
        bl      printf
        mov     r3, #-1
        b       .L9
.L8:
        add     r3, r7, #24
        mov     r1, r3
        movs    r0, #4
        bl      clock_gettime
        ldr     r3, [r7, #60]
        vmov    s15, r3 @ int
        vcvt.f64.s32    d7, s15
        ldrd    r0, [r7, #48]
        vmov.f64        d0, d7
        bl      CalcSin
        vstr.64 d0, [r7, #40]
        add     r3, r7, #16
        mov     r1, r3
        movs    r0, #4
        bl      clock_gettime
        ldrd    r2, [r7, #40]
        movw    r0, #:lower16:.LC6
        movt    r0, #:upper16:.LC6
        bl      printf
        ldr     r2, [r7, #16]
        ldr     r3, [r7, #24]
        subs    r3, r2, r3
        vmov    s15, r3 @ int
        vcvt.f64.s32    d6, s15
        ldr     r2, [r7, #20]
        ldr     r3, [r7, #28]
        subs    r3, r2, r3
        vmov    s15, r3 @ int
        vcvt.f64.s32    d7, s15
        vldr.64 d5, .L10
        vmul.f64        d7, d7, d5
        vadd.f64        d7, d6, d7
        vmov    r2, r3, d7
        movw    r0, #:lower16:.LC7
        movt    r0, #:upper16:.LC7
        bl      printf
        movs    r3, #0
.L9:
        mov     r0, r3
        adds    r7, r7, #64
        mov     sp, r7
        pop     {r4, r5, r7, pc}
.L10:
        .word   -400107883
        .word   1041313291
CalcSin:
        push    {r4, r5, r7, r8, r9, r10, fp, lr}
        vpush.64        {d8}
        sub     sp, sp, #56
        add     r7, sp, #0
        vstr.64 d0, [r7, #24]
        strd    r0, [r7, #16]
        mov     r2, #0
        mov     r3, #0
        strd    r2, [r7, #48]
        vldr.64 d7, [r7, #24]
        vldr.64 d6, .L16
        vmul.f64        d6, d7, d6
        vldr.64 d5, .L16+8
        vdiv.f64        d7, d6, d5
        vstr.64 d7, [r7, #24]
        ldrd    r2, [r7, #24]
        strd    r2, [r7, #40]
        mov     r2, #1
        mov     r3, #0
        strd    r2, [r7, #32]
        b       .L13
.L14:
        vldr.64 d6, [r7, #48]
        vldr.64 d7, [r7, #40]
        vadd.f64        d7, d6, d7
        vstr.64 d7, [r7, #48]
        vldr.64 d6, [r7, #40]
        vldr.64 d7, [r7, #24]
        vmul.f64        d6, d6, d7
        vldr.64 d7, [r7, #24]
        vmul.f64        d7, d6, d7
        vneg.f64        d8, d7
        ldrd    r2, [r7, #32]
        adds    r4, r2, #1
        adc     r5, r3, #0
        ldrd    r2, [r7, #32]
        adds    r8, r2, #2
        adc     r9, r3, #0
        mul     r2, r8, r5
        mul     r3, r4, r9
        add     r3, r3, r2
        umull   r10, fp, r4, r8
        add     r3, r3, fp
        mov     fp, r3
        mov     r0, r10
        mov     r1, fp
        bl      __aeabi_l2d
        vmov    d6, r0, r1
        vdiv.f64        d7, d8, d6
        vstr.64 d7, [r7, #40]
        ldrd    r2, [r7, #32]
        adds    r1, r2, #2
        str     r1, [r7, #8]
        adc     r3, r3, #0
        str     r3, [r7, #12]
        ldrd    r2, [r7, #8]
        strd    r2, [r7, #32]
.L13:
        ldrd    r2, [r7, #16]
        adds    r1, r2, r2
        str     r1, [r7]
        adcs    r3, r3, r3
        str     r3, [r7, #4]
        ldrd    r0, [r7]
        ldrd    r2, [r7, #32]
        cmp     r2, r0
        sbcs    r3, r3, r1
        blt     .L14
        ldrd    r2, [r7, #48]
        vmov    d7, r2, r3
        vmov.f64        d0, d7
        adds    r7, r7, #56
        mov     sp, r7
        vldm    sp!, {d8}
        pop     {r4, r5, r7, r8, r9, r10, fp, pc}
.L16:
        .word   1413753926
        .word   1074340347
        .word   0
        .word   1080459264
        
