##PRINCIPIOS DE COMPUTADORES
## Franco Alla
##
##

nrows=3
ncols=4
size=4

	.data		# directiva que indica la zona de datos
titulo: 		.asciiz "\nPrincipios de computadores.\n" 
msgpregunta:    .asciiz "\nElija Opci�n \n1- imprimir matrices, \n2- suma recursiva de divisiones de eltos de matriz\n(0 para salir):"
msg1:           	.asciiz "\nMatriz\n"
msg2:		.asciiz "\nEl resultado de la operaci�n es:"
msgfin:		.asciiz "\nFIN DEL PROGRAMA."
error_menu: 	.asciiz "\nError Menu."
error: 		.asciiz "\nError"
espacio: 		.asciiz " "
salto: 		.asciiz "\n"

matrix1:	.word	3, 4, 5, 6
		.word	7, 8, 9, 10
		.word	11, 12, 13, 14
			
matrix2:	.word	1, 3, 1, 5
		.word	2, 6, 1, 8
		.word	2, 3, 3, 1


	.text		# directiva que indica la zona de codigo

	
	
##################################FUNCION print_matrix
fun_print_matrix:

	addi $sp,$sp,-32
	sw $ra, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)

	move $s0,$a0 # Direcci�n base de la matriz
	move $s1,$a1 # N�mero de filas de la matriz
	move $s2,$a2 # N�mero de columnas de la matriz
	move $s3,$a3 # $s3 == caracter asciiz "space"
	li $s4,0 # Recorrer filas
	li $s5,0 # Recorrer columnas
	
	bucle1:
		move $s5,$zero # Reseteo las columnas
		bucle2:
			mul $t3,$s4,$s2 # f*ncol
			add $t3,$t3,$s5 # f*ncol+c
			mul $t3,$t3,size # (f*ncol+c)*size
			add $t3,$t3,$s0 # Le sumo la direcci�n base de la matriz a t3
			lw $t1,($t3) # Cargo el elemento en f12
			li $v0,1 # Muestro el elemento
			move $a0,$t1
			syscall
			li $v0,4
			move $a0,$s3
			syscall
			addi $s5,$s5,1 # c++
			blt $s5,$s2,bucle2
			addi $s4,$s4,1 # f++
			li $v0,4
			move $a0,$s6
			syscall
			blt $s4,$s1,bucle1
		bucle2_fin:
	bucle1_fin:

	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $ra, 28($sp)
	addi $sp,$sp,32
	jr $ra

fin_fun_print_matrix:
		
		
##################################FUNCION print_matrix		
fun_suma_eltos_div_matriz:
	
fin_fun_suma_eltos_div_matriz:	
		
		
		
##################################PROGRAMA PRINCIPAL		
main:
	li $v0,4
	la $a0,titulo # Muestra el t�tulo del programa
	syscall

	menu:
		# Mostrar el men�
		li $v0,4
		la $a0,msgpregunta
		syscall
		li $v0,5
		syscall
		move $t5,$v0
		beq $t5,1,imprimir_matrices # Si la opci�n es uno imprimir_matrices
		beqz $t5,salir # Si la opcion es 0 finalizar
		bgt $t5,2,errores # Si es mayor que 2 mostrar mensaje de error_menu
		bltz $t5,errores # Si es menor que 0 mostrar error
	menu_fin:


	imprimir_matrices:
		
		li $v0,4
		la $a0,msg1
		syscall
		# Imprimir MATRIZ_1
		la $a0,matrix1 # Cargo la direcci�n base de la matriz en a0
		li $a1,3 # Cargo el n�mero de filas en a1
		li $a2,4 # Cargo el numero de columnas en a2
		la $a3,espacio # cargo el espacio en a3
		la $s6,salto
		jal fun_print_matrix

		li $v0,4
		la $a0,salto # Nueva l�nea
		syscall

		li $v0,4
		la $a0,msg1
		syscall

		# Imprimir MATRIZ_2
		la $a0,matrix2 # Cargo la direcci�n base de la matriz en a0
		li $a1,3 # Cargo el n�mero de filas en a1
		li $a2,4 # Cargo el numero de columnas en a2
		la $a3,espacio # cargo el espacio en a3
		la $s6,salto
		jal fun_print_matrix
		j menu
	imprimir_matrices_fin:

	# Tipos de errores
	errores:
		li $v0,4
		la $a0,error_menu
		syscall
		j menu
	errores_fin:

	salir:
		li $v0,4
		la $a0,msgfin
		syscall
	salir_fin:

	li $v0,10
	syscall
#EXIT

