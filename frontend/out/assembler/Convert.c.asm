	.file	"Convert.c"
	.intel_syntax noprefix
	.text
	.globl	convert_getType
	.type	convert_getType, @function
convert_getType:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-8], 0
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L2
	add	QWORD PTR [rbp-24], 1
.L2:
	mov	DWORD PTR [rbp-4], 0
	jmp	.L3
.L8:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 46
	je	.L4
	cmp	eax, 46
	jl	.L5
	sub	eax, 48
	cmp	eax, 9
	ja	.L5
	jmp	.L10
.L4:
	mov	eax, 2
	jmp	.L7
.L5:
	mov	eax, 3
	jmp	.L7
.L10:
	add	DWORD PTR [rbp-4], 1
	add	QWORD PTR [rbp-24], 1
.L3:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L8
	cmp	DWORD PTR [rbp-8], 0
	jne	.L9
	cmp	DWORD PTR [rbp-4], 11
	jle	.L9
	mov	eax, 1
	jmp	.L7
.L9:
	mov	eax, 0
.L7:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	convert_getType, .-convert_getType
	.globl	convert_LongToCStr
	.type	convert_LongToCStr, @function
convert_LongToCStr:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	eax, 16
	sub	rax, 1
	add	rax, 20
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rbp-24], rax
	cmp	QWORD PTR [rbp-40], 0
	jns	.L12
	mov	BYTE PTR [rbp-9], 1
	neg	QWORD PTR [rbp-40]
	jmp	.L15
.L12:
	cmp	QWORD PTR [rbp-40], 0
	jne	.L15
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], 48
	mov	eax, 1
	jmp	.L14
.L16:
	mov	rcx, QWORD PTR [rbp-40]
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
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-8], 1
	mov	rcx, QWORD PTR [rbp-40]
	movabs	rdx, 7378697629483820647
	mov	rax, rcx
	imul	rdx
	mov	rax, rdx
	sar	rax, 2
	sar	rcx, 63
	mov	rdx, rcx
	sub	rax, rdx
	mov	QWORD PTR [rbp-40], rax
.L15:
	cmp	QWORD PTR [rbp-40], 0
	jne	.L16
	cmp	BYTE PTR [rbp-9], 0
	je	.L17
	mov	rax, QWORD PTR [rbp-8]
	mov	BYTE PTR [rax], 45
	add	QWORD PTR [rbp-8], 1
.L17:
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rbp-28], eax
	sub	QWORD PTR [rbp-8], 1
	jmp	.L18
.L19:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], dl
	sub	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-48], 1
.L18:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-24]
	jnb	.L19
	mov	eax, DWORD PTR [rbp-28]
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	convert_LongToCStr, .-convert_LongToCStr
	.globl	convert_ULongToCStr
	.type	convert_ULongToCStr, @function
convert_ULongToCStr:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	eax, 16
	sub	rax, 1
	add	rax, 19
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-40], 0
	jne	.L23
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], 48
	mov	eax, 1
	jmp	.L22
.L24:
	mov	rcx, QWORD PTR [rbp-40]
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
	mov	eax, edx
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-8], 1
	mov	rax, QWORD PTR [rbp-40]
	movabs	rdx, -3689348814741910323
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	QWORD PTR [rbp-40], rax
.L23:
	cmp	QWORD PTR [rbp-40], 0
	jne	.L24
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rbp-20], eax
	sub	QWORD PTR [rbp-8], 1
	jmp	.L25
.L26:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], dl
	sub	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-48], 1
.L25:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-16]
	jnb	.L26
	mov	eax, DWORD PTR [rbp-20]
.L22:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	convert_ULongToCStr, .-convert_ULongToCStr
	.globl	convert_IntToCStr
	.type	convert_IntToCStr, @function
convert_IntToCStr:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	DWORD PTR [rbp-36], edi
	mov	QWORD PTR [rbp-48], rsi
	mov	eax, 16
	sub	rax, 1
	add	rax, 20
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rbp-24], rax
	mov	BYTE PTR [rbp-9], 0
	cmp	DWORD PTR [rbp-36], 0
	jns	.L28
	mov	BYTE PTR [rbp-9], 1
	neg	DWORD PTR [rbp-36]
	jmp	.L31
.L28:
	cmp	DWORD PTR [rbp-36], 0
	jne	.L31
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], 48
	mov	eax, 1
	jmp	.L30
.L32:
	mov	edx, DWORD PTR [rbp-36]
	movsx	rax, edx
	imul	rax, rax, 1717986919
	shr	rax, 32
	mov	ecx, eax
	sar	ecx, 2
	mov	eax, edx
	sar	eax, 31
	sub	ecx, eax
	mov	eax, ecx
	sal	eax, 2
	add	eax, ecx
	add	eax, eax
	mov	ecx, edx
	sub	ecx, eax
	mov	eax, ecx
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-8], 1
	mov	eax, DWORD PTR [rbp-36]
	movsx	rdx, eax
	imul	rdx, rdx, 1717986919
	shr	rdx, 32
	mov	ecx, edx
	sar	ecx, 2
	cdq
	mov	eax, ecx
	sub	eax, edx
	mov	DWORD PTR [rbp-36], eax
.L31:
	cmp	DWORD PTR [rbp-36], 0
	jne	.L32
	cmp	BYTE PTR [rbp-9], 0
	je	.L33
	mov	rax, QWORD PTR [rbp-8]
	mov	BYTE PTR [rax], 45
	add	QWORD PTR [rbp-8], 1
.L33:
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rbp-28], eax
	sub	QWORD PTR [rbp-8], 1
	jmp	.L34
.L35:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], dl
	sub	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-48], 1
.L34:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-24]
	jnb	.L35
	mov	eax, DWORD PTR [rbp-28]
.L30:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	convert_IntToCStr, .-convert_IntToCStr
	.globl	convert_UIntToCStr
	.type	convert_UIntToCStr, @function
convert_UIntToCStr:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	DWORD PTR [rbp-36], edi
	mov	QWORD PTR [rbp-48], rsi
	mov	eax, 16
	sub	rax, 1
	add	rax, 19
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rbp-16], rax
	cmp	DWORD PTR [rbp-36], 0
	jne	.L39
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], 48
	mov	eax, 1
	jmp	.L38
.L40:
	mov	ecx, DWORD PTR [rbp-36]
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
	mov	eax, edx
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-8]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-8], 1
	mov	eax, DWORD PTR [rbp-36]
	mov	edx, eax
	mov	eax, 3435973837
	imul	rax, rdx
	shr	rax, 32
	shr	eax, 3
	mov	DWORD PTR [rbp-36], eax
.L39:
	cmp	DWORD PTR [rbp-36], 0
	jne	.L40
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rbp-20], eax
	sub	QWORD PTR [rbp-8], 1
	jmp	.L41
.L42:
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	BYTE PTR [rax], dl
	sub	QWORD PTR [rbp-8], 1
	add	QWORD PTR [rbp-48], 1
.L41:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-16]
	jnb	.L42
	mov	eax, DWORD PTR [rbp-20]
.L38:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	convert_UIntToCStr, .-convert_UIntToCStr
	.globl	convert_CStrToUInt
	.type	convert_CStrToUInt, @function
convert_CStrToUInt:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-4], 0
	jmp	.L44
.L45:
	mov	edx, DWORD PTR [rbp-4]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	add	eax, edx
	sub	eax, 48
	mov	DWORD PTR [rbp-4], eax
	add	QWORD PTR [rbp-24], 1
.L44:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L45
	mov	eax, DWORD PTR [rbp-4]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	convert_CStrToUInt, .-convert_CStrToUInt
	.globl	convert_CStrToInt
	.type	convert_CStrToInt, @function
convert_CStrToInt:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L48
	add	QWORD PTR [rbp-24], 1
	mov	BYTE PTR [rbp-1], 1
	jmp	.L49
.L48:
	mov	BYTE PTR [rbp-1], 0
.L49:
	mov	DWORD PTR [rbp-8], 0
	jmp	.L50
.L51:
	mov	edx, DWORD PTR [rbp-8]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	add	eax, edx
	sub	eax, 48
	mov	DWORD PTR [rbp-8], eax
	add	QWORD PTR [rbp-24], 1
.L50:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L51
	cmp	BYTE PTR [rbp-1], 0
	je	.L52
	mov	eax, DWORD PTR [rbp-8]
	neg	eax
	jmp	.L53
.L52:
	mov	eax, DWORD PTR [rbp-8]
.L53:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	convert_CStrToInt, .-convert_CStrToInt
	.globl	convert_CStrToULong
	.type	convert_CStrToULong, @function
convert_CStrToULong:
.LFB13:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-8], 0
	jmp	.L55
.L56:
	mov	rdx, QWORD PTR [rbp-8]
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	add	rax, rdx
	sub	rax, 48
	mov	QWORD PTR [rbp-8], rax
	add	QWORD PTR [rbp-24], 1
.L55:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L56
	mov	rax, QWORD PTR [rbp-8]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	convert_CStrToULong, .-convert_CStrToULong
	.globl	convert_CStrToLong
	.type	convert_CStrToLong, @function
convert_CStrToLong:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	BYTE PTR [rbp-1], 0
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L59
	add	QWORD PTR [rbp-24], 1
	mov	BYTE PTR [rbp-1], 1
	jmp	.L60
.L59:
	mov	BYTE PTR [rbp-1], 0
.L60:
	mov	QWORD PTR [rbp-16], 0
	jmp	.L61
.L62:
	mov	rdx, QWORD PTR [rbp-16]
	mov	rax, rdx
	sal	rax, 2
	add	rax, rdx
	add	rax, rax
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	add	rax, rdx
	sub	rax, 48
	mov	QWORD PTR [rbp-16], rax
	add	QWORD PTR [rbp-24], 1
.L61:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L62
	cmp	BYTE PTR [rbp-1], 0
	je	.L63
	mov	rax, QWORD PTR [rbp-16]
	neg	rax
	jmp	.L64
.L63:
	mov	rax, QWORD PTR [rbp-16]
.L64:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	convert_CStrToLong, .-convert_CStrToLong
	.globl	convert_CStrToFloat
	.type	convert_CStrToFloat, @function
convert_CStrToFloat:
.LFB15:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	BYTE PTR [rbp-1], 0
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L66
	add	QWORD PTR [rbp-24], 1
	mov	BYTE PTR [rbp-1], 1
	jmp	.L67
.L66:
	mov	BYTE PTR [rbp-1], 0
.L67:
	pxor	xmm0, xmm0
	movss	DWORD PTR [rbp-8], xmm0
	jmp	.L68
.L72:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L69
	cmp	BYTE PTR [rbp-1], 0
	je	.L70
	movss	xmm0, DWORD PTR [rbp-8]
	movss	xmm1, DWORD PTR .LC1[rip]
	xorps	xmm0, xmm1
	jmp	.L71
.L70:
	movss	xmm0, DWORD PTR [rbp-8]
	jmp	.L71
.L69:
	movss	xmm1, DWORD PTR [rbp-8]
	movss	xmm0, DWORD PTR .LC2[rip]
	mulss	xmm1, xmm0
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, eax
	addss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm0, xmm1
	movss	DWORD PTR [rbp-8], xmm0
	add	QWORD PTR [rbp-24], 1
.L68:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 46
	jne	.L72
	add	QWORD PTR [rbp-24], 1
	movss	xmm0, DWORD PTR .LC4[rip]
	movss	DWORD PTR [rbp-12], xmm0
	pxor	xmm0, xmm0
	movss	DWORD PTR [rbp-16], xmm0
	jmp	.L73
.L74:
	movss	xmm1, DWORD PTR [rbp-12]
	movss	xmm0, DWORD PTR .LC2[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rbp-12], xmm0
	movss	xmm1, DWORD PTR [rbp-16]
	movss	xmm0, DWORD PTR .LC2[rip]
	mulss	xmm1, xmm0
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, eax
	addss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm0, xmm1
	movss	DWORD PTR [rbp-16], xmm0
	add	QWORD PTR [rbp-24], 1
.L73:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L74
	cmp	BYTE PTR [rbp-1], 0
	je	.L75
	movss	xmm0, DWORD PTR [rbp-16]
	divss	xmm0, DWORD PTR [rbp-12]
	addss	xmm0, DWORD PTR [rbp-8]
	movss	xmm1, DWORD PTR .LC1[rip]
	xorps	xmm0, xmm1
	jmp	.L71
.L75:
	movss	xmm0, DWORD PTR [rbp-16]
	divss	xmm0, DWORD PTR [rbp-12]
	addss	xmm0, DWORD PTR [rbp-8]
.L71:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	convert_CStrToFloat, .-convert_CStrToFloat
	.globl	convert_CStrToDouble
	.type	convert_CStrToDouble, @function
convert_CStrToDouble:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-40], rdi
	mov	BYTE PTR [rbp-1], 0
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L77
	add	QWORD PTR [rbp-40], 1
	mov	BYTE PTR [rbp-1], 1
	jmp	.L78
.L77:
	mov	BYTE PTR [rbp-1], 0
.L78:
	pxor	xmm0, xmm0
	movsd	QWORD PTR [rbp-16], xmm0
	jmp	.L79
.L83:
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L80
	cmp	BYTE PTR [rbp-1], 0
	je	.L81
	movsd	xmm0, QWORD PTR [rbp-16]
	movq	xmm1, QWORD PTR .LC6[rip]
	xorpd	xmm0, xmm1
	jmp	.L82
.L81:
	movsd	xmm0, QWORD PTR [rbp-16]
	jmp	.L82
.L80:
	movsd	xmm1, QWORD PTR [rbp-16]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm1, xmm0
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC8[rip]
	subsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-16], xmm0
	add	QWORD PTR [rbp-40], 1
.L79:
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 46
	jne	.L83
	add	QWORD PTR [rbp-40], 1
	movsd	xmm0, QWORD PTR .LC9[rip]
	movsd	QWORD PTR [rbp-24], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR [rbp-32], xmm0
	jmp	.L84
.L85:
	movsd	xmm1, QWORD PTR [rbp-24]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-24], xmm0
	movsd	xmm1, QWORD PTR [rbp-32]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm1, xmm0
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC8[rip]
	subsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-32], xmm0
	add	QWORD PTR [rbp-40], 1
.L84:
	mov	rax, QWORD PTR [rbp-40]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L85
	cmp	BYTE PTR [rbp-1], 0
	je	.L86
	movsd	xmm0, QWORD PTR [rbp-32]
	divsd	xmm0, QWORD PTR [rbp-24]
	addsd	xmm0, QWORD PTR [rbp-16]
	movq	xmm1, QWORD PTR .LC6[rip]
	xorpd	xmm0, xmm1
	jmp	.L82
.L86:
	movsd	xmm0, QWORD PTR [rbp-32]
	divsd	xmm0, QWORD PTR [rbp-24]
	addsd	xmm0, QWORD PTR [rbp-16]
.L82:
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	convert_CStrToDouble, .-convert_CStrToDouble
	.globl	convert_FloatToCStr
	.type	convert_FloatToCStr, @function
convert_FloatToCStr:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	movss	DWORD PTR [rbp-52], xmm0
	mov	QWORD PTR [rbp-64], rdi
	mov	BYTE PTR [rbp-17], 0
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
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbp-40], rax
	pxor	xmm0, xmm0
	comiss	xmm0, DWORD PTR [rbp-52]
	jbe	.L88
	mov	BYTE PTR [rbp-17], 1
	movss	xmm0, DWORD PTR [rbp-52]
	movss	xmm1, DWORD PTR .LC1[rip]
	xorps	xmm0, xmm1
	movss	DWORD PTR [rbp-52], xmm0
	movss	xmm0, DWORD PTR [rbp-52]
	comiss	xmm0, DWORD PTR .LC10[rip]
	jbe	.L88
	mov	rax, QWORD PTR [rbp-64]
	movabs	rsi, 8388357179923392813
	mov	QWORD PTR [rax], rsi
	mov	WORD PTR [rax+8], 121
	mov	eax, 9
	jmp	.L91
.L88:
	movss	xmm0, DWORD PTR [rbp-52]
	comiss	xmm0, DWORD PTR .LC10[rip]
	jbe	.L114
	mov	rax, QWORD PTR [rbp-64]
	movabs	rdi, 8751735898823356009
	mov	QWORD PTR [rax], rdi
	mov	BYTE PTR [rax+8], 0
	mov	eax, 8
	jmp	.L91
.L114:
	movss	xmm0, DWORD PTR [rbp-52]
	comiss	xmm0, DWORD PTR .LC11[rip]
	jnb	.L94
	movss	xmm0, DWORD PTR [rbp-52]
	cvttss2si	rax, xmm0
	mov	QWORD PTR [rbp-8], rax
	jmp	.L95
.L94:
	movss	xmm0, DWORD PTR [rbp-52]
	movss	xmm1, DWORD PTR .LC11[rip]
	subss	xmm0, xmm1
	cvttss2si	rax, xmm0
	mov	QWORD PTR [rbp-8], rax
	movabs	rax, -9223372036854775808
	xor	QWORD PTR [rbp-8], rax
.L95:
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, 1
	test	rax, rax
	js	.L96
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rax
	jmp	.L97
.L96:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rdx
	addss	xmm0, xmm0
.L97:
	movss	xmm1, DWORD PTR [rbp-52]
	subss	xmm1, xmm0
	movss	DWORD PTR [rbp-52], xmm1
	movss	xmm1, DWORD PTR [rbp-52]
	movss	xmm0, DWORD PTR .LC12[rip]
	mulss	xmm0, xmm1
	movss	DWORD PTR [rbp-52], xmm0
	movss	xmm0, DWORD PTR [rbp-52]
	comiss	xmm0, DWORD PTR .LC11[rip]
	jnb	.L98
	movss	xmm0, DWORD PTR [rbp-52]
	cvttss2si	rax, xmm0
	mov	QWORD PTR [rbp-16], rax
	jmp	.L99
.L98:
	movss	xmm0, DWORD PTR [rbp-52]
	movss	xmm1, DWORD PTR .LC11[rip]
	subss	xmm0, xmm1
	cvttss2si	rax, xmm0
	mov	QWORD PTR [rbp-16], rax
	movabs	rax, -9223372036854775808
	xor	QWORD PTR [rbp-16], rax
.L99:
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	jne	.L102
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 48
	add	QWORD PTR [rbp-32], 1
	jmp	.L101
.L103:
	mov	rcx, QWORD PTR [rbp-16]
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
	mov	eax, edx
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-32], 1
	mov	rax, QWORD PTR [rbp-16]
	movabs	rdx, -3689348814741910323
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	QWORD PTR [rbp-16], rax
.L102:
	cmp	QWORD PTR [rbp-16], 1
	jne	.L103
.L101:
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 46
	add	QWORD PTR [rbp-32], 1
	cmp	QWORD PTR [rbp-8], 0
	jne	.L106
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 48
	add	QWORD PTR [rbp-32], 1
	jmp	.L105
.L107:
	mov	rcx, QWORD PTR [rbp-8]
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
	mov	eax, edx
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-32], 1
	mov	rax, QWORD PTR [rbp-8]
	movabs	rdx, -3689348814741910323
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	QWORD PTR [rbp-8], rax
.L106:
	cmp	QWORD PTR [rbp-8], 0
	jne	.L107
.L105:
	cmp	BYTE PTR [rbp-17], 0
	je	.L108
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 45
	add	QWORD PTR [rbp-32], 1
.L108:
	mov	rax, QWORD PTR [rbp-32]
	sub	rax, QWORD PTR [rbp-40]
	mov	DWORD PTR [rbp-44], eax
	sub	QWORD PTR [rbp-32], 1
	jmp	.L109
.L110:
	mov	rax, QWORD PTR [rbp-32]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-64]
	mov	BYTE PTR [rax], dl
	sub	QWORD PTR [rbp-32], 1
	add	QWORD PTR [rbp-64], 1
.L109:
	mov	rax, QWORD PTR [rbp-32]
	cmp	rax, QWORD PTR [rbp-40]
	jnb	.L110
	mov	eax, DWORD PTR [rbp-44]
.L91:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	convert_FloatToCStr, .-convert_FloatToCStr
	.globl	convert_DoubleToCStr
	.type	convert_DoubleToCStr, @function
convert_DoubleToCStr:
.LFB18:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	movsd	QWORD PTR [rbp-56], xmm0
	mov	QWORD PTR [rbp-64], rdi
	mov	BYTE PTR [rbp-17], 0
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
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rbp-40], rax
	pxor	xmm0, xmm0
	comisd	xmm0, QWORD PTR [rbp-56]
	jbe	.L116
	mov	BYTE PTR [rbp-17], 1
	movsd	xmm0, QWORD PTR [rbp-56]
	movq	xmm1, QWORD PTR .LC6[rip]
	xorpd	xmm0, xmm1
	movsd	QWORD PTR [rbp-56], xmm0
	movsd	xmm0, QWORD PTR [rbp-56]
	comisd	xmm0, QWORD PTR .LC13[rip]
	jbe	.L116
	mov	rax, QWORD PTR [rbp-64]
	movabs	rsi, 8388357179923392813
	mov	QWORD PTR [rax], rsi
	mov	WORD PTR [rax+8], 121
	mov	eax, 9
	jmp	.L119
.L116:
	movsd	xmm0, QWORD PTR [rbp-56]
	comisd	xmm0, QWORD PTR .LC13[rip]
	jbe	.L142
	mov	rax, QWORD PTR [rbp-64]
	movabs	rdi, 8751735898823356009
	mov	QWORD PTR [rax], rdi
	mov	BYTE PTR [rax+8], 0
	mov	eax, 8
	jmp	.L119
.L142:
	movsd	xmm0, QWORD PTR [rbp-56]
	comisd	xmm0, QWORD PTR .LC14[rip]
	jnb	.L122
	movsd	xmm0, QWORD PTR [rbp-56]
	cvttsd2si	rax, xmm0
	mov	QWORD PTR [rbp-8], rax
	jmp	.L123
.L122:
	movsd	xmm0, QWORD PTR [rbp-56]
	movsd	xmm1, QWORD PTR .LC14[rip]
	subsd	xmm0, xmm1
	cvttsd2si	rax, xmm0
	mov	QWORD PTR [rbp-8], rax
	movabs	rax, -9223372036854775808
	xor	QWORD PTR [rbp-8], rax
.L123:
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, 1
	test	rax, rax
	js	.L124
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	jmp	.L125
.L124:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L125:
	movsd	xmm1, QWORD PTR [rbp-56]
	subsd	xmm1, xmm0
	movsd	QWORD PTR [rbp-56], xmm1
	movsd	xmm1, QWORD PTR [rbp-56]
	movsd	xmm0, QWORD PTR .LC15[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-56], xmm0
	movsd	xmm0, QWORD PTR [rbp-56]
	comisd	xmm0, QWORD PTR .LC14[rip]
	jnb	.L126
	movsd	xmm0, QWORD PTR [rbp-56]
	cvttsd2si	rax, xmm0
	mov	QWORD PTR [rbp-16], rax
	jmp	.L127
.L126:
	movsd	xmm0, QWORD PTR [rbp-56]
	movsd	xmm1, QWORD PTR .LC14[rip]
	subsd	xmm0, xmm1
	cvttsd2si	rax, xmm0
	mov	QWORD PTR [rbp-16], rax
	movabs	rax, -9223372036854775808
	xor	QWORD PTR [rbp-16], rax
.L127:
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	jne	.L130
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 48
	add	QWORD PTR [rbp-32], 1
	jmp	.L129
.L131:
	mov	rcx, QWORD PTR [rbp-16]
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
	mov	eax, edx
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-32], 1
	mov	rax, QWORD PTR [rbp-16]
	movabs	rdx, -3689348814741910323
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	QWORD PTR [rbp-16], rax
.L130:
	cmp	QWORD PTR [rbp-16], 1
	jne	.L131
.L129:
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 46
	add	QWORD PTR [rbp-32], 1
	cmp	QWORD PTR [rbp-8], 0
	jne	.L134
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 48
	add	QWORD PTR [rbp-32], 1
	jmp	.L133
.L135:
	mov	rcx, QWORD PTR [rbp-8]
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
	mov	eax, edx
	add	eax, 48
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-32], 1
	mov	rax, QWORD PTR [rbp-8]
	movabs	rdx, -3689348814741910323
	mul	rdx
	mov	rax, rdx
	shr	rax, 3
	mov	QWORD PTR [rbp-8], rax
.L134:
	cmp	QWORD PTR [rbp-8], 0
	jne	.L135
.L133:
	cmp	BYTE PTR [rbp-17], 0
	je	.L136
	mov	rax, QWORD PTR [rbp-32]
	mov	BYTE PTR [rax], 45
	add	QWORD PTR [rbp-32], 1
.L136:
	mov	rax, QWORD PTR [rbp-32]
	sub	rax, QWORD PTR [rbp-40]
	mov	DWORD PTR [rbp-44], eax
	sub	QWORD PTR [rbp-32], 1
	jmp	.L137
.L138:
	mov	rax, QWORD PTR [rbp-32]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-64]
	mov	BYTE PTR [rax], dl
	sub	QWORD PTR [rbp-32], 1
	add	QWORD PTR [rbp-64], 1
.L137:
	mov	rax, QWORD PTR [rbp-32]
	cmp	rax, QWORD PTR [rbp-40]
	jnb	.L138
	mov	eax, DWORD PTR [rbp-44]
.L119:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	convert_DoubleToCStr, .-convert_DoubleToCStr
	.globl	convert_printf
	.type	convert_printf, @function
convert_printf:
.LFB19:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 240
	mov	QWORD PTR [rbp-232], rdi
	mov	QWORD PTR [rbp-168], rsi
	mov	QWORD PTR [rbp-160], rdx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L168
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L168:
	mov	eax, 16
	sub	rax, 1
	add	rax, 24
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
	mov	rax, QWORD PTR [rbp-184]
	mov	DWORD PTR [rax+4], 8
	mov	rax, QWORD PTR [rbp-184]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR [rbp-184]
	mov	eax, DWORD PTR [rax+4]
	mov	eax, eax
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-184]
	mov	QWORD PTR [rax+8], rdx
	mov	DWORD PTR [rbp-216], 8
	mov	DWORD PTR [rbp-212], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-208], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-200], rax
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
	mov	QWORD PTR [rbp-192], rax
	jmp	.L145
.L167:
	mov	rax, QWORD PTR [rbp-232]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 37
	je	.L146
	mov	rax, QWORD PTR [rbp-232]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-184]
	mov	esi, edx
	mov	rdi, rax
	call	sstr_appendc
	jmp	.L147
.L146:
	add	QWORD PTR [rbp-232], 1
	mov	rax, QWORD PTR [rbp-232]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	sub	eax, 102
	cmp	eax, 18
	ja	.L169
	mov	eax, eax
	mov	rax, QWORD PTR .L150[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L150:
	.quad	.L154
	.quad	.L169
	.quad	.L169
	.quad	.L153
	.quad	.L169
	.quad	.L169
	.quad	.L152
	.quad	.L169
	.quad	.L169
	.quad	.L169
	.quad	.L169
	.quad	.L169
	.quad	.L169
	.quad	.L151
	.quad	.L169
	.quad	.L169
	.quad	.L169
	.quad	.L169
	.quad	.L149
	.text
.L153:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L155
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L156
.L155:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L156:
	mov	eax, DWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-192]
	mov	rsi, rdx
	mov	edi, eax
	call	convert_IntToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-192]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L147
.L152:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L157
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L158
.L157:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L158:
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-192]
	mov	rsi, rdx
	mov	rdi, rax
	call	convert_LongToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-192]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L147
.L154:
	mov	eax, DWORD PTR [rbp-212]
	cmp	eax, 175
	ja	.L159
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-212]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-212]
	add	edx, 16
	mov	DWORD PTR [rbp-212], edx
	jmp	.L160
.L159:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L160:
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-192]
	mov	rdi, rdx
	movq	xmm0, rax
	call	convert_DoubleToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-192]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L147
.L151:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L161
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L162
.L161:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L162:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rdx
	mov	rdi, rax
	call	sstr_appendcs
	jmp	.L147
.L149:
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L163
	mov	rax, QWORD PTR [rbp-200]
	mov	edx, DWORD PTR [rbp-216]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-216]
	add	edx, 8
	mov	DWORD PTR [rbp-216], edx
	jmp	.L164
.L163:
	mov	rax, QWORD PTR [rbp-208]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-208], rdx
.L164:
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-216]
	cmp	eax, 47
	ja	.L165
	mov	rax, QWORD PTR [rbp-200]
	mov	ecx, DWORD PTR [rbp-216]
	mov	ecx, ecx
	add	rax, rcx
	mov	ecx, DWORD PTR [rbp-216]
	add	ecx, 8
	mov	DWORD PTR [rbp-216], ecx
	jmp	.L166
.L165:
	mov	rax, QWORD PTR [rbp-208]
	lea	rcx, [rax+8]
	mov	QWORD PTR [rbp-208], rcx
.L166:
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L147
.L169:
	nop
.L147:
	add	QWORD PTR [rbp-232], 1
.L145:
	mov	rax, QWORD PTR [rbp-232]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L167
	mov	rax, QWORD PTR [rbp-184]
	mov	rdi, rax
	call	sstr_printf
	mov	rax, QWORD PTR [rbp-184]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	convert_printf, .-convert_printf
	.globl	convert_dprintf
	.type	convert_dprintf, @function
convert_dprintf:
.LFB20:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 256
	mov	DWORD PTR [rbp-244], edi
	mov	QWORD PTR [rbp-256], rsi
	mov	QWORD PTR [rbp-160], rdx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L195
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L195:
	mov	eax, 16
	sub	rax, 1
	add	rax, 24
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
	mov	rax, QWORD PTR [rbp-184]
	mov	DWORD PTR [rax+4], 8
	mov	rax, QWORD PTR [rbp-184]
	mov	DWORD PTR [rax], 0
	mov	rax, QWORD PTR [rbp-184]
	mov	eax, DWORD PTR [rax+4]
	mov	eax, eax
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-184]
	mov	QWORD PTR [rax+8], rdx
	mov	DWORD PTR [rbp-232], 16
	mov	DWORD PTR [rbp-228], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-224], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-216], rax
	mov	eax, 16
	sub	rax, 1
	add	rax, 50
	mov	ecx, 16
	mov	edx, 0
	div	rcx
	imul	rax, rax, 16
	sub	rsp, rax
	mov	rax, rsp
	add	rax, 15
	shr	rax, 4
	sal	rax, 4
	mov	QWORD PTR [rbp-192], rax
	jmp	.L172
.L194:
	mov	rax, QWORD PTR [rbp-256]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 37
	je	.L173
	mov	rax, QWORD PTR [rbp-256]
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-184]
	mov	esi, edx
	mov	rdi, rax
	call	sstr_appendc
	jmp	.L174
.L173:
	add	QWORD PTR [rbp-256], 1
	mov	rax, QWORD PTR [rbp-256]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	sub	eax, 102
	cmp	eax, 18
	ja	.L196
	mov	eax, eax
	mov	rax, QWORD PTR .L177[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L177:
	.quad	.L181
	.quad	.L196
	.quad	.L196
	.quad	.L180
	.quad	.L196
	.quad	.L196
	.quad	.L179
	.quad	.L196
	.quad	.L196
	.quad	.L196
	.quad	.L196
	.quad	.L196
	.quad	.L196
	.quad	.L178
	.quad	.L196
	.quad	.L196
	.quad	.L196
	.quad	.L196
	.quad	.L176
	.text
.L180:
	mov	eax, DWORD PTR [rbp-232]
	cmp	eax, 47
	ja	.L182
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-232]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-232]
	add	edx, 8
	mov	DWORD PTR [rbp-232], edx
	jmp	.L183
.L182:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L183:
	mov	eax, DWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-192]
	mov	rsi, rdx
	mov	edi, eax
	call	convert_IntToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-192]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L174
.L179:
	mov	eax, DWORD PTR [rbp-232]
	cmp	eax, 47
	ja	.L184
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-232]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-232]
	add	edx, 8
	mov	DWORD PTR [rbp-232], edx
	jmp	.L185
.L184:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L185:
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-192]
	mov	rsi, rdx
	mov	rdi, rax
	call	convert_LongToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-192]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L174
.L181:
	mov	eax, DWORD PTR [rbp-228]
	cmp	eax, 175
	ja	.L186
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-228]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-228]
	add	edx, 16
	mov	DWORD PTR [rbp-228], edx
	jmp	.L187
.L186:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L187:
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-192]
	mov	rdi, rdx
	movq	xmm0, rax
	call	convert_DoubleToCStr
	mov	edx, eax
	mov	rcx, QWORD PTR [rbp-192]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L174
.L178:
	mov	eax, DWORD PTR [rbp-232]
	cmp	eax, 47
	ja	.L188
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-232]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-232]
	add	edx, 8
	mov	DWORD PTR [rbp-232], edx
	jmp	.L189
.L188:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L189:
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rdx
	mov	rdi, rax
	call	sstr_appendcs
	jmp	.L174
.L176:
	mov	eax, DWORD PTR [rbp-232]
	cmp	eax, 47
	ja	.L190
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-232]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-232]
	add	edx, 8
	mov	DWORD PTR [rbp-232], edx
	jmp	.L191
.L190:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L191:
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-200], rax
	mov	eax, DWORD PTR [rbp-232]
	cmp	eax, 47
	ja	.L192
	mov	rax, QWORD PTR [rbp-216]
	mov	edx, DWORD PTR [rbp-232]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-232]
	add	edx, 8
	mov	DWORD PTR [rbp-232], edx
	jmp	.L193
.L192:
	mov	rax, QWORD PTR [rbp-224]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-224], rdx
.L193:
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-204], eax
	mov	edx, DWORD PTR [rbp-204]
	mov	rcx, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rbp-184]
	mov	rsi, rcx
	mov	rdi, rax
	call	sstr_appends
	jmp	.L174
.L196:
	nop
.L174:
	add	QWORD PTR [rbp-256], 1
.L172:
	mov	rax, QWORD PTR [rbp-256]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L194
	mov	rax, QWORD PTR [rbp-184]
	mov	eax, DWORD PTR [rax]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-184]
	mov	rcx, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-244]
	mov	rsi, rcx
	mov	edi, eax
	call	write
	mov	rax, QWORD PTR [rbp-184]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	convert_dprintf, .-convert_dprintf
	.section	.rodata
	.align 16
.LC1:
	.long	-2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC2:
	.long	1092616192
	.align 4
.LC3:
	.long	1111490560
	.align 4
.LC4:
	.long	1065353216
	.align 16
.LC6:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC7:
	.long	0
	.long	1076101120
	.align 8
.LC8:
	.long	0
	.long	1078460416
	.align 8
.LC9:
	.long	0
	.long	1072693248
	.align 4
.LC10:
	.long	1602224128
	.align 4
.LC11:
	.long	1593835520
	.align 4
.LC12:
	.long	1120403456
	.align 8
.LC13:
	.long	0
	.long	1139802112
	.align 8
.LC14:
	.long	0
	.long	1138753536
	.align 8
.LC15:
	.long	0
	.long	1086556160
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
