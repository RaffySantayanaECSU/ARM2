main:
	LDR R0, =6		;find the n-th term in the fib sequence --- (R0) = n
	BL fibStart		;branch line to fibStart
	BL finish		;branch line to finish

fibStart:
	STMDB sp!, {lr}		;store link back to main
	STMDB sp!, {R4}		;Push R4 onto stack
	STMDB sp!, {R5}		;Push R5 onto stack
	STMDB sp!, {R6}		;Push R6 onto stack
	LDR R4, =2		;(R4) = 2
	LDR R5, =1		;(R5) = 1
	LDR R6, =1		;(R6) = 1
fib:
	ADD R4, R4, #1		;Increment (R4) by one for each recursion.
	STMDB sp!, {R7}		;Push R7 onto stack
	ADD R7, R5, R6		;Next term is equal to (R5) + (R6)
	ADD R5, R6, #0		;Store R6 into R5
	ADD R6, R7, #0		;Store R7 into R6
	LDMIA sp!, {R7}		;Pop (R7) off the stack
	CMP R4, R0		;if R4 =/= R0
	BNE fib			;	then, jump to fib if R4 =/= R0
fibEnd:
	ADD R1, R6, #0		;store R6 into R1
	LDMIA sp!, {R6}		;Push R6 onto stack
	LDMIA sp!, {R5}		;Push R5 onto stack
	LDMIA sp!, {R4}		;Push R4 onto stack
	LDMIA sp!, {pc}		;Push pc onto stack
finish:
	.end

; R0 = parameter = n
; R1 = value at Fib_n
; lr = link to main
; R4 = counter, execute fib until == r0
; R5 = value1	(third-to-last fib number)
; R6 = value2	(second-to-last fib number)
; R7 = upcoming number in fib sequence (value1 + value2 = next fib number)

;Note: We start the sequence at 1, not 0.