    .data
cadenunciado: .asciiz "Este programa cuenta el numero de veces que aparece una cifra en un numero entero positivo.\n"
cadpedx: .asciiz "Introduzca un numero entero positivo (introduzca negativo para finalizar el programa): "
cadpedcifra: .asciiz "Introduzca la cifra (0-9, introduzca otra cosa para finalizar el programa): "
cadsol: .asciiz "\nEl numero de veces que aparece la cifra en el numero es: "
cadfin: .asciiz "\nFin del programa.\n"

    # Registros utilizados 
    # $t1 == x
    # $t2 == c
    # $t3 == cuenta
    # $t4 == 9 == Rango maximo de c
    # $t5 == resto

    .text
main:
    while:
        li $v0,4
        la $a0,cadenunciado # Muestra por consola el enunciado del programa 
        syscall 
        li $v0,4
        la $a0,cadpedx # Pide la cifra de x
        syscall
        li $v0,5
        syscall
        move $t1,$v0 # Mueve la x al registro t1
        if: bltz $t1,exit
        li $v0,4
        la $a0,cadpedcifra # Pide la cifra 
        syscall
        li $v0,5
        syscall
        move $t2,$v0 # Mueve la c al registro t2
        li $t4,9 # Cargo un 9 en el registro t4
        if2: bltz $t2,exit # Si c es menor que 0 termina el programa 
        if3: bgt $t2,$t4,exit # Si c es mayor que 9 termina el programa 
        while2:
            beqz $t1,while2Fin
            li $t6,10 # Cargo un 10 en t6
            div $t1,$t6 # x / 10
            mfhi $t5 # Pone el resto de la división en t5
            div $t1,$t1,$t6 # x /= 10
            if4: bne $t5,$t2,while2 # Si el resto no es igual a c se repite el bucle 
            add $t3,$t3,1 # cuenta ++
            b while2 # Se repite el bucle 
        while2Fin:
        li $v0,4
        la $a0,cadsol # Muestra el mensaje de la solución 
        syscall
        li $v0,1
        move $a0,$t3
        syscall
    whileFin:
    exit:
    li $v0,4
    la $a0,cadfin # Termina el programa 
    syscall
    li $v0,10
    syscall
# EXIT