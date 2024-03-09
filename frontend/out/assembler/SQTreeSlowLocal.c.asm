	.file	"SQTreeSlowLocal.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	""
	.text
	.globl	sqtr_local_create
	.type	sqtr_local_create, @function
sqtr_local_create:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	edi, 40
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax], OFFSET FLAT:.LC0
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+24], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+32], 1
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	sqtr_local_create, .-sqtr_local_create
	.type	_sqtr_local_clonen, @function
_sqtr_local_clonen:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L4
	mov	edi, 40
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	rsi, rdx
	mov	rdi, rax
	call	_sqtr_local_clonen
.L4:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L6
	mov	edi, 40
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+24], rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+24]
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	mov	rsi, rdx
	mov	rdi, rax
	call	_sqtr_local_clonen
.L6:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	_sqtr_local_clonen, .-_sqtr_local_clonen
	.globl	sqtr_local_foreach
	.type	sqtr_local_foreach, @function
sqtr_local_foreach:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	cmp	QWORD PTR [rbp-8], 0
	je	.L10
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_foreach
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_foreach
	jmp	.L7
.L10:
	nop
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	sqtr_local_foreach, .-sqtr_local_foreach
	.globl	sqtr_local_clone
	.type	sqtr_local_clone, @function
sqtr_local_clone:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	edi, 40
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rdx, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, rdx
	mov	rdi, rax
	call	_sqtr_local_clonen
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	sqtr_local_clone, .-sqtr_local_clone
	.type	sqtr_local_keyeqval, @function
sqtr_local_keyeqval:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	jmp	.L14
.L18:
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L15
	mov	eax, 0
	jmp	.L16
.L15:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L17
	mov	eax, 0
	jmp	.L16
.L17:
	add	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-16], 1
.L14:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L18
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L19
	mov	eax, 0
	jmp	.L16
.L19:
	mov	eax, 1
.L16:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	sqtr_local_keyeqval, .-sqtr_local_keyeqval
	.globl	sqtr_local_empty
	.type	sqtr_local_empty, @function
sqtr_local_empty:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	jne	.L21
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	jne	.L21
	mov	eax, 1
	jmp	.L22
.L21:
	mov	eax, 0
.L22:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	sqtr_local_empty, .-sqtr_local_empty
	.globl	sqtr_local_set
	.type	sqtr_local_set, @function
sqtr_local_set:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r12
	push	rbx
	sub	rsp, 32
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	QWORD PTR [rbp-40], rdx
	mov	rbx, QWORD PTR [rbp-24]
.L24:
	mov	r12d, 0
	jmp	.L25
.L34:
	mov	eax, DWORD PTR [rbx+32]
	cmp	eax, 1
	je	.L26
	mov	rax, QWORD PTR [rbx]
	mov	edx, r12d
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	ecx, r12d
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L27
	mov	rax, QWORD PTR [rbx]
	mov	rdx, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	strequals
	test	eax, eax
	je	.L27
.L26:
	mov	eax, DWORD PTR [rbx+32]
	cmp	eax, 1
	jne	.L28
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbx], rax
	mov	DWORD PTR [rbx+32], 0
.L28:
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rbx+8], rax
	jmp	.L23
.L27:
	mov	eax, r12d
	shr	eax, 3
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	eax, r12d
	and	eax, 7
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	test	eax, eax
	je	.L30
	mov	rax, QWORD PTR [rbx+24]
	test	rax, rax
	je	.L31
	mov	rbx, QWORD PTR [rbx+24]
	jmp	.L32
.L31:
	mov	edi, 40
	call	malloc
	mov	r12, rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [r12], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [r12+8], rax
	mov	QWORD PTR [r12+24], 0
	mov	QWORD PTR [r12+16], 0
	mov	DWORD PTR [r12+32], 0
	mov	rax, r12
	mov	QWORD PTR [rbx+24], rax
	jmp	.L23
.L30:
	mov	rax, QWORD PTR [rbx+16]
	test	rax, rax
	je	.L33
	mov	rbx, QWORD PTR [rbx+16]
	jmp	.L32
.L33:
	mov	edi, 40
	call	malloc
	mov	r12, rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [r12], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [r12+8], rax
	mov	QWORD PTR [r12+24], 0
	mov	QWORD PTR [r12+16], 0
	mov	DWORD PTR [r12+32], 0
	mov	rax, r12
	mov	QWORD PTR [rbx+16], rax
	jmp	.L23
.L32:
	add	r12d, 1
.L25:
	mov	edx, r12d
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L34
	jmp	.L24
.L23:
	add	rsp, 32
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	sqtr_local_set, .-sqtr_local_set
	.globl	sqtr_local_get
	.type	sqtr_local_get, @function
sqtr_local_get:
.LFB13:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r12
	push	rbx
	sub	rsp, 16
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	rbx, QWORD PTR [rbp-24]
.L36:
	mov	r12d, 0
	jmp	.L37
.L44:
	mov	rax, QWORD PTR [rbx]
	mov	edx, r12d
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	ecx, r12d
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L38
	mov	rax, QWORD PTR [rbx]
	mov	rdx, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	strequals
	test	eax, eax
	je	.L38
	mov	rax, QWORD PTR [rbx+8]
	jmp	.L39
.L38:
	mov	eax, r12d
	shr	eax, 3
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	eax, r12d
	and	eax, 7
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	test	eax, eax
	je	.L40
	mov	rbx, QWORD PTR [rbx+24]
	test	rbx, rbx
	jne	.L45
	mov	eax, 0
	jmp	.L39
.L40:
	mov	rbx, QWORD PTR [rbx+16]
	test	rbx, rbx
	jne	.L46
	mov	eax, 0
	jmp	.L39
.L45:
	nop
	jmp	.L42
.L46:
	nop
.L42:
	add	r12d, 1
.L37:
	mov	edx, r12d
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L44
	jmp	.L36
.L39:
	add	rsp, 16
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	sqtr_local_get, .-sqtr_local_get
	.type	_sqtr_local_insertn, @function
_sqtr_local_insertn:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	QWORD PTR [rbp-40], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L48
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+24]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+24], 0
.L48:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L49
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], 0
.L49:
	mov	eax, DWORD PTR [rbp-28]
	and	eax, 8
	mov	BYTE PTR [rbp-1], al
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rbp-1]
	mov	ecx, DWORD PTR [rbp-28]
	sub	ecx, eax
	mov	eax, ecx
	add	rax, rdx
	mov	QWORD PTR [rbp-16], rax
	jmp	.L50
.L57:
	cmp	BYTE PTR [rbp-1], 8
	jne	.L51
	mov	BYTE PTR [rbp-1], 0
	add	QWORD PTR [rbp-16], 1
.L51:
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	movzx	eax, BYTE PTR [rbp-1]
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	test	eax, eax
	je	.L52
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	jne	.L53
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+24], rdx
	jmp	.L47
.L53:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-24], rax
	jmp	.L55
.L52:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	jne	.L56
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L47
.L56:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-24], rax
	nop
.L55:
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, 1
	mov	BYTE PTR [rbp-1], al
.L50:
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L57
.L47:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	_sqtr_local_insertn, .-_sqtr_local_insertn
	.globl	sqtr_local_delete
	.type	sqtr_local_delete, @function
sqtr_local_delete:
.LFB15:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rbp-16], rax
	mov	BYTE PTR [rbp-1], 0
	jmp	.L59
.L72:
	cmp	BYTE PTR [rbp-1], 8
	jne	.L60
	mov	BYTE PTR [rbp-1], 0
	add	QWORD PTR [rbp-48], 1
.L60:
	mov	rax, QWORD PTR [rbp-48]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	movzx	eax, BYTE PTR [rbp-1]
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	test	eax, eax
	je	.L61
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L73
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_keyeqval
	cmp	eax, 1
	jne	.L64
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+24], 0
	mov	rax, QWORD PTR [rbp-16]
	sub	rax, QWORD PTR [rbp-48]
	mov	edx, eax
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, edx
	mov	DWORD PTR [rbp-32], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L65
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+24]
	mov	ecx, DWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-40]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
.L65:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L74
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	ecx, DWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-40]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
	jmp	.L74
.L64:
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-40], rax
	jmp	.L67
.L61:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L75
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_keyeqval
	cmp	eax, 1
	jne	.L69
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], 0
	mov	rax, QWORD PTR [rbp-16]
	sub	rax, QWORD PTR [rbp-48]
	mov	edx, eax
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, edx
	mov	DWORD PTR [rbp-28], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L70
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+24]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-40]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
.L70:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L76
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-40]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
	jmp	.L76
.L69:
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-40], rax
	nop
.L67:
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, 1
	mov	BYTE PTR [rbp-1], al
.L59:
	mov	rax, QWORD PTR [rbp-48]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L72
	jmp	.L58
.L73:
	nop
	jmp	.L58
.L74:
	nop
	jmp	.L58
.L75:
	nop
	jmp	.L58
.L76:
	nop
.L58:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	sqtr_local_delete, .-sqtr_local_delete
	.globl	sqtr_local_pop
	.type	sqtr_local_pop, @function
sqtr_local_pop:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 80
	mov	QWORD PTR [rbp-72], rdi
	mov	QWORD PTR [rbp-80], rsi
	mov	rax, QWORD PTR [rbp-80]
	mov	QWORD PTR [rbp-16], rax
	mov	BYTE PTR [rbp-1], 0
	jmp	.L78
.L91:
	cmp	BYTE PTR [rbp-1], 8
	jne	.L79
	mov	BYTE PTR [rbp-1], 0
	add	QWORD PTR [rbp-80], 1
.L79:
	mov	rax, QWORD PTR [rbp-80]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	movzx	eax, BYTE PTR [rbp-1]
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	test	eax, eax
	je	.L80
	mov	rax, QWORD PTR [rbp-72]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	jne	.L81
	mov	eax, 0
	jmp	.L77
.L81:
	mov	rax, QWORD PTR [rbp-72]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_keyeqval
	cmp	eax, 1
	jne	.L83
	mov	rax, QWORD PTR [rbp-72]
	mov	QWORD PTR [rax+24], 0
	mov	rax, QWORD PTR [rbp-16]
	sub	rax, QWORD PTR [rbp-80]
	mov	edx, eax
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, edx
	mov	DWORD PTR [rbp-44], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L84
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+24]
	mov	ecx, DWORD PTR [rbp-44]
	mov	rax, QWORD PTR [rbp-72]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
.L84:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L85
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	ecx, DWORD PTR [rbp-44]
	mov	rax, QWORD PTR [rbp-72]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
.L85:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-56], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-56]
	jmp	.L77
.L83:
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-72], rax
	jmp	.L86
.L80:
	mov	rax, QWORD PTR [rbp-72]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	jne	.L87
	mov	eax, 0
	jmp	.L77
.L87:
	mov	rax, QWORD PTR [rbp-72]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_keyeqval
	cmp	eax, 1
	jne	.L88
	mov	rax, QWORD PTR [rbp-72]
	mov	QWORD PTR [rax+16], 0
	mov	rax, QWORD PTR [rbp-16]
	sub	rax, QWORD PTR [rbp-80]
	mov	edx, eax
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, edx
	mov	DWORD PTR [rbp-28], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L89
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+24]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-72]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
.L89:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L90
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-72]
	mov	esi, ecx
	mov	rdi, rax
	call	_sqtr_local_insertn
.L90:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-40], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-40]
	jmp	.L77
.L88:
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-72], rax
	nop
.L86:
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, 1
	mov	BYTE PTR [rbp-1], al
.L78:
	mov	rax, QWORD PTR [rbp-80]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L91
.L77:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	sqtr_local_pop, .-sqtr_local_pop
	.globl	sqtr_local_popl
	.type	sqtr_local_popl, @function
sqtr_local_popl:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-8], rax
.L100:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L93
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-24], rax
	jmp	.L100
.L93:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	test	rax, rax
	je	.L95
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-24], rax
	jmp	.L100
.L95:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-24]
	jne	.L96
	mov	eax, 0
	jmp	.L97
.L96:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	cmp	QWORD PTR [rbp-24], rax
	jne	.L98
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+24], 0
	jmp	.L99
.L98:
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], 0
.L99:
	mov	rax, QWORD PTR [rbp-24]
.L97:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	sqtr_local_popl, .-sqtr_local_popl
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
