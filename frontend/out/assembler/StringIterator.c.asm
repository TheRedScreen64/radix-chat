	.file	"StringIterator.c"
	.intel_syntax noprefix
	.text
	.globl	INFO
	.bss
	.align 16
	.type	INFO, @object
	.size	INFO, 16
INFO:
	.zero	16
	.text
	.globl	itr_geterr
	.type	itr_geterr, @function
itr_geterr:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, QWORD PTR INFO[rip]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	itr_geterr, .-itr_geterr
	.globl	charTable
	.bss
	.align 32
	.type	charTable, @object
	.size	charTable, 1024
charTable:
	.zero	1024
	.section	.rodata
.LC0:
	.string	"open"
.LC1:
	.string	"mmap"
	.text
	.globl	itr_loadFromLargeFile
	.type	itr_loadFromLargeFile, @function
itr_loadFromLargeFile:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 176
	mov	QWORD PTR [rbp-168], rdi
	mov	eax, 0
	call	itr_construct
	mov	edi, 40
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-168]
	mov	edx, 384
	mov	esi, 2
	mov	rdi, rax
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-12], eax
	cmp	DWORD PTR [rbp-12], -1
	jne	.L4
	mov	edi, OFFSET FLAT:.LC0
	call	perror
	mov	eax, 0
	jmp	.L7
.L4:
	lea	rdx, [rbp-160]
	mov	eax, DWORD PTR [rbp-12]
	mov	rsi, rdx
	mov	edi, eax
	call	fstat
	mov	rdx, QWORD PTR [rbp-112]
	mov	rax, QWORD PTR [rbp-8]
	add	rax, 32
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-8]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR [rbp-12]
	mov	r9d, 0
	mov	r8d, edx
	mov	ecx, 1
	mov	edx, 3
	mov	rsi, rax
	mov	edi, 0
	call	mmap
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L6
	mov	edi, OFFSET FLAT:.LC1
	call	perror
	mov	eax, 0
	jmp	.L7
.L6:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+24], 1
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-8]
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	itr_loadFromLargeFile, .-itr_loadFromLargeFile
	.globl	_itr_construct
	.type	_itr_construct, @function
_itr_construct:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	_itr_construct, .-_itr_construct
	.section	.rodata
.LC2:
	.string	"Success"
.LC3:
	.string	"None"
	.text
	.globl	__itr_construct
	.type	__itr_construct, @function
__itr_construct:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	BYTE PTR [rbp-1], 0
	jmp	.L10
.L20:
	cmp	BYTE PTR [rbp-1], 47
	jbe	.L11
	cmp	BYTE PTR [rbp-1], 57
	ja	.L11
	movzx	eax, BYTE PTR [rbp-1]
	cdqe
	mov	DWORD PTR charTable[0+rax*4], 4
	jmp	.L12
.L11:
	cmp	BYTE PTR [rbp-1], 96
	jbe	.L13
	cmp	BYTE PTR [rbp-1], 122
	jbe	.L14
.L13:
	cmp	BYTE PTR [rbp-1], 64
	jbe	.L15
	cmp	BYTE PTR [rbp-1], 90
	jbe	.L14
.L15:
	cmp	BYTE PTR [rbp-1], 95
	jne	.L16
.L14:
	movzx	eax, BYTE PTR [rbp-1]
	cdqe
	mov	DWORD PTR charTable[0+rax*4], 5
	jmp	.L12
.L16:
	cmp	BYTE PTR [rbp-1], 32
	je	.L17
	cmp	BYTE PTR [rbp-1], 9
	jne	.L18
.L17:
	movzx	eax, BYTE PTR [rbp-1]
	cdqe
	mov	DWORD PTR charTable[0+rax*4], 2
	jmp	.L12
.L18:
	cmp	BYTE PTR [rbp-1], 10
	jne	.L19
	movzx	eax, BYTE PTR [rbp-1]
	cdqe
	mov	DWORD PTR charTable[0+rax*4], 1
	jmp	.L12
.L19:
	movzx	eax, BYTE PTR [rbp-1]
	cdqe
	mov	DWORD PTR charTable[0+rax*4], 0
.L12:
	add	BYTE PTR [rbp-1], 1
.L10:
	cmp	BYTE PTR [rbp-1], -1
	jne	.L20
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC2
	mov	QWORD PTR INFO[rip+8], OFFSET FLAT:.LC3
	mov	eax, OFFSET FLAT:_itr_construct
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	__itr_construct, .-__itr_construct
	.globl	itr_construct
	.type	itr_construct, @gnu_indirect_function
	.set	itr_construct,__itr_construct
	.globl	itr_closeLargeFile
	.type	itr_closeLargeFile, @function
itr_closeLargeFile:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	add	rax, 32
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	rsi, rdx
	mov	rdi, rax
	call	munmap
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	itr_closeLargeFile, .-itr_closeLargeFile
	.globl	itr_getcolumn
	.type	itr_getcolumn, @function
itr_getcolumn:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-8], rax
	mov	DWORD PTR [rbp-12], 1
	jmp	.L24
.L26:
	add	DWORD PTR [rbp-12], 1
	sub	QWORD PTR [rbp-8], 1
.L24:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	cmp	QWORD PTR [rbp-8], rax
	je	.L25
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	jne	.L26
.L25:
	mov	eax, DWORD PTR [rbp-12]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	itr_getcolumn, .-itr_getcolumn
	.globl	itr_getline
	.type	itr_getline, @function
itr_getline:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+24]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	itr_getline, .-itr_getline
	.globl	itr_state
	.type	itr_state, @function
itr_state:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	itr_state, .-itr_state
	.globl	jumpTable
	.bss
	.align 32
	.type	jumpTable, @object
	.size	jumpTable, 2048
jumpTable:
	.zero	2048
	.text
	.globl	_itr_getAbstract
	.type	_itr_getAbstract, @function
_itr_getAbstract:
.LFB15:
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
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	cdqe
	mov	rax, QWORD PTR jumpTable[0+rax*8]
#APP
# 17 "utils/StringIterator/itr_getAbstract.h" 1
	jmp *rax
# 0 "" 2
# 20 "utils/StringIterator/itr_getAbstract.h" 1
	empty_skip:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	cdqe
	mov	rax, QWORD PTR jumpTable[0+rax*8]
#APP
# 22 "utils/StringIterator/itr_getAbstract.h" 1
	jmp *rax
# 0 "" 2
# 24 "utils/StringIterator/itr_getAbstract.h" 1
	line_skip:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+24], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	cdqe
	mov	rax, QWORD PTR jumpTable[0+rax*8]
#APP
# 27 "utils/StringIterator/itr_getAbstract.h" 1
	jmp *rax
# 0 "" 2
# 29 "utils/StringIterator/itr_getAbstract.h" 1
	CSTRING:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	_itr_getstr
	mov	rdx, QWORD PTR [rbp-16]
	mov	QWORD PTR [rdx+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	test	rax, rax
	jne	.L33
#APP
# 31 "utils/StringIterator/itr_getAbstract.h" 1
	jmp CNONE
# 0 "" 2
#NO_APP
.L33:
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax], 34
#APP
# 33 "utils/StringIterator/itr_getAbstract.h" 1
	jmp push
# 0 "" 2
# 35 "utils/StringIterator/itr_getAbstract.h" 1
	CCHAR:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax], 1
	mov	rax, QWORD PTR [rbp-16]
	lea	rdx, [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rdx
	mov	rdi, rax
	call	_itr_getchar
	test	eax, eax
	jne	.L34
#APP
# 38 "utils/StringIterator/itr_getAbstract.h" 1
	jmp CNONE
# 0 "" 2
#NO_APP
.L34:
#APP
# 39 "utils/StringIterator/itr_getAbstract.h" 1
	jmp push
# 0 "" 2
# 41 "utils/StringIterator/itr_getAbstract.h" 1
	CJSON:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	_itr_collectJsonMap
	mov	rdx, QWORD PTR [rbp-16]
	mov	QWORD PTR [rdx+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	test	rax, rax
	jne	.L35
#APP
# 43 "utils/StringIterator/itr_getAbstract.h" 1
	jmp CNONE
# 0 "" 2
#NO_APP
.L35:
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax], 10
#APP
# 45 "utils/StringIterator/itr_getAbstract.h" 1
	jmp push
# 0 "" 2
# 47 "utils/StringIterator/itr_getAbstract.h" 1
	CARRAY:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	_itr_collectJsonList
	mov	rdx, QWORD PTR [rbp-16]
	mov	QWORD PTR [rdx+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	test	rax, rax
	jne	.L36
#APP
# 49 "utils/StringIterator/itr_getAbstract.h" 1
	jmp CNONE
# 0 "" 2
#NO_APP
.L36:
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax], 11
#APP
# 51 "utils/StringIterator/itr_getAbstract.h" 1
	jmp push
# 0 "" 2
# 53 "utils/StringIterator/itr_getAbstract.h" 1
	CLETTER:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	_itr_gettext
	mov	rdx, QWORD PTR [rbp-16]
	mov	QWORD PTR [rdx+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	test	rax, rax
	jne	.L37
#APP
# 55 "utils/StringIterator/itr_getAbstract.h" 1
	jmp CNONE
# 0 "" 2
#NO_APP
.L37:
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax], 35
#APP
# 57 "utils/StringIterator/itr_getAbstract.h" 1
	jmp push
# 0 "" 2
# 59 "utils/StringIterator/itr_getAbstract.h" 1
	CNUM:
# 0 "" 2
#NO_APP
	mov	rdx, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rdx
	mov	rdi, rax
	call	_itr_getabstractnum
	test	eax, eax
	jne	.L38
#APP
# 61 "utils/StringIterator/itr_getAbstract.h" 1
	jmp CNONE
# 0 "" 2
#NO_APP
.L38:
#APP
# 62 "utils/StringIterator/itr_getAbstract.h" 1
	jmp push
# 0 "" 2
# 64 "utils/StringIterator/itr_getAbstract.h" 1
	CNONE:
# 0 "" 2
#NO_APP
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], 0
	mov	rax, QWORD PTR [rbp-16]
	mov	DWORD PTR [rax], 0
#APP
# 66 "utils/StringIterator/itr_getAbstract.h" 1
	push:
# 0 "" 2
#NO_APP
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	_itr_getAbstract, .-_itr_getAbstract
	.globl	itr_clearAbstract
	.type	itr_clearAbstract, @function
itr_clearAbstract:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-56], rdi
	mov	rax, QWORD PTR [rbp-56]
	mov	eax, DWORD PTR [rax]
	cmp	eax, 35
	jg	.L53
	cmp	eax, 34
	jge	.L42
	cmp	eax, 10
	je	.L43
	cmp	eax, 11
	je	.L44
	jmp	.L53
.L43:
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rax+8]
	sal	rax, 3
	add	rax, rdx
	mov	QWORD PTR [rbp-40], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L45
.L49:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	je	.L46
	jmp	.L47
.L48:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-48], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	itr_clearAbstract
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rbp-16], rax
.L47:
	cmp	QWORD PTR [rbp-16], 0
	jne	.L48
.L46:
	add	QWORD PTR [rbp-8], 8
.L45:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-40]
	jne	.L49
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rax+16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	jmp	.L40
.L44:
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rax+8]
	mov	eax, eax
	sal	rax, 4
	add	rax, rdx
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-24], rax
	jmp	.L51
.L52:
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	itr_clearAbstract
	add	QWORD PTR [rbp-24], 16
.L51:
	mov	rax, QWORD PTR [rbp-24]
	cmp	rax, QWORD PTR [rbp-32]
	jb	.L52
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	jmp	.L40
.L42:
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	jmp	.L40
.L53:
	nop
.L40:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	itr_clearAbstract, .-itr_clearAbstract
	.type	itr_abstractDispatcher, @function
itr_abstractDispatcher:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
#APP
# 119 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CNONE, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rax, rbx
	mov	QWORD PTR jumpTable[rip], rax
	mov	BYTE PTR [rbp-9], 1
	jmp	.L55
.L71:
	cmp	BYTE PTR [rbp-9], 47
	jbe	.L56
	cmp	BYTE PTR [rbp-9], 57
	jbe	.L57
.L56:
	cmp	BYTE PTR [rbp-9], 45
	jne	.L58
.L57:
#APP
# 123 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CNUM, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L58:
	cmp	BYTE PTR [rbp-9], 34
	jne	.L60
#APP
# 125 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CSTRING, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L60:
	cmp	BYTE PTR [rbp-9], 39
	jne	.L61
#APP
# 127 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CCHAR, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L61:
	cmp	BYTE PTR [rbp-9], 96
	jbe	.L62
	cmp	BYTE PTR [rbp-9], 122
	jbe	.L63
.L62:
	cmp	BYTE PTR [rbp-9], 64
	jbe	.L64
	cmp	BYTE PTR [rbp-9], 90
	jbe	.L63
.L64:
	cmp	BYTE PTR [rbp-9], 95
	jne	.L65
.L63:
#APP
# 129 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CLETTER, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L65:
	cmp	BYTE PTR [rbp-9], 123
	jne	.L66
#APP
# 131 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CJSON, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L66:
	cmp	BYTE PTR [rbp-9], 91
	jne	.L67
#APP
# 133 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CARRAY, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L67:
	cmp	BYTE PTR [rbp-9], 32
	je	.L68
	cmp	BYTE PTR [rbp-9], 9
	jne	.L69
.L68:
#APP
# 135 "utils/StringIterator/itr_getAbstract.h" 1
	mov $empty_skip, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L69:
	cmp	BYTE PTR [rbp-9], 10
	jne	.L70
#APP
# 137 "utils/StringIterator/itr_getAbstract.h" 1
	mov $line_skip, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
	jmp	.L59
.L70:
#APP
# 139 "utils/StringIterator/itr_getAbstract.h" 1
	mov $CNONE, rax
# 0 "" 2
#NO_APP
	mov	rbx, rax
	mov	rdx, rbx
	movzx	eax, BYTE PTR [rbp-9]
	cdqe
	mov	QWORD PTR jumpTable[0+rax*8], rdx
.L59:
	add	BYTE PTR [rbp-9], 1
.L55:
	cmp	BYTE PTR [rbp-9], 0
	jne	.L71
	mov	eax, OFFSET FLAT:_itr_getAbstract
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	itr_abstractDispatcher, .-itr_abstractDispatcher
	.globl	itr_getAbstract
	.type	itr_getAbstract, @gnu_indirect_function
	.set	itr_getAbstract,itr_abstractDispatcher
	.globl	_itr_skipchars
	.type	_itr_skipchars, @function
_itr_skipchars:
.LFB18:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
.L74:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 32
	je	.L75
	cmp	eax, 32
	jg	.L78
	cmp	eax, 9
	je	.L75
	cmp	eax, 10
	jne	.L78
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+24], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L74
.L75:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L74
.L78:
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	_itr_skipchars, .-_itr_skipchars
	.section	.rodata
.LC4:
	.string	"{"
.LC5:
	.string	"  \"type\":\"IT_NONE\"\n}"
	.align 8
.LC6:
	.string	"  \"type\":\"IT_CHAR\",\n  \"value\":\"%c\"\n}\n"
	.align 8
.LC7:
	.string	"  \"type\":\"IT_VERYSHORT\",\n  \"value\":\"%d\"\n}\n"
	.align 8
.LC8:
	.string	"  \"type\":\"IT_UVERYSHORT\",\n  \"value\":\"%u\"\n}\n"
	.align 8
.LC9:
	.string	"  \"type\":\"IT_SHORT\",\n  \"value\":\"%d\"\n}\n"
	.align 8
.LC10:
	.string	"  \"type\":\"IT_USHORT\",\n  \"value\":\"%u\"\n}\n"
	.align 8
.LC11:
	.string	"  \"type\":\"IT_INT\",\n  \"value\":\"%d\"\n}\n"
	.align 8
.LC12:
	.string	"  \"type\":\"IT_UINT\",\n  \"value\":\"%u\"\n}\n"
	.align 8
.LC13:
	.string	"  \"type\":\"IT_LONG\",\n  \"value\":\"%lld\"\n}\n"
	.align 8
.LC14:
	.string	"  \"type\":\"IT_ULONG\",\n  \"value\":\"%llu\"\n}\n"
	.align 8
.LC15:
	.string	"  \"type\":\"IT_JSON\",\n  \"value\":\"%x\"\n}\n"
	.align 8
.LC16:
	.string	"  \"type\":\"IT_JSON_ARRAY\",\n  \"value\":\"%x\"\n}\n"
.LC17:
	.string	"  \"type\":\"IT_EMPTY\"\n}"
.LC18:
	.string	"  \"type\":\"IT_NOSTD_NULL\"\n}"
.LC19:
	.string	"  \"type\":\"IT_NOSTD_TRUE\"\n}"
.LC20:
	.string	"  \"type\":\"IT_NOSTD_FALSE\"\n}"
	.align 8
.LC21:
	.string	"  \"type\":\"IT_FLOAT\",\n  \"value\":\"%f\"\n}\n"
	.align 8
.LC22:
	.string	"  \"type\":\"IT_DOUBLE\",\n  \"value\":\"%f\"\n}\n"
	.align 8
.LC23:
	.string	"  \"type\":\"IT_STRING\",\n  \"value\":\"%s\"\n}\n"
	.align 8
.LC24:
	.string	"  \"type\":\"IT_TEXT\",\n  \"value\":\"%s\"\n}\n"
	.text
	.globl	itr_printObject
	.type	itr_printObject, @function
itr_printObject:
.LFB19:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	mov	edi, OFFSET FLAT:.LC4
	call	puts
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	add	eax, 35
	cmp	eax, 70
	ja	.L102
	mov	eax, eax
	mov	rax, QWORD PTR .L82[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L82:
	.quad	.L101
	.quad	.L100
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L99
	.quad	.L98
	.quad	.L97
	.quad	.L96
	.quad	.L95
	.quad	.L94
	.quad	.L93
	.quad	.L92
	.quad	.L91
	.quad	.L90
	.quad	.L89
	.quad	.L88
	.quad	.L87
	.quad	.L86
	.quad	.L102
	.quad	.L85
	.quad	.L84
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L102
	.quad	.L83
	.quad	.L81
	.text
.L99:
	mov	edi, OFFSET FLAT:.LC5
	call	puts
	jmp	.L80
.L98:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax+8]
	movsx	eax, al
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC6
	mov	eax, 0
	call	printf
	jmp	.L80
.L97:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax+8]
	movsx	eax, al
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC7
	mov	eax, 0
	call	printf
	jmp	.L80
.L96:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax+8]
	movzx	eax, al
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC8
	mov	eax, 0
	call	printf
	jmp	.L80
.L95:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, WORD PTR [rax+8]
	cwde
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC9
	mov	eax, 0
	call	printf
	jmp	.L80
.L94:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, WORD PTR [rax+8]
	movzx	eax, ax
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC10
	mov	eax, 0
	call	printf
	jmp	.L80
.L93:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+8]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC11
	mov	eax, 0
	call	printf
	jmp	.L80
.L92:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+8]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC12
	mov	eax, 0
	call	printf
	jmp	.L80
.L91:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC13
	mov	eax, 0
	call	printf
	jmp	.L80
.L90:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC14
	mov	eax, 0
	call	printf
	jmp	.L80
.L89:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC15
	mov	eax, 0
	call	printf
	jmp	.L80
.L88:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC16
	mov	eax, 0
	call	printf
	jmp	.L80
.L87:
	mov	edi, OFFSET FLAT:.LC17
	call	puts
	jmp	.L80
.L86:
	mov	edi, OFFSET FLAT:.LC18
	call	puts
	jmp	.L80
.L85:
	mov	edi, OFFSET FLAT:.LC19
	call	puts
	jmp	.L80
.L84:
	mov	edi, OFFSET FLAT:.LC20
	call	puts
	jmp	.L80
.L100:
	mov	rax, QWORD PTR [rbp-8]
	movss	xmm0, DWORD PTR [rax+8]
	pxor	xmm1, xmm1
	cvtss2sd	xmm1, xmm0
	movq	rax, xmm1
	movq	xmm0, rax
	mov	edi, OFFSET FLAT:.LC21
	mov	eax, 1
	call	printf
	jmp	.L80
.L101:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	movq	xmm0, rax
	mov	edi, OFFSET FLAT:.LC22
	mov	eax, 1
	call	printf
	jmp	.L80
.L83:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC23
	mov	eax, 0
	call	printf
	jmp	.L80
.L81:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC24
	mov	eax, 0
	call	printf
.L80:
.L102:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	itr_printObject, .-itr_printObject
	.section	.rodata
.LC25:
	.string	"undefined"
.LC26:
	.string	"empty"
.LC27:
	.string	"null"
.LC28:
	.string	"true"
.LC29:
	.string	"false"
	.text
	.globl	itr_stringify
	.type	itr_stringify, @function
itr_stringify:
.LFB20:
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
	add	eax, 35
	cmp	eax, 70
	ja	.L126
	mov	eax, eax
	mov	rax, QWORD PTR .L106[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L106:
	.quad	.L125
	.quad	.L124
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L123
	.quad	.L122
	.quad	.L121
	.quad	.L120
	.quad	.L119
	.quad	.L118
	.quad	.L117
	.quad	.L116
	.quad	.L115
	.quad	.L114
	.quad	.L113
	.quad	.L112
	.quad	.L111
	.quad	.L110
	.quad	.L126
	.quad	.L109
	.quad	.L108
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L126
	.quad	.L107
	.quad	.L105
	.text
.L123:
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, OFFSET FLAT:.LC25
	mov	rdi, rax
	call	xstrappends
	jmp	.L104
.L122:
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, 39
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax+8]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, 39
	mov	rdi, rax
	call	xstrappendc
	jmp	.L104
.L121:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax+8]
	movsx	edx, al
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendi
	jmp	.L104
.L120:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax+8]
	movzx	edx, al
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendui
	jmp	.L104
.L119:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, WORD PTR [rax+8]
	movsx	edx, ax
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendi
	jmp	.L104
.L118:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, WORD PTR [rax+8]
	movzx	edx, ax
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendui
	jmp	.L104
.L117:
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendi
	jmp	.L104
.L116:
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, edx
	mov	rdi, rax
	call	xstrappendui
	jmp	.L104
.L115:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappendl
	jmp	.L104
.L114:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappendul
	jmp	.L104
.L113:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	itr_stringifyObject
	jmp	.L104
.L112:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	itr_stringifyArray
	jmp	.L104
.L111:
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, OFFSET FLAT:.LC26
	mov	rdi, rax
	call	xstrappends
	jmp	.L104
.L110:
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, OFFSET FLAT:.LC27
	mov	rdi, rax
	call	xstrappends
	jmp	.L104
.L109:
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, OFFSET FLAT:.LC28
	mov	rdi, rax
	call	xstrappends
	jmp	.L104
.L108:
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, OFFSET FLAT:.LC29
	mov	rdi, rax
	call	xstrappends
	jmp	.L104
.L124:
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	movd	xmm0, edx
	mov	rdi, rax
	call	xstrappendf
	jmp	.L104
.L125:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	movq	xmm0, rdx
	mov	rdi, rax
	call	xstrappendd
	jmp	.L104
.L107:
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, 34
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, 34
	mov	rdi, rax
	call	xstrappendc
	jmp	.L104
.L105:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
.L104:
.L126:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	itr_stringify, .-itr_stringify
	.section	.rodata
.LC30:
	.string	"[]"
	.text
	.globl	itr_stringifyArray
	.type	itr_stringifyArray, @function
itr_stringifyArray:
.LFB21:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	test	eax, eax
	jne	.L128
	mov	rax, QWORD PTR [rbp-32]
	mov	esi, OFFSET FLAT:.LC30
	mov	rdi, rax
	call	xstrappends
	jmp	.L127
.L128:
	mov	rax, QWORD PTR [rbp-32]
	mov	esi, 91
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	mov	eax, eax
	sal	rax, 4
	add	rax, rdx
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L130
.L131:
	mov	rdx, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rdx
	mov	rdi, rax
	call	itr_stringify
	mov	rax, QWORD PTR [rbp-32]
	mov	esi, 44
	mov	rdi, rax
	call	xstrappendc
	add	QWORD PTR [rbp-8], 16
.L130:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-16]
	jb	.L131
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rax+8]
	cdqe
	sub	rax, 1
	add	rax, rdx
	mov	BYTE PTR [rax], 93
.L127:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	itr_stringifyArray, .-itr_stringifyArray
	.section	.rodata
.LC31:
	.string	"{}"
	.text
	.globl	itr_stringifyObject
	.type	itr_stringifyObject, @function
itr_stringifyObject:
.LFB22:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L133
	mov	rax, QWORD PTR [rbp-48]
	mov	esi, OFFSET FLAT:.LC31
	mov	rdi, rax
	call	xstrappends
	jmp	.L132
.L133:
	mov	rax, QWORD PTR [rbp-48]
	mov	esi, 123
	mov	rdi, rax
	call	xstrappendc
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
	jmp	.L135
.L139:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-16], rax
	cmp	QWORD PTR [rbp-16], 0
	je	.L136
	jmp	.L137
.L138:
	mov	rax, QWORD PTR [rbp-48]
	mov	esi, 34
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	rax, QWORD PTR [rbp-48]
	mov	esi, 34
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-48]
	mov	esi, 58
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+8]
	mov	rdx, QWORD PTR [rbp-48]
	mov	rsi, rdx
	mov	rdi, rax
	call	itr_stringify
	mov	rax, QWORD PTR [rbp-48]
	mov	esi, 44
	mov	rdi, rax
	call	xstrappendc
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+24]
	mov	QWORD PTR [rbp-16], rax
.L137:
	cmp	QWORD PTR [rbp-16], 0
	jne	.L138
.L136:
	add	QWORD PTR [rbp-8], 8
.L135:
	mov	rax, QWORD PTR [rbp-8]
	cmp	rax, QWORD PTR [rbp-24]
	jne	.L139
	mov	rax, QWORD PTR [rbp-48]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rax+8]
	cdqe
	sub	rax, 1
	add	rax, rdx
	mov	BYTE PTR [rax], 125
.L132:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	itr_stringifyObject, .-itr_stringifyObject
	.section	.rodata
.LC32:
	.string	"write"
	.text
	.globl	itr_dump
	.type	itr_dump, @function
itr_dump:
.LFB23:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-24], 0
	lea	rdx, [rbp-32]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, rdx
	mov	rdi, rax
	call	itr_stringify
	mov	rax, QWORD PTR [rbp-48]
	mov	edx, 384
	mov	esi, 66
	mov	rdi, rax
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-4], eax
	cmp	DWORD PTR [rbp-4], -1
	jne	.L141
	mov	edi, OFFSET FLAT:.LC0
	call	perror
	jmp	.L140
.L141:
	mov	eax, DWORD PTR [rbp-24]
	movsx	rdx, eax
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-4]
	mov	rsi, rcx
	mov	edi, eax
	call	write
	cmp	rax, -1
	jne	.L143
	mov	edi, OFFSET FLAT:.LC32
	call	perror
.L143:
	mov	eax, DWORD PTR [rbp-4]
	mov	edi, eax
	call	close
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	free
.L140:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	itr_dump, .-itr_dump
	.section	.rodata
.LC33:
	.string	"invalid Json Object"
.LC34:
	.string	"invalid Json Value"
.LC35:
	.string	"missing Json Value"
.LC36:
	.string	"invalid Json Entry"
.LC37:
	.string	"missing object terminator '}'"
	.text
	.globl	_itr_collectJsonMap
	.type	_itr_collectJsonMap, @function
_itr_collectJsonMap:
.LFB24:
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
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 123
	mov	rdi, rax
	call	itr_char
	test	eax, eax
	jne	.L145
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC33
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L146
.L145:
	call	shm_create
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 125
	mov	rdi, rax
	call	itr_char
	cmp	eax, 1
	jne	.L166
	mov	rax, QWORD PTR [rbp-24]
	jmp	.L146
.L166:
	nop
.L147:
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rbp-40], rax
.L148:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 32
	je	.L149
	cmp	eax, 32
	jg	.L167
	cmp	eax, 9
	je	.L149
	cmp	eax, 10
	jne	.L167
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	DWORD PTR [rax+24], edx
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L148
.L149:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L148
.L167:
	nop
	mov	rax, QWORD PTR [rbp-56]
	mov	rdi, rax
	call	_itr_getstr
	mov	rbx, rax
	test	rbx, rbx
	jne	.L152
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC34
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L146
.L152:
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 58
	mov	rdi, rax
	call	itr_char
	test	eax, eax
	jne	.L153
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC35
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L146
.L153:
	mov	rdx, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-56]
	mov	rsi, rdx
	mov	rdi, rax
	call	itr_getAbstract
	mov	rax, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	je	.L154
	cmp	eax, 35
	je	.L155
	jmp	.L162
.L154:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC36
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L146
.L155:
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+8]
	mov	r8d, OFFSET FLAT:.LC27
	mov	ecx, OFFSET FLAT:.LC29
	mov	edx, OFFSET FLAT:.LC28
	mov	esi, 3
	mov	rdi, rax
	mov	eax, 0
	call	strequalsmo
	cmp	eax, 3
	je	.L157
	cmp	eax, 3
	jg	.L158
	cmp	eax, 1
	je	.L159
	cmp	eax, 2
	je	.L160
	jmp	.L158
.L159:
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], 15
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	jmp	.L161
.L160:
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], 16
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	jmp	.L161
.L157:
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], 13
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	jmp	.L161
.L158:
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], 34
	nop
.L161:
	nop
.L162:
	mov	rdx, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, rbx
	mov	rdi, rax
	call	shm_set
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 44
	mov	rdi, rax
	call	itr_char
	cmp	eax, 1
	jne	.L163
	jmp	.L147
.L163:
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 125
	mov	rdi, rax
	call	itr_char
	cmp	eax, 1
	jne	.L164
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-24]
	jmp	.L146
.L164:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC37
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
.L146:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	_itr_collectJsonMap, .-_itr_collectJsonMap
	.section	.rodata
.LC38:
	.string	"invalid Json Array"
.LC39:
	.string	"missing array terminator ']'"
	.text
	.globl	_itr_collectJsonList
	.type	_itr_collectJsonList, @function
_itr_collectJsonList:
.LFB25:
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
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 91
	mov	rdi, rax
	call	itr_char
	test	eax, eax
	jne	.L169
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC38
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L184
.L169:
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rax+8], 0
	mov	edi, 64
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 93
	mov	rdi, rax
	call	itr_char
	cmp	eax, 1
	jne	.L185
	mov	rax, QWORD PTR [rbp-24]
	jmp	.L184
.L185:
	nop
.L171:
	lea	rdx, [rbp-48]
	mov	rax, QWORD PTR [rbp-56]
	mov	rsi, rdx
	mov	rdi, rax
	call	itr_getAbstract
	mov	eax, DWORD PTR [rbp-48]
	test	eax, eax
	je	.L172
	cmp	eax, 35
	je	.L173
	jmp	.L180
.L172:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC36
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L184
.L173:
	mov	rax, QWORD PTR [rbp-40]
	mov	r8d, OFFSET FLAT:.LC27
	mov	ecx, OFFSET FLAT:.LC29
	mov	edx, OFFSET FLAT:.LC28
	mov	esi, 3
	mov	rdi, rax
	mov	eax, 0
	call	strequalsmo
	cmp	eax, 3
	je	.L175
	cmp	eax, 3
	jg	.L176
	cmp	eax, 1
	je	.L177
	cmp	eax, 2
	je	.L178
	jmp	.L176
.L177:
	mov	DWORD PTR [rbp-48], 15
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	free
	jmp	.L179
.L178:
	mov	DWORD PTR [rbp-48], 16
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	free
	jmp	.L179
.L175:
	mov	DWORD PTR [rbp-48], 13
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	free
	jmp	.L179
.L176:
	mov	DWORD PTR [rbp-48], 34
	nop
.L179:
	nop
.L180:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	mov	ebx, eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	malloc_usable_size
	shr	rax, 4
	cmp	rbx, rax
	jne	.L181
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
.L181:
	mov	rax, QWORD PTR [rbp-24]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+8]
	lea	ecx, [rax+1]
	mov	rdx, QWORD PTR [rbp-24]
	mov	DWORD PTR [rdx+8], ecx
	mov	eax, eax
	sal	rax, 4
	lea	rcx, [rsi+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rcx], rax
	mov	QWORD PTR [rcx+8], rdx
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 44
	mov	rdi, rax
	call	itr_char
	cmp	eax, 1
	jne	.L182
	jmp	.L171
.L182:
	mov	rax, QWORD PTR [rbp-56]
	mov	esi, 93
	mov	rdi, rax
	call	itr_char
	cmp	eax, 1
	jne	.L183
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-24]
	jmp	.L184
.L183:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC39
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-56]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-56]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
.L184:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	_itr_collectJsonList, .-_itr_collectJsonList
	.globl	itr_getlinestr
	.type	itr_getlinestr, @function
itr_getlinestr:
.LFB26:
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
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-24], rax
	jmp	.L187
.L189:
	sub	QWORD PTR [rbp-24], 1
.L187:
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax]
	cmp	QWORD PTR [rbp-24], rax
	je	.L188
	mov	rax, QWORD PTR [rbp-24]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	jne	.L189
.L188:
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-48], rax
	mov	DWORD PTR [rbp-40], 0
	jmp	.L190
.L193:
	mov	eax, DWORD PTR [rbp-40]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L191
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-48], rax
.L191:
	mov	rcx, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rbp-40]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-40], edx
	cdqe
	lea	rdx, [rcx+rax]
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	QWORD PTR [rbp-24], 1
.L190:
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L192
	mov	rax, QWORD PTR [rbp-24]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L193
.L192:
	mov	eax, DWORD PTR [rbp-40]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L194
	mov	rax, QWORD PTR [rbp-48]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-48], rax
.L194:
	mov	rcx, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rbp-40]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-40], edx
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-48]
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	itr_getlinestr, .-itr_getlinestr
	.section	.rodata
.LC40:
	.string	"invalid literal"
	.text
	.globl	_itr_gettext
	.type	_itr_gettext, @function
_itr_gettext:
.LFB27:
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
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 5
	je	.L197
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC40
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L205
.L197:
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-24], 0
	jmp	.L199
.L203:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L200
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L201
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L201:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-32]
	jmp	.L205
.L200:
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L202
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L202:
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rsi, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	ecx, [rax+1]
	mov	DWORD PTR [rbp-24], ecx
	cdqe
	lea	rcx, [rsi+rax]
	movzx	eax, BYTE PTR [rdx]
	mov	BYTE PTR [rcx], al
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
.L199:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 3
	ja	.L203
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L204
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L204:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-32]
.L205:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	_itr_gettext, .-_itr_gettext
	.section	.rodata
.LC41:
	.string	"invalid string"
.LC42:
	.string	"expected string enclosure (\")"
.LC43:
	.string	"illegal linebreak"
.LC44:
	.string	"invalid character format code"
	.text
	.globl	_itr_getstr
	.type	_itr_getstr, @function
_itr_getstr:
.LFB28:
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
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx+16], rcx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 34
	je	.L207
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC41
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L222
.L207:
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-24], 0
.L221:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 92
	je	.L209
	cmp	eax, 92
	jg	.L210
	cmp	eax, 34
	je	.L211
	cmp	eax, 34
	jg	.L210
	test	eax, eax
	je	.L212
	cmp	eax, 10
	je	.L213
	jmp	.L210
.L212:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC42
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L222
.L211:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L214
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L214:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-32]
	jmp	.L222
.L213:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC43
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L222
.L209:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx+16], rcx
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 92
	jne	.L215
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L216
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L216:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], 92
	jmp	.L217
.L215:
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L218
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L218:
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	edx, [rax+1]
	mov	DWORD PTR [rbp-24], edx
	cdqe
	lea	rdx, [rcx+rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	rsi, rdx
	mov	rdi, rax
	call	_itr_getuveryshort
	test	eax, eax
	jne	.L223
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC44
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L222
.L210:
	mov	eax, DWORD PTR [rbp-24]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L220
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-32], rax
.L220:
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rsi, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	lea	ecx, [rax+1]
	mov	DWORD PTR [rbp-24], ecx
	cdqe
	lea	rcx, [rsi+rax]
	movzx	eax, BYTE PTR [rdx]
	mov	BYTE PTR [rcx], al
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L221
.L223:
	nop
.L217:
	jmp	.L221
.L222:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	_itr_getstr, .-_itr_getstr
	.section	.rodata
.LC45:
	.string	"invalid character"
.LC46:
	.string	"expected character"
.LC47:
	.string	"expected enclosure (')"
	.text
	.globl	_itr_getchar
	.type	_itr_getchar, @function
_itr_getchar:
.LFB29:
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
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+16], rcx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 39
	je	.L225
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC45
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L224
.L225:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+16], rcx
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	mov	BYTE PTR [rax], dl
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 92
	je	.L227
	cmp	eax, 92
	jg	.L234
	test	eax, eax
	je	.L229
	cmp	eax, 10
	jne	.L234
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC43
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L224
.L229:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC46
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L224
.L227:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+16], rcx
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 92
	jne	.L230
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	BYTE PTR [rax], 92
	jmp	.L231
.L230:
	mov	rdx, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rdx
	mov	rdi, rax
	call	_itr_getuveryshort
	test	eax, eax
	jne	.L235
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC44
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L224
.L234:
	nop
	jmp	.L231
.L235:
	nop
.L231:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+16], rcx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 39
	je	.L233
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC47
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L224
.L233:
.L224:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	_itr_getchar, .-_itr_getchar
	.section	.rodata
.LC48:
	.string	"not an valid numer"
.LC49:
	.string	"very short constant too large"
	.text
	.globl	_itr_getveryshort
	.type	_itr_getveryshort, @function
_itr_getveryshort:
.LFB30:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-32], rdi
	mov	QWORD PTR [rbp-40], rsi
	mov	BYTE PTR [rbp-9], 1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L237
	mov	BYTE PTR [rbp-9], -1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L237:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L240
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC48
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L239
.L242:
	cmp	bl, 11
	jle	.L241
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC49
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L239
.L241:
	mov	edx, ebx
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	add	eax, edx
	sub	eax, 48
	mov	ebx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L240:
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L242
	mov	eax, ebx
	movzx	edx, BYTE PTR [rbp-9]
	imul	eax, edx
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	BYTE PTR [rax], dl
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L239:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	_itr_getveryshort, .-_itr_getveryshort
	.section	.rodata
.LC50:
	.string	"not a valid number"
.LC51:
	.string	"long constant too large"
	.globl	__floatditf
	.globl	__fixtfdi
.LC53:
	.string	"integer constant too large"
.LC54:
	.string	"not a valid double"
	.globl	__extenddftf2
	.globl	__trunctfdf2
	.text
	.globl	_itr_getabstractnum
	.type	_itr_getabstractnum, @function
_itr_getabstractnum:
.LFB31:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r12
	push	rbx
	sub	rsp, 64
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	r12d, 1
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L244
	mov	r12, -1
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
.L244:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L247
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L246
.L250:
	mov	rdx, rbx
	movabs	rax, 922337203685477579
	cmp	rax, rdx
	jnb	.L248
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC51
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L246
.L248:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	add	rax, rdx
	lea	rbx, [rax-48]
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 95
	jne	.L249
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
.L249:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
.L247:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L250
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 46
	je	.L251
	cmp	eax, 46
	jl	.L252
	cmp	eax, 117
	jg	.L252
	cmp	eax, 70
	jl	.L252
	sub	eax, 70
	cmp	eax, 47
	ja	.L252
	mov	eax, eax
	mov	rax, QWORD PTR .L254[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L254:
	.quad	.L257
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L255
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L253
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L256
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L255
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L252
	.quad	.L253
	.text
.L251:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	nop
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L260
	jmp	.L265
.L257:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	rdi, r12
	call	__floatditf
	movaps	XMMWORD PTR [rbp-48], xmm0
	mov	rdi, rbx
	call	__floatditf
	movdqa	xmm1, xmm0
	movdqa	xmm0, XMMWORD PTR .LC52[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, XMMWORD PTR [rbp-48]
	por	xmm0, xmm2
	call	__fixtfdi
	mov	rbx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rbx
	mov	rax, QWORD PTR [rbp-32]
	movsd	QWORD PTR [rax+8], xmm0
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], -35
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
	jmp	.L246
.L256:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	rdi, r12
	call	__floatditf
	movaps	XMMWORD PTR [rbp-48], xmm0
	mov	rdi, rbx
	call	__floatditf
	movdqa	xmm1, xmm0
	movdqa	xmm0, XMMWORD PTR .LC52[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, XMMWORD PTR [rbp-48]
	por	xmm0, xmm2
	call	__fixtfdi
	mov	rbx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rbx
	mov	rax, QWORD PTR [rbp-32]
	movsd	QWORD PTR [rax+8], xmm0
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], -34
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
	jmp	.L246
.L255:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	rdi, r12
	call	__floatditf
	movaps	XMMWORD PTR [rbp-48], xmm0
	mov	rdi, rbx
	call	__floatditf
	movdqa	xmm1, xmm0
	movdqa	xmm0, XMMWORD PTR .LC52[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, XMMWORD PTR [rbp-48]
	por	xmm0, xmm2
	call	__fixtfdi
	mov	rbx, rax
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+8], rbx
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], 8
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
	jmp	.L246
.L253:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	rdx, rbx
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], 9
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
	jmp	.L246
.L252:
	mov	eax, 2147483648
	cmp	rbx, rax
	jl	.L259
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC53
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L246
.L259:
	mov	rdi, r12
	call	__floatditf
	movaps	XMMWORD PTR [rbp-48], xmm0
	mov	rdi, rbx
	call	__floatditf
	movdqa	xmm1, xmm0
	movdqa	xmm0, XMMWORD PTR .LC52[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, XMMWORD PTR [rbp-48]
	por	xmm0, xmm2
	call	__fixtfdi
	mov	rbx, rax
	mov	edx, ebx
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax+8], edx
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], 6
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
	jmp	.L246
.L265:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC54
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L246
.L260:
	movsd	xmm4, QWORD PTR .LC55[rip]
	movsd	QWORD PTR [rbp-48], xmm4
	pxor	xmm5, xmm5
	movsd	QWORD PTR [rbp-56], xmm5
	jmp	.L261
.L262:
	movsd	xmm0, QWORD PTR .LC57[rip]
	movsd	xmm1, QWORD PTR [rbp-56]
	mulsd	xmm1, xmm0
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC58[rip]
	subsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-56], xmm0
	movsd	xmm0, QWORD PTR .LC57[rip]
	mulsd	xmm0, QWORD PTR [rbp-48]
	movsd	QWORD PTR [rbp-48], xmm0
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
.L261:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L262
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 102
	je	.L263
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 70
	jne	.L264
.L263:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
.L264:
	mov	rax, QWORD PTR [rbp-32]
	mov	DWORD PTR [rax], -35
	mov	rdi, r12
	call	__floatditf
	movaps	XMMWORD PTR [rbp-80], xmm0
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rbx
	movsd	xmm3, QWORD PTR [rbp-56]
	divsd	xmm3, QWORD PTR [rbp-48]
	movapd	xmm0, xmm3
	addsd	xmm1, xmm0
	movq	rax, xmm1
	movq	xmm0, rax
	call	__extenddftf2
	movdqa	xmm1, xmm0
	movdqa	xmm0, XMMWORD PTR .LC52[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, XMMWORD PTR [rbp-80]
	por	xmm0, xmm2
	call	__trunctfdf2
	movq	rax, xmm0
	mov	rdx, QWORD PTR [rbp-32]
	mov	QWORD PTR [rdx+8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L246:
	add	rsp, 64
	pop	rbx
	pop	r12
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	_itr_getabstractnum, .-_itr_getabstractnum
	.section	.rodata
.LC59:
	.string	"short constant too large"
	.text
	.globl	_itr_getshort
	.type	_itr_getshort, @function
_itr_getshort:
.LFB32:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-32], rdi
	mov	QWORD PTR [rbp-40], rsi
	mov	WORD PTR [rbp-10], 1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L267
	mov	WORD PTR [rbp-10], -1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L267:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L270
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC48
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L269
.L272:
	cmp	bx, 3275
	jle	.L271
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC59
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L269
.L271:
	mov	edx, ebx
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cbw
	add	eax, edx
	sub	eax, 48
	mov	ebx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L270:
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L272
	mov	edx, ebx
	movzx	eax, WORD PTR [rbp-10]
	imul	eax, edx
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	WORD PTR [rax], dx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L269:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	_itr_getshort, .-_itr_getshort
	.globl	_itr_getint
	.type	_itr_getint, @function
_itr_getint:
.LFB33:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-32], rdi
	mov	QWORD PTR [rbp-40], rsi
	mov	DWORD PTR [rbp-12], 1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L274
	mov	DWORD PTR [rbp-12], -1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L274:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L277
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L276
.L279:
	cmp	ebx, 214748363
	jle	.L278
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC53
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L276
.L278:
	mov	eax, ebx
	sal	eax, 2
	add	eax, ebx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	add	eax, edx
	lea	ebx, [rax-48]
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L277:
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L279
	imul	ebx, DWORD PTR [rbp-12]
	mov	edx, ebx
	mov	rax, QWORD PTR [rbp-40]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L276:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	_itr_getint, .-_itr_getint
	.section	.rodata
	.align 8
.LC60:
	.string	"missing suffix for 64 Bit integers ('L')"
	.text
	.globl	_itr_getlong
	.type	_itr_getlong, @function
_itr_getlong:
.LFB34:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-32], rdi
	mov	QWORD PTR [rbp-40], rsi
	mov	QWORD PTR [rbp-16], 1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L281
	mov	QWORD PTR [rbp-16], -1
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L281:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L284
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L283
.L287:
	mov	rdx, rbx
	movabs	rax, 922337203685477579
	cmp	rax, rdx
	jnb	.L285
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC51
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L283
.L285:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	add	rax, rdx
	lea	rbx, [rax-48]
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 95
	jne	.L286
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L286:
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
.L284:
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L287
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 108
	je	.L288
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 76
	je	.L288
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC60
	mov	rax, QWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L283
.L288:
	imul	rbx, QWORD PTR [rbp-16]
	mov	rdx, rbx
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L283:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	_itr_getlong, .-_itr_getlong
	.section	.rodata
.LC61:
	.string	"unsigned type has a sign"
	.align 8
.LC62:
	.string	"unsigned very short constant too large"
	.text
	.globl	_itr_getuveryshort
	.type	_itr_getuveryshort, @function
_itr_getuveryshort:
.LFB35:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-16], rdi
	mov	QWORD PTR [rbp-24], rsi
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L290
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC61
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L291
.L290:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L293
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L291
.L295:
	cmp	bl, 24
	jbe	.L294
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC62
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L291
.L294:
	mov	eax, ebx
	sal	eax, 2
	add	eax, ebx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	add	eax, edx
	lea	ebx, [rax-48]
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
.L293:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L295
	mov	rax, QWORD PTR [rbp-24]
	mov	BYTE PTR [rax], bl
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L291:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	_itr_getuveryshort, .-_itr_getuveryshort
	.section	.rodata
	.align 8
.LC63:
	.string	"unsigned short constant too large"
	.text
	.globl	_itr_getushort
	.type	_itr_getushort, @function
_itr_getushort:
.LFB36:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-16], rdi
	mov	QWORD PTR [rbp-24], rsi
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L297
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC61
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L298
.L297:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L300
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L298
.L302:
	cmp	bx, 6552
	jbe	.L301
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC63
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L298
.L301:
	mov	eax, ebx
	sal	eax, 2
	add	eax, ebx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cbw
	add	eax, edx
	lea	ebx, [rax-48]
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
.L300:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L302
	mov	rax, QWORD PTR [rbp-24]
	mov	WORD PTR [rax], bx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L298:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	_itr_getushort, .-_itr_getushort
	.section	.rodata
	.align 8
.LC64:
	.string	"unsigned integer constant too large"
	.text
	.globl	_itr_getuint
	.type	_itr_getuint, @function
_itr_getuint:
.LFB37:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-16], rdi
	mov	QWORD PTR [rbp-24], rsi
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L304
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC61
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L305
.L304:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L307
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L305
.L309:
	cmp	ebx, 429496728
	jbe	.L308
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC64
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L305
.L308:
	mov	eax, ebx
	sal	eax, 2
	add	eax, ebx
	add	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	add	eax, edx
	lea	ebx, [rax-48]
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
.L307:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L309
	mov	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rax], ebx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L305:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	_itr_getuint, .-_itr_getuint
	.section	.rodata
	.align 8
.LC65:
	.string	"unsigned long constant too large"
	.align 8
.LC66:
	.string	"missing suffix for unsigned 64 Bit integers ('U')"
	.text
	.globl	_itr_getulong
	.type	_itr_getulong, @function
_itr_getulong:
.LFB38:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-16], rdi
	mov	QWORD PTR [rbp-24], rsi
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L311
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC61
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L312
.L311:
	mov	ebx, 0
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L314
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L312
.L317:
	movabs	rax, 1844674407370955160
	cmp	rax, rbx
	jnb	.L315
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC65
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L312
.L315:
	mov	rax, rbx
	sal	rax, 2
	add	rax, rbx
	add	rax, rax
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	add	rax, rdx
	lea	rbx, [rax-48]
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 95
	jne	.L316
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
.L316:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
.L314:
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L317
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 117
	je	.L318
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 85
	je	.L318
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC66
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L312
.L318:
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax], rbx
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L312:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	_itr_getulong, .-_itr_getulong
	.section	.rodata
	.align 8
.LC68:
	.string	"missing suffix for doubles ('D')"
	.text
	.globl	_itr_getdouble
	.type	_itr_getdouble, @function
_itr_getdouble:
.LFB39:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 88
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	movsd	xmm0, QWORD PTR .LC55[rip]
	movsd	QWORD PTR [rbp-24], xmm0
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L320
	movsd	xmm0, QWORD PTR .LC67[rip]
	movsd	QWORD PTR [rbp-24], xmm0
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
.L320:
	mov	rbx, QWORD PTR .LC56[rip]
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L323
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC50
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L322
.L324:
	movsd	xmm0, QWORD PTR .LC57[rip]
	movq	xmm1, rbx
	mulsd	xmm1, xmm0
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC58[rip]
	subsd	xmm0, xmm1
	movq	rbx, xmm0
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
.L323:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L324
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-40]
	mov	QWORD PTR [rdx+16], rcx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 46
	je	.L325
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 70
	je	.L326
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 102
	jne	.L327
.L326:
	movsd	xmm0, QWORD PTR [rbp-24]
	call	__extenddftf2
	movaps	XMMWORD PTR [rbp-64], xmm0
	movq	xmm0, rbx
	call	__extenddftf2
	movdqa	xmm1, xmm0
	movdqa	xmm0, XMMWORD PTR .LC52[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, XMMWORD PTR [rbp-64]
	por	xmm0, xmm2
	call	__trunctfdf2
	movq	rax, xmm0
	mov	rdx, QWORD PTR [rbp-48]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
	jmp	.L322
.L327:
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC68
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L322
.L325:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L328
	mov	QWORD PTR INFO[rip], OFFSET FLAT:.LC54
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR INFO[rip+8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L322
.L328:
	movsd	xmm6, QWORD PTR .LC55[rip]
	movsd	QWORD PTR [rbp-64], xmm6
	pxor	xmm7, xmm7
	movsd	QWORD PTR [rbp-72], xmm7
	jmp	.L329
.L330:
	movsd	xmm0, QWORD PTR .LC57[rip]
	movsd	xmm1, QWORD PTR [rbp-72]
	mulsd	xmm1, xmm0
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC58[rip]
	subsd	xmm0, xmm1
	movsd	QWORD PTR [rbp-72], xmm0
	movsd	xmm0, QWORD PTR .LC57[rip]
	mulsd	xmm0, QWORD PTR [rbp-64]
	movsd	QWORD PTR [rbp-64], xmm0
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
.L329:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cdqe
	mov	eax, DWORD PTR charTable[0+rax*4]
	cmp	eax, 4
	je	.L330
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 102
	je	.L331
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 70
	jne	.L332
.L331:
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rdx
.L332:
	movsd	xmm0, QWORD PTR [rbp-24]
	call	__extenddftf2
	movaps	XMMWORD PTR [rbp-96], xmm0
	movsd	xmm3, QWORD PTR [rbp-72]
	divsd	xmm3, QWORD PTR [rbp-64]
	movapd	xmm0, xmm3
	movq	xmm4, rbx
	addsd	xmm4, xmm0
	movq	rax, xmm4
	movq	xmm0, rax
	call	__extenddftf2
	movdqa	xmm1, xmm0
	movdqa	xmm0, XMMWORD PTR .LC52[rip]
	movdqa	xmm2, xmm0
	pandn	xmm2, xmm1
	pand	xmm0, XMMWORD PTR [rbp-96]
	por	xmm0, xmm2
	call	__trunctfdf2
	movq	rax, xmm0
	mov	rdx, QWORD PTR [rbp-48]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L322:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	_itr_getdouble, .-_itr_getdouble
	.globl	itr_matchtext
	.type	itr_matchtext, @function
itr_matchtext:
.LFB40:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 120
	mov	QWORD PTR [rbp-232], rdi
	mov	DWORD PTR [rbp-236], esi
	mov	QWORD PTR [rbp-160], rdx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L364
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L364:
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rbp-200], rax
.L350:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 59
	je	.L335
	cmp	eax, 59
	jg	.L367
	cmp	eax, 32
	je	.L368
	cmp	eax, 32
	jg	.L367
	cmp	eax, 9
	je	.L369
	cmp	eax, 10
	je	.L339
	jmp	.L367
.L339:
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
	jmp	.L340
.L335:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-200]
	mov	QWORD PTR [rdx+16], rcx
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	jne	.L341
	jmp	.L342
.L346:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	jne	.L343
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	je	.L370
.L343:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	jne	.L345
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
.L345:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
.L342:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L346
	jmp	.L370
.L341:
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
	jmp	.L347
.L348:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
.L347:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L370
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L348
	jmp	.L370
.L368:
	nop
	jmp	.L340
.L369:
	nop
	jmp	.L340
.L370:
	nop
.L340:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L350
.L367:
	nop
	mov	DWORD PTR [rbp-224], 16
	mov	DWORD PTR [rbp-220], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-216], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-208], rax
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+8], rdx
	mov	DWORD PTR [rbp-180], 0
	jmp	.L351
.L362:
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L352
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L353
.L352:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L353:
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-192], rax
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L354
.L358:
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-192]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L371
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L372
	add	QWORD PTR [rbp-192], 1
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
.L354:
	mov	rax, QWORD PTR [rbp-192]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L358
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, DWORD PTR [rbp-180]
	jmp	.L363
.L371:
	nop
	jmp	.L356
.L372:
	nop
.L356:
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L360
	mov	eax, DWORD PTR [rbp-224]
	add	eax, 8
	mov	DWORD PTR [rbp-224], eax
	jmp	.L373
.L360:
	mov	rax, QWORD PTR [rbp-216]
	add	rax, 8
	mov	QWORD PTR [rbp-216], rax
.L373:
	nop
	add	DWORD PTR [rbp-180], 1
.L351:
	mov	eax, DWORD PTR [rbp-180]
	cmp	eax, DWORD PTR [rbp-236]
	jb	.L362
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, -1
.L363:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	itr_matchtext, .-itr_matchtext
	.globl	itr_text
	.type	itr_text, @function
itr_text:
.LFB41:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 256
	mov	QWORD PTR [rbp-232], rdi
	mov	QWORD PTR [rbp-240], rsi
	mov	DWORD PTR [rbp-244], edx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L407
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L407:
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rbp-200], rax
.L391:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 59
	je	.L376
	cmp	eax, 59
	jg	.L410
	cmp	eax, 32
	je	.L411
	cmp	eax, 32
	jg	.L410
	cmp	eax, 9
	je	.L412
	cmp	eax, 10
	je	.L380
	jmp	.L410
.L380:
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
	jmp	.L381
.L376:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-200]
	mov	QWORD PTR [rdx+16], rcx
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	jne	.L382
	jmp	.L383
.L387:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	jne	.L384
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	je	.L413
.L384:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	jne	.L386
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
.L386:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
.L383:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L387
	jmp	.L413
.L382:
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
	jmp	.L388
.L389:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
.L388:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L413
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L389
	jmp	.L413
.L411:
	nop
	jmp	.L381
.L412:
	nop
	jmp	.L381
.L413:
	nop
.L381:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L391
.L410:
	nop
	mov	DWORD PTR [rbp-224], 24
	mov	DWORD PTR [rbp-220], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-216], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-208], rax
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+8], rdx
	mov	DWORD PTR [rbp-180], 0
	jmp	.L392
.L405:
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L393
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L394
.L393:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L394:
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-192], rax
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L395
.L399:
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-192]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L414
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L415
	add	QWORD PTR [rbp-192], 1
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
.L395:
	mov	rax, QWORD PTR [rbp-192]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L399
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L400
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L401
.L400:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L401:
	mov	rax, QWORD PTR [rax]
	mov	rdx, rax
	mov	eax, 0
	call	rdx
	jmp	.L374
.L414:
	nop
	jmp	.L397
.L415:
	nop
.L397:
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L403
	mov	eax, DWORD PTR [rbp-224]
	add	eax, 8
	mov	DWORD PTR [rbp-224], eax
	jmp	.L416
.L403:
	mov	rax, QWORD PTR [rbp-216]
	add	rax, 8
	mov	QWORD PTR [rbp-216], rax
.L416:
	nop
	add	DWORD PTR [rbp-180], 1
.L392:
	mov	eax, DWORD PTR [rbp-180]
	cmp	eax, DWORD PTR [rbp-244]
	jb	.L405
	mov	rdx, QWORD PTR [rbp-240]
	mov	eax, 0
	call	rdx
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
	nop
.L374:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE41:
	.size	itr_text, .-itr_text
	.globl	itr_jtext
	.type	itr_jtext, @function
itr_jtext:
.LFB42:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 136
	mov	QWORD PTR [rbp-232], rdi
	mov	QWORD PTR [rbp-240], rsi
	mov	DWORD PTR [rbp-244], edx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L450
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L450:
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rbp-200], rax
.L434:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 59
	je	.L419
	cmp	eax, 59
	jg	.L453
	cmp	eax, 32
	je	.L454
	cmp	eax, 32
	jg	.L453
	cmp	eax, 9
	je	.L455
	cmp	eax, 10
	je	.L423
	jmp	.L453
.L423:
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
	jmp	.L424
.L419:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rcx, [rax+1]
	mov	rdx, QWORD PTR [rbp-200]
	mov	QWORD PTR [rdx+16], rcx
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	jne	.L425
	jmp	.L426
.L430:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	jne	.L427
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 59
	je	.L456
.L427:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	jne	.L429
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
.L429:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
.L426:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L430
	jmp	.L456
.L425:
	mov	rax, QWORD PTR [rbp-200]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	DWORD PTR [rax+24], edx
	jmp	.L431
.L432:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
.L431:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L456
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L432
	jmp	.L456
.L454:
	nop
	jmp	.L424
.L455:
	nop
	jmp	.L424
.L456:
	nop
.L424:
	mov	rax, QWORD PTR [rbp-200]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-200]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L434
.L453:
	nop
	mov	DWORD PTR [rbp-224], 24
	mov	DWORD PTR [rbp-220], 48
	lea	rax, [rbp+16]
	mov	QWORD PTR [rbp-216], rax
	lea	rax, [rbp-176]
	mov	QWORD PTR [rbp-208], rax
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+8], rdx
	mov	DWORD PTR [rbp-180], 0
	jmp	.L435
.L448:
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L436
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L437
.L436:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L437:
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-192], rax
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L438
.L442:
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-192]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L457
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L458
	add	QWORD PTR [rbp-192], 1
	mov	rax, QWORD PTR [rbp-232]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
.L438:
	mov	rax, QWORD PTR [rbp-192]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L442
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L443
	mov	rax, QWORD PTR [rbp-208]
	mov	edx, DWORD PTR [rbp-224]
	mov	edx, edx
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-224]
	add	edx, 8
	mov	DWORD PTR [rbp-224], edx
	jmp	.L444
.L443:
	mov	rax, QWORD PTR [rbp-216]
	lea	rdx, [rax+8]
	mov	QWORD PTR [rbp-216], rdx
.L444:
	mov	rax, QWORD PTR [rax]
	jmp	.L449
.L457:
	nop
	jmp	.L440
.L458:
	nop
.L440:
	mov	eax, DWORD PTR [rbp-224]
	cmp	eax, 47
	ja	.L446
	mov	eax, DWORD PTR [rbp-224]
	add	eax, 8
	mov	DWORD PTR [rbp-224], eax
	jmp	.L459
.L446:
	mov	rax, QWORD PTR [rbp-216]
	add	rax, 8
	mov	QWORD PTR [rbp-216], rax
.L459:
	nop
	add	DWORD PTR [rbp-180], 1
.L435:
	mov	eax, DWORD PTR [rbp-180]
	cmp	eax, DWORD PTR [rbp-244]
	jb	.L448
	mov	rax, QWORD PTR [rbp-232]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-232]
	mov	QWORD PTR [rax+16], rdx
	mov	rax, QWORD PTR [rbp-240]
.L449:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE42:
	.size	itr_jtext, .-itr_jtext
	.globl	itr_char
	.type	itr_char, @function
itr_char:
.LFB43:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	eax, esi
	mov	BYTE PTR [rbp-28], al
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-8], rax
.L461:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 32
	je	.L462
	cmp	eax, 32
	jg	.L468
	cmp	eax, 9
	je	.L462
	cmp	eax, 10
	jne	.L468
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+24]
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax+24], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L461
.L462:
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	jmp	.L461
.L468:
	nop
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	movzx	eax, BYTE PTR [rax]
	cmp	BYTE PTR [rbp-28], al
	jne	.L465
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+16]
	lea	rdx, [rax+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 1
	jmp	.L466
.L465:
	mov	eax, 0
.L466:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE43:
	.size	itr_char, .-itr_char
	.globl	itr_search
	.type	itr_search, @function
itr_search:
.LFB44:
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
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	strsearch
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+16], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	jne	.L470
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L471
.L470:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L471:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE44:
	.size	itr_search, .-itr_search
	.globl	itr_searchbf
	.type	itr_searchbf, @function
itr_searchbf:
.LFB45:
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
	mov	rax, QWORD PTR [rax+16]
	mov	rdx, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	strsearchbf
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+16], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	jne	.L473
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+16], rdx
	mov	eax, 0
	jmp	.L474
.L473:
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+16]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], rdx
	mov	eax, 1
.L474:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE45:
	.size	itr_searchbf, .-itr_searchbf
	.section	.rodata
	.align 16
.LC52:
	.long	0
	.long	0
	.long	0
	.long	-2147483648
	.align 8
.LC55:
	.long	0
	.long	1072693248
	.align 8
.LC56:
	.long	0
	.long	0
	.align 8
.LC57:
	.long	0
	.long	1076101120
	.align 8
.LC58:
	.long	0
	.long	1078460416
	.align 8
.LC67:
	.long	0
	.long	-1074790400
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
