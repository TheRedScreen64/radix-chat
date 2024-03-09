	.file	"WSLocal.c"
	.intel_syntax noprefix
	.text
	.globl	file_check
	.bss
	.align 8
	.type	file_check, @object
	.size	file_check, 8
file_check:
	.zero	8
	.local	SRV_STATIC_DIR_R
	.comm	SRV_STATIC_DIR_R,8,8
	.globl	microhttp_server
	.align 8
	.type	microhttp_server, @object
	.size	microhttp_server, 8
microhttp_server:
	.zero	8
	.globl	staticFiles
	.align 8
	.type	staticFiles, @object
	.size	staticFiles, 8
staticFiles:
	.zero	8
	.globl	static404
	.align 16
	.type	static404, @object
	.size	static404, 16
static404:
	.zero	16
	.globl	staticCMS
	.align 16
	.type	staticCMS, @object
	.size	staticCMS, 16
staticCMS:
	.zero	16
	.globl	pageData
	.align 16
	.type	pageData, @object
	.size	pageData, 16
pageData:
	.zero	16
	.globl	pageDataJsonRawString
	.align 8
	.type	pageDataJsonRawString, @object
	.size	pageDataJsonRawString, 8
pageDataJsonRawString:
	.zero	8
	.globl	metaData
	.align 8
	.type	metaData, @object
	.size	metaData, 8
metaData:
	.zero	8
	.section	.rodata
	.align 8
.LC0:
	.string	"./assets/json/pages-config.json"
.LC1:
	.string	"title"
.LC2:
	.string	"<title>%s</title>\n"
.LC3:
	.string	"description"
	.align 8
.LC4:
	.string	"<meta name=\"description\" content=\"%s\">\n"
.LC5:
	.string	"author"
	.align 8
.LC6:
	.string	"<meta name=\"author\" content=\"%s\">\n"
.LC7:
	.string	"keywords"
	.align 8
.LC8:
	.string	"<meta name=\"keywords\" content=\""
.LC9:
	.string	", "
.LC10:
	.string	"\">\n"
.LC11:
	.string	"static"
.LC12:
	.string	"route"
.LC13:
	.string	"C_PRELOAD_CONST_PAGES"
	.align 8
.LC14:
	.string	"<meta name=\"cms-dynamic-header\">"
	.text
	.type	srv_optainPageData, @function
srv_optainPageData:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r13
	push	r12
	push	rbx
	sub	rsp, 328
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	mov	esi, 0
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-52], eax
	cmp	DWORD PTR [rbp-52], 0
	jns	.L2
	mov	edi, 1
	call	exit
.L2:
	lea	rdx, [rbp-352]
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, rdx
	mov	edi, eax
	call	fstat
	mov	rax, QWORD PTR [rbp-304]
	add	rax, 1
	mov	rdi, rax
	call	malloc
	mov	rbx, rax
	mov	rax, QWORD PTR [rbp-304]
	mov	rdx, rax
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, rbx
	mov	edi, eax
	call	read
	mov	rax, QWORD PTR [rbp-304]
	add	rax, rbx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-304]
	mov	r12, rbx
	mov	edx, eax
	mov	rcx, r13
	movabs	rax, -4294967296
	and	rax, rcx
	or	rax, rdx
	mov	r13, rax
	mov	QWORD PTR [rbp-128], r12
	mov	QWORD PTR [rbp-120], r13
	mov	eax, DWORD PTR [rbp-52]
	mov	edi, eax
	call	close
	mov	eax, 0
	call	sqtr_local_create
	mov	QWORD PTR metaData[rip], rax
	mov	eax, DWORD PTR [rbp-120]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-128]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L3
	mov	rax, QWORD PTR [rbp-128]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-128]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-128], rax
.L3:
	mov	rdx, QWORD PTR [rbp-128]
	mov	eax, DWORD PTR [rbp-120]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-128]
	mov	QWORD PTR pageDataJsonRawString[rip], rax
	mov	rax, QWORD PTR pageDataJsonRawString[rip]
	mov	QWORD PTR [rbp-160], rax
	mov	rax, QWORD PTR pageDataJsonRawString[rip]
	mov	QWORD PTR [rbp-152], rax
	mov	rax, QWORD PTR pageDataJsonRawString[rip]
	mov	QWORD PTR [rbp-144], rax
	mov	DWORD PTR [rbp-136], 1
	mov	eax, 0
	call	itr_construct
	lea	rax, [rbp-160]
	mov	esi, OFFSET FLAT:pageData
	mov	rdi, rax
	call	itr_getAbstract
	mov	rax, QWORD PTR pageData[rip+8]
	mov	QWORD PTR [rbp-64], rax
	mov	DWORD PTR [rbp-36], 0
	jmp	.L4
.L9:
	mov	rax, QWORD PTR [rbp-64]
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR [rbp-36]
	movsx	rdx, edx
	sal	rdx, 4
	add	rax, rdx
	mov	QWORD PTR [rbp-72], rax
	mov	rax, QWORD PTR [rbp-72]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-80], rax
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-208], rax
	mov	DWORD PTR [rbp-200], 0
	mov	rax, QWORD PTR [rbp-80]
	mov	esi, OFFSET FLAT:.LC1
	mov	rdi, rax
	call	shm_get
	mov	rdx, QWORD PTR [rax+8]
	lea	rax, [rbp-208]
	mov	esi, OFFSET FLAT:.LC2
	mov	rdi, rax
	mov	eax, 0
	call	xstrappendformat
	mov	rax, QWORD PTR [rbp-80]
	mov	esi, OFFSET FLAT:.LC3
	mov	rdi, rax
	call	shm_get
	mov	rdx, QWORD PTR [rax+8]
	lea	rax, [rbp-208]
	mov	esi, OFFSET FLAT:.LC4
	mov	rdi, rax
	mov	eax, 0
	call	xstrappendformat
	mov	rax, QWORD PTR [rbp-80]
	mov	esi, OFFSET FLAT:.LC5
	mov	rdi, rax
	call	shm_get
	mov	rdx, QWORD PTR [rax+8]
	lea	rax, [rbp-208]
	mov	esi, OFFSET FLAT:.LC6
	mov	rdi, rax
	mov	eax, 0
	call	xstrappendformat
	mov	rax, QWORD PTR [rbp-80]
	mov	esi, OFFSET FLAT:.LC7
	mov	rdi, rax
	call	shm_get
	mov	QWORD PTR [rbp-88], rax
	lea	rax, [rbp-208]
	mov	esi, OFFSET FLAT:.LC8
	mov	rdi, rax
	call	xstrappends
	mov	rax, QWORD PTR [rbp-88]
	mov	rax, QWORD PTR [rax+8]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-88]
	mov	rax, QWORD PTR [rax+8]
	mov	eax, DWORD PTR [rax+8]
	mov	eax, eax
	sal	rax, 4
	add	rax, rdx
	mov	QWORD PTR [rbp-96], rax
	mov	rax, QWORD PTR [rbp-88]
	mov	rax, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-48], rax
	jmp	.L5
.L7:
	mov	rax, QWORD PTR [rbp-48]
	mov	rdx, QWORD PTR [rax+8]
	lea	rax, [rbp-208]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	rax, QWORD PTR [rbp-96]
	sub	rax, 16
	cmp	QWORD PTR [rbp-48], rax
	je	.L6
	lea	rax, [rbp-208]
	mov	esi, OFFSET FLAT:.LC9
	mov	rdi, rax
	call	xstrappends
.L6:
	add	QWORD PTR [rbp-48], 16
.L5:
	mov	rax, QWORD PTR [rbp-48]
	cmp	rax, QWORD PTR [rbp-96]
	jb	.L7
	lea	rax, [rbp-208]
	mov	esi, OFFSET FLAT:.LC10
	mov	rdi, rax
	call	xstrappends
	mov	edi, 32
	call	malloc
	mov	QWORD PTR [rbp-104], rax
	mov	eax, DWORD PTR [rbp-200]
	movsx	rbx, eax
	mov	rax, QWORD PTR [rbp-208]
	mov	rdi, rax
	call	malloc_usable_size
	cmp	rbx, rax
	jne	.L8
	mov	rax, QWORD PTR [rbp-208]
	mov	rdi, rax
	call	malloc_usable_size
	lea	rdx, [rax+rax]
	mov	rax, QWORD PTR [rbp-208]
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc
	mov	QWORD PTR [rbp-208], rax
.L8:
	mov	rdx, QWORD PTR [rbp-208]
	mov	eax, DWORD PTR [rbp-200]
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rdx, QWORD PTR [rbp-208]
	mov	rax, QWORD PTR [rbp-104]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-80]
	mov	esi, OFFSET FLAT:.LC11
	mov	rdi, rax
	call	shm_get
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-104]
	mov	QWORD PTR [rax+8], rdx
	mov	rax, QWORD PTR [rbp-80]
	mov	esi, OFFSET FLAT:.LC12
	mov	rdi, rax
	call	shm_get
	mov	rbx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-104]
	mov	DWORD PTR [rax+24], 0
	mov	edi, 2048
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-104]
	mov	QWORD PTR [rax+16], rdx
	mov	rsi, QWORD PTR pageDataJsonRawString[rip]
	mov	rdx, QWORD PTR [rbp-208]
	mov	rax, QWORD PTR staticCMS[rip]
	mov	rcx, QWORD PTR [rbp-104]
	lea	rdi, [rcx+16]
	sub	rsp, 8
	push	0
	mov	r9, rsi
	mov	r8d, OFFSET FLAT:.LC13
	mov	rcx, rdx
	mov	edx, OFFSET FLAT:.LC14
	mov	rsi, rax
	mov	eax, 0
	call	strreplaceallmultipletd
	add	rsp, 16
	mov	rax, QWORD PTR metaData[rip]
	mov	rdx, QWORD PTR [rbp-104]
	mov	rsi, rbx
	mov	rdi, rax
	call	sqtr_local_set
	add	DWORD PTR [rbp-36], 1
.L4:
	mov	rax, QWORD PTR [rbp-64]
	mov	eax, DWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-36]
	cmp	edx, eax
	jb	.L9
	nop
	nop
	lea	rsp, [rbp-24]
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	srv_optainPageData, .-srv_optainPageData
	.type	srv_optainDataForRoute, @function
srv_optainDataForRoute:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR metaData[rip]
	mov	rdx, QWORD PTR [rbp-24]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_get
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	srv_optainDataForRoute, .-srv_optainDataForRoute
	.type	srv_destroyPageData, @function
srv_destroyPageData:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	jmp	.L13
.L14:
	mov	rax, QWORD PTR metaData[rip]
	mov	rdi, rax
	call	sqtr_local_popl
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax+16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	free
.L13:
	mov	rax, QWORD PTR metaData[rip]
	mov	rdi, rax
	call	sqtr_local_empty
	test	eax, eax
	je	.L14
	mov	rax, QWORD PTR metaData[rip]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR pageDataJsonRawString[rip]
	mov	rdi, rax
	call	free
	mov	edi, OFFSET FLAT:pageData
	call	itr_clearAbstract
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	srv_destroyPageData, .-srv_destroyPageData
	.type	srv_response404, @function
srv_response404:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rcx, QWORD PTR static404[rip]
	mov	eax, DWORD PTR static404[rip+8]
	cdqe
	mov	edx, 0
	mov	rsi, rcx
	mov	rdi, rax
	call	MHD_create_response_from_buffer
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	srv_response404, .-srv_response404
	.type	srv_responseDef, @function
srv_responseDef:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	srv_optainDataForRoute
	mov	QWORD PTR [rbp-8], rax
	cmp	QWORD PTR [rbp-8], 0
	jne	.L18
	mov	eax, 0
	call	srv_response404
	jmp	.L20
.L18:
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	srv_optainDataForRoute
	mov	rdx, QWORD PTR [rax+24]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR [rbp-32], rax
	mov	QWORD PTR [rbp-24], rdx
	mov	rcx, QWORD PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	mov	edx, 0
	mov	rsi, rcx
	mov	rdi, rax
	call	MHD_create_response_from_buffer
.L20:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	srv_responseDef, .-srv_responseDef
	.section	.rodata
.LC15:
	.string	".svg"
.LC16:
	.string	".jpeg"
.LC17:
	.string	".png"
.LC18:
	.string	".nosehad"
.LC19:
	.string	".mpeg"
.LC20:
	.string	".css"
.LC21:
	.string	".js"
.LC22:
	.string	".json"
.LC23:
	.string	".ttf"
.LC24:
	.string	"text/html"
.LC25:
	.string	"image/png"
.LC26:
	.string	"image/jpeg"
.LC27:
	.string	"image/svg+xml"
.LC28:
	.string	"font/ttf"
.LC29:
	.string	"application/json"
.LC30:
	.string	"text/javascript"
.LC31:
	.string	"text/css"
.LC32:
	.string	"audio/mpeg"
	.text
	.type	srv_optainct, @function
srv_optainct:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	rax, rdi
	mov	rcx, rsi
	mov	rdx, rcx
	mov	QWORD PTR [rbp-16], rax
	mov	QWORD PTR [rbp-8], rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	xstrgetfileextension
	sub	rsp, 8
	push	OFFSET FLAT:.LC19
	push	OFFSET FLAT:.LC20
	push	OFFSET FLAT:.LC21
	push	OFFSET FLAT:.LC22
	push	OFFSET FLAT:.LC23
	mov	r9d, OFFSET FLAT:.LC15
	mov	r8d, OFFSET FLAT:.LC16
	mov	ecx, OFFSET FLAT:.LC17
	mov	edx, OFFSET FLAT:.LC18
	mov	esi, 9
	mov	rdi, rax
	mov	eax, 0
	call	strequalsmo
	add	rsp, 48
	cmp	eax, 8
	ja	.L22
	mov	eax, eax
	mov	rax, QWORD PTR .L24[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L24:
	.quad	.L32
	.quad	.L31
	.quad	.L30
	.quad	.L29
	.quad	.L28
	.quad	.L27
	.quad	.L26
	.quad	.L25
	.quad	.L23
	.text
.L32:
	mov	eax, OFFSET FLAT:.LC24
	jmp	.L33
.L31:
	mov	eax, OFFSET FLAT:.LC25
	jmp	.L33
.L30:
	mov	eax, OFFSET FLAT:.LC26
	jmp	.L33
.L29:
	mov	eax, OFFSET FLAT:.LC27
	jmp	.L33
.L28:
	mov	eax, OFFSET FLAT:.LC28
	jmp	.L33
.L27:
	mov	eax, OFFSET FLAT:.LC29
	jmp	.L33
.L26:
	mov	eax, OFFSET FLAT:.LC30
	jmp	.L33
.L25:
	mov	eax, OFFSET FLAT:.LC31
	jmp	.L33
.L23:
	mov	eax, OFFSET FLAT:.LC32
	jmp	.L33
.L22:
	mov	eax, OFFSET FLAT:.LC24
.L33:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	srv_optainct, .-srv_optainct
	.section	.rodata
.LC33:
	.string	"/static/"
.LC34:
	.string	"Content-Type"
	.text
	.type	srv_handleonreq, @function
srv_handleonreq:
.LFB12:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 264
	.cfi_offset 3, -24
	mov	QWORD PTR [rbp-232], rdi
	mov	QWORD PTR [rbp-240], rsi
	mov	QWORD PTR [rbp-248], rdx
	mov	QWORD PTR [rbp-256], rcx
	mov	QWORD PTR [rbp-264], r8
	mov	QWORD PTR [rbp-272], r9
	mov	rax, QWORD PTR [rbp-248]
	mov	esi, OFFSET FLAT:.LC33
	mov	rdi, rax
	call	strremoveAdStart
	mov	QWORD PTR [rbp-32], rax
	cmp	QWORD PTR [rbp-32], 0
	jne	.L35
	mov	rax, QWORD PTR [rbp-248]
	mov	rdi, rax
	call	srv_responseDef
	mov	QWORD PTR [rbp-24], rax
	mov	rdx, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rbp-240]
	mov	esi, 200
	mov	rdi, rax
	call	MHD_queue_response
	mov	DWORD PTR [rbp-52], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	MHD_destroy_response
	mov	eax, DWORD PTR [rbp-52]
	jmp	.L41
.L35:
	mov	rax, QWORD PTR staticFiles[rip]
	mov	rdx, QWORD PTR [rbp-32]
	mov	rsi, rdx
	mov	rdi, rax
	call	sqtr_local_get
	mov	QWORD PTR [rbp-40], rax
	cmp	QWORD PTR [rbp-40], 0
	je	.L37
	mov	rax, QWORD PTR [rbp-40]
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	cdqe
	mov	edx, 0
	mov	rsi, rcx
	mov	rdi, rax
	call	MHD_create_response_from_buffer
	mov	QWORD PTR [rbp-24], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rbx, QWORD PTR [rax+16]
	jmp	.L38
.L37:
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-80], rax
	mov	DWORD PTR [rbp-72], 0
	mov	rdx, QWORD PTR SRV_STATIC_DIR_R[rip]
	lea	rax, [rbp-80]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	mov	rdx, QWORD PTR [rbp-32]
	lea	rax, [rbp-80]
	mov	rsi, rdx
	mov	rdi, rax
	call	xstrappends
	lea	rax, [rbp-80]
	mov	esi, 0
	mov	rdi, rax
	call	xstrappendc
	mov	rdx, QWORD PTR [rbp-80]
	mov	rax, QWORD PTR [rbp-72]
	mov	rdi, rdx
	mov	rsi, rax
	call	srv_optainct
	mov	rbx, rax
	mov	rax, QWORD PTR [rbp-80]
	mov	esi, 0
	mov	rdi, rax
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-44], eax
	cmp	DWORD PTR [rbp-44], 0
	jns	.L39
	mov	eax, 0
	call	srv_response404
	mov	QWORD PTR [rbp-24], rax
	jmp	.L38
.L39:
	lea	rdx, [rbp-224]
	mov	eax, DWORD PTR [rbp-44]
	mov	rsi, rdx
	mov	edi, eax
	call	fstat
	mov	edi, 24
	call	malloc
	mov	QWORD PTR [rbp-40], rax
	mov	rax, QWORD PTR [rbp-176]
	mov	rdi, rax
	call	malloc
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-176]
	mov	edx, eax
	mov	rax, QWORD PTR [rbp-40]
	mov	DWORD PTR [rax+8], edx
	mov	rax, QWORD PTR [rbp-176]
	mov	rdx, rax
	mov	rax, QWORD PTR [rbp-40]
	mov	rcx, QWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-44]
	mov	rsi, rcx
	mov	edi, eax
	call	read
	cmp	rax, -1
	jne	.L40
	mov	rax, QWORD PTR [rbp-80]
	mov	rdi, rax
	call	free
	mov	eax, 0
	call	srv_response404
	mov	QWORD PTR [rbp-24], rax
	jmp	.L38
.L40:
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rax+16], rbx
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	strcopyusingmalloc
	mov	rcx, rax
	mov	rax, QWORD PTR staticFiles[rip]
	mov	rdx, QWORD PTR [rbp-40]
	mov	rsi, rcx
	mov	rdi, rax
	call	sqtr_local_set
	mov	eax, DWORD PTR [rbp-44]
	mov	edi, eax
	call	close
	mov	rax, QWORD PTR [rbp-80]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-40]
	mov	rcx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-40]
	mov	eax, DWORD PTR [rax+8]
	cdqe
	mov	edx, 0
	mov	rsi, rcx
	mov	rdi, rax
	call	MHD_create_response_from_buffer
	mov	QWORD PTR [rbp-24], rax
.L38:
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, rbx
	mov	esi, OFFSET FLAT:.LC34
	mov	rdi, rax
	call	MHD_add_response_header
	mov	rdx, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rbp-240]
	mov	esi, 200
	mov	rdi, rax
	call	MHD_queue_response
	mov	DWORD PTR [rbp-48], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	MHD_destroy_response
	mov	eax, DWORD PTR [rbp-48]
.L41:
	mov	rbx, QWORD PTR [rbp-8]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	srv_handleonreq, .-srv_handleonreq
	.section	.rodata
.LC35:
	.string	"./assets/404.nosehad"
.LC36:
	.string	"./assets/cms.nosehad"
	.text
	.type	srv_loadFiles, @function
srv_loadFiles:
.LFB13:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 168
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	mov	eax, 0
	call	sqtr_local_create
	mov	QWORD PTR staticFiles[rip], rax
	mov	esi, 0
	mov	edi, OFFSET FLAT:.LC35
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-52], eax
	cmp	DWORD PTR [rbp-52], 0
	jns	.L43
	mov	edi, 1
	call	exit
.L43:
	lea	rdx, [rbp-208]
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, rdx
	mov	edi, eax
	call	fstat
	mov	rax, QWORD PTR [rbp-160]
	add	rax, 1
	mov	rdi, rax
	call	malloc
	mov	rbx, rax
	mov	rax, QWORD PTR [rbp-160]
	mov	rdx, rax
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, rbx
	mov	edi, eax
	call	read
	mov	rax, QWORD PTR [rbp-160]
	add	rax, rbx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-160]
	mov	r14, rbx
	mov	edx, eax
	mov	rcx, r15
	movabs	rax, -4294967296
	and	rax, rcx
	or	rax, rdx
	mov	r15, rax
	mov	QWORD PTR static404[rip], r14
	mov	QWORD PTR static404[rip+8], r15
	mov	eax, DWORD PTR [rbp-52]
	mov	edi, eax
	call	close
	mov	esi, 0
	mov	edi, OFFSET FLAT:.LC36
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-52], eax
	lea	rdx, [rbp-208]
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, rdx
	mov	edi, eax
	call	fstat
	mov	rax, QWORD PTR [rbp-160]
	add	rax, 1
	mov	rdi, rax
	call	malloc
	mov	rbx, rax
	mov	rax, QWORD PTR [rbp-160]
	mov	rdx, rax
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, rbx
	mov	edi, eax
	call	read
	mov	rax, QWORD PTR [rbp-160]
	add	rax, rbx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-160]
	mov	r12, rbx
	mov	edx, eax
	mov	rcx, r13
	movabs	rax, -4294967296
	and	rax, rcx
	or	rax, rdx
	mov	r13, rax
	mov	QWORD PTR staticCMS[rip], r12
	mov	QWORD PTR staticCMS[rip+8], r13
	mov	eax, DWORD PTR [rbp-52]
	mov	edi, eax
	call	close
	mov	eax, 0
	call	srv_optainPageData
	nop
	add	rsp, 168
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	srv_loadFiles, .-srv_loadFiles
	.section	.rodata
.LC37:
	.string	"./assets/"
	.text
	.type	_radix_srv_start, @function
_radix_srv_start:
.LFB14:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	edi, OFFSET FLAT:radix_srv_exit
	call	atexit
	mov	QWORD PTR SRV_STATIC_DIR_R[rip], OFFSET FLAT:.LC37
	sub	rsp, 8
	push	0
	mov	r9d, 0
	mov	r8d, OFFSET FLAT:srv_handleonreq
	mov	ecx, 0
	mov	edx, 0
	mov	esi, 4564
	mov	edi, 8
	mov	eax, 0
	call	MHD_start_daemon
	add	rsp, 16
	mov	QWORD PTR microhttp_server[rip], rax
	mov	rax, QWORD PTR microhttp_server[rip]
	test	rax, rax
	jne	.L45
	mov	edi, 1
	call	exit
.L45:
	mov	eax, 0
	call	srv_loadFiles
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	_radix_srv_start, .-_radix_srv_start
	.type	srv_unloadFiles, @function
srv_unloadFiles:
.LFB15:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	jmp	.L47
.L48:
	mov	rax, QWORD PTR staticFiles[rip]
	mov	rdi, rax
	call	sqtr_local_popl
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-8]
	mov	rdi, rax
	call	free
.L47:
	mov	rax, QWORD PTR staticFiles[rip]
	mov	rdi, rax
	call	sqtr_local_empty
	test	eax, eax
	je	.L48
	mov	eax, 0
	call	srv_destroyPageData
	mov	rax, QWORD PTR staticFiles[rip]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR static404[rip]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR staticCMS[rip]
	mov	rdi, rax
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	srv_unloadFiles, .-srv_unloadFiles
	.section	.rodata
	.align 8
.LC38:
	.string	"inotifywait -qq -e modify -r \"./html\""
.LC39:
	.string	"./html/build.sh"
	.text
	.type	srv_filelistener, @function
srv_filelistener:
.LFB16:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
.L50:
	mov	edi, OFFSET FLAT:.LC38
	call	system
	mov	edi, OFFSET FLAT:.LC39
	call	system
	mov	eax, 0
	call	srv_unloadFiles
	mov	eax, 0
	call	srv_loadFiles
	jmp	.L50
	.cfi_endproc
.LFE16:
	.size	srv_filelistener, .-srv_filelistener
	.section	.rodata
.LC40:
	.string	"pthread"
	.text
	.globl	radix_srv_start
	.type	radix_srv_start, @function
radix_srv_start:
.LFB17:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	eax, 0
	call	_radix_srv_start
	mov	ecx, 0
	mov	edx, OFFSET FLAT:srv_filelistener
	mov	esi, 0
	mov	edi, OFFSET FLAT:file_check
	call	pthread_create
	test	eax, eax
	je	.L51
	mov	edi, OFFSET FLAT:.LC40
	call	perror
	nop
.L51:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	radix_srv_start, .-radix_srv_start
	.section	.rodata
.LC41:
	.string	"Failed to detach PThread"
	.text
	.globl	radix_srv_exit
	.type	radix_srv_exit, @function
radix_srv_exit:
.LFB18:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, QWORD PTR file_check[rip]
	mov	rdi, rax
	call	pthread_detach
	test	eax, eax
	je	.L54
	mov	edi, OFFSET FLAT:.LC41
	call	perror
.L54:
	mov	rax, QWORD PTR microhttp_server[rip]
	mov	rdi, rax
	call	MHD_stop_daemon
	mov	eax, 0
	call	srv_unloadFiles
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	radix_srv_exit, .-radix_srv_exit
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
