	.file	"SString.c"
	.intel_syntax noprefix
	.text
	.globl	HEX
	.data
	.align 16
	.type	HEX, @object
	.size	HEX, 16
HEX:
	.ascii	"0123456789abcdef"
	.text
	.globl	sstr_createcs
	.type	sstr_createcs, @function
sstr_createcs:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], 16
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	mov	eax, eax
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], rdx
	jmp	.L2
.L3:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-8]
	mov	esi, edx
	mov	rdi, rax
	call	sstr_appendc
	add	QWORD PTR [rbp-24], 1
.L2:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L3
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	sstr_createcs, .-sstr_createcs
	.globl	sstr_creates
	.type	sstr_creates, @function
sstr_creates:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rbp-28]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rbp-28]
	mov	DWORD PTR [rax], edx
	mov	eax, DWORD PTR [rbp-28]
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], rdx
	mov	edx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rcx, QWORD PTR [rbp-24]
	mov	rsi, rcx
	mov	rdi, rax
	call	memcpy
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	sstr_creates, .-sstr_creates
	.globl	sstr_createe
	.type	sstr_createe, @function
sstr_createe:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], 2
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	mov	eax, eax
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	sstr_createe, .-sstr_createe
	.section	.rodata
.LC0:
	.string	"Error opening file: "
	.align 8
.LC1:
	.string	"Error getting file information: "
	.text
	.globl	sstr_createff
	.type	sstr_createff, @function
sstr_createff:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 176
	mov	QWORD PTR [rbp-168], rdi
	mov	rax, QWORD PTR [rbp-168]
	mov	esi, 0
	mov	rdi, rax
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-4], eax
	cmp	DWORD PTR [rbp-4], -1
	jne	.L10
	mov	edi, OFFSET FLAT:.LC0
	call	perror
	mov	edi, 1
	call	exit
.L10:
	lea	rdx, [rbp-160]
	mov	eax, DWORD PTR [rbp-4]
	mov	rsi, rdx
	mov	edi, eax
	call	fstat
	cmp	eax, -1
	jne	.L11
	mov	edi, OFFSET FLAT:.LC1
	call	perror
	mov	edi, 1
	call	exit
.L11:
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-112]
	add	rax, 1
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-112]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR [rbp-112]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-112]
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rcx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-4]
	mov	rsi, rcx
	mov	edi, eax
	call	read
	mov	eax, DWORD PTR [rbp-4]
	mov	edi, eax
	call	close
	mov	rax, QWORD PTR [rbp-16]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	sstr_createff, .-sstr_createff
	.globl	sstr_clone
	.type	sstr_clone, @function
sstr_clone:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], edx
	mov	edi, 16
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rcx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rcx
	mov	rdi, rax
	call	memcpy
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	sstr_clone, .-sstr_clone
	.globl	sstr_appendcs
	.type	sstr_appendcs, @function
sstr_appendcs:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	jmp	.L16
.L17:
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-8]
	mov	esi, edx
	mov	rdi, rax
	call	sstr_appendc
	add	QWORD PTR [rbp-16], 1
.L16:
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L17
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	sstr_appendcs, .-sstr_appendcs
	.globl	sstr_serialize
	.type	sstr_serialize, @function
sstr_serialize:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+4]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	jne	.L19
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+8], rax
.L19:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	mov	eax, eax
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	sstr_serialize, .-sstr_serialize
	.globl	sstr_appendc
	.type	sstr_appendc, @function
sstr_appendc:
.LFB13:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	eax, esi
	mov	BYTE PTR [rbp-12], al
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+4]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	jne	.L22
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+8], rax
.L22:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	mov	eax, eax
	add	rdx, rax
	movzx	eax, BYTE PTR [rbp-12]
	mov	BYTE PTR [rdx], al
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	sstr_appendc, .-sstr_appendc
	.globl	sstr_toLong
	.type	sstr_toLong, @function
sstr_toLong:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-8], 1
	mov	DWORD PTR [rbp-12], 0
	jmp	.L24
.L25:
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	add	QWORD PTR [rbp-8], rax
	sal	QWORD PTR [rbp-8]
	add	DWORD PTR [rbp-12], 1
.L24:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	mov	edx, DWORD PTR [rbp-12]
	cmp	edx, eax
	jb	.L25
	mov	rax, QWORD PTR [rbp-8]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	sstr_toLong, .-sstr_toLong
	.globl	sstr_truncate
	.type	sstr_truncate, @function
sstr_truncate:
.LFB15:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	DWORD PTR [rbp-12], esi
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rbp-12]
	mov	DWORD PTR [rax], edx
	jmp	.L28
.L29:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], edx
.L28:
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+4]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	jb	.L29
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	sstr_truncate, .-sstr_truncate
	.globl	sstr_appends
	.type	sstr_appends, @function
sstr_appends:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	mov	DWORD PTR [rbp-20], edx
.L31:
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+4]
	mov	rax, QWORD PTR [rbp-8]
	mov	ecx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-20]
	add	eax, ecx
	cmp	edx, eax
	jnb	.L32
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+8], rax
	jmp	.L31
.L32:
	mov	edx, DWORD PTR [rbp-20]
	mov	rax, QWORD PTR [rbp-8]
	mov	rcx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	mov	eax, eax
	add	rcx, rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rsi, rax
	mov	rdi, rcx
	call	memcpy
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-20]
	add	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	sstr_appends, .-sstr_appends
	.globl	sstr_equals
	.type	sstr_equals, @function
sstr_equals:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	DWORD PTR [rbp-36], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR [rbp-36], eax
	je	.L34
	mov	eax, 0
	jmp	.L35
.L34:
	mov	DWORD PTR [rbp-4], 0
	jmp	.L36
.L38:
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-4]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	ecx, DWORD PTR [rbp-4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L37
	mov	eax, 0
	jmp	.L35
.L37:
	add	DWORD PTR [rbp-4], 1
.L36:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-36]
	jb	.L38
	mov	eax, 1
.L35:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	sstr_equals, .-sstr_equals
	.globl	sstr_equals_mo
	.type	sstr_equals_mo, @function
sstr_equals_mo:
.LFB18:
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
	je	.L40
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L40:
	mov	eax, esi
	mov	BYTE PTR [rbp-236], al
	mov	DWORD PTR [rbp-224], 16
	mov	DWORD PTR [rbp-220], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-216], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-208], rax
	mov	DWORD PTR [rbp-180], 0
	mov	DWORD PTR [rbp-188], 0
.L41:
	movsx	eax, BYTE PTR [rbp-236]
	cmp	DWORD PTR [rbp-180], eax
	jnb	.L42
	add	DWORD PTR [rbp-180], 1
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L43
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L44
.L43:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L44:
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-200], rax
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L45
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L46
.L45:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L46:
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-188], eax
	mov	rax, QWORD PTR [rbp-232]
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR [rbp-188], eax
	je	.L47
	jmp	.L41
.L47:
	mov	DWORD PTR [rbp-184], 0
	jmp	.L48
.L50:
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-184]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	ecx, DWORD PTR [rbp-184]
	mov	rax, QWORD PTR [rbp-200]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L49
	jmp	.L41
.L49:
	add	DWORD PTR [rbp-184], 1
.L48:
	mov	eax, DWORD PTR [rbp-184]
	cmp	eax, DWORD PTR [rbp-188]
	jb	.L50
	mov	eax, DWORD PTR [rbp-184]
	jmp	.L52
.L42:
	mov	eax, -1
.L52:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	sstr_equals_mo, .-sstr_equals_mo
	.globl	sstr_cstr_equals_mo
	.type	sstr_cstr_equals_mo, @function
sstr_cstr_equals_mo:
.LFB19:
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
	je	.L54
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L54:
	mov	eax, esi
	mov	BYTE PTR [rbp-236], al
	mov	DWORD PTR [rbp-224], 16
	mov	DWORD PTR [rbp-220], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-216], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-208], rax
	mov	BYTE PTR [rbp-185], 0
	jmp	.L55
.L66:
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rbp-184], rax
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L56
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L57
.L56:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L57:
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-200], rax
	jmp	.L58
.L62:
	mov	rax, QWORD PTR [rbp-200]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L69
	mov	rax, QWORD PTR [rbp-184]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-200]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L70
	add	QWORD PTR [rbp-184], 1
	add	QWORD PTR [rbp-200], 1
.L58:
	mov	rax, QWORD PTR [rbp-184]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L62
	mov	rax, QWORD PTR [rbp-200]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L63
	jmp	.L60
.L69:
	nop
	jmp	.L68
.L70:
	nop
.L60:
	jmp	.L68
.L63:
	movzx	eax, BYTE PTR [rbp-185]
	jmp	.L67
.L68:
	add	BYTE PTR [rbp-185], 1
.L55:
	movzx	eax, BYTE PTR [rbp-185]
	cmp	al, BYTE PTR [rbp-236]
	jb	.L66
	mov	eax, -1
.L67:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	sstr_cstr_equals_mo, .-sstr_cstr_equals_mo
	.globl	sstr_endswith
	.type	sstr_endswith, @function
sstr_endswith:
.LFB20:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	DWORD PTR [rbp-36], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-36]
	jnb	.L72
	mov	eax, 0
	jmp	.L73
.L72:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	sub	eax, DWORD PTR [rbp-36]
	mov	DWORD PTR [rbp-8], eax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L74
.L76:
	mov	edx, DWORD PTR [rbp-4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	esi, DWORD PTR [rbp-8]
	mov	ecx, DWORD PTR [rbp-4]
	add	rcx, rsi
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L75
	mov	eax, 0
	jmp	.L73
.L75:
	add	DWORD PTR [rbp-4], 1
.L74:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-36]
	jb	.L76
	mov	eax, 1
.L73:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	sstr_endswith, .-sstr_endswith
	.globl	sstr_startswith
	.type	sstr_startswith, @function
sstr_startswith:
.LFB21:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	DWORD PTR [rbp-36], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-36]
	jnb	.L78
	mov	eax, 0
	jmp	.L79
.L78:
	mov	DWORD PTR [rbp-4], 0
	jmp	.L80
.L82:
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-4]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	ecx, DWORD PTR [rbp-4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L81
	mov	eax, 0
	jmp	.L79
.L81:
	add	DWORD PTR [rbp-4], 1
.L80:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-36]
	jb	.L82
	mov	eax, 1
.L79:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	sstr_startswith, .-sstr_startswith
	.type	sstr_smallerth, @function
sstr_smallerth:
.LFB22:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	rax, QWORD PTR [rbp-32]
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	cmovnb	eax, edx
	mov	DWORD PTR [rbp-8], eax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L84
.L88:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+8]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jle	.L85
	mov	eax, 0
	jmp	.L86
.L85:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+8]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jge	.L87
	mov	eax, 1
	jmp	.L86
.L87:
	add	DWORD PTR [rbp-4], 1
.L84:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-8]
	jl	.L88
	mov	eax, 0
.L86:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	sstr_smallerth, .-sstr_smallerth
	.globl	sstr_smaller
	.type	sstr_smaller, @function
sstr_smaller:
.LFB23:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	mov	rdx, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rdx
	mov	rdi, rax
	call	sstr_smallerth
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	sstr_smaller, .-sstr_smaller
	.globl	sstr_bigger
	.type	sstr_bigger, @function
sstr_bigger:
.LFB24:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	mov	rdx, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	sstr_smallerth
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	sstr_bigger, .-sstr_bigger
	.globl	sstr_delete
	.type	sstr_delete, @function
sstr_delete:
.LFB25:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	sstr_delete, .-sstr_delete
	.type	sstr_remove, @function
sstr_remove:
.LFB26:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	DWORD PTR [rbp-12], esi
	mov	DWORD PTR [rbp-16], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	sub	eax, DWORD PTR [rbp-16]
	mov	esi, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-16]
	lea	rcx, [rdx+rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-12]
	add	rax, rdx
	mov	rdx, rsi
	mov	rsi, rcx
	mov	rdi, rax
	call	memmove
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-12]
	sub	eax, DWORD PTR [rbp-16]
	add	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	sstr_remove, .-sstr_remove
	.type	sstr_removeAll, @function
sstr_removeAll:
.LFB27:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	DWORD PTR [rbp-36], edx
	mov	DWORD PTR [rbp-4], 0
.L96:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	sub	eax, DWORD PTR [rbp-36]
	mov	DWORD PTR [rbp-12], eax
	mov	DWORD PTR [rbp-8], 0
	jmp	.L97
.L100:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	ecx, DWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rbp-4]
	movsx	rdx, edx
	add	rdx, rcx
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	ecx, DWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L102
	add	DWORD PTR [rbp-8], 1
.L97:
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-36]
	jb	.L100
	mov	edx, DWORD PTR [rbp-4]
	mov	eax, DWORD PTR [rbp-36]
	add	edx, eax
	mov	ecx, DWORD PTR [rbp-4]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	sstr_remove
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	mov	edx, DWORD PTR [rbp-4]
	cmp	edx, eax
	jnb	.L103
	jmp	.L96
.L102:
	nop
	jmp	.L99
.L103:
	nop
.L99:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-12]
	jge	.L104
	add	DWORD PTR [rbp-4], 1
	jmp	.L96
.L104:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	sstr_removeAll, .-sstr_removeAll
	.globl	sstr_replaceAll
	.type	sstr_replaceAll, @function
sstr_replaceAll:
.LFB28:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	DWORD PTR [rbp-36], edx
	mov	QWORD PTR [rbp-48], rcx
	mov	DWORD PTR [rbp-40], r8d
	cmp	DWORD PTR [rbp-40], 0
	jne	.L106
	mov	edx, DWORD PTR [rbp-36]
	mov	rcx, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_removeAll
	jmp	.L105
.L106:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	sub	eax, DWORD PTR [rbp-36]
	mov	DWORD PTR [rbp-4], eax
	mov	DWORD PTR [rbp-8], 0
.L108:
	mov	DWORD PTR [rbp-12], 0
	jmp	.L109
.L112:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-12]
	movsx	rcx, edx
	mov	edx, DWORD PTR [rbp-8]
	movsx	rdx, edx
	add	rdx, rcx
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	eax, DWORD PTR [rbp-12]
	movsx	rcx, eax
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L113
	add	DWORD PTR [rbp-12], 1
.L109:
	mov	eax, DWORD PTR [rbp-12]
	cmp	eax, DWORD PTR [rbp-36]
	jb	.L112
	mov	edx, DWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rbp-36]
	add	edx, eax
	mov	ecx, DWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	sstr_remove
	mov	esi, DWORD PTR [rbp-8]
	mov	ecx, DWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rbp-48]
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	sstr_insert
	mov	eax, DWORD PTR [rbp-40]
	add	DWORD PTR [rbp-4], eax
	mov	edx, DWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rbp-40]
	add	eax, edx
	sub	eax, 1
	mov	DWORD PTR [rbp-8], eax
	jmp	.L111
.L113:
	nop
.L111:
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-4]
	jnb	.L105
	add	DWORD PTR [rbp-8], 1
	jmp	.L108
.L105:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	sstr_replaceAll, .-sstr_replaceAll
	.globl	sstr_print
	.type	sstr_print, @function
sstr_print:
.LFB29:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rdx, QWORD PTR stdout[rip]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rcx, rdx
	mov	edx, 1
	mov	rdi, rax
	call	fwrite
	mov	edi, 10
	call	putchar
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	sstr_print, .-sstr_print
	.globl	sstr_printf
	.type	sstr_printf, @function
sstr_printf:
.LFB30:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rdx, QWORD PTR stdout[rip]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rcx, rdx
	mov	edx, 1
	mov	rdi, rax
	call	fwrite
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	sstr_printf, .-sstr_printf
	.type	sstr_insert, @function
sstr_insert:
.LFB31:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-8], rdi
	mov	DWORD PTR [rbp-12], esi
	mov	QWORD PTR [rbp-24], rdx
	mov	DWORD PTR [rbp-16], ecx
.L117:
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+4]
	mov	rax, QWORD PTR [rbp-8]
	mov	ecx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-16]
	add	eax, ecx
	cmp	edx, eax
	jnb	.L118
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+4]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+8], rax
	jmp	.L117
.L118:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	sub	eax, DWORD PTR [rbp-12]
	mov	edi, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-12]
	lea	rcx, [rdx+rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	esi, DWORD PTR [rbp-12]
	mov	edx, DWORD PTR [rbp-16]
	add	rdx, rsi
	add	rax, rdx
	mov	rdx, rdi
	mov	rsi, rcx
	mov	rdi, rax
	call	memmove
	mov	edx, DWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rbp-8]
	mov	rcx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-12]
	add	rcx, rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, rax
	mov	rdi, rcx
	call	memcpy
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-16]
	add	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	sstr_insert, .-sstr_insert
	.globl	sstr_write
	.type	sstr_write, @function
sstr_write:
.LFB32:
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
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rcx, rdx
	mov	edx, 1
	mov	rdi, rax
	call	fwrite
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	sstr_write, .-sstr_write
	.section	.rodata
.LC2:
	.string	"%u"
.LC3:
	.string	""
	.text
	.globl	printBits
	.type	printBits, @function
printBits:
.LFB33:
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
	mov	rax, QWORD PTR [rbp-40]
	sub	eax, 1
	mov	DWORD PTR [rbp-4], eax
	jmp	.L121
.L124:
	mov	DWORD PTR [rbp-8], 7
	jmp	.L122
.L123:
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	eax, DWORD PTR [rbp-8]
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	mov	BYTE PTR [rbp-17], al
	movzx	eax, BYTE PTR [rbp-17]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC2
	mov	eax, 0
	call	printf
	sub	DWORD PTR [rbp-8], 1
.L122:
	cmp	DWORD PTR [rbp-8], 0
	jns	.L123
	sub	DWORD PTR [rbp-4], 1
.L121:
	cmp	DWORD PTR [rbp-4], 0
	jns	.L124
	mov	edi, OFFSET FLAT:.LC3
	call	puts
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	printBits, .-printBits
	.globl	sstr_appendh
	.type	sstr_appendh, @function
sstr_appendh:
.LFB34:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	eax, 16
	sub	rax, 1
	add	rax, 72
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-16], rax
	mov	BYTE PTR [rbp-1], 0
	jmp	.L126
.L127:
	mov	rax, QWORD PTR [rbp-32]
	and	eax, 15
	mov	rcx, rax
	movzx	eax, BYTE PTR [rbp-1]
	mov	edx, 63
	sub	edx, eax
	movsx	rdx, edx
	mov	rax, QWORD PTR [rbp-16]
	add	rdx, rax
	movzx	eax, BYTE PTR HEX[rcx]
	mov	BYTE PTR [rdx], al
	shr	QWORD PTR [rbp-32], 4
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, 1
	mov	BYTE PTR [rbp-1], al
.L126:
	cmp	QWORD PTR [rbp-32], 0
	jne	.L127
	movzx	edx, BYTE PTR [rbp-1]
	movzx	eax, BYTE PTR [rbp-1]
	mov	ecx, 64
	sub	ecx, eax
	movsx	rcx, ecx
	mov	rax, QWORD PTR [rbp-16]
	add	rcx, rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	sstr_appendh, .-sstr_appendh
	.globl	sstr_appendd
	.type	sstr_appendd, @function
sstr_appendd:
.LFB35:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	cmp	QWORD PTR [rbp-32], 0
	jne	.L129
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, 48
	mov	rdi, rax
	call	sstr_appendc
	jmp	.L128
.L129:
	mov	eax, 16
	sub	rax, 1
	add	rax, 72
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-32], 0
	jns	.L131
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, 45
	mov	rdi, rax
	call	sstr_appendc
	neg	QWORD PTR [rbp-32]
.L131:
	mov	BYTE PTR [rbp-1], 0
	jmp	.L132
.L133:
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
	mov	eax, edx
	lea	ecx, [rax+48]
	movzx	eax, BYTE PTR [rbp-1]
	mov	edx, 63
	sub	edx, eax
	movsx	rdx, edx
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
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
	movzx	eax, BYTE PTR [rbp-1]
	add	eax, 1
	mov	BYTE PTR [rbp-1], al
.L132:
	cmp	QWORD PTR [rbp-32], 0
	jne	.L133
	movzx	edx, BYTE PTR [rbp-1]
	movzx	eax, BYTE PTR [rbp-1]
	mov	ecx, 64
	sub	ecx, eax
	movsx	rcx, ecx
	mov	rax, QWORD PTR [rbp-16]
	add	rcx, rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
.L128:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	sstr_appendd, .-sstr_appendd
	.globl	sstr_clear
	.type	sstr_clear, @function
sstr_clear:
.LFB36:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], 0
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	sstr_clear, .-sstr_clear
	.globl	sstr_fill
	.type	sstr_fill, @function
sstr_fill:
.LFB37:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	eax, esi
	mov	DWORD PTR [rbp-32], edx
	mov	BYTE PTR [rbp-28], al
	mov	rax, QWORD PTR [rbp-24]
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-32]
	add	eax, edx
	mov	DWORD PTR [rbp-4], eax
.L136:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+4]
	cmp	eax, DWORD PTR [rbp-4]
	jnb	.L138
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+4]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+4]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx+8], rax
	jmp	.L136
.L139:
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	mov	eax, eax
	add	rdx, rax
	movzx	eax, BYTE PTR [rbp-28]
	mov	BYTE PTR [rdx], al
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rax], edx
.L138:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-4]
	jb	.L139
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	sstr_fill, .-sstr_fill
	.globl	sstr_removeFromEndAfter
	.type	sstr_removeFromEndAfter, @function
sstr_removeFromEndAfter:
.LFB38:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	eax, esi
	mov	BYTE PTR [rbp-12], al
	jmp	.L141
.L143:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	lea	edx, [rax-1]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
.L141:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	je	.L142
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	mov	eax, eax
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	BYTE PTR [rbp-12], al
	jne	.L143
.L142:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	sstr_removeFromEndAfter, .-sstr_removeFromEndAfter
	.globl	sstr_removeFromEnd
	.type	sstr_removeFromEnd, @function
sstr_removeFromEnd:
.LFB39:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	DWORD PTR [rbp-12], esi
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	sub	eax, DWORD PTR [rbp-12]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], edx
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	sstr_removeFromEnd, .-sstr_removeFromEnd
	.globl	sstr_appendformat
	.type	sstr_appendformat, @function
sstr_appendformat:
.LFB40:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 224
	mov	QWORD PTR [rbp-216], rdi
	mov	QWORD PTR [rbp-224], rsi
	mov	QWORD PTR [rbp-160], rdx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L170
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L170:
	mov	DWORD PTR [rbp-208], 16
	mov	DWORD PTR [rbp-204], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-200], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-192], rax
	mov	eax, 16
	sub	rax, 1
	add	rax, 50
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-184], rax
	jmp	.L147
.L169:
	mov	rax, QWORD PTR [rbp-224]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 37
	je	.L148
	mov	rax, QWORD PTR [rbp-224]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-216]
	mov	esi, edx
	mov	rdi, rax
	call	sstr_appendc
	jmp	.L149
.L148:
	add	QWORD PTR [rbp-224], 1
	mov	rax, QWORD PTR [rbp-224]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	sub	eax, 102
	cmp	eax, 18
	ja	.L171
	mov	eax, eax
	mov	rax, QWORD PTR .L152[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L152:
	.quad	.L156
	.quad	.L171
	.quad	.L171
	.quad	.L155
	.quad	.L171
	.quad	.L171
	.quad	.L154
	.quad	.L171
	.quad	.L171
	.quad	.L171
	.quad	.L171
	.quad	.L171
	.quad	.L171
	.quad	.L153
	.quad	.L171
	.quad	.L171
	.quad	.L171
	.quad	.L171
	.quad	.L151
	.text
.L155:
	mov	eax, DWORD PTR [rbp-208]
	cmp	eax, 47
	ja	.L157
	mov	rax, QWORD PTR [rbp-192]
	mov	edx, DWORD PTR [rbp-208]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-208]
	add	edx, 8
	mov	DWORD PTR [rbp-208], edx
	jmp	.L158
.L157:
	mov	rax, QWORD PTR [rbp-200]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-200], rdx
.L158:
	mov	eax, DWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-184]
	mov	rsi, rdx
	mov	edi, eax
	call	convert_IntToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-184]
	mov	rax, QWORD PTR [rbp-216]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L149
.L154:
	mov	eax, DWORD PTR [rbp-208]
	cmp	eax, 47
	ja	.L159
	mov	rax, QWORD PTR [rbp-192]
	mov	edx, DWORD PTR [rbp-208]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-208]
	add	edx, 8
	mov	DWORD PTR [rbp-208], edx
	jmp	.L160
.L159:
	mov	rax, QWORD PTR [rbp-200]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-200], rdx
.L160:
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-184]
	mov	rsi, rdx
	mov	rdi, rax
	call	convert_LongToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-184]
	mov	rax, QWORD PTR [rbp-216]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L149
.L156:
	mov	eax, DWORD PTR [rbp-204]
	cmp	eax, 175
	ja	.L161
	mov	rax, QWORD PTR [rbp-192]
	mov	edx, DWORD PTR [rbp-204]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-204]
	add	edx, 16
	mov	DWORD PTR [rbp-204], edx
	jmp	.L162
.L161:
	mov	rax, QWORD PTR [rbp-200]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-200], rdx
.L162:
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-184]
	mov	rdi, rdx
	movq	xmm0, rax
	call	convert_DoubleToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-184]
	mov	rax, QWORD PTR [rbp-216]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L149
.L153:
	mov	eax, DWORD PTR [rbp-208]
	cmp	eax, 47
	ja	.L163
	mov	rax, QWORD PTR [rbp-192]
	mov	edx, DWORD PTR [rbp-208]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-208]
	add	edx, 8
	mov	DWORD PTR [rbp-208], edx
	jmp	.L164
.L163:
	mov	rax, QWORD PTR [rbp-200]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-200], rdx
.L164:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-216]
	mov	rsi, rdx
	mov	rdi, rax
	call	sstr_appendcs
	jmp	.L149
.L151:
	mov	eax, DWORD PTR [rbp-208]
	cmp	eax, 47
	ja	.L165
	mov	rax, QWORD PTR [rbp-192]
	mov	edx, DWORD PTR [rbp-208]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-208]
	add	edx, 8
	mov	DWORD PTR [rbp-208], edx
	jmp	.L166
.L165:
	mov	rax, QWORD PTR [rbp-200]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-200], rdx
.L166:
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-208]
	cmp	eax, 47
	ja	.L167
	mov	rax, QWORD PTR [rbp-192]
	mov	ecx, DWORD PTR [rbp-208]
	mov	ecx, ecx
	add	rax, rcx
	mov	ecx, DWORD PTR [rbp-208]
	add	ecx, 8
	mov	DWORD PTR [rbp-208], ecx
	jmp	.L168
.L167:
	mov	rax, QWORD PTR [rbp-200]
	lea	rcx, [rax+8]
	mov	QWORD PTR [rbp-200], rcx
.L168:
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-216]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L149
.L171:
	nop
.L149:
	add	QWORD PTR [rbp-224], 1
.L147:
	mov	rax, QWORD PTR [rbp-224]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L169
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	sstr_appendformat, .-sstr_appendformat
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
