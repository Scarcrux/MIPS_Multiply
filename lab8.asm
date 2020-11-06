		.data
outmsg:		.asciiz			"The sum is "
		.text
		.globl	main
main:
		li 	$a0, 4 		# input1 = 4
		li 	$a1, 4 		# input2 = 4

		sub 	$sp, $sp, 8	# Prepares to push 2 elements to stack
		sw	$a0, 0($sp)	# Pushes a0
		sw	$a1, 4($sp)	# Pushes a1
					# Note that these registers aren't necessary but saved for practice

		jal	multiply	# Calls multiply function

		move	$s0, $v0	# Saves the returned value
print:
		la	$a0, outmsg	# Prints the output message
		li	$v0, 4
		syscall

		li	$v0, 1		# Prints the stored sum
		move	$a0, $s0
		syscall
exit:

		lw	$a1, 4($sp)	# Restores a1
		lw	$a0, 0($sp)	# Restores a0
		add	$sp, $sp, 8	# Pops 2 elements from stack
		
		
		li 	$v0, 10		# Exits program
		syscall
multiply:
		li 	$t0, 0		# int i = 0
		li	$t1, 0		# sum = 0

		sub	$sp, $sp, 12	# Prepares to push 3 elements to stack
		sw	$ra, 0($sp)	# Pushes ra
		sw	$t0, 4($sp)	# Pushes t0
		sw	$t1, 8($sp)	# Pushes t1
loop:
		addiu 	$t0, $t0, 1 	# i++
		addu 	$t1, $t1, $a0 	# sum += input1
		bne	$a1, $t0, loop  # exit loop if input1 = input2
		
		move	$v0, $t1	# Moves sum to the return register
		
		lw	$t1, 8($sp)	# Restores t1
		lw	$t0, 4($sp)	# Restores t0
		lw	$ra, 0($sp)	# Restores ra
		add	$sp, $sp, 12	# Pops 3 elements from stack

		jr	$ra		# Returns to caller