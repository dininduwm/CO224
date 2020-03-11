@ ARM Assembly - lab 3.2 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
mod:  @ calculating the mod value
	cmp r0, r1 @ cmp r0, r1
	blo modNext @ if r0 > r1 
		sub r0, r0, r1 @ r0 = r0 - r1
		b mod          @ loop through mod
	modNext:
		mov pc, lr @ returning from the function

gcd:
	cmp r0, r1
	bge next 	@ if r0 >= r1 go next
	mov r2, r0 	@ else: exchange r0, r1
	mov r0, r1
	mov r1, r2

	next:
	cmp r1, #0 @ compare the smaller value with 0 (base case)
	bne next2
	mov pc, lr @ going back to the caller function

	next2:
	sub sp, sp, #4 @ move the stack pointer
	str lr, [sp, #0]
	bl mod @ taking the r0 = r0%r1
	bl gcd @ gcd(r0, r1)
	ldr lr, [sp, #0]
	add sp, sp, #4 @ move the stack pointer

	mov pc, lr

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a 64
	mov r5, #24 	@the value b 24	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "gcd(%d,%d) = %d\n"

@ arm-linux-gnueabi-gcc -Wall lab3_2.s -o lab3_2
@ qemu-arm -L /usr/arm-linux-gnueabi lab3_2

