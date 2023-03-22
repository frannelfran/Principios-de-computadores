  .text
main:
	if: 
    	bgt $t1,$t2,ifFin # Indica que t1 es menor que t2
	  	move $t3,$t1 # Mueve el valor que tenga t1 a t3
	  	move $t4,$t2 # Mueve el valor que tenga t2 a t4
  	ifFin:

  	if2: 
    	bgt $t2,$t1,ifFin2 # Indica que t2 es menor que t1
	  	move $t3,$t2 # Mueve el valor que tenga t2 a t3
	  	move $t4,$t1 # Mueve el valor que tenga t1 a t4
  	ifFin2: 

  	li $t0,1 # Inialización de i
  	for:  
		bgt $t0,$t2,forFin # Comprueba que el valor almacenado en t0 es menor que t2
    	add $t5,$t2,$t0 # Suma t2 y t3 y el resultado lo almacena en t5
    	addi $t0,$t0,1 # Añade 1 a t0
    	b for # Repite el bucle 
  	forFin:

  	for2:  
		bgt $t0,$t1,forFin # Comprueba que el valor almacenado en t0 es menor que t1
    	add $t5,$t1,$t0 # Suma t1 y t0 y lo almacena en t5
    	addi $t0,$t0,1 
    	b for
  	forFin2:
  	li $v0,10
	syscall