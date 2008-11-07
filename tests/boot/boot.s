# Minimal SIMPLE boot code

	.text

	# Initialize Stack Pointer ($sp) to make the program fit into 4 KByte of memory space
	addi $29,$0,0x1000

	# Initialize Return Address ($ra) to jump to the "end-of-test" special address
	lui $31,0xDEAD
	ori $31,0xBEEF

	# Continue to the main test
