.data
argument: .word    10
str1:     .string "Fibonacci("
str2:     .string ") = "

.text
main:
        lw    a0, argument  # n = 10
        li    s0, 1
        jal   ra, fib          # call fib(10)

        mv    a1, a0
        lw    a0, argument
        jal   ra, printResult

        j     exit

fib:
        ble   a0, s0, L1
        addi  sp, sp, -12
        sw    ra, 8(sp)
        sw    a0, 4(sp)
        addi  a0, a0, -1
        jal   ra, fib
        sw    a0, 0(sp)
        lw    a0, 4(sp)
        addi  a0, a0, -2
        jal   ra, fib
        lw    t0, 0(sp)
        add   a0, a0, t0
        lw    ra, 8(sp)
        addi  sp, sp, 12
        ret
	
L1:
        ret

printResult:
        mv    t0, a0
        mv    t1, a1
        la    a0, str1
        li    a7, 4
        ecall
        mv    a0, t0
        li    a7, 1
        ecall
        la    a0, str2
        li    a7, 4
        ecall
        mv    a0, t1
        li    a7, 1
        ecall
        ret

exit:
        li   a7, 10
        ecall
