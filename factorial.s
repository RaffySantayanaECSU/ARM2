main:
	LDR R0, =5           ; calculate factorial of R0 --- (R0) = n
	LDR R2, =0           ; store factorial in R2 --- (R0)! = (R2) = n!
	BL factorial         ; jump to factorial
	BL finish            ; end program after n! is calculated

factorial:
	STMDB sp!, {lr}      ; store link back to main
	CMP R0, #0           ; check if factorial is done being calculated
	BNE factorialWhile   ; if not, jump to factorialWhile and being calculation
	LDMIA sp!, {pc}      ; if so, pop pc to go back to main
factorialWhile:
	CMP R2, #0	     ; if R2 =/= 0
	BNE factorialNext    ;    then, go to factorialNext
	STMDB sp!, {R4}      ;    else, push R4 onto stack and execute the following instructions
	SUB R4, R0, #1       ; decrement R0 by 1 
	MUL R2, R0, R4       ; R0 * R4, the first two terms of the factorial. Then store in R2
	SUB R0, R0, #2       ; Decrement R0 by two.
	LDMIA sp!, {R4}      ; Pop R4 from stack. Not needed anymore.
	BL factorial         ; call factorial function
factorialNext:
	STMDB sp!, {R5}	     ;push number to multiply final answer by onto the stack
	ADD R5, R2, #0       ; temporarily store R2 into R5
	MUL R5, R2, r0       ; R5 = R2 * R0
	SUB R0, R0, #1       ; decrement R0 by 1
	ADD R2, R5, #0       ; store R5 into R2.
	LDMIA sp!, {R5}      ; pop R5 from the stack. Not needed unless we return to factorialNext
	BL factorial         ; call factorial function

finish:
	.end                 ; terminate


;R0 = paramater = n
;R2 = factorial of paramater = n!

;R4 = temporary value used to calculate (n - 1) * n.
;R5 = temporary value used to calculate factorial through recursion