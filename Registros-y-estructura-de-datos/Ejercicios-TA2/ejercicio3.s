	.text
main:
	if:
		bge $t1,$t3,ifFin # Comprueba que t1 es menor que t3
      	if2:
        	blt $t2,$t3,ifFin2 # Comprueba que t2 es mayor o igual a t3
			li $t5,1 # Si se cumple la condición carg 1 a t5
			li $v0,10
			syscall 
		ifFin2: 
    ifFin:
    	sub $t4,$t2,$t3 # Suma t2 y t3 y el resulatdo lo almacena en t4
	if3:
      	bne $t4,$t1,ifFin3 # Comprueba que t4 es igual a t1
		li $t5,1 
		li $v0,10
		syscall
	ifFin3:
  	li $v0,10
	syscall