	.file	"RadixApplication.c"
	.intel_syntax noprefix
	.text
	.globl	radix_onExit
	.type	radix_onExit, @function
radix_onExit:
.LFB2913:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	call	radix_gtk_exit
	mov	edi, 0
	call	_Exit
	.cfi_endproc
.LFE2913:
	.size	radix_onExit, .-radix_onExit
	.section	.rodata
	.align 8
.LC0:
	.string	"http://localhost:4564/static/login.html"
	.text
	.globl	radix_launchApplication
	.type	radix_launchApplication, @function
radix_launchApplication:
.LFB2914:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	call	radix_gtk_init
	mov	edi, 2
	call	sleep
	mov	QWORD PTR [rbp-32], OFFSET FLAT:.LC0
	mov	DWORD PTR [rbp-24], 1010
	mov	DWORD PTR [rbp-20], 690
	mov	QWORD PTR [rbp-16], 0
	mov	DWORD PTR [rbp-8], 1
	sub	rsp, 32
	mov	rcx, rsp
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rcx], rax
	mov	QWORD PTR [rcx+8], rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rcx+16], rax
	mov	QWORD PTR [rcx+24], rdx
	call	radix_gtk_uri
	add	rsp, 32
	mov	edi, OFFSET FLAT:radix_onExit
	call	atexit
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2914:
	.size	radix_launchApplication, .-radix_launchApplication
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
