@ ARM Assembly - lab 2
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	mov r0, #10
	mov r1, #5
	mov r2, #7
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------

	MOV r0, #-1 @ i = 0
	MOV r3, #0 @ sum = 0

Loop1:              @ Outer Loop
	ADD r0, r0, #1  @ i = i + 1
	CMP r0, #10
	BGE Exit        @ if (r1 >= 10) then Exit

	MOV r1, #4      @ j = 4

	Loop2:
		ADD r1, r1, #1  @ j = j + 1
		CMP r1, #15
		BGE Loop1    @ if (r2 >= 15) then Exit_Inner_Loop

		ADD r4, r0, r1 @ r4 = i + j
		CMP r4, #10
		BGE Else      @ if (r4 >= 10) then Else
		ADD r3, r3, r0, LSL #1  @ sum += i*2 (if Condition)
		b EndIf

		Else:
			AND r6, r0, r1 @ r6 = i&j
			ADD r3, r3, r6 @ r3 = r3 + r6

		EndIf:
			B Loop2
	
Exit:	
	MOV r5, r3
	
	
	
	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

