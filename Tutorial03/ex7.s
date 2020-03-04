@ ARM Assembly - exercise 7 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
Fibonacci:

	cmp r0, #2 
	bls Exit

	//preserving the varibles in the stack
	sub sp, sp, #12
	str lr, [sp, #8]

	sub r0, r0, #1
	str r0, [sp, #4] @ r0 value saved
	bl Fibonacci
	str r0, [sp, #0]

	ldr r0, [sp, #4] @ get the r0 value	
	sub r0, r0, #1	
	bl Fibonacci

	ldr r1, [sp, #0]
	add r0, r0, r1 @ fib(n) = fib(n-1) + fib(n-2)
	ldr lr, [sp, #8]
	add sp, sp, #12
	mov pc, lr

	Exit:
		mov r0, #1
		mov pc, lr

@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
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
format: .asciz "F_%d is %d\n"

