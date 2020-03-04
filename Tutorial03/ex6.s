@ ARM Assembly - exercise 6 
@ Group Number :

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	
fact:
	//stack operations
	mov r2, #1 @ r2 = 1
	loop:
		cmp r0, #1 @ loop when the ro = 1
		bls Exit
		mov r1, r2 @ save the value temarily for multiplication operation r1 = r2
		mul r2, r1, r0
		sub r0, r0, #1
		b loop
	Exit:
		mov r0, r2
	//stack oparation
	mov pc, lr
@ ---------------------	

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "Factorial of %d is %d\n"

