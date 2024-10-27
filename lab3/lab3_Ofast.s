.LC1:
        .string "Bad input! Few arguments. Enter x and n in command line."
.LC2:
        .string "Bad input! A lot of arguments. Enter x and n in command line."
.LC3:
        .string "Timer resolution: %ld sec, %ld nanosec.\n"
.LC4:
        .string "Call error clock_getres!"
.LC5:
        .string "Error: Invalid input for x: %s\n"
.LC6:
        .string "Error: Invalid input for n: %s\n"
.LC9:
        .string "%lf\n"
.LC11:
        .string "Time takken: %lf sec.\n"
main:
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 80
        cmp     edi, 2
        jle     .L16
        cmp     edi, 3
        jne     .L17
        mov     rbp, rsi
        mov     edi, 4
        lea     rsi, [rsp+32]
        call    clock_getres
        test    eax, eax
        je      .L18
        mov     edi, OFFSET FLAT:.LC4
        call    perror
.L7:
        mov     rdi, QWORD PTR [rbp+8]
        lea     rsi, [rsp+16]
        mov     edx, 10
        call    strtol
        mov     rdi, QWORD PTR [rbp+16]
        lea     rsi, [rsp+24]
        mov     edx, 10
        mov     r12, rax
        call    strtol
        mov     rbx, rax
        mov     rax, QWORD PTR [rsp+16]
        cmp     BYTE PTR [rax], 0
        jne     .L19
        mov     rax, QWORD PTR [rsp+24]
        cmp     BYTE PTR [rax], 0
        jne     .L20
        lea     rsi, [rsp+48]
        mov     edi, 4
        call    clock_gettime
        pxor    xmm0, xmm0
        lea     rcx, [rbx+rbx]
        cvtsi2sd        xmm0, r12
        mulsd   xmm0, QWORD PTR .LC7[rip]
        cmp     rcx, 1
        jle     .L12
        movapd  xmm4, xmm0
        add     rcx, 1
        mov     eax, 1
        movq    xmm3, QWORD PTR .LC8[rip]
        mulsd   xmm4, xmm0
        pxor    xmm1, xmm1
.L11:
        lea     rdx, [rax+1]
        addsd   xmm1, xmm0
        mulsd   xmm0, xmm4
        add     rax, 2
        imul    rdx, rax
        pxor    xmm2, xmm2
        cvtsi2sd        xmm2, rdx
        xorpd   xmm0, xmm3
        divsd   xmm0, xmm2
        cmp     rax, rcx
        jne     .L11
.L10:
        lea     rsi, [rsp+64]
        mov     edi, 4
        movsd   QWORD PTR [rsp+8], xmm1
        call    clock_gettime
        movsd   xmm1, QWORD PTR [rsp+8]
        mov     edi, OFFSET FLAT:.LC9
        mov     eax, 1
        movapd  xmm0, xmm1
        call    printf
        mov     rax, QWORD PTR [rsp+72]
        pxor    xmm0, xmm0
        sub     rax, QWORD PTR [rsp+56]
        cvtsi2sd        xmm0, rax
        pxor    xmm1, xmm1
        mov     rax, QWORD PTR [rsp+64]
        sub     rax, QWORD PTR [rsp+48]
        mulsd   xmm0, QWORD PTR .LC10[rip]
        cvtsi2sd        xmm1, rax
        mov     edi, OFFSET FLAT:.LC11
        mov     eax, 1
        addsd   xmm0, xmm1
        call    printf
        xor     eax, eax
.L1:
        add     rsp, 80
        pop     rbx
        pop     rbp
        pop     r12
        ret
.L18:
        mov     rdx, QWORD PTR [rsp+40]
        mov     rsi, QWORD PTR [rsp+32]
        mov     edi, OFFSET FLAT:.LC3
        call    printf
        jmp     .L7
.L12:
        pxor    xmm1, xmm1
        jmp     .L10
.L17:
        mov     edi, OFFSET FLAT:.LC2
        xor     eax, eax
        call    printf
.L3:
        or      eax, -1
        jmp     .L1
.L20:
        mov     rsi, QWORD PTR [rbp+16]
        mov     edi, OFFSET FLAT:.LC6
        xor     eax, eax
        call    printf
        jmp     .L3
.L19:
        mov     rsi, QWORD PTR [rbp+8]
        mov     edi, OFFSET FLAT:.LC5
        xor     eax, eax
        call    printf
        jmp     .L3
.L16:
        mov     edi, OFFSET FLAT:.LC1
        xor     eax, eax
        call    printf
        jmp     .L3
CalcSin:
        mulsd   xmm0, QWORD PTR .LC7[rip]
        add     rdi, rdi
        cmp     rdi, 1
        jle     .L24
        movapd  xmm4, xmm0
        add     rdi, 1
        mov     eax, 1
        movq    xmm3, QWORD PTR .LC8[rip]
        mulsd   xmm4, xmm0
        pxor    xmm1, xmm1
.L23:
        lea     rdx, [rax+1]
        addsd   xmm1, xmm0
        mulsd   xmm0, xmm4
        add     rax, 2
        imul    rdx, rax
        pxor    xmm2, xmm2
        cvtsi2sd        xmm2, rdx
        xorpd   xmm0, xmm3
        divsd   xmm0, xmm2
        cmp     rax, rdi
        jne     .L23
        movapd  xmm0, xmm1
        ret
.L24:
        pxor    xmm1, xmm1
        movapd  xmm0, xmm1
        ret
.LC7:
        .long   -1571644252
        .long   1066524486
.LC8:
        .long   0
        .long   -2147483648
        .long   0
        .long   0
.LC10:
        .long   -400107883
        .long   1041313291