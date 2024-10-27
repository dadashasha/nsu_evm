CalcSin:
        mulsd   xmm0, QWORD PTR .LC1[rip]
        divsd   xmm0, QWORD PTR .LC2[rip]
        add     rdi, rdi
        cmp     rdi, 1
        jle     .L4
        add     rdi, 1
        movapd  xmm1, xmm0
        mov     eax, 1
        pxor    xmm2, xmm2
        movq    xmm4, QWORD PTR .LC3[rip]
.L3:
        addsd   xmm2, xmm1
        mulsd   xmm1, xmm0
        mulsd   xmm1, xmm0
        xorpd   xmm1, xmm4
        lea     rdx, [rax+1]
        add     rax, 2
        imul    rdx, rax
        pxor    xmm3, xmm3
        cvtsi2sd        xmm3, rdx
        divsd   xmm1, xmm3
        cmp     rax, rdi
        jne     .L3
.L1:
        movapd  xmm0, xmm2
        ret
.L4:
        pxor    xmm2, xmm2
        jmp     .L1
.LC4:
        .string "Bad input! Few arguments. Enter x and n in command line."
.LC5:
        .string "Bad input! A lot of arguments. Enter x and n in command line."
.LC6:
        .string "Timer resolution: %ld sec, %ld nanosec.\n"
.LC7:
        .string "Call error clock_getres!"
.LC8:
        .string "Error: Invalid input for x: %s\n"
.LC9:
        .string "Error: Invalid input for n: %s\n"
.LC10:
        .string "%lf\n"
.LC12:
        .string "Time takken: %lf sec.\n"
main:
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 80
        cmp     edi, 2
        jle     .L15
        mov     rbx, rsi
        cmp     edi, 3
        jg      .L16
        lea     rsi, [rsp+64]
        mov     edi, 4
        call    clock_getres
        test    eax, eax
        jne     .L10
        mov     rdx, QWORD PTR [rsp+72]
        mov     rsi, QWORD PTR [rsp+64]
        mov     edi, OFFSET FLAT:.LC6
        call    printf
.L11:
        lea     rsi, [rsp+24]
        mov     rdi, QWORD PTR [rbx+8]
        mov     edx, 10
        call    strtol
        mov     r12, rax
        lea     rsi, [rsp+16]
        mov     rdi, QWORD PTR [rbx+16]
        mov     edx, 10
        call    strtol
        mov     rbp, rax
        mov     rax, QWORD PTR [rsp+24]
        cmp     BYTE PTR [rax], 0
        jne     .L17
        mov     rax, QWORD PTR [rsp+16]
        cmp     BYTE PTR [rax], 0
        jne     .L18
        lea     rsi, [rsp+48]
        mov     edi, 4
        call    clock_gettime
        pxor    xmm0, xmm0
        cvtsi2sd        xmm0, r12
        mov     rdi, rbp
        call    CalcSin
        movsd   QWORD PTR [rsp+8], xmm0
        lea     rsi, [rsp+32]
        mov     edi, 4
        call    clock_gettime
        movsd   xmm0, QWORD PTR [rsp+8]
        mov     edi, OFFSET FLAT:.LC10
        mov     eax, 1
        call    printf
        mov     rax, QWORD PTR [rsp+40]
        sub     rax, QWORD PTR [rsp+56]
        pxor    xmm0, xmm0
        cvtsi2sd        xmm0, rax
        mulsd   xmm0, QWORD PTR .LC11[rip]
        mov     rax, QWORD PTR [rsp+32]
        sub     rax, QWORD PTR [rsp+48]
        pxor    xmm1, xmm1
        cvtsi2sd        xmm1, rax
        addsd   xmm0, xmm1
        mov     edi, OFFSET FLAT:.LC12
        mov     eax, 1
        call    printf
        mov     eax, 0
.L6:
        add     rsp, 80
        pop     rbx
        pop     rbp
        pop     r12
        ret
.L15:
        mov     edi, OFFSET FLAT:.LC4
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L6
.L16:
        mov     edi, OFFSET FLAT:.LC5
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L6
.L10:
        mov     edi, OFFSET FLAT:.LC7
        call    perror
        jmp     .L11
.L17:
        mov     rsi, QWORD PTR [rbx+8]
        mov     edi, OFFSET FLAT:.LC8
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L6
.L18:
        mov     rsi, QWORD PTR [rbx+16]
        mov     edi, OFFSET FLAT:.LC9
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L6
.LC1:
        .long   1413753926
        .long   1074340347
.LC2:
        .long   0
        .long   1080459264
.LC3:
        .long   0
        .long   -2147483648
        .long   0
        .long   0
.LC11:
        .long   -400107883
        .long   1041313291