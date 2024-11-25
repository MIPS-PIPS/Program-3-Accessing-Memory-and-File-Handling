# CS 2640
# 11/24/2024
# Program 3 Accessing Memory and File Handling - Bonus Task
# Brandon Tseng, Michael Wu, Jonathan Dang

.data
	menuPrompt: .asciiz "\nMenu:\n1. Create a file\n2. Exit\nEnter your choice: "
	prompt: .asciiz "\nEnter a name for your .txt file (do not include '.txt'): "
	dotTxt: .asciiz ".txt"	
	buffer: .space 64
	resultFilename: .space 64
	contentBuffer: .space 128
	errorMessage: .asciiz "\nYour file name cannot be empty!\n"
	invalidChoice: .asciiz "\nInvalid choice! Please try again.\n"
	contentPrompt: .asciiz "\nEnter content to write to the file: "
	newline: .asciiz "\n"

.macro exit
	li $v0, 10
	syscall
.end_macro

.text
main:
    	# Display menu
    	li $v0, 4
    	la $a0, menuPrompt
    	syscall

    	# Get user choice
    	li $v0, 5
    	syscall
    	move $t0, $v0 # Store user choice in $t0

    	# Handle menu choice
    	beq $t0, 1, getFilename # If choice is 1, go to getFilename
    	beq $t0, 2, exit_program # If choice is 2, exit program
    	j invalidMenuChoice # Otherwise, handle invalid choice
    
getFilename:
	# Print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read user input
    	li $v0, 8
    	la $a0, buffer # Address to store input
    	li $a1, 256 # Max input size
    	syscall
    	
    	la $t0, buffer
    	
remove_newline:
    	lb $t1, 0($t0)    
    	li $t2, 0x0A # ASCII for newline ('\n')
    	beq $t1, $t2, replace # If newline found, replace it
    	beqz $t1, copy_buffer 
    	addiu $t0, $t0, 1
    	j remove_newline

replace:
    	sb $zero, 0($t0) # Replace newline with null terminator
    	
    	la $t0, buffer
    	la $t1, dotTxt
    	la $t2 resultFilename

copy_buffer:
    	lb $t3, 0($t0)
    	beqz $t3, copy_dotTxt
    	sb $t3, 0($t2)
    	addi $t0, $t0, 1
    	addi $t2, $t2, 1
    	j copy_buffer
    	
copy_dotTxt:    
    	lb $t3, 0($t1)
    	beqz $t3, continueMain
    	sb $t3, 0($t2)
    	addi $t1, $t1, 1
    	addi $t2, $t2, 1
    	j copy_dotTxt
   
continueMain:
	# print out filename
	li $v0, 4
	la $a0, resultFilename
	syscall
	
	# Get content to write to file
    	li $v0, 4
    	la $a0, contentPrompt
    	syscall

    	li $v0, 8
    	la $a0, contentBuffer
    	li $a1, 128
    	syscall
    
    	# Create file
    	li $v0, 13
    	la $a0, resultFilename       
    	li $a1, 1            
    	li $a2, 0          
    	syscall
    	move $s0, $v0
    
    	li $v0, 15
    	move $a0, $s0         
    	la $a1, contentBuffer 
    	li $a2, 128          
    	syscall
	
	# Close file
    	li $v0, 16            
    	move $a0, $s0         
    	syscall
	
	j main
	
printError:
    	li $v0, 4
    	la $a0, errorMessage
    	syscall
    	j main

invalidMenuChoice:
    	li $v0, 4
    	la $a0, invalidChoice
    	syscall
    	j main
	
exit_program:
	exit

	
	
