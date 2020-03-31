@ ARM Assembly Example
@	a function to reverse strings
@	Call it from main


	.text	@ instruction memory

	
	.global main
main:	
	@ push (store) lr to the stack, allocate space for put lr	
	sub	sp, sp, #16
	str r4, [sp, #8]
	str r5, [sp, #12]
	str	lr, [sp, #4]	

	ldr r0, =formatInpOut @ print the output string for take the input
	bl printf

	ldr r0, =formatInp
	mov r1, sp
	bl scanf

	ldr r4, [sp]

	cmp r4, #0 @ error handling
	beq exitLoopMain
	blt exitLoopMainNeg

	mov r5, #0 @ counter of the string

loopMain:
	ldr r0, =formatInpStr @ print formated string
	mov r1, r5
	bl printf

	@ calling to the function 
	mov r0, r5
    bl strReverse	

	add r5, r5, #1
	cmp r4, r5
	beq exitLoopMain @ Loop until r4 == 45
	b loopMain

exitLoopMainNeg:
	ldr r0, =formatInvalid
	bl printf

exitLoopMain:    
	
    @ stack handling (pop lr from the stack) and return
	mov	r0, #0		@return 0
	ldr	lr, [sp, #4]
	ldr r4, [sp, #8]
	ldr r5, [sp, #12]
	add	sp, sp, #16
	mov	pc, lr	

strReverse:

    @ allocating memory to store 200 chars
    sub sp, sp, #212
	str lr, [sp, #200]
	str r4, [sp, #204]	
	str r0, [sp, #208]

	@scanf for string
	ldr	r0, =formats
	mov	r1, sp
	bl	scanf	@scanf("%s",sp)

	@Output string
	ldr r1, [sp, #208]
	ldr r0, =formatOut
	bl printf

	mov r4, sp @moving the stack pointer value to r4

loop: @loop to find the ending char
	ldrb r1, [r4, #0]
	cmp	r1, #0
	beq	printLoop

	add	r4, r4, #1	@ move to the next element in the char array
	b	loop

printLoop: @ loop to print the chars in reverse order
	sub r4, r4, #1
	cmp r4, sp
	beq endLoop

	ldrb r1, [r4, #0] @ load the current character

	@ printing the current element
	ldr	r0, =formatp
	bl	printf

	b printLoop

endLoop:

	@ print the last character
	ldr	r0, =formatpLast
	ldrb r1, [r4, #0] @ load the current character
	bl	printf

	@ releasing the stack
	
	ldr lr, [sp, #200]
	ldr r4, [sp, #204]
	add sp, sp, #212
	mov pc, lr


	.data	@ data memory
formatInpOut: .asciz "Enter the number of strings : \n" @ format to preview before input a string
formatInpStr: .asciz "Enter input string %d:\n"         @ format to preview a string
formatInvalid: .asciz "Invalid Number\n"                @ invalid number format
formatOut: .asciz "Output string %d is...\n"            @ format to output string
formatInp: .asciz "%d%*c"							    @ taking the number input
formats: .asciz "%[^\n]%*c"                             @ input a string					
formatp: .asciz "%c"                                    @ print a char
formatpLast: .asciz "%c\n"                              @ print a char with new line
