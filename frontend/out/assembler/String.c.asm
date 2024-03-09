	.file	"String.c"
	.intel_syntax noprefix
	.text
	.globl	xstrgetfileextension
	.type	xstrgetfileextension, @function
xstrgetfileextension:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-16], rdi
	mov	rbx, QWORD PTR [rbp-16]
	jmp	.L2
.L3:
	add	QWORD PTR [rbp-16], 1
.L2:
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L3
	jmp	.L4
.L6:
	sub	QWORD PTR [rbp-16], 1
.L4:
	cmp	QWORD PTR [rbp-16], rbx
	je	.L5
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 46
	jne	.L6
.L5:
	mov	rax, QWORD PTR [rbp-16]
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	xstrgetfileextension, .-xstrgetfileextension
	.globl	strend
	.type	strend, @function
strend:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	jmp	.L9
.L10:
	add	QWORD PTR [rbp-8], 1
.L9:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L10
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	strend, .-strend
	.globl	strendswith
	.type	strendswith, @function
strendswith:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L13
.L16:
	mov	rax, QWORD PTR [rbp-32]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L14
	add	QWORD PTR [rbp-32], 1
	jmp	.L15
.L14:
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rbp-32], rax
.L15:
	add	QWORD PTR [rbp-24], 1
.L13:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L16
	mov	rax, QWORD PTR [rbp-32]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	sete	al
	movzx	eax, al
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	strendswith, .-strendswith
	.globl	strstartswith
	.type	strstartswith, @function
strstartswith:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	jmp	.L19
.L22:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L20
	mov	eax, 0
	jmp	.L21
.L20:
	add	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-16], 1
.L19:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L22
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	sete	al
	movzx	eax, al
.L21:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	strstartswith, .-strstartswith
	.globl	strequals
	.type	strequals, @function
strequals:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	jmp	.L24
.L27:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	imul	eax, edx
	test	eax, eax
	jne	.L25
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	sete	al
	movzx	eax, al
	jmp	.L26
.L25:
	add	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-16], 1
.L24:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L27
	mov	eax, 0
.L26:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	strequals, .-strequals
	.globl	strsplitmutable
	.type	strsplitmutable, @function
strsplitmutable:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	eax, esi
	mov	BYTE PTR [rbp-12], al
	jmp	.L29
.L32:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L30
	mov	rax, QWORD PTR [rbp-8]
	jmp	.L31
.L30:
	add	QWORD PTR [rbp-8], 1
.L29:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	cmp	BYTE PTR [rbp-12], al
	jne	.L32
	mov	rax, QWORD PTR [rbp-8]
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-8]
	add	rax, 1
.L31:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	strsplitmutable, .-strsplitmutable
	.globl	strreplaceall
	.type	strreplaceall, @function
strreplaceall:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r12
	push	rbx
	sub	rsp, 48
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	QWORD PTR [rbp-56], rdx
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-24], 0
	jmp	.L34
.L40:
	mov	rbx, QWORD PTR [rbp-40]
	mov	r12, QWORD PTR [rbp-48]
	movzx	edx, BYTE PTR [rbx]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L35
.L38:
	movzx	eax, BYTE PTR [r12]
	test	al, al
	jne	.L36
	mov	rdx, QWORD PTR [rbp-56]
	lea	rax, [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	QWORD PTR [rbp-40], rbx
	jmp	.L35
.L36:
	movzx	edx, BYTE PTR [rbx]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L43
	add	r12, 1
	add	rbx, 1
	jmp	.L38
.L43:
	nop
.L35:
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L39
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L39:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	lea	rdx, [rcx+rax]
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	QWORD PTR [rbp-40], 1
.L34:
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L40
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L41
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L41:
	mov	rdx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-32]
	add	rsp, 48
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	strreplaceall, .-strreplaceall
	.globl	strreplaceallmultiple
	.type	strreplaceallmultiple, @function
strreplaceallmultiple:
.LFB13:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r12
	push	rbx
	sub	rsp, 272
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	mov	QWORD PTR [rbp-280], rdi
	mov	QWORD PTR [rbp-184], rsi
	mov	QWORD PTR [rbp-176], rdx
	mov	QWORD PTR [rbp-168], rcx
	mov	QWORD PTR [rbp-160], r8
	mov	QWORD PTR [rbp-152], r9
	test	al, al
	je	.L63
	movaps	XMMWORD PTR [rbp-144], xmm0
	movaps	XMMWORD PTR [rbp-128], xmm1
	movaps	XMMWORD PTR [rbp-112], xmm2
	movaps	XMMWORD PTR [rbp-96], xmm3
	movaps	XMMWORD PTR [rbp-80], xmm4
	movaps	XMMWORD PTR [rbp-64], xmm5
	movaps	XMMWORD PTR [rbp-48], xmm6
	movaps	XMMWORD PTR [rbp-32], xmm7
.L63:
	mov	DWORD PTR [rbp-232], 8
	mov	DWORD PTR [rbp-228], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-224], rax
	lea	rax, [rbp-192]
	mov	QWORD PTR [rbp-216], rax
	mov	edi, 64
	call	malloc
	mov	QWORD PTR [rbp-256], rax
	mov	DWORD PTR [rbp-248], 0
	jmp	.L46
.L50:
	mov	eax, DWORD PTR [rbp-248]
	mov	r12d, eax
	mov	rax, QWORD PTR [rbp-256]
	mov	rdi, rax
	call	malloc_usable_size
	shr	rax, 3
	cmp	r12, rax
	jne	.L47
	mov	rax, QWORD PTR [rbp-256]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-256]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-256], rax
.L47:
	mov	rcx, QWORD PTR [rbp-256]
	mov	eax, DWORD PTR [rbp-248]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-248], edx
	mov	eax, eax
	sal	rax, 3
	add	rax, rcx
	mov	QWORD PTR [rax], rbx
.L46:
	mov	eax, DWORD PTR [rbp-232]
	cmp	eax, 47
	ja	.L48
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-232]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-232]
	add	edx, 8
	mov	DWORD PTR [rbp-232], edx
	jmp	.L49
.L48:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L49:
	mov	rbx, QWORD PTR [rax]
	test	rbx, rbx
	jne	.L50
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-272], rax
	mov	DWORD PTR [rbp-264], 0
	jmp	.L51
.L60:
	mov	rax, QWORD PTR [rbp-256]
	mov	edx, DWORD PTR [rbp-248]
	mov	edx, edx
	sal	rdx, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-208], rax
	mov	rax, QWORD PTR [rbp-256]
	mov	QWORD PTR [rbp-200], rax
	jmp	.L52
.L58:
	mov	rbx, QWORD PTR [rbp-280]
	mov	rax, QWORD PTR [rbp-200]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-200], rdx
	mov	r12, QWORD PTR [rax]
	movzx	edx, BYTE PTR [rbx]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L64
.L57:
	movzx	eax, BYTE PTR [r12]
	test	al, al
	jne	.L54
	mov	rax, QWORD PTR [rbp-200]
	mov	rdx, QWORD PTR [rax]
	lea	rax, [rbp-272]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	QWORD PTR [rbp-280], rbx
	jmp	.L55
.L54:
	movzx	edx, BYTE PTR [rbx]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L65
	add	r12, 1
	add	rbx, 1
	jmp	.L57
.L64:
	nop
	jmp	.L66
.L65:
	nop
.L53:
.L66:
	nop
	add	QWORD PTR [rbp-200], 8
.L52:
	mov	rax, QWORD PTR [rbp-200]
	cmp	rax, QWORD PTR [rbp-208]
	jb	.L58
	nop
.L55:
	mov	eax, DWORD PTR [rbp-264]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-272]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L59
	mov	rax, QWORD PTR [rbp-272]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-272]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-272], rax
.L59:
	mov	rcx, QWORD PTR [rbp-272]
	mov	eax, DWORD PTR [rbp-264]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-264], edx
	cdqe
	lea	rdx, [rcx+rax]
	mov	rax, QWORD PTR [rbp-280]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	nop
	add	QWORD PTR [rbp-280], 1
.L51:
	mov	rax, QWORD PTR [rbp-280]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L60
	mov	rax, QWORD PTR [rbp-256]
	mov	rdi, rax
	call	free
	mov	eax, DWORD PTR [rbp-264]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-272]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L61
	mov	rax, QWORD PTR [rbp-272]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-272]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-272], rax
.L61:
	mov	rdx, QWORD PTR [rbp-272]
	mov	eax, DWORD PTR [rbp-264]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-272]
	add	rsp, 272
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	strreplaceallmultiple, .-strreplaceallmultiple
	.globl	strreplaceallmultipletd
	.type	strreplaceallmultipletd, @function
strreplaceallmultipletd:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r12
	push	rbx
	sub	rsp, 256
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	mov	QWORD PTR [rbp-264], rdi
	mov	QWORD PTR [rbp-272], rsi
	mov	QWORD PTR [rbp-176], rdx
	mov	QWORD PTR [rbp-168], rcx
	mov	QWORD PTR [rbp-160], r8
	mov	QWORD PTR [rbp-152], r9
	test	al, al
	je	.L83
	movaps	XMMWORD PTR [rbp-144], xmm0
	movaps	XMMWORD PTR [rbp-128], xmm1
	movaps	XMMWORD PTR [rbp-112], xmm2
	movaps	XMMWORD PTR [rbp-96], xmm3
	movaps	XMMWORD PTR [rbp-80], xmm4
	movaps	XMMWORD PTR [rbp-64], xmm5
	movaps	XMMWORD PTR [rbp-48], xmm6
	movaps	XMMWORD PTR [rbp-32], xmm7
.L83:
	mov	DWORD PTR [rbp-232], 16
	mov	DWORD PTR [rbp-228], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-224], rax
	lea	rax, [rbp-192]
	mov	QWORD PTR [rbp-216], rax
	mov	edi, 64
	call	malloc
	mov	QWORD PTR [rbp-256], rax
	mov	DWORD PTR [rbp-248], 0
	jmp	.L69
.L73:
	mov	eax, DWORD PTR [rbp-248]
	mov	r12d, eax
	mov	rax, QWORD PTR [rbp-256]
	mov	rdi, rax
	call	malloc_usable_size
	shr	rax, 3
	cmp	r12, rax
	jne	.L70
	mov	rax, QWORD PTR [rbp-256]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-256]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-256], rax
.L70:
	mov	rcx, QWORD PTR [rbp-256]
	mov	eax, DWORD PTR [rbp-248]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-248], edx
	mov	eax, eax
	sal	rax, 3
	add	rax, rcx
	mov	QWORD PTR [rax], rbx
.L69:
	mov	eax, DWORD PTR [rbp-232]
	cmp	eax, 47
	ja	.L71
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-232]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-232]
	add	edx, 8
	mov	DWORD PTR [rbp-232], edx
	jmp	.L72
.L71:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L72:
	mov	rbx, QWORD PTR [rax]
	test	rbx, rbx
	jne	.L73
	jmp	.L74
.L82:
	mov	rax, QWORD PTR [rbp-256]
	mov	edx, DWORD PTR [rbp-248]
	mov	edx, edx
	sal	rdx, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-208], rax
	mov	rax, QWORD PTR [rbp-256]
	mov	QWORD PTR [rbp-200], rax
	jmp	.L75
.L81:
	mov	rbx, QWORD PTR [rbp-272]
	mov	rax, QWORD PTR [rbp-200]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-200], rdx
	mov	r12, QWORD PTR [rax]
	movzx	edx, BYTE PTR [rbx]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L84
.L80:
	movzx	eax, BYTE PTR [r12]
	test	al, al
	jne	.L77
	mov	rax, QWORD PTR [rbp-200]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-264]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	QWORD PTR [rbp-272], rbx
	jmp	.L78
.L77:
	movzx	edx, BYTE PTR [rbx]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L85
	add	r12, 1
	add	rbx, 1
	jmp	.L80
.L84:
	nop
	jmp	.L86
.L85:
	nop
.L76:
.L86:
	nop
	add	QWORD PTR [rbp-200], 8
.L75:
	mov	rax, QWORD PTR [rbp-200]
	cmp	rax, QWORD PTR [rbp-208]
	jb	.L81
	nop
.L78:
	mov	rax, QWORD PTR [rbp-272]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-264]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendc
	nop
	add	QWORD PTR [rbp-272], 1
.L74:
	mov	rax, QWORD PTR [rbp-272]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L82
	mov	rax, QWORD PTR [rbp-256]
	mov	rdi, rax
	call	free
	nop
	add	rsp, 256
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	strreplaceallmultipletd, .-strreplaceallmultipletd
	.globl	xstrreplaceonce
	.type	xstrreplaceonce, @function
xstrreplaceonce:
.LFB15:
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
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	DWORD PTR [rbp-52], edx
	mov	QWORD PTR [rbp-64], rcx
	mov	DWORD PTR [rbp-56], r8d
	mov	rax, QWORD PTR [rbp-40]
	mov	rbx, QWORD PTR [rax]
	jmp	.L88
.L96:
	mov	r13, rbx
	mov	r12, QWORD PTR [rbp-48]
	movzx	edx, BYTE PTR [r13+0]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L89
.L95:
	movzx	eax, BYTE PTR [r12]
	test	al, al
	jne	.L90
	mov	eax, DWORD PTR [rbp-56]
	sub	eax, DWORD PTR [rbp-52]
	mov	r12d, eax
	jmp	.L91
.L92:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L91:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	mov	rdx, QWORD PTR [rbp-40]
	mov	edx, DWORD PTR [rdx+8]
	add	edx, r12d
	movsx	rdx, edx
	cmp	rdx, rax
	jnb	.L92
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	rcx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdx, r13
	sub	rdx, rax
	mov	rax, rcx
	sub	rax, rdx
	mov	rdx, rax
	mov	eax, DWORD PTR [rbp-52]
	cdqe
	lea	rcx, [rbx+rax]
	mov	eax, DWORD PTR [rbp-56]
	cdqe
	add	rax, rbx
	mov	rsi, rcx
	mov	rdi, rax
	call	memmove
	mov	eax, DWORD PTR [rbp-56]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-64]
	mov	rsi, rax
	mov	rdi, rbx
	call	memcpy
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	edx, [r12+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	DWORD PTR [rax+8], edx
	jmp	.L87
.L90:
	movzx	edx, BYTE PTR [r13+0]
	movzx	eax, BYTE PTR [r12]
	cmp	dl, al
	jne	.L97
	add	r12, 1
	add	r13, 1
	jmp	.L95
.L97:
	nop
.L89:
	add	rbx, 1
.L88:
	movzx	eax, BYTE PTR [rbx]
	test	al, al
	jne	.L96
.L87:
	add	rsp, 40
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	xstrreplaceonce, .-xstrreplaceonce
	.globl	strequalsmo
	.type	strequalsmo, @function
strequalsmo:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 120
	mov	QWORD PTR [rbp-232], rdi
	mov	QWORD PTR [rbp-160], rdx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L99
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L99:
	mov	eax, esi
	mov	BYTE PTR [rbp-236], al
	mov	DWORD PTR [rbp-224], 16
	mov	DWORD PTR [rbp-220], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-216], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-208], rax
	mov	DWORD PTR [rbp-180], 0
	jmp	.L100
.L110:
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L101
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L102
.L101:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L102:
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-192], rax
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rbp-200], rax
	jmp	.L103
.L109:
	mov	rax, QWORD PTR [rbp-192]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L104
	mov	rax, QWORD PTR [rbp-200]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L113
	mov	eax, DWORD PTR [rbp-180]
	jmp	.L111
.L104:
	mov	rax, QWORD PTR [rbp-200]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L108
	mov	eax, DWORD PTR [rbp-180]
	jmp	.L111
.L108:
	add	QWORD PTR [rbp-192], 1
	add	QWORD PTR [rbp-200], 1
.L103:
	mov	rax, QWORD PTR [rbp-192]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-200]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L109
	jmp	.L114
.L113:
	nop
.L114:
	nop
	add	DWORD PTR [rbp-180], 1
.L100:
	movsx	eax, BYTE PTR [rbp-236]
	cmp	DWORD PTR [rbp-180], eax
	jb	.L110
	mov	eax, -1
.L111:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	strequalsmo, .-strequalsmo
	.globl	strhash
	.type	strhash, @function
strhash:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	mov	QWORD PTR [rbp-8], rax
	mov	DWORD PTR [rbp-12], 0
	jmp	.L116
.L117:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	imul	eax, DWORD PTR [rbp-12]
	cdqe
	imul	rdx, rax, 1325222022
	mov	rax, QWORD PTR [rbp-8]
	add	rax, rdx
	shr	rax, 3
	mov	QWORD PTR [rbp-8], rax
	add	QWORD PTR [rbp-24], 1
	add	DWORD PTR [rbp-12], 1
.L116:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L117
	mov	rax, QWORD PTR [rbp-8]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	strhash, .-strhash
	.globl	xstrappends
	.type	xstrappends, @function
xstrappends:
.LFB18:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 24
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	jmp	.L120
.L122:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L121
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L121:
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	lea	rdx, [rsi+rax]
	mov	rax, QWORD PTR [rbp-32]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	QWORD PTR [rbp-32], 1
.L120:
	mov	rax, QWORD PTR [rbp-32]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L122
	nop
	nop
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	xstrappends, .-xstrappends
	.globl	xstrappendc
	.type	xstrappendc, @function
xstrappendc:
.LFB19:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 24
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-24], rdi
	mov	eax, esi
	mov	BYTE PTR [rbp-28], al
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L124
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L124:
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	lea	rdx, [rsi+rax]
	movzx	eax, BYTE PTR [rbp-28]
	mov	BYTE PTR [rdx], al
	nop
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	xstrappendc, .-xstrappendc
	.globl	_num_
	.data
	.align 32
	.type	_num_, @object
	.size	_num_, 36
_num_:
	.ascii	"0123456789abcdefghijklmnopqrstuvwxyz"
	.globl	__floatsitf
	.globl	__fixtfsi
	.text
	.globl	xstrappendi
	.type	xstrappendi, @function
xstrappendi:
.LFB20:
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
	mov	DWORD PTR [rbp-28], esi
	cmp	DWORD PTR [rbp-28], 0
	jns	.L126
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L127
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L127:
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 45
	mov	edi, DWORD PTR [rbp-28]
	call	__floatsitf
	movdqa	xmm1, xmm0
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, xmm3
	por	xmm0, xmm2
	call	__fixtfsi
	mov	DWORD PTR [rbp-28], eax
.L126:
	mov	ebx, 0
	jmp	.L128
.L129:
	mov	eax, ebx
	sal	eax, 2
	add	eax, ebx
	add	eax, eax
	mov	esi, eax
	mov	ecx, DWORD PTR [rbp-28]
	movsx	rax, ecx
	imul	rax, rax, 1717986919
	shr	rax, 32
	mov	edx, eax
	sar	edx, 2
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	sub	ecx, eax
	mov	edx, ecx
	mov	eax, edx
	lea	ebx, [rsi+rax]
	mov	eax, DWORD PTR [rbp-28]
	movsx	rdx, eax
	imul	rdx, rdx, 1717986919
	shr	rdx, 32
	mov	ecx, edx
	sar	ecx, 2
	cdq
	mov	eax, ecx
	sub	eax, edx
	mov	DWORD PTR [rbp-28], eax
.L128:
	cmp	DWORD PTR [rbp-28], 0
	jne	.L129
	jmp	.L130
.L132:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L131
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L131:
	mov	edx, ebx
	mov	eax, 3435973837
	imul	rax, rdx
	shr	rax, 32
	mov	edx, eax
	shr	edx, 3
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, ebx
	sub	edx, eax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	mov	edx, ebx
	mov	eax, 3435973837
	imul	rax, rdx
	shr	rax, 32
	shr	eax, 3
	mov	ebx, eax
.L130:
	test	ebx, ebx
	jne	.L132
	nop
	nop
	add	rsp, 16
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	xstrappendi, .-xstrappendi
	.globl	__floatditf
	.globl	__fixtfdi
	.globl	xstrappendl
	.type	xstrappendl, @function
xstrappendl:
.LFB21:
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
	cmp	QWORD PTR [rbp-32], 0
	jns	.L134
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L135
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L135:
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 45
	mov	rdi, QWORD PTR [rbp-32]
	call	__floatditf
	movdqa	xmm1, xmm0
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, xmm3
	por	xmm0, xmm2
	call	__fixtfdi
	mov	QWORD PTR [rbp-32], rax
.L134:
	mov	ebx, 0
	jmp	.L136
.L137:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rsi, rax
	mov	rcx, QWORD PTR [rbp-32]
	movabs	rdx, 7378697629483820647
	mov	rax, rcx
	imul	rdx
	sar	rdx, 2
	mov	rax, rcx
	sar	rax, 63
	sub	rdx, rax
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	sub	rcx, rax
	mov	rdx, rcx
	mov	rax, rdx
	lea	rbx, [rsi+rax]
	mov	rcx, QWORD PTR [rbp-32]
	movabs	rdx, 7378697629483820647
	mov	rax, rcx
	imul	rdx
	mov	rax, rdx
	sar	rax, 2
	sar	rcx, 63
	mov	rdx, rcx
	sub	rax, rdx
	mov	QWORD PTR [rbp-32], rax
.L136:
	cmp	QWORD PTR [rbp-32], 0
	jne	.L137
	jmp	.L138
.L140:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L139
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L139:
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
.L138:
	test	rbx, rbx
	jne	.L140
	nop
	nop
	add	rsp, 16
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	xstrappendl, .-xstrappendl
	.globl	xstrappendui
	.type	xstrappendui, @function
xstrappendui:
.LFB22:
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
	mov	DWORD PTR [rbp-28], esi
	mov	ebx, 0
	jmp	.L142
.L143:
	mov	eax, ebx
	sal	eax, 2
	add	eax, ebx
	add	eax, eax
	mov	esi, eax
	mov	ecx, DWORD PTR [rbp-28]
	mov	edx, ecx
	mov	eax, 3435973837
	imul	rax, rdx
	shr	rax, 32
	mov	edx, eax
	shr	edx, 3
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	sub	ecx, eax
	mov	edx, ecx
	lea	ebx, [rsi+rdx]
	mov	eax, DWORD PTR [rbp-28]
	mov	edx, eax
	mov	eax, 3435973837
	imul	rax, rdx
	shr	rax, 32
	shr	eax, 3
	mov	DWORD PTR [rbp-28], eax
.L142:
	cmp	DWORD PTR [rbp-28], 0
	jne	.L143
	jmp	.L144
.L146:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L145
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L145:
	mov	edx, ebx
	mov	eax, 3435973837
	imul	rax, rdx
	shr	rax, 32
	mov	edx, eax
	shr	edx, 3
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, ebx
	sub	edx, eax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	mov	edx, ebx
	mov	eax, 3435973837
	imul	rax, rdx
	shr	rax, 32
	shr	eax, 3
	mov	ebx, eax
.L144:
	test	ebx, ebx
	jne	.L146
	nop
	nop
	add	rsp, 16
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	xstrappendui, .-xstrappendui
	.globl	xstrappendul
	.type	xstrappendul, @function
xstrappendul:
.LFB23:
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
	mov	ebx, 0
	jmp	.L148
.L149:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rsi, rax
	mov	rcx, QWORD PTR [rbp-32]
	movabs	rdx, -3689348814741910323
	mov	rax, rcx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	sub	rcx, rax
	mov	rdx, rcx
	lea	rbx, [rsi+rdx]
	mov	rax, QWORD PTR [rbp-32]
	movabs	rdx, -3689348814741910323
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	QWORD PTR [rbp-32], rax
.L148:
	cmp	QWORD PTR [rbp-32], 0
	jne	.L149
	jmp	.L150
.L152:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L151
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L151:
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
.L150:
	test	rbx, rbx
	jne	.L152
	nop
	nop
	add	rsp, 16
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	xstrappendul, .-xstrappendul
	.globl	__extendsftf2
	.globl	__trunctfsf2
	.globl	xstrappendf
	.type	xstrappendf, @function
xstrappendf:
.LFB24:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r13
	push	r12
	push	rbx
	sub	rsp, 24
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	mov	QWORD PTR [rbp-40], rdi
	movss	DWORD PTR [rbp-44], xmm0
	pxor	xmm0, xmm0
	comiss	xmm0, DWORD PTR [rbp-44]
	jbe	.L154
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L156
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L156:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 45
	movss	xmm0, DWORD PTR [rbp-44]
	call	__extendsftf2
	movdqa	xmm1, xmm0
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, xmm3
	por	xmm0, xmm2
	call	__trunctfsf2
	movd	eax, xmm0
	mov	DWORD PTR [rbp-44], eax
.L154:
	movss	xmm0, DWORD PTR [rbp-44]
	comiss	xmm0, DWORD PTR .LC3[rip]
	jnb	.L157
	movss	xmm0, DWORD PTR [rbp-44]
	cvttss2si	r12, xmm0
	jmp	.L158
.L157:
	movss	xmm0, DWORD PTR [rbp-44]
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm0, xmm1
	cvttss2si	r12, xmm0
	movabs	rax, -9223372036854775808
	xor	r12, rax
.L158:
	test	r12, r12
	js	.L159
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, r12
	jmp	.L160
.L159:
	mov	rax, r12
	shr	rax
	mov	rdx, r12
	and	edx, 1
	or	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rax
	addss	xmm0, xmm0
.L160:
	movss	xmm1, DWORD PTR [rbp-44]
	subss	xmm1, xmm0
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	comiss	xmm0, DWORD PTR .LC3[rip]
	jnb	.L161
	cvttss2si	r13, xmm0
	jmp	.L162
.L161:
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm0, xmm1
	cvttss2si	r13, xmm0
	movabs	rax, -9223372036854775808
	xor	r13, rax
.L162:
	mov	ebx, 0
	jmp	.L163
.L164:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r12
	sub	rdx, rax
	lea	rbx, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r12, rax
.L163:
	test	r12, r12
	jne	.L164
	jmp	.L165
.L167:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L166
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L166:
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
.L165:
	test	rbx, rbx
	jne	.L167
	mov	ebx, 0
	jmp	.L168
.L169:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r13
	sub	rdx, rax
	lea	rbx, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r13, rax
.L168:
	test	r13, r13
	jne	.L169
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L170
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L170:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 46
	jmp	.L171
.L175:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L172
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L172:
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	test	rbx, rbx
	je	.L177
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
.L171:
	test	rbx, rbx
	jne	.L175
	jmp	.L178
.L177:
	nop
.L178:
	nop
	add	rsp, 24
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	xstrappendf, .-xstrappendf
	.globl	__extenddftf2
	.globl	__trunctfdf2
	.globl	xstrappendd
	.type	xstrappendd, @function
xstrappendd:
.LFB25:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r13
	push	r12
	push	rbx
	sub	rsp, 24
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	mov	QWORD PTR [rbp-40], rdi
	movsd	QWORD PTR [rbp-48], xmm0
	pxor	xmm0, xmm0
	comisd	xmm0, QWORD PTR [rbp-48]
	jbe	.L180
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L182
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L182:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 45
	movsd	xmm0, QWORD PTR [rbp-48]
	call	__extenddftf2
	movdqa	xmm1, xmm0
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, xmm3
	por	xmm0, xmm2
	call	__trunctfdf2
	movq	rax, xmm0
	mov	QWORD PTR [rbp-48], rax
.L180:
	movsd	xmm0, QWORD PTR [rbp-48]
	comisd	xmm0, QWORD PTR .LC6[rip]
	jnb	.L183
	movsd	xmm0, QWORD PTR [rbp-48]
	cvttsd2si	r12, xmm0
	jmp	.L184
.L183:
	movsd	xmm0, QWORD PTR [rbp-48]
	movsd	xmm1, QWORD PTR .LC6[rip]
	subsd	xmm0, xmm1
	cvttsd2si	r12, xmm0
	movabs	rax, -9223372036854775808
	xor	r12, rax
.L184:
	test	r12, r12
	js	.L185
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, r12
	jmp	.L186
.L185:
	mov	rax, r12
	shr	rax
	mov	rdx, r12
	and	edx, 1
	or	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	addsd	xmm0, xmm0
.L186:
	movsd	xmm1, QWORD PTR [rbp-48]
	subsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC6[rip]
	jnb	.L187
	cvttsd2si	r13, xmm0
	jmp	.L188
.L187:
	movsd	xmm1, QWORD PTR .LC6[rip]
	subsd	xmm0, xmm1
	cvttsd2si	r13, xmm0
	movabs	rax, -9223372036854775808
	xor	r13, rax
.L188:
	mov	ebx, 0
	jmp	.L189
.L190:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r12
	sub	rdx, rax
	lea	rbx, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r12, rax
.L189:
	test	r12, r12
	jne	.L190
	jmp	.L191
.L193:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L192
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L192:
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
.L191:
	test	rbx, rbx
	jne	.L193
	mov	ebx, 0
	jmp	.L194
.L195:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r13
	sub	rdx, rax
	lea	rbx, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r13, rax
.L194:
	test	r13, r13
	jne	.L195
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L196
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L196:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 46
.L200:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L197
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L197:
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	test	rbx, rbx
	je	.L203
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
	jmp	.L200
.L203:
	nop
	nop
	add	rsp, 24
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	xstrappendd, .-xstrappendd
	.globl	xstrappendfp
	.type	xstrappendfp, @function
xstrappendfp:
.LFB26:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r13
	push	r12
	push	rbx
	sub	rsp, 24
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	mov	QWORD PTR [rbp-40], rdi
	movss	DWORD PTR [rbp-44], xmm0
	mov	DWORD PTR [rbp-48], esi
	pxor	xmm0, xmm0
	comiss	xmm0, DWORD PTR [rbp-44]
	jbe	.L205
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L207
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L207:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 45
	movss	xmm0, DWORD PTR [rbp-44]
	call	__extendsftf2
	movdqa	xmm1, xmm0
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, xmm3
	por	xmm0, xmm2
	call	__trunctfsf2
	movd	eax, xmm0
	mov	DWORD PTR [rbp-44], eax
.L205:
	movss	xmm0, DWORD PTR [rbp-44]
	comiss	xmm0, DWORD PTR .LC3[rip]
	jnb	.L208
	movss	xmm0, DWORD PTR [rbp-44]
	cvttss2si	rbx, xmm0
	jmp	.L209
.L208:
	movss	xmm0, DWORD PTR [rbp-44]
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm0, xmm1
	cvttss2si	rbx, xmm0
	movabs	rax, -9223372036854775808
	xor	rbx, rax
.L209:
	test	rbx, rbx
	js	.L210
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rbx
	jmp	.L211
.L210:
	mov	rax, rbx
	shr	rax
	mov	rdx, rbx
	and	edx, 1
	or	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rax
	addss	xmm0, xmm0
.L211:
	movss	xmm1, DWORD PTR [rbp-44]
	subss	xmm1, xmm0
	movss	xmm0, DWORD PTR .LC4[rip]
	mulss	xmm0, xmm1
	comiss	xmm0, DWORD PTR .LC3[rip]
	jnb	.L212
	cvttss2si	r13, xmm0
	jmp	.L213
.L212:
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm0, xmm1
	cvttss2si	r13, xmm0
	movabs	rax, -9223372036854775808
	xor	r13, rax
.L213:
	mov	r12d, 0
	jmp	.L214
.L215:
	mov	rax, r12
	sal	rax, 2
	add	rax, r12
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	lea	r12, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
.L214:
	test	rbx, rbx
	jne	.L215
	jmp	.L216
.L218:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L217
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L217:
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r12
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r12, rax
.L216:
	test	r12, r12
	jne	.L218
	cmp	DWORD PTR [rbp-48], 0
	je	.L228
	mov	r12d, 0
	mov	rbx, r13
	jmp	.L221
.L222:
	mov	rax, r12
	sal	rax, 2
	add	rax, r12
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r13
	sub	rdx, rax
	lea	r12, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r13, rax
.L221:
	test	r13, r13
	jne	.L222
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r13, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r13, rax
	jne	.L223
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L223:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 46
	jmp	.L224
.L226:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r13, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r13, rax
	jne	.L225
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L225:
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r12
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r12, rax
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
	sub	DWORD PTR [rbp-48], 1
.L224:
	cmp	DWORD PTR [rbp-48], 0
	jg	.L226
	jmp	.L204
.L228:
	nop
.L204:
	add	rsp, 24
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	xstrappendfp, .-xstrappendfp
	.globl	xstrappenddp
	.type	xstrappenddp, @function
xstrappenddp:
.LFB27:
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
	mov	QWORD PTR [rbp-40], rdi
	movsd	QWORD PTR [rbp-48], xmm0
	mov	DWORD PTR [rbp-52], esi
	pxor	xmm0, xmm0
	comisd	xmm0, QWORD PTR [rbp-48]
	jbe	.L230
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L232
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L232:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 45
	movsd	xmm0, QWORD PTR [rbp-48]
	call	__extenddftf2
	movdqa	xmm1, xmm0
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, xmm3
	por	xmm0, xmm2
	call	__trunctfdf2
	movq	rax, xmm0
	mov	QWORD PTR [rbp-48], rax
.L230:
	movsd	xmm0, QWORD PTR [rbp-48]
	comisd	xmm0, QWORD PTR .LC6[rip]
	jnb	.L233
	movsd	xmm0, QWORD PTR [rbp-48]
	cvttsd2si	rbx, xmm0
	jmp	.L234
.L233:
	movsd	xmm0, QWORD PTR [rbp-48]
	movsd	xmm1, QWORD PTR .LC6[rip]
	subsd	xmm0, xmm1
	cvttsd2si	rbx, xmm0
	movabs	rax, -9223372036854775808
	xor	rbx, rax
.L234:
	test	rbx, rbx
	js	.L235
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rbx
	jmp	.L236
.L235:
	mov	rax, rbx
	shr	rax
	mov	rdx, rbx
	and	edx, 1
	or	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	addsd	xmm0, xmm0
.L236:
	movsd	xmm1, QWORD PTR [rbp-48]
	subsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC6[rip]
	jnb	.L237
	cvttsd2si	r13, xmm0
	jmp	.L238
.L237:
	movsd	xmm1, QWORD PTR .LC6[rip]
	subsd	xmm0, xmm1
	cvttsd2si	r13, xmm0
	movabs	rax, -9223372036854775808
	xor	r13, rax
.L238:
	mov	r12d, 0
	jmp	.L239
.L240:
	mov	rax, r12
	sal	rax, 2
	add	rax, r12
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rbx
	sub	rdx, rax
	lea	r12, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
.L239:
	test	rbx, rbx
	jne	.L240
	jmp	.L241
.L243:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L242
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L242:
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r12
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r12, rax
.L241:
	test	r12, r12
	jne	.L243
	cmp	DWORD PTR [rbp-52], 0
	je	.L253
	mov	r12d, 0
	mov	rbx, r13
	jmp	.L246
.L247:
	mov	rax, r12
	sal	rax, 2
	add	rax, r12
	add	rax, rax
	mov	rcx, rax
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r13
	sub	rdx, rax
	lea	r12, [rcx+rdx]
	movabs	rdx, -3689348814741910323
	mov	rax, r13
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r13, rax
.L246:
	test	r13, r13
	jne	.L247
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r13, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r13, rax
	jne	.L248
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L248:
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 46
	jmp	.L249
.L251:
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	movsx	r13, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r13, rax
	jne	.L250
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx], rax
.L250:
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	shr	rdx, 3
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, r12
	sub	rdx, rax
	mov	eax, edx
	lea	edi, [rax+48]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	movabs	rdx, -3689348814741910323
	mov	rax, r12
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	r12, rax
	movabs	rdx, -3689348814741910323
	mov	rax, rbx
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	rbx, rax
	sub	DWORD PTR [rbp-52], 1
.L249:
	cmp	DWORD PTR [rbp-52], 0
	jg	.L251
	jmp	.L229
.L253:
	nop
.L229:
	add	rsp, 40
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	xstrappenddp, .-xstrappenddp
	.globl	xstrappendmemaddr
	.type	xstrappendmemaddr, @function
xstrappendmemaddr:
.LFB28:
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
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L255
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L255:
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 48
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L256
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L256:
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 120
	mov	ebx, 0
	jmp	.L257
.L258:
	sal	rbx, 4
	mov	rdx, rbx
	mov	rax, QWORD PTR [rbp-32]
	and	eax, 15
	lea	rbx, [rdx+rax]
	mov	rax, QWORD PTR [rbp-32]
	shr	rax, 4
	mov	QWORD PTR [rbp-32], rax
.L257:
	cmp	QWORD PTR [rbp-32], 0
	jne	.L258
	jmp	.L259
.L261:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	movsx	r12, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	r12, rax
	jne	.L260
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
.L260:
	mov	rsi, rbx
	and	esi, 15
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	lea	rdx, [rdi+rax]
	movzx	eax, BYTE PTR _num_[rsi]
	mov	BYTE PTR [rdx], al
	mov	rax, rbx
	shr	rax, 4
	mov	rbx, rax
.L259:
	test	rbx, rbx
	jne	.L261
	nop
	nop
	add	rsp, 16
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	xstrappendmemaddr, .-xstrappendmemaddr
	.globl	xstrappendformat
	.type	xstrappendformat, @function
xstrappendformat:
.LFB29:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 232
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-232], rdi
	mov	QWORD PTR [rbp-240], rsi
	mov	QWORD PTR [rbp-176], rdx
	mov	QWORD PTR [rbp-168], rcx
	mov	QWORD PTR [rbp-160], r8
	mov	QWORD PTR [rbp-152], r9
	test	al, al
	je	.L303
	movaps	XMMWORD PTR [rbp-144], xmm0
	movaps	XMMWORD PTR [rbp-128], xmm1
	movaps	XMMWORD PTR [rbp-112], xmm2
	movaps	XMMWORD PTR [rbp-96], xmm3
	movaps	XMMWORD PTR [rbp-80], xmm4
	movaps	XMMWORD PTR [rbp-64], xmm5
	movaps	XMMWORD PTR [rbp-48], xmm6
	movaps	XMMWORD PTR [rbp-32], xmm7
.L303:
	mov	DWORD PTR [rbp-216], 16
	mov	DWORD PTR [rbp-212], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-208], rax
	lea	rax, [rbp-192]
	mov	QWORD PTR [rbp-200], rax
	jmp	.L264
.L302:
	mov	rax, QWORD PTR [rbp-240]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 37
	je	.L265
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L266
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-232]
	mov	QWORD PTR [rdx], rax
.L266:
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-232]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	lea	rdx, [rsi+rax]
	mov	rax, QWORD PTR [rbp-240]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	jmp	.L267
.L265:
	add	QWORD PTR [rbp-240], 1
	mov	rax, QWORD PTR [rbp-240]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	sub	eax, 70
	cmp	eax, 47
	ja	.L267
	mov	eax, eax
	mov	rax, QWORD PTR .L269[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L269:
	.quad	.L275
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L274
	.quad	.L273
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L272
	.quad	.L267
	.quad	.L267
	.quad	.L267
	.quad	.L271
	.quad	.L267
	.quad	.L267
	.quad	.L270
	.quad	.L267
	.quad	.L268
	.text
.L273:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L276
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L277
.L276:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L277:
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendi
	jmp	.L267
.L272:
	mov	rax, QWORD PTR [rbp-240]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 70
	je	.L278
	cmp	eax, 108
	jne	.L279
	mov	rax, QWORD PTR [rbp-240]
	add	rax, 2
	movzx	eax, BYTE PTR [rax]
	cmp	al, 100
	jne	.L280
	add	QWORD PTR [rbp-240], 2
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L281
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L282
.L281:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L282:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappendl
	jmp	.L283
.L280:
	mov	rax, QWORD PTR [rbp-240]
	add	rax, 2
	movzx	eax, BYTE PTR [rax]
	cmp	al, 117
	jne	.L284
	add	QWORD PTR [rbp-240], 2
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L285
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L286
.L285:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L286:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappendul
	jmp	.L283
.L284:
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L287
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-232]
	mov	QWORD PTR [rdx], rax
.L287:
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-232]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 37
	sub	QWORD PTR [rbp-240], 1
	jmp	.L283
.L278:
	add	QWORD PTR [rbp-240], 1
	mov	eax, DWORD PTR [rbp-212]
	cmp	eax, 175
	ja	.L288
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-212]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-212]
	add	edx, 16
	mov	DWORD PTR [rbp-212], edx
	jmp	.L289
.L288:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L289:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	movq	xmm0, rdx
	mov	rdi, rax
	call	xstrappendd
	jmp	.L283
.L279:
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L290
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-232]
	mov	QWORD PTR [rdx], rax
.L290:
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-232]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	BYTE PTR [rax], 37
	sub	QWORD PTR [rbp-240], 1
	nop
.L283:
	jmp	.L267
.L275:
	mov	eax, DWORD PTR [rbp-212]
	cmp	eax, 175
	ja	.L291
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-212]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-212]
	add	edx, 16
	mov	DWORD PTR [rbp-212], edx
	jmp	.L292
.L291:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L292:
	movsd	xmm0, QWORD PTR [rax]
	pxor	xmm1, xmm1
	cvtsd2ss	xmm1, xmm0
	movd	edx, xmm1
	mov	rax, QWORD PTR [rbp-232]
	movd	xmm0, edx
	mov	rdi, rax
	call	xstrappendf
	jmp	.L267
.L268:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L293
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L294
.L293:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L294:
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendui
	jmp	.L267
.L274:
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L295
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-232]
	mov	QWORD PTR [rdx], rax
.L295:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L296
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L297
.L296:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L297:
	mov	edi, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-232]
	mov	DWORD PTR [rdx+8], ecx
	cdqe
	add	rax, rsi
	mov	edx, edi
	mov	BYTE PTR [rax], dl
	jmp	.L267
.L270:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L298
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L299
.L298:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L299:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	jmp	.L267
.L271:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L300
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L301
.L300:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L301:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-232]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappendmemaddr
	nop
.L267:
	add	QWORD PTR [rbp-240], 1
.L264:
	mov	rax, QWORD PTR [rbp-240]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L302
	nop
	nop
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	xstrappendformat, .-xstrappendformat
	.globl	strcreaterandomlowercase
	.type	strcreaterandomlowercase, @function
strcreaterandomlowercase:
.LFB30:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	DWORD PTR [rbp-20], edi
	mov	DWORD PTR [rbp-24], esi
	call	rand
	mov	edx, DWORD PTR [rbp-24]
	mov	esi, edx
	sub	esi, DWORD PTR [rbp-20]
	cdq
	idiv	esi
	mov	ecx, edx
	mov	edx, ecx
	mov	eax, DWORD PTR [rbp-20]
	add	eax, edx
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-4]
	add	eax, 2
	cdqe
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-16], rax
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	jmp	.L305
.L306:
	call	rand
	movsx	rdx, eax
	imul	rdx, rdx, 1321528399
	shr	rdx, 32
	sar	edx, 3
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 26
	sub	eax, ecx
	mov	edx, eax
	mov	eax, edx
	lea	ecx, [rax+97]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	sub	DWORD PTR [rbp-4], 1
.L305:
	cmp	DWORD PTR [rbp-4], 0
	jns	.L306
	mov	rax, QWORD PTR [rbp-16]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	strcreaterandomlowercase, .-strcreaterandomlowercase
	.globl	strcreaterandom
	.type	strcreaterandom, @function
strcreaterandom:
.LFB31:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	DWORD PTR [rbp-20], edi
	mov	DWORD PTR [rbp-24], esi
	call	rand
	mov	edx, DWORD PTR [rbp-24]
	mov	esi, edx
	sub	esi, DWORD PTR [rbp-20]
	cdq
	idiv	esi
	mov	ecx, edx
	mov	edx, ecx
	mov	eax, DWORD PTR [rbp-20]
	add	eax, edx
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-4]
	add	eax, 2
	cdqe
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-16], rax
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	jmp	.L309
.L310:
	call	rand
	movsx	rdx, eax
	imul	rdx, rdx, -2130574327
	shr	rdx, 32
	add	edx, eax
	sar	edx, 7
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 254
	sub	eax, ecx
	mov	edx, eax
	mov	eax, edx
	lea	ecx, [rax+1]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	sub	DWORD PTR [rbp-4], 1
.L309:
	cmp	DWORD PTR [rbp-4], 0
	jns	.L310
	mov	rax, QWORD PTR [rbp-16]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	strcreaterandom, .-strcreaterandom
	.globl	strcontainschar
	.type	strcontainschar, @function
strcontainschar:
.LFB32:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	eax, esi
	mov	BYTE PTR [rbp-12], al
	jmp	.L313
.L316:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	cmp	BYTE PTR [rbp-12], al
	jne	.L314
	mov	eax, 1
	jmp	.L315
.L314:
	add	QWORD PTR [rbp-8], 1
.L313:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L316
	mov	eax, 0
.L315:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	strcontainschar, .-strcontainschar
	.globl	strremoveAdStart
	.type	strremoveAdStart, @function
strremoveAdStart:
.LFB33:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	jmp	.L318
.L321:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L319
	mov	eax, 0
	jmp	.L320
.L319:
	add	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-16], 1
.L318:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L321
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L322
	mov	rax, QWORD PTR [rbp-8]
	jmp	.L320
.L322:
	mov	eax, 0
.L320:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	strremoveAdStart, .-strremoveAdStart
	.globl	strremovecAdStart
	.type	strremovecAdStart, @function
strremovecAdStart:
.LFB34:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	eax, esi
	mov	BYTE PTR [rbp-12], al
	jmp	.L325
.L326:
	add	QWORD PTR [rbp-8], 1
.L325:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	cmp	BYTE PTR [rbp-12], al
	je	.L326
	mov	rax, QWORD PTR [rbp-8]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	strremovecAdStart, .-strremovecAdStart
	.globl	strcopyusingmalloc
	.type	strcopyusingmalloc, @function
strcopyusingmalloc:
.LFB35:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 40
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-40], rdi
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-24], 0
	jmp	.L329
.L331:
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L330
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L330:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	lea	rdx, [rcx+rax]
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	QWORD PTR [rbp-40], 1
.L329:
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L331
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L332
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L332:
	mov	rdx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	strcopyusingmalloc, .-strcopyusingmalloc
	.globl	strccat
	.type	strccat, @function
strccat:
.LFB36:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 40
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-24], 0
	mov	rdx, QWORD PTR [rbp-40]
	lea	rax, [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	rdx, QWORD PTR [rbp-48]
	lea	rax, [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L335
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L335:
	mov	rdx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	strccat, .-strccat
	.globl	strccatph
	.type	strccatph, @function
strccatph:
.LFB37:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 56
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-40], rdi
	mov	eax, esi
	mov	QWORD PTR [rbp-56], rdx
	mov	BYTE PTR [rbp-44], al
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-24], 0
	mov	rdx, QWORD PTR [rbp-40]
	lea	rax, [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L338
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L338:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	lea	rdx, [rcx+rax]
	movzx	eax, BYTE PTR [rbp-44]
	mov	BYTE PTR [rdx], al
	mov	rdx, QWORD PTR [rbp-56]
	lea	rax, [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L339
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L339:
	mov	rdx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	strccatph, .-strccatph
	.globl	strsubbf
	.type	strsubbf, @function
strsubbf:
.LFB38:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 56
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-56], rdi
	mov	QWORD PTR [rbp-64], rsi
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-48], rax
	mov	DWORD PTR [rbp-40], 0
	jmp	.L342
.L350:
	mov	rax, QWORD PTR [rbp-56]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-64]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L343
	mov	rax, QWORD PTR [rbp-64]
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rbp-32], rax
	jmp	.L344
.L346:
	add	QWORD PTR [rbp-32], 1
	add	QWORD PTR [rbp-24], 1
.L344:
	mov	rax, QWORD PTR [rbp-32]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L345
	mov	rax, QWORD PTR [rbp-32]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L345
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L346
.L345:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	sete	al
	movzx	eax, al
	test	eax, eax
	je	.L343
	mov	eax, DWORD PTR [rbp-40]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L347
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-48], rax
.L347:
	mov	rdx, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rbp-40]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-48]
	jmp	.L352
.L343:
	mov	eax, DWORD PTR [rbp-40]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L349
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-48], rax
.L349:
	mov	rcx, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rbp-40]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-40], edx
	cdqe
	lea	rdx, [rcx+rax]
	mov	rax, QWORD PTR [rbp-56]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	QWORD PTR [rbp-56], 1
.L342:
	mov	rax, QWORD PTR [rbp-56]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L350
	mov	eax, DWORD PTR [rbp-40]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L351
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-48], rax
.L351:
	mov	rdx, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rbp-40]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-48]
	nop
.L352:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	strsubbf, .-strsubbf
	.globl	strsearch
	.type	strsearch, @function
strsearch:
.LFB39:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	jmp	.L354
.L360:
	mov	rax, QWORD PTR [rbp-24]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-32]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L355
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L356
.L358:
	add	QWORD PTR [rbp-16], 1
	add	QWORD PTR [rbp-8], 1
.L356:
	mov	rax, QWORD PTR [rbp-16]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L357
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L357
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L358
.L357:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L355
	mov	rax, QWORD PTR [rbp-16]
	jmp	.L359
.L355:
	add	QWORD PTR [rbp-24], 1
.L354:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L360
	mov	eax, 0
.L359:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	strsearch, .-strsearch
	.globl	strsearchbf
	.type	strsearchbf, @function
strsearchbf:
.LFB40:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	jmp	.L362
.L368:
	mov	rax, QWORD PTR [rbp-24]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-32]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L363
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L364
.L366:
	add	QWORD PTR [rbp-16], 1
	add	QWORD PTR [rbp-8], 1
.L364:
	mov	rax, QWORD PTR [rbp-16]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L365
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L365
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L366
.L365:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L363
	mov	rax, QWORD PTR [rbp-24]
	jmp	.L367
.L363:
	add	QWORD PTR [rbp-24], 1
.L362:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L368
	mov	eax, 0
.L367:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	strsearchbf, .-strsearchbf
	.section	.rodata
	.align 16
.LC0:
	.long	0
	.long	0
	.long	0
	.long	1073676288
	.align 16
.LC1:
	.long	0
	.long	0
	.long	0
	.long	-2147483648
	.align 4
.LC3:
	.long	1593835520
	.align 4
.LC4:
	.long	1594541859
	.align 8
.LC6:
	.long	0
	.long	1138753536
	.align 8
.LC7:
	.long	1620131072
	.long	1138841828
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
