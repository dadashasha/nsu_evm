.LC0:
        .string "Bad input! Few arguments. Enter x and n in command line."
.LC1:
        .string "Bad input! A lot of arguments. Enter x and n in command line."
.LC2:
        .string "Timer resolution: %ld sec, %ld nanosec.\n"
.LC3:
        .string "Call error clock_getres!"
.LC4:
        .string "Error: Invalid input for x: %s\n"
.LC5:
        .string "Error: Invalid input for n: %s\n"
.LC6:
        .string "%lf\n"
.LC8:
        .string "Time takken: %lf sec.\n"
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 112
        mov     DWORD PTR [rbp-100], edi
        mov     QWORD PTR [rbp-112], rsi
        cmp     DWORD PTR [rbp-100], 2
        jg      .L2
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L9
.L2:
        cmp     DWORD PTR [rbp-100], 3
        jle     .L4
        mov     edi, OFFSET FLAT:.LC1
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L9
.L4:
        lea     rax, [rbp-48]
        mov     rsi, rax
        mov     edi, 4
        call    clock_getres
        test    eax, eax
        jne     .L5
        mov     rdx, QWORD PTR [rbp-40]
        mov     rax, QWORD PTR [rbp-48]
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC2
        mov     eax, 0
        call    printf
        jmp     .L6
.L5:
        mov     edi, OFFSET FLAT:.LC3
        call    perror
.L6:
        mov     rax, QWORD PTR [rbp-112]
        add     rax, 8
        mov     rax, QWORD PTR [rax]
        lea     rcx, [rbp-88]
        mov     edx, 10
        mov     rsi, rcx
        mov     rdi, rax
        call    strtol
        mov     QWORD PTR [rbp-8], rax
        mov     rax, QWORD PTR [rbp-112]
        add     rax, 16
        mov     rax, QWORD PTR [rax]
        lea     rcx, [rbp-96]
        mov     edx, 10
        mov     rsi, rcx
        mov     rdi, rax
        call    strtol
        mov     QWORD PTR [rbp-16], rax
        mov     rax, QWORD PTR [rbp-88]
        movzx   eax, BYTE PTR [rax]
        test    al, al
        je      .L7
        mov     rax, QWORD PTR [rbp-112]
        add     rax, 8
        mov     rax, QWORD PTR [rax]
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC4
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L9
.L7:
        mov     rax, QWORD PTR [rbp-96]
        movzx   eax, BYTE PTR [rax]
        test    al, al
        je      .L8
        mov     rax, QWORD PTR [rbp-112]
        add     rax, 16
        mov     rax, QWORD PTR [rax]
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.LC5
        mov     eax, 0
        call    printf
        mov     eax, -1
        jmp     .L9
.L8:
        lea     rax, [rbp-64]
        mov     rsi, rax
        mov     edi, 4
        call    clock_gettime
        pxor    xmm3, xmm3
        cvtsi2sd        xmm3, QWORD PTR [rbp-8]
        movq    rax, xmm3
        mov     rdx, QWORD PTR [rbp-16]
        mov     rdi, rdx
        movq    xmm0, rax
        call    CalcSin
        movq    rax, xmm0
        mov     QWORD PTR [rbp-24], rax
        lea     rax, [rbp-80]
        mov     rsi, rax
        mov     edi, 4
        call    clock_gettime
        mov     rax, QWORD PTR [rbp-24]
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC6
        mov     eax, 1
        call    printf
        mov     rdx, QWORD PTR [rbp-80]
        mov     rax, QWORD PTR [rbp-64]
        sub     rdx, rax
        pxor    xmm1, xmm1
        cvtsi2sd        xmm1, rdx
        mov     rdx, QWORD PTR [rbp-72]
        mov     rax, QWORD PTR [rbp-56]
        sub     rdx, rax
        pxor    xmm2, xmm2
        cvtsi2sd        xmm2, rdx
        movsd   xmm0, QWORD PTR .LC7[rip]
        mulsd   xmm0, xmm2
        addsd   xmm1, xmm0
        movq    rax, xmm1
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:.LC8
        mov     eax, 1
        call    printf
        mov     eax, 0
.L9:
        leave
        ret
CalcSin:
        push    rbp
        mov     rbp, rsp
        movsd   QWORD PTR [rbp-40], xmm0
        mov     QWORD PTR [rbp-48], rdi
        pxor    xmm0, xmm0
        movsd   QWORD PTR [rbp-8], xmm0
        movsd   xmm1, QWORD PTR [rbp-40]
        movsd   xmm0, QWORD PTR .LC10[rip]
        mulsd   xmm0, xmm1
        movsd   xmm1, QWORD PTR .LC11[rip]
        divsd   xmm0, xmm1
        movsd   QWORD PTR [rbp-40], xmm0
        movsd   xmm0, QWORD PTR [rbp-40]
        movsd   QWORD PTR [rbp-16], xmm0
        mov     QWORD PTR [rbp-24], 1
        jmp     .L11
.L12:
        movsd   xmm0, QWORD PTR [rbp-8]
        addsd   xmm0, QWORD PTR [rbp-16]
        movsd   QWORD PTR [rbp-8], xmm0
        movsd   xmm0, QWORD PTR [rbp-16]
        mulsd   xmm0, QWORD PTR [rbp-40]
        mulsd   xmm0, QWORD PTR [rbp-40]
        movq    xmm1, QWORD PTR .LC12[rip]
        xorpd   xmm0, xmm1
        mov     rax, QWORD PTR [rbp-24]
        lea     rdx, [rax+1]
        mov     rax, QWORD PTR [rbp-24]
        add     rax, 2
        imul    rax, rdx
        pxor    xmm1, xmm1
        cvtsi2sd        xmm1, rax
        divsd   xmm0, xmm1
        movsd   QWORD PTR [rbp-16], xmm0
        add     QWORD PTR [rbp-24], 2
.L11:
        mov     rax, QWORD PTR [rbp-48]
        add     rax, rax
        cmp     QWORD PTR [rbp-24], rax
        jl      .L12
        movsd   xmm0, QWORD PTR [rbp-8]
        pop     rbp
        ret
.LC7:
        .long   -400107883
        .long   1041313291
.LC10:
        .long   1413753926
        .long   1074340347
.LC11:
        .long   0
        .long   1080459264
.LC12:
        .long   0
        .long   -2147483648
        .long   0
        .long   0