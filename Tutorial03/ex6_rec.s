@ ARM Assembly - exercise 7 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
Fibonacci:
	cmp r0, #1
	bls Exit

	//preserving the variables in the stack
	sub sp, sp, #8
	str lr, [sp, #4] //preserve the link register value
	str r0, [sp, #0] // storing the r0 value

	sub r0, r0, #1
	bl Fibonacci //recursively call the fibonacci function

	//retriving variables preserved
	ldr r1, [sp, #0]
	ldr lr, [sp, #4]
	add sp, sp, #8

	mov r2, r0
	mul r0, r2, r1 @ fib = n*fib(n-1)

	Exit:
		mov pc, lr @ put the lr address to the pc register
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

