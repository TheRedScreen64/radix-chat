	.file	"RadixGTK.c"
	.intel_syntax noprefix
	.text
	.globl	gtk_thread
	.bss
	.align 8
	.type	gtk_thread, @object
	.size	gtk_thread, 8
gtk_thread:
	.zero	8
	.globl	gtk_window
	.align 8
	.type	gtk_window, @object
	.size	gtk_window, 8
gtk_window:
	.zero	8
	.globl	gtk_view
	.align 8
	.type	gtk_view, @object
	.size	gtk_view, 8
gtk_view:
	.zero	8
	.globl	gtk_bgcolor
	.align 32
	.type	gtk_bgcolor, @object
	.size	gtk_bgcolor, 32
gtk_bgcolor:
	.zero	32
	.globl	gtk_semaphore
	.align 32
	.type	gtk_semaphore, @object
	.size	gtk_semaphore, 32
gtk_semaphore:
	.zero	32
	.section	.rodata
.LC0:
	.string	"destroy"
.LC1:
	.string	"enable-webgl"
.LC2:
	.string	"enable-webaudio"
.LC3:
	.string	"enable-developer-extras"
.LC4:
	.string	"enable_media"
	.align 8
.LC5:
	.string	"media_playback_requires_user_gesture"
.LC6:
	.string	"disable-web-security"
.LC7:
	.string	"Radix Chat"
	.text
	.globl	radix_gtk_overrideAsCenteredWindow
	.type	radix_gtk_overrideAsCenteredWindow, @function
radix_gtk_overrideAsCenteredWindow:
.LFB2913:
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
	call	gtk_widget_get_type
	mov	rdx, rax
	mov	rax, QWORD PTR gtk_window[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	g_type_check_instance_cast
	mov	rdi, rax
	call	gtk_widget_hide
	mov	edi, 0
	call	gtk_window_new
	mov	rbx, rax
	mov	rax, QWORD PTR [rbp-40]
	mov	r13d, DWORD PTR [rax+12]
	mov	rax, QWORD PTR [rbp-40]
	mov	r12d, DWORD PTR [rax+8]
	call	gtk_window_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	edx, r13d
	mov	esi, r12d
	mov	rdi, rax
	call	gtk_window_set_default_size
	call	gtk_window_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	esi, 1
	mov	rdi, rax
	call	gtk_window_set_position
	mov	edx, OFFSET FLAT:gtk_bgcolor
	mov	esi, 0
	mov	rdi, rbx
	call	gtk_widget_override_background_color
	mov	r9d, 0
	mov	r8d, 0
	mov	ecx, 0
	mov	edx, OFFSET FLAT:radix_onExit
	mov	esi, OFFSET FLAT:.LC0
	mov	rdi, rbx
	call	g_signal_connect_data
	mov	rax, rbx
	mov	QWORD PTR gtk_window[rip], rax
	call	webkit_web_view_get_type
	mov	rbx, rax
	call	webkit_web_view_new
	mov	rsi, rbx
	mov	rdi, rax
	call	g_type_check_instance_cast
	mov	rbx, rax
	call	webkit_web_view_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	esi, OFFSET FLAT:gtk_bgcolor
	mov	rdi, rax
	call	webkit_web_view_set_background_color
	call	gtk_widget_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	r12, rax
	call	gtk_container_get_type
	mov	rdx, rax
	mov	rax, QWORD PTR gtk_window[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	g_type_check_instance_cast
	mov	rsi, r12
	mov	rdi, rax
	call	gtk_container_add
	mov	rax, rbx
	mov	QWORD PTR gtk_view[rip], rax
	sub	rsp, 8
	push	0
	push	1
	push	OFFSET FLAT:.LC4
	push	0
	push	OFFSET FLAT:.LC5
	push	1
	push	OFFSET FLAT:.LC6
	mov	r9d, 1
	mov	r8d, OFFSET FLAT:.LC1
	mov	ecx, 1
	mov	edx, OFFSET FLAT:.LC2
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC3
	mov	eax, 0
	call	webkit_settings_new_with_settings
	add	rsp, 64
	mov	rbx, rax
	call	webkit_web_view_get_type
	mov	rdx, rax
	mov	rax, QWORD PTR gtk_view[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	g_type_check_instance_cast
	mov	rsi, rbx
	mov	rdi, rax
	call	webkit_web_view_set_settings
	mov	rax, QWORD PTR [rbp-40]
	mov	rax, QWORD PTR [rax+16]
	test	rax, rax
	je	.L2
	mov	rax, QWORD PTR [rbp-40]
	mov	rbx, QWORD PTR [rax+16]
	jmp	.L3
.L2:
	mov	ebx, OFFSET FLAT:.LC7
.L3:
	call	gtk_window_get_type
	mov	rdx, rax
	mov	rax, QWORD PTR gtk_window[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	g_type_check_instance_cast
	mov	rsi, rbx
	mov	rdi, rax
	call	gtk_window_set_title
	mov	rax, QWORD PTR [rbp-40]
	mov	ebx, DWORD PTR [rax+24]
	call	gtk_window_get_type
	mov	rdx, rax
	mov	rax, QWORD PTR gtk_window[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	g_type_check_instance_cast
	mov	esi, ebx
	mov	rdi, rax
	call	gtk_window_set_resizable
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR gtk_view[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	webkit_web_view_load_uri
	mov	rax, QWORD PTR gtk_window[rip]
	mov	rdi, rax
	call	gtk_widget_show_all
	mov	edi, OFFSET FLAT:gtk_semaphore
	call	sem_post
	mov	eax, 0
	lea	rsp, [rbp-24]
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2913:
	.size	radix_gtk_overrideAsCenteredWindow, .-radix_gtk_overrideAsCenteredWindow
	.section	.rodata
.LC8:
	.string	"rgb(228, 223, 218)"
.LC9:
	.string	"./assets/loader.html"
	.text
	.type	_radix_gtk_init, @function
_radix_gtk_init:
.LFB2914:
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
	sub	rsp, 184
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	mov	esi, 0
	mov	edi, 0
	call	gtk_init
	mov	esi, OFFSET FLAT:.LC8
	mov	edi, OFFSET FLAT:gtk_bgcolor
	call	gdk_rgba_parse
	mov	edi, 0
	call	gtk_window_new
	mov	rbx, rax
	call	gtk_window_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	edx, 400
	mov	esi, 400
	mov	rdi, rax
	call	gtk_window_set_default_size
	call	gtk_window_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	esi, 1
	mov	rdi, rax
	call	gtk_window_set_position
	mov	edx, OFFSET FLAT:gtk_bgcolor
	mov	esi, 0
	mov	rdi, rbx
	call	gtk_widget_override_background_color
	mov	r9d, 0
	mov	r8d, 0
	mov	ecx, 0
	mov	edx, OFFSET FLAT:radix_onExit
	mov	esi, OFFSET FLAT:.LC0
	mov	rdi, rbx
	call	g_signal_connect_data
	mov	rax, rbx
	mov	rbx, rax
	call	gtk_window_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	esi, 0
	mov	rdi, rax
	call	gtk_window_set_resizable
	call	gtk_window_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	esi, 0
	mov	rdi, rax
	call	gtk_window_set_decorated
	call	webkit_web_view_get_type
	mov	r14, rax
	call	webkit_web_view_new
	mov	rsi, r14
	mov	rdi, rax
	call	g_type_check_instance_cast
	mov	r14, rax
	call	webkit_web_view_get_type
	mov	rsi, rax
	mov	rdi, r14
	call	g_type_check_instance_cast
	mov	esi, OFFSET FLAT:gtk_bgcolor
	mov	rdi, rax
	call	webkit_web_view_set_background_color
	call	gtk_widget_get_type
	mov	rsi, rax
	mov	rdi, r14
	call	g_type_check_instance_cast
	mov	r15, rax
	call	gtk_container_get_type
	mov	rsi, rax
	mov	rdi, rbx
	call	g_type_check_instance_cast
	mov	rsi, r15
	mov	rdi, rax
	call	gtk_container_add
	mov	rax, r14
	mov	r15, rax
	mov	esi, 0
	mov	edi, OFFSET FLAT:.LC9
	mov	eax, 0
	call	open
	mov	DWORD PTR [rbp-52], eax
	lea	rdx, [rbp-224]
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, rdx
	mov	edi, eax
	call	fstat
	mov	rax, QWORD PTR [rbp-176]
	add	rax, 1
	mov	rdi, rax
	call	malloc
	mov	r14, rax
	mov	rax, QWORD PTR [rbp-176]
	mov	rdx, rax
	mov	eax, DWORD PTR [rbp-52]
	mov	rsi, r14
	mov	edi, eax
	call	read
	mov	eax, DWORD PTR [rbp-52]
	mov	edi, eax
	call	close
	mov	rax, QWORD PTR [rbp-176]
	add	rax, r14
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-176]
	mov	r12, r14
	mov	edx, eax
	mov	rcx, r13
	movabs	rax, -4294967296
	and	rax, rcx
	or	rax, rdx
	mov	r13, rax
	mov	QWORD PTR [rbp-80], r12
	mov	QWORD PTR [rbp-72], r13
	mov	rax, QWORD PTR [rbp-80]
	mov	edx, 0
	mov	rsi, rax
	mov	rdi, r15
	call	webkit_web_view_load_html
	mov	rax, QWORD PTR [rbp-80]
	mov	rdi, rax
	call	free
	mov	rdi, rbx
	call	gtk_widget_show_all
	mov	QWORD PTR gtk_view[rip], r15
	mov	QWORD PTR gtk_window[rip], rbx
	call	gtk_main
	nop
	add	rsp, 184
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2914:
	.size	_radix_gtk_init, .-_radix_gtk_init
	.section	.rodata
.LC10:
	.string	"pthread"
	.text
	.globl	radix_gtk_init
	.type	radix_gtk_init, @function
radix_gtk_init:
.LFB2915:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	ecx, 0
	mov	edx, OFFSET FLAT:_radix_gtk_init
	mov	esi, 0
	mov	edi, OFFSET FLAT:gtk_thread
	call	pthread_create
	test	eax, eax
	je	.L7
	mov	edi, OFFSET FLAT:.LC10
	call	perror
	jmp	.L6
.L7:
	mov	edx, 0
	mov	esi, 0
	mov	edi, OFFSET FLAT:gtk_semaphore
	call	sem_init
.L6:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2915:
	.size	radix_gtk_init, .-radix_gtk_init
	.globl	radix_gtk_uri
	.type	radix_gtk_uri, @function
radix_gtk_uri:
.LFB2916:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	lea	rsi, [rbp+16]
	mov	edi, OFFSET FLAT:radix_gtk_overrideAsCenteredWindow
	call	g_idle_add
	mov	edi, OFFSET FLAT:gtk_semaphore
	call	sem_wait
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2916:
	.size	radix_gtk_uri, .-radix_gtk_uri
	.globl	radix_gtk_getWindow
	.type	radix_gtk_getWindow, @function
radix_gtk_getWindow:
.LFB2917:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, QWORD PTR gtk_window[rip]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2917:
	.size	radix_gtk_getWindow, .-radix_gtk_getWindow
	.globl	radix_gtk_getView
	.type	radix_gtk_getView, @function
radix_gtk_getView:
.LFB2918:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, QWORD PTR gtk_view[rip]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2918:
	.size	radix_gtk_getView, .-radix_gtk_getView
	.globl	radix_gtk_exit
	.type	radix_gtk_exit, @function
radix_gtk_exit:
.LFB2919:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	call	gtk_main_quit
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2919:
	.size	radix_gtk_exit, .-radix_gtk_exit
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
