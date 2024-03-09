	.file	"SHashmap.c"
	.intel_syntax noprefix
	.text
	.type	shm_hash, @function
shm_hash:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	strhash
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	shm_hash, .-shm_hash
	.globl	shm_create
	.type	shm_create, @function
shm_create:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], 15
	mov	edi, 120
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	edx, 120
	mov	esi, 0
	mov	rdi, rax
	call	memset
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	shm_create, .-shm_create
	.globl	shm_createob
	.type	shm_createob, @function
shm_createob:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], 15
	mov	edi, 120
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	edx, 120
	mov	esi, 0
	mov	rdi, rax
	call	memset
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	shm_createob, .-shm_createob
	.globl	shm_putp
	.type	shm_putp, @function
shm_putp:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rcx
	mov	rdi, rax
	call	shm_put
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	shm_putp, .-shm_putp
	.globl	shm_set
	.type	shm_set, @function
shm_set:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 80
	mov	QWORD PTR [rbp-56], rdi
	mov	QWORD PTR [rbp-64], rsi
	mov	QWORD PTR [rbp-72], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-56]
	mov	QWORD PTR [rdx], rcx
	mov	rdx, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rdx+8]
	cmp	rax, rdx
	jne	.L8
	mov	rax, QWORD PTR [rbp-56]
	mov	rdi, rax
	call	shm_resize
.L8:
	mov	rax, QWORD PTR [rbp-64]
	mov	rdi, rax
	call	shm_hash
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rcx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	edx, 0
	div	rcx
	mov	QWORD PTR [rbp-24], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-24]
	sal	rdx, 3
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-32], rax
	cmp	QWORD PTR [rbp-32], 0
	jne	.L9
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-64]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-72]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+24], 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-24]
	sal	rdx, 3
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rdx], rax
	jmp	.L7
.L9:
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L11
.L13:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-64]
	mov	rsi, rdx
	mov	rdi, rax
	call	strequals
	test	eax, eax
	je	.L12
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rbp-72]
	mov	QWORD PTR [rax+8], rdx
	jmp	.L7
.L12:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-8], rax
.L11:
	cmp	QWORD PTR [rbp-8], 0
	jne	.L13
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-40], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rbp-64]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rbp-72]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+24], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-24]
	sal	rdx, 3
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	shm_set, .-shm_set
	.globl	shm_put
	.type	shm_put, @function
shm_put:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	QWORD PTR [rbp-56], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rcx
	mov	rdx, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rdx+8]
	cmp	rax, rdx
	jne	.L15
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	shm_resize
.L15:
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	shm_hash
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rcx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, 0
	div	rcx
	mov	QWORD PTR [rbp-16], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	sal	rdx, 3
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-24], rax
	cmp	QWORD PTR [rbp-24], 0
	jne	.L16
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+24], 0
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	sal	rdx, 3
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
	jmp	.L18
.L16:
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+24], rdx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	sal	rdx, 3
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rdx], rax
.L18:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	shm_put, .-shm_put
	.globl	shm_contains
	.type	shm_contains, @function
shm_contains:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	shm_hash
	mov	rdx, QWORD PTR [rbp-24]
	mov	rcx, QWORD PTR [rdx+8]
	mov	edx, 0
	div	rcx
	mov	QWORD PTR [rbp-16], rdx
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	sal	rdx, 3
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-8], rax
	cmp	QWORD PTR [rbp-8], 0
	je	.L20
	jmp	.L21
.L24:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	strequals
	test	eax, eax
	je	.L22
	mov	eax, 1
	jmp	.L23
.L22:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-8], rax
.L21:
	cmp	QWORD PTR [rbp-8], 0
	jne	.L24
.L20:
	mov	eax, 0
.L23:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	shm_contains, .-shm_contains
	.globl	shm_get
	.type	shm_get, @function
shm_get:
.LFB13:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	shm_hash
	mov	rdx, QWORD PTR [rbp-24]
	mov	rcx, QWORD PTR [rdx+8]
	mov	edx, 0
	div	rcx
	mov	QWORD PTR [rbp-16], rdx
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	sal	rdx, 3
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-8], rax
	cmp	QWORD PTR [rbp-8], 0
	je	.L26
	jmp	.L27
.L30:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	strequals
	test	eax, eax
	je	.L28
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	jmp	.L29
.L28:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-8], rax
.L27:
	cmp	QWORD PTR [rbp-8], 0
	jne	.L30
.L26:
	mov	eax, 0
.L29:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	shm_get, .-shm_get
	.globl	shm_remove
	.type	shm_remove, @function
shm_remove:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r13
	push	r12
	push	rbx
	sub	rsp, 40
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	mov	QWORD PTR [rbp-56], rdi
	mov	QWORD PTR [rbp-64], rsi
	mov	rax, QWORD PTR [rbp-64]
	mov	rdi, rax
	call	shm_hash
	mov	rdx, QWORD PTR [rbp-56]
	mov	rcx, QWORD PTR [rdx+8]
	mov	edx, 0
	div	rcx
	mov	QWORD PTR [rbp-40], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-40]
	sal	rdx, 3
	add	rax, rdx
	mov	rbx, QWORD PTR [rax]
	mov	r12d, 0
	jmp	.L32
.L36:
	mov	r13, QWORD PTR [rbx+24]
	mov	rax, QWORD PTR [rbx]
	mov	rdx, QWORD PTR [rbp-64]
	mov	rsi, rdx
	mov	rdi, rax
	call	strequals
	test	eax, eax
	je	.L33
	test	r12, r12
	jne	.L34
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-40]
	sal	rdx, 3
	add	rdx, rax
	mov	rax, QWORD PTR [rbx+24]
	mov	QWORD PTR [rdx], rax
	mov	rdi, rbx
	call	free
	jmp	.L31
.L34:
	mov	rax, QWORD PTR [rbx+24]
	mov	QWORD PTR [r12+24], rax
	mov	rdi, rbx
	call	free
	jmp	.L31
.L33:
	mov	r12, rbx
	mov	rbx, r13
.L32:
	test	rbx, rbx
	jne	.L36
.L31:
	add	rsp, 40
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	shm_remove, .-shm_remove
	.globl	shm_copy
	.type	shm_copy, @function
shm_copy:
.LFB15:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-56], rdi
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	esi, 0
	mov	rdi, rax
	call	memset
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+24], OFFSET FLAT:shm_hash
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-40], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L38
.L44:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-24], rax
	cmp	QWORD PTR [rbp-24], 0
	je	.L39
	jmp	.L40
.L43:
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-48], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax+24], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L41
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax], rdx
	jmp	.L42
.L41:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax+24], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rbp-48]
	mov	QWORD PTR [rax], rdx
.L42:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-24], rax
.L40:
	cmp	QWORD PTR [rbp-24], 0
	jne	.L43
.L39:
	add	QWORD PTR [rbp-16], 8
	add	QWORD PTR [rbp-8], 8
.L38:
	mov	rax, QWORD PTR [rbp-16]
	cmp	rax, QWORD PTR [rbp-40]
	jne	.L44
	mov	rax, QWORD PTR [rbp-32]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	shm_copy, .-shm_copy
	.type	shm_insertToBucketList, @function
shm_insertToBucketList:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	QWORD PTR [rbp-56], rdx
	mov	rax, QWORD PTR [rbp-48]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, 0
	div	QWORD PTR [rbp-56]
	mov	QWORD PTR [rbp-16], rdx
	mov	rax, QWORD PTR [rbp-16]
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-40]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-48]
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+24], rdx
	mov	rax, QWORD PTR [rbp-16]
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-40]
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rdx], rax
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	shm_insertToBucketList, .-shm_insertToBucketList
	.globl	shm_resize
	.type	shm_resize, @function
shm_resize:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-56], rdi
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-32]
	mov	esi, 0
	mov	rdi, rax
	call	memset
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L48
.L52:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	je	.L49
.L51:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-40], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rcx, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rcx
	mov	rdi, rax
	call	shm_insertToBucketList
	cmp	QWORD PTR [rbp-40], 0
	je	.L53
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L51
.L53:
	nop
.L49:
	add	QWORD PTR [rbp-8], 8
.L48:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-24]
	jne	.L52
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	shm_resize, .-shm_resize
	.globl	shm_iterate
	.type	shm_iterate, @function
shm_iterate:
.LFB18:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-56], rdi
	mov	QWORD PTR [rbp-64], rsi
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L55
.L59:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	je	.L56
	jmp	.L57
.L58:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-48], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-40], rax
	lea	rax, [rbp-48]
	mov	rdx, QWORD PTR [rbp-64]
	mov	rdi, rax
	call	rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-16], rax
.L57:
	cmp	QWORD PTR [rbp-16], 0
	jne	.L58
.L56:
	add	QWORD PTR [rbp-8], 8
.L55:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-24]
	jne	.L59
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	shm_iterate, .-shm_iterate
	.globl	shm_delete
	.type	shm_delete, @function
shm_delete:
.LFB19:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L61
.L65:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	je	.L62
	jmp	.L63
.L64:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbp-16], rax
.L63:
	cmp	QWORD PTR [rbp-16], 0
	jne	.L64
.L62:
	add	QWORD PTR [rbp-8], 8
.L61:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-24]
	jne	.L65
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	shm_delete, .-shm_delete
	.section	.rodata
.LC0:
	.string	"%d : %d\n"
.LC1:
	.string	"%d : \033[1m\033[31m%d\033[0m\n"
	.text
	.globl	shm_printBuckets
	.type	shm_printBuckets, @function
shm_printBuckets:
.LFB20:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-56], rdi
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-40], rax
	mov	DWORD PTR [rbp-4], 0
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L67
.L73:
	add	DWORD PTR [rbp-4], 1
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-24], rax
	mov	DWORD PTR [rbp-28], 0
	cmp	QWORD PTR [rbp-24], 0
	je	.L68
	jmp	.L69
.L70:
	add	DWORD PTR [rbp-28], 1
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-24], rax
.L69:
	cmp	QWORD PTR [rbp-24], 0
	jne	.L70
.L68:
	cmp	DWORD PTR [rbp-28], 1
	jne	.L71
	mov	edx, DWORD PTR [rbp-28]
	mov	eax, DWORD PTR [rbp-4]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
.L71:
	cmp	DWORD PTR [rbp-28], 1
	jle	.L72
	mov	edx, DWORD PTR [rbp-28]
	mov	eax, DWORD PTR [rbp-4]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
.L72:
	add	QWORD PTR [rbp-16], 8
.L67:
	mov	rax, QWORD PTR [rbp-16]
	cmp	rax, QWORD PTR [rbp-40]
	jne	.L73
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	shm_printBuckets, .-shm_printBuckets
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
