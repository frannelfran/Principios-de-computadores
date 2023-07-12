	# Programa que suma los n términos de la serie de fibonacci
	.data
cadpet: .asciiz "Introducir un número: ";
cadresultado: .asciiz "La suma de los términos es: ";
cadmenor: .asciiz "El número debe ser mayor que 0";
	.text
main:
	li $v0,4 # Pide un número por consola 
	la $a0,cadpet
	syscall
	li $v0,5 # Lee un número por consola y lo almacena en t0
	syscall
	move $t1,$v0 # Mueve lo que estaba almacenado en v0 a t1
	li $t2,1 # Carga en el registro t2 un 1 (número)
	li $t3,0 # Carga en el registro t3 un 0 (último número)
	if: bgtz $t1,ifFin
		li $v0,4 
		la $a0,cadmenor # Muestra por consola mensaje de error
		syscall
		li $v0,10
		syscall
	ifFin:
	while: bltz $t1,whileFin # Salta el bucle si t1 es menor que cero 
		add $t4,$t2,$t3 # Suma los registros t2 y t3 y el resultado lo amacena en t4
		move $t3,$t2 # Mueve lo que está almacenado en t2 a t3
		move $t2,$t4 # Mueve lo que esta almacenado en t4 a t2
		sub $t1,$t1,1 # Le resta al registro t1 un 1
		b while # Se repite el bucle 
	whileFin:
	li $v0,4
	la $a0,cadresultado # Muestra por consola el mensaje de la solución
	syscall
	li $v0,1
	move $a0,$t3 # Muestra la solución 
	syscall
	li $v0,10
	syscall
# EXIT