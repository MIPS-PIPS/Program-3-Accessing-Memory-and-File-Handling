# CS 2640
# 11/23/2024
# Program 3 Accessing Memory and File Handling
# Brandon Tseng, Michael Wu, Jonathan Dang



.data
file_name:      .asciiz "practiceFile.txt"    # Name of the file to append to
prompt: .asciiz "What have you enjoyed most about the class so far? "
newline:        .asciiz "\n"
user_input:     .space 128     
.text
main:

    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 8
    la $a0, user_input
    li $a1, 128           
    syscall

    li $v0, 13            # Open
    la $a0, file_name     
    li $a1, 9             # 9 is append
    li $a2, 0             #ignore
    syscall
    move $t0, $v0         # Store file descriptor


    bltz $t0, exit        


    move $a0, $t0         
    la $a1, user_input    
    li $a2, 128          
    li $v0, 15           
    syscall


    move $a0, $t0         
    la $a1, newline       
    li $a2, 1             
    li $v0, 15           
    syscall

    # Close
    li $v0, 16            
    move $a0, $t0         
    syscall

exit:
    li $v0, 10            
    syscall
