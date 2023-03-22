# Programa que calcula la divisón entre dos numeros flotantes simples
	.data
solidividendo: .asciiz "Teclee un número cualquiera para que sea el dividendo: "
solidivisor: .asciiz "Teclee un número cualuiera para que sea el divisor: "
solresult: .asciiz "El resultado de la división es: "
solerrorden: .asciiz "El denominador no pueden ser cero"
	.text
main:
	# Preguntar por el dividendo
	li $v0,4
	la $a0,solidividendo
	syscall
	# Teclear dividendo en consola
	li $v0,6 # Flotante para leer
	syscall
	mov.s $f1,$f0 # Carga el dividendo en f1
	# Preguntar por el divisor
	li $v0,4
	la $a0,solidivisor
	syscall
	
	li $v0,6 # Teclear divisor en consola
	syscall
	mov.s $f2,$f0 # Carga el divisor en f2
	div.s $f3,$f1,$f2 # Divide f1 entre f2 y lo almacena en f3
	
	if: c.eq.s $f7,$f2 # Si lo que esta almacenado en f2 es igual a 0 se acaba el programa 
	bc1f ifFin
	li $v0,4
	la $a0,solerrorden # Muestra por consola el mensaje de error del denominador 
	syscall
	li $v0,10
	syscall
	ifFin:
	
	li $v0,4
	la $a0,solresult # Muestra por pantalla el mensaje de la solución
	syscall
	li $v0,2
	mov.s $f12,$f3 # Mueve lo que esta almacenado en f3 a f12 y lo muestra por consola
	syscall

	li $v0,10
	syscall
# EXIT
