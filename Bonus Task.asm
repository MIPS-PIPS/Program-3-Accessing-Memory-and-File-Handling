# CS 2640
# 11/24/2024
# Program 3 Accessing Memory and File Handling - Bonus Task
# Brandon Tseng, Michael Wu, Jonathan Dang

.data
	prompt: .asciiz "Enter a name for your .txt file (do not include '.txt'): "
	dotTxt: .asciiz ".txt"	
	buffer: .space 256
	errorMessage: .asciiz "Your file name cannot be empty!\n"

.macro exit
	li $v0, 10
	syscall
.end_macro

.text
main:
	# Print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read user input
    	li $v0, 8
    	la $a0, buffer         # Address to store input
    	li $a1, 256            # Max input size
    	syscall
    	
appendDotTxt:
    	# Append .txt to user input string
   	la $t1, dotTxt
    
appendLoop:
	beqz $t2, continueMain
    	lb $t2, 0($t1)
    	sb $t2, 0($t0)
    	addi $t0, $t0, 1
    	addi $t1, $t1, 1
    	j appendLoop
    
continueMain:
	li $v0, 4
	move $a0, $t2
	syscall
	# Create new file
	li $v0, 13
    	la $a0, buffer
    	li $a1, 1
    	li $a2, 0
    	syscall
    	move $s0, $v0 
	
	# Close file
    	li $v0, 16            
    	move $a0, $t0         
    	syscall
	
	exit
	

	
	
