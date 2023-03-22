	# Programa que calcula el área de un circulo
	.data
cadpet:		.asciiz "Instroduzca radio del círculo: "
cadresultado:	.asciiz "El área del círculo es: "
	.text
main:
	li $v0,4 # Dirección de la cadena a imprimir
	la $a0,cadpet 
	syscall

	li $v0,6 # Flotante que se lee
	syscall
	mov.s $f1,$f0
	
	li.s $f2,2.0000 # Carga un 2 en el registro f2
	li.s $f3,3.1416 # Carga el número pi a f3
	mul.s $f4,$f1,$f1 # Radio al cuadrado
	mul.s $f5,$f2,$f3 # Multiplica f2 y f3 y el resultado lo almacena en f4
	mul.s $f6,$f5,$f4 # Área
	mov.s $f7,$f6 # Mueve lo que esta almacenado en el registro f6 y lo almacena en f7
	syscall

	# Lo que muestra por consola 
	li $v0,4 # Dirección de memoria de la cadena a imprimir
	la $a0,cadresultado # Cadena a imprimir 
	syscall

	li $v0,2 # Flotante a imprimir 
	mov.s $f12,$f7 # Mueve lo que esta guardado en el registro f7 al f12 y lo muestra por consola 
	syscall

	li $v0,10
	syscall
# EXIT