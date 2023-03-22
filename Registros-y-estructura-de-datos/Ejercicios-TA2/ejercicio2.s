	.text
main:
	if: 
		bltz $t1,ifFin # Comprueba que el registro t1 es mayor que 0
		if2: 
			bltz $t2,ifFin # Comprueba que el registro t2 es mayor que 0
			li $t0,1 # Cargamos 1 a t0
			for: bgt $t0,$t1,forFin # Hasta que t0 sea > que t1 el bucle no para 
				div $t2,$t0 # Divide t2 entre t0 y el resto lo guarda en HI
				mfhi $t4 # Mueve lo que está almacenado en HI a t4
			
				if3: 
					bnez $t4,ifFin3 # Comprueba que el resto (almacenado en t4) es iagual a 0
					move $t3,$t0 # Mueve lo que está almacenado en t0 a t3
				ifFin3:
				addi $t0,$t0,1 # actualización i++
				b for # Hace que se repita el bucle 
			forFin:
		ifFin:
	ifFin:
li $v0,10
syscall