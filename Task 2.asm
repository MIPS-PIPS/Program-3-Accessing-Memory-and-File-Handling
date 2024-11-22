# CS 2640
# 11/24/2024
# Program 3 Accessing Memory and File Handling
# Brandon Tseng, Michael Wu, Jonathan Dang

.data
	fileName: .asciiz "practiceFile.txt"
	buffer: .space 1024
	
.text
main:
	# Open file
	li $v0, 13
	la $a0, fileName
	li $a1, 0
	li $a2, 0
	syscall
	move $s0, $v0
	
	# Read file
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 1000
	syscall
	
	# Print file (buffer)
	li $v0, 4
    la $a0, buffer
    syscall
	
	# Close files
	li $v0, 16
	move $a0, $s0
	syscall
	li $v0, 16
	move $a0, $s1
	syscall
	
	# Exit program
	li $v0, 10
	syscall
