# CS 2640
# 11/24/2024
# Program 3 Accessing Memory and File Handling
# Brandon Tseng, Michael Wu, Jonathan Dang

.data
array: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82 # Length of 10

gradeFor: .asciiz "\nThe grade for "
is: .asciiz " is: "
extraCred: .asciiz " with Extra Credit"

A: .asciiz "A"
B: .asciiz "B"
C: .asciiz "C"
D: .asciiz "D"
F: .asciiz "F"

names: .asciiz "\n\nProgram by: Brandon Tseng, Michael Wu, & Jonathan Dang."
programExit: .asciiz "\nThe program will now exit."

.text
main:
	# Load base address of 'array' into $s0
	la $s0, array
	
	# Counter for loops done
	li $t1, 0
	
loop:
	# Check if the counter equals 5
	beq $t1, 10, exit
	
	# Load element of 'array' into $t0
	lw $t0, 0($s0)
	
	# Print result
	li $v0, 4
	la $a0, gradeFor
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, is
	syscall
	
	# Find letter grade of score
	bge $t0, 90, gradeA 
	bge $t0, 80, gradeB
	bge $t0, 70, gradeC
	bge $t0, 60, gradeD
	j gradeF
	
gradeA:
	# Print letter A
	la $a0, A
	syscall
	
	bge $t0, 101 extraCredit # Determine if score has extra credit
	
	j restartLoop
	
extraCredit: 
	# Print "with Extra Credit"
	la $a0, extraCred
	syscall
	
	j restartLoop
		
gradeB:
	# Print letter B
	la $a0, B
	syscall
	
	j restartLoop
	
gradeC:
	# Print letter C
	la $a0, C
	syscall
	
	j restartLoop
	
gradeD:
	# Print letter D
	la $a0, D
	syscall
	
	j restartLoop
	
gradeF:
	# Print letter F
	la $a0, F
	syscall
	
	j restartLoop

restartLoop:
	# Go to next element in the array
	add $s0, $s0, 4
	
	# Increment counter
	add $t1, $t1, 1
	
	# Restart loop
	j loop

exit:
	# Print exit messages
	li $v0, 4
	la $a0, names
	syscall
	la $a0, programExit
	syscall
	
	# Exit program
	li $v0, 10
	syscall
