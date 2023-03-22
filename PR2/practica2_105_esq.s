# practica 2. Principio de computadoras


	.data		# directiva que indica la zona de datos
titulo: 		.asciiz	"\nSe dice que un numero A es divisible entre B cuando el resultado de la division A/B es un numero entero. Introduzca un 0 para salir del programa.\n "
msgnumero1:	.asciiz	"\n Introduzca numero positivo 1 (0 para salir): "
msgnumero2:	.asciiz	"\n Introduzca numero positivo 2 < numero1 (0 para salir): "
msgnum:		.asciiz	"\nNumero  "
msgdiv:		.asciiz	" divisible por  "
msgentre:   .asciiz	" entre "
msgigual:   .asciiz	" igual "
msgfin:		.asciiz "\nFIN DEL PROGRAMA."

    # Registros utilizados
	# $t1 == numero1
	# $t2 == numero2
	# $t3 == i
	# $t4 == numero2%i
	# $f1 == division
	# $f2 == float(numero2)
	# $f3 == float(i)

	.text
main:
	 
	la	$a0,titulo # Muestra el título del programa 
	li	$v0,4
	syscall
	do1:
		do2:
			li $v0,4
			la $a0,msgnumero1 # Pide el numero 1
			syscall
			li $v0,5
			syscall
			move $t1,$v0 # Mueve el numero 1 al registro t1
			while: bltz $t1,do2
		    do3:
			    li $v0,4
			    la $a0,msgnumero2 # Pide el numero 2
			    syscall
			    li $v0,5
			    syscall
			    move $t2,$v0 # Mueve el numero 2 al registro t2
			    while2: bltz $t2,do3 # numero2 < 0 repite el bucle
			    while3: bgt $t2,$t1,do3 # numero2 > numero1 se repite
		    do2Fin:
		do3Fin:
    
		if: beqz $t1,exit # Si el numero1 == 0 para el programa
		if2: beqz $t2,exit # Si el numero2 == 0 para el programa

	li $t3,1 # inicializo i
	for: bgt $t3,$t1,forFin
		div $t2,$t3
		mfhi $t4 # muevo al registro t4 el resto de numero2%i
		if4: bnez $t4,else
			li $v0,4
			la $a0,msgnum
			syscall
			li $v0,1
			move $a0,$t2 # Muestro el por consola el numero2
			syscall
			li $v0,4
			la $a0,msgdiv # Muestro por consola divisible
			syscall
			li $v0,1
			move $a0,$t3
			syscall
		if4Fin:
		else: beqz $t4,elseFin
			mtc1 $t2,$f2
			cvt.s.w $f2,$f2 # Conversion de numero2
			mtc1 $t3,$f3
			cvt.s.w $f3,$f3 # Conversion de i
			div.s $f1,$f2,$f3 # division == numero2 / i
			
			# Muestra por consola
			li $v0,4
			la $a0,msgnum
			syscall
			li $v0,1
			move $a0,$t2 # Muestra el numero2
			syscall
			li $v0,4
			la $a0,msgentre
			syscall
			li $v0,1
			move $a0,$t3 # Muestra i
			syscall
			li $v0,4
			la $a0,msgigual
			syscall
			li $v0,2
			mov.s $f12,$f1 # Muestra la division
			syscall
		elseFin:
		add $t3,$t3,1 # i++
		b for
	forFin:
	b do2 # Se repite el bucle 
	do1Fin:
	exit:
	li $v0,4
	la $a0,msgfin # Fin del programa
	syscall
	li $v0,10
	syscall
# EXIT
