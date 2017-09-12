	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.text
	.align	2
	.globl	es_capicua
	.ent	es_capicua
es_capicua:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$zero,24($fp)
	lw	$a0,56($fp)
	la	$t9,strlen
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	bne	$v0,$zero,$L18
	sw	$zero,36($fp)
	b	$L17
$L18:
	sw	$zero,24($fp)
$L19:
	lw	$v0,28($fp)
	srl	$v1,$v0,1
	lw	$v0,24($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L22
	b	$L20
$L22:
	lw	$v1,28($fp)
	lw	$v0,24($fp)
	subu	$v0,$v1,$v0
	addu	$v0,$v0,-1
	sw	$v0,32($fp)
	lw	$v1,56($fp)
	lw	$v0,24($fp)
	addu	$v0,$v1,$v0
	lb	$v0,0($v0)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$a0,$v0,2
	lw	$v1,56($fp)
	lw	$v0,32($fp)
	addu	$v0,$v1,$v0
	lb	$v0,0($v0)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$v0,$v0,2
	lh	$v1,0($a0)
	lh	$v0,0($v0)
	beq	$v1,$v0,$L21
	sw	$zero,36($fp)
	b	$L17
$L21:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L19
$L20:
	li	$v0,1			# 0x1
	sw	$v0,36($fp)
$L17:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	es_capicua
	.size	es_capicua, .-es_capicua
	.align	2
	.globl	caracter_valido
	.ent	caracter_valido
caracter_valido:
	.frame	$fp,24,$ra		# vars= 8, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,24
	.cprestore 0
	sw	$fp,20($sp)
	sw	$gp,16($sp)
	move	$fp,$sp
	sw	$a0,24($fp)
	lw	$v0,24($fp)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$v0,$v0,2
	lh	$v0,0($v0)
	sw	$v0,8($fp)
	lw	$v0,8($fp)
	slt	$v0,$v0,97
	bne	$v0,$zero,$L27
	lw	$v0,8($fp)
	slt	$v0,$v0,123
	bne	$v0,$zero,$L26
$L27:
	lw	$v0,8($fp)
	slt	$v0,$v0,48
	bne	$v0,$zero,$L28
	lw	$v0,8($fp)
	slt	$v0,$v0,58
	bne	$v0,$zero,$L26
$L28:
	lw	$v1,8($fp)
	li	$v0,45			# 0x2d
	beq	$v1,$v0,$L26
	lw	$v1,8($fp)
	li	$v0,95			# 0x5f
	beq	$v1,$v0,$L26
	b	$L25
$L26:
	li	$v0,1			# 0x1
	sw	$v0,12($fp)
	b	$L24
$L25:
	sw	$zero,12($fp)
$L24:
	lw	$v0,12($fp)
	move	$sp,$fp
	lw	$fp,20($sp)
	addu	$sp,$sp,24
	j	$ra
	.end	caracter_valido
	.size	caracter_valido, .-caracter_valido
	.rdata
	.align	2
$LC0:
	.ascii	"Error al reservar memoria\000"
	.align	2
$LC1:
	.ascii	"Error al leer archivo de entrada\000"
	.text
	.align	2
	.globl	leer_palabra_valida
	.ent	leer_palabra_valida
leer_palabra_valida:
	.frame	$fp,64,$ra		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	sw	$zero,24($fp)
	li	$v0,128			# 0x80
	sw	$v0,28($fp)
	sw	$zero,36($fp)
	sw	$zero,40($fp)
	lw	$a0,28($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L30
	la	$a0,__sF+176
	la	$a1,$LC0
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L30:
	.set	noreorder
	nop
	.set	reorder
$L31:
	lw	$v0,68($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L32
	lw	$a0,68($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$t9,caracter_valido
	jal	$ra,$t9
	bne	$v0,$zero,$L32
	lw	$v0,68($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L35
	la	$a0,__sF+176
	la	$a1,$LC1
	la	$t9,fprintf
	jal	$ra,$t9
$L35:
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sw	$v0,36($fp)
	b	$L31
$L32:
	.set	noreorder
	nop
	.set	reorder
$L36:
	lw	$v0,68($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L37
	lw	$a0,32($fp)
	la	$t9,caracter_valido
	jal	$ra,$t9
	bne	$v0,$zero,$L38
	b	$L37
$L38:
	lw	$v1,36($fp)
	lw	$v0,40($fp)
	addu	$v0,$v1,$v0
	addu	$v1,$v0,1
	lw	$v0,28($fp)
	bne	$v1,$v0,$L40
	lw	$v0,28($fp)
	sll	$v0,$v0,1
	sw	$v0,28($fp)
	lw	$a0,24($fp)
	lw	$a1,28($fp)
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L40
	la	$a0,__sF+176
	la	$a1,$LC0
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L40:
	addu	$a1,$fp,40
	lw	$v1,0($a1)
	move	$a0,$v1
	lw	$v0,24($fp)
	addu	$a0,$a0,$v0
	lbu	$v0,32($fp)
	sb	$v0,0($a0)
	addu	$v1,$v1,1
	sw	$v1,0($a1)
	lw	$a0,68($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,68($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L36
	la	$a0,__sF+176
	la	$a1,$LC1
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L36
$L37:
	lw	$v1,24($fp)
	lw	$v0,40($fp)
	addu	$v0,$v1,$v0
	sb	$zero,0($v0)
	lw	$v1,64($fp)
	lw	$v0,24($fp)
	sw	$v0,0($v1)
	lw	$v0,68($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L44
	lw	$v0,40($fp)
	bne	$v0,$zero,$L43
$L44:
	sw	$zero,44($fp)
	b	$L29
$L43:
	li	$v0,1			# 0x1
	sw	$v0,44($fp)
$L29:
	lw	$v0,44($fp)
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	leer_palabra_valida
	.size	leer_palabra_valida, .-leer_palabra_valida
	.rdata
	.align	2
$LC2:
	.ascii	"%s\n\000"
	.align	2
$LC3:
	.ascii	"Error al escribir en archivo de salida\n\000"
	.text
	.align	2
	.globl	procesar_archivo
	.ent	procesar_archivo
procesar_archivo:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$v0,48($fp)
	beq	$v0,$zero,$L47
	lw	$v0,52($fp)
	bne	$v0,$zero,$L46
$L47:
	lw	$v0,48($fp)
	beq	$v0,$zero,$L48
	lw	$a0,48($fp)
	la	$t9,fclose
	jal	$ra,$t9
$L48:
	lw	$v0,52($fp)
	beq	$v0,$zero,$L49
	lw	$a0,52($fp)
	la	$t9,fclose
	jal	$ra,$t9
$L49:
	sw	$zero,28($fp)
	b	$L45
$L46:
	.set	noreorder
	nop
	.set	reorder
$L50:
	addu	$a0,$fp,24
	lw	$a1,48($fp)
	la	$t9,leer_palabra_valida
	jal	$ra,$t9
	bne	$v0,$zero,$L52
	b	$L51
$L52:
	lw	$a0,24($fp)
	la	$t9,es_capicua
	jal	$ra,$t9
	beq	$v0,$zero,$L53
	lw	$a0,52($fp)
	la	$a1,$LC2
	lw	$a2,24($fp)
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$v0,52($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L53
	la	$a0,__sF+176
	la	$a1,$LC3
	la	$t9,fprintf
	jal	$ra,$t9
$L53:
	lw	$a0,24($fp)
	la	$t9,free
	jal	$ra,$t9
	b	$L50
$L51:
	li	$v0,1			# 0x1
	sw	$v0,28($fp)
$L45:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	procesar_archivo
	.size	procesar_archivo, .-procesar_archivo
	.rdata
	.align	2
$LC4:
	.ascii	"Usage:\n\000"
	.align	2
$LC5:
	.ascii	"\ttp0 -h\n\000"
	.align	2
$LC6:
	.ascii	"\ttp0 -V\n\000"
	.align	2
$LC7:
	.ascii	"\ttp0 [options]\n\000"
	.align	2
$LC8:
	.ascii	"\n\000"
	.align	2
$LC9:
	.ascii	"Options:\n\000"
	.align	2
$LC10:
	.ascii	"\t-v --version\tPrint version and quit.\n\000"
	.align	2
$LC11:
	.ascii	"\t-h --help\tPrint this information.\n\000"
	.align	2
$LC12:
	.ascii	"\t-i --input\tLocation of the input file.\n\000"
	.align	2
$LC13:
	.ascii	"\t-o --output\tLocation of the output file.\n\000"
	.align	2
$LC14:
	.ascii	"Examples:\n\000"
	.align	2
$LC15:
	.ascii	"\ttp0 -i ~/input ~/output\n\000"
	.text
	.align	2
	.globl	mostrar_usage
	.ent	mostrar_usage
mostrar_usage:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC4
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC5
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC6
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC7
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC8
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC9
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC10
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC11
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC12
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC13
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC8
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC14
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC15
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	mostrar_usage
	.size	mostrar_usage, .-mostrar_usage
	.rdata
	.align	2
$LC16:
	.ascii	"tp0 version: %s\n\000"
	.align	2
$LC17:
	.ascii	"0.1.0beta\000"
	.text
	.align	2
	.globl	mostrar_version
	.ent	mostrar_version
mostrar_version:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC16
	la	$a1,$LC17
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	mostrar_version
	.size	mostrar_version, .-mostrar_version
	.rdata
	.align	2
$LC18:
	.ascii	"erro fatal: Los parametros son incorrectos!\n\000"
	.text
	.align	2
	.globl	error_parametros_incorrectos
	.ent	error_parametros_incorrectos
error_parametros_incorrectos:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,__sF+176
	la	$a1,$LC18
	la	$t9,fprintf
	jal	$ra,$t9
	la	$t9,mostrar_usage
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
	.end	error_parametros_incorrectos
	.size	error_parametros_incorrectos, .-error_parametros_incorrectos
	.rdata
	.align	2
$LC19:
	.ascii	"-v\000"
	.align	2
$LC20:
	.ascii	"--version\000"
	.align	2
$LC21:
	.ascii	"-h\000"
	.align	2
$LC22:
	.ascii	"--help\000"
	.align	2
$LC23:
	.ascii	"-i\000"
	.align	2
$LC24:
	.ascii	"--input\000"
	.align	2
$LC25:
	.ascii	"-o\000"
	.align	2
$LC26:
	.ascii	"--output\000"
	.align	2
$LC27:
	.ascii	"-\000"
	.align	2
$LC28:
	.ascii	"r\000"
	.align	2
$LC29:
	.ascii	"Error en apertura de archivo\000"
	.align	2
$LC30:
	.ascii	"w\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,96,$ra		# vars= 56, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,96
	.cprestore 16
	sw	$ra,88($sp)
	sw	$fp,84($sp)
	sw	$gp,80($sp)
	move	$fp,$sp
	sw	$a0,96($fp)
	sw	$a1,100($fp)
	sw	$zero,28($fp)
	sw	$zero,32($fp)
	sw	$zero,36($fp)
	sw	$zero,40($fp)
	sw	$zero,52($fp)
	sw	$zero,56($fp)
	sw	$zero,60($fp)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
$L59:
	lw	$v0,24($fp)
	lw	$v1,96($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L62
	b	$L60
$L62:
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC19
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L64
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC20
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L63
$L64:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L61
$L63:
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC21
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L67
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC22
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L66
$L67:
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	b	$L61
$L66:
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC23
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L70
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC24
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L69
$L70:
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sw	$v0,36($fp)
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	lw	$v0,96($fp)
	addu	$v0,$v0,-1
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L71
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$v0,0($v0)
	sw	$v0,44($fp)
	b	$L61
$L71:
	la	$t9,error_parametros_incorrectos
	jal	$ra,$t9
	b	$L61
$L69:
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC25
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L75
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC26
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L74
$L75:
	lw	$v0,40($fp)
	addu	$v0,$v0,1
	sw	$v0,40($fp)
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	lw	$v0,96($fp)
	addu	$v0,$v0,-1
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L76
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,100($fp)
	addu	$v0,$v1,$v0
	lw	$v0,0($v0)
	sw	$v0,48($fp)
	b	$L61
$L76:
	la	$t9,error_parametros_incorrectos
	jal	$ra,$t9
	b	$L61
$L74:
	la	$t9,error_parametros_incorrectos
	jal	$ra,$t9
$L61:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L59
$L60:
	lw	$v0,28($fp)
	slt	$v0,$v0,2
	beq	$v0,$zero,$L80
	lw	$v0,32($fp)
	slt	$v0,$v0,2
	beq	$v0,$zero,$L80
	lw	$v0,36($fp)
	slt	$v0,$v0,2
	beq	$v0,$zero,$L80
	lw	$v0,40($fp)
	slt	$v0,$v0,2
	beq	$v0,$zero,$L80
	b	$L79
$L80:
	la	$t9,error_parametros_incorrectos
	jal	$ra,$t9
$L79:
	lw	$v1,32($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L81
	lw	$v1,96($fp)
	li	$v0,2			# 0x2
	bne	$v1,$v0,$L82
	la	$t9,mostrar_usage
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L82:
	la	$t9,error_parametros_incorrectos
	jal	$ra,$t9
$L81:
	lw	$v1,28($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L84
	lw	$v1,96($fp)
	li	$v0,2			# 0x2
	bne	$v1,$v0,$L85
	la	$t9,mostrar_version
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L85:
	la	$t9,error_parametros_incorrectos
	jal	$ra,$t9
$L84:
	lw	$v0,36($fp)
	bne	$v0,$zero,$L89
	lw	$v0,40($fp)
	bne	$v0,$zero,$L89
	b	$L88
$L89:
	lw	$v0,36($fp)
	bne	$v0,$zero,$L90
	lw	$v1,40($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L90
	lw	$a0,48($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L90
	b	$L88
$L90:
	lw	$v1,36($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L91
	lw	$v0,40($fp)
	bne	$v0,$zero,$L91
	lw	$a0,44($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L91
	b	$L88
$L91:
	lw	$v1,36($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L87
	lw	$v1,40($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L87
	lw	$a0,44($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L87
	lw	$a0,48($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L87
$L88:
	sw	$zero,60($fp)
	b	$L92
$L87:
	lw	$v0,36($fp)
	bne	$v0,$zero,$L95
	lw	$v1,40($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L95
	lw	$a0,48($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L94
$L95:
	lw	$v1,36($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L93
	lw	$v1,40($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L93
	lw	$a0,44($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L93
	lw	$a0,48($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L94
	b	$L93
$L94:
	li	$v0,2			# 0x2
	sw	$v0,60($fp)
	b	$L92
$L93:
	lw	$v1,36($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L99
	lw	$v0,40($fp)
	bne	$v0,$zero,$L99
	lw	$a0,44($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L98
$L99:
	lw	$v1,36($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L97
	lw	$v1,40($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L97
	lw	$a0,44($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L97
	lw	$a0,48($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L97
$L98:
	li	$v0,1			# 0x1
	sw	$v0,60($fp)
	b	$L92
$L97:
	lw	$v1,36($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L101
	lw	$v1,40($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L101
	lw	$a0,44($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L101
	lw	$a0,48($fp)
	la	$a1,$LC27
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L101
	li	$v0,3			# 0x3
	sw	$v0,60($fp)
	b	$L92
$L101:
	la	$t9,error_parametros_incorrectos
	jal	$ra,$t9
$L92:
	lw	$v0,60($fp)
	sw	$v0,68($fp)
	li	$v0,1			# 0x1
	lw	$v1,68($fp)
	beq	$v1,$v0,$L105
	lw	$v1,68($fp)
	sltu	$v0,$v1,1
	bne	$v0,$zero,$L104
	li	$v0,2			# 0x2
	lw	$v1,68($fp)
	beq	$v1,$v0,$L107
	li	$v0,3			# 0x3
	lw	$v1,68($fp)
	beq	$v1,$v0,$L109
	b	$L103
$L104:
	la	$v0,__sF
	sw	$v0,52($fp)
	la	$v0,__sF+88
	sw	$v0,56($fp)
	b	$L103
$L105:
	lw	$a0,44($fp)
	la	$a1,$LC28
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,52($fp)
	la	$v0,__sF+88
	sw	$v0,56($fp)
	lw	$v0,52($fp)
	bne	$v0,$zero,$L103
	la	$a0,__sF+176
	la	$a1,$LC29
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,1			# 0x1
	sw	$v0,64($fp)
	b	$L58
$L107:
	la	$v0,__sF
	sw	$v0,52($fp)
	lw	$a0,48($fp)
	la	$a1,$LC30
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,56($fp)
	lw	$v0,56($fp)
	bne	$v0,$zero,$L103
	la	$a0,__sF+176
	la	$a1,$LC29
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v1,1			# 0x1
	sw	$v1,64($fp)
	b	$L58
$L109:
	lw	$a0,44($fp)
	la	$a1,$LC28
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,52($fp)
	lw	$a0,48($fp)
	la	$a1,$LC30
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,56($fp)
	lw	$v0,52($fp)
	beq	$v0,$zero,$L111
	lw	$v0,56($fp)
	bne	$v0,$zero,$L103
$L111:
	lw	$v0,52($fp)
	beq	$v0,$zero,$L112
	lw	$a0,52($fp)
	la	$t9,fclose
	jal	$ra,$t9
$L112:
	lw	$v0,56($fp)
	beq	$v0,$zero,$L113
	lw	$a0,56($fp)
	la	$t9,fclose
	jal	$ra,$t9
$L113:
	la	$a0,__sF+176
	la	$a1,$LC29
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,1			# 0x1
	sw	$v0,64($fp)
	b	$L58
$L103:
	lw	$a0,52($fp)
	lw	$a1,56($fp)
	la	$t9,procesar_archivo
	jal	$ra,$t9
	lw	$v1,60($fp)
	sw	$v1,72($fp)
	li	$v0,1			# 0x1
	lw	$v1,72($fp)
	beq	$v1,$v0,$L118
	lw	$v1,72($fp)
	sltu	$v0,$v1,1
	bne	$v0,$zero,$L116
	li	$v0,2			# 0x2
	lw	$v1,72($fp)
	beq	$v1,$v0,$L119
	li	$v0,3			# 0x3
	lw	$v1,72($fp)
	beq	$v1,$v0,$L120
	b	$L116
$L118:
	lw	$a0,52($fp)
	la	$t9,fclose
	jal	$ra,$t9
	b	$L116
$L119:
	lw	$a0,56($fp)
	la	$t9,fclose
	jal	$ra,$t9
	b	$L116
$L120:
	lw	$a0,52($fp)
	la	$t9,fclose
	jal	$ra,$t9
	lw	$a0,56($fp)
	la	$t9,fclose
	jal	$ra,$t9
$L116:
	sw	$zero,64($fp)
$L58:
	lw	$v0,64($fp)
	move	$sp,$fp
	lw	$ra,88($sp)
	lw	$fp,84($sp)
	addu	$sp,$sp,96
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
