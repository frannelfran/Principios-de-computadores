    .data
cadtitulo:           .asciiz "Programa para repasar las tablas de multiplicar.\n"
cadtabla:            .asciiz "\n¿Qué tabla deseas repasar? Introduce un número (0 para salir): "
cadx:                .asciiz " x "
cadinterrogante:     .asciiz " ? "
cadaciertos:         .asciiz "Tu porcenaje de aciertos es del "
cadporcentaje:       .asciiz "%"
cadfin:              .asciiz "Termina el programa.\n"

    # Registros utilizados 
    # $t1 == n 
    # $t2 == aciertos 
    # $t3 == i
    # $t4 == resultado
    # $t5 == i*n
    # $t6 == porcentaje

    .text
main:
    li $v0,4
    la $a0,cadtitulo # Muestra el título del programa 
    syscall
    do1:
        li $v0,4
        la $a0,cadtabla # Muestra por consla que tabla deseas repasar 
        syscall
        li $v0,5 # Pide n
        syscall
        move $t1,$v0 # Mueve n al registro t1
        if: beqz $t1,exit # Si t1 es igual a cero termina el programa
        li $t3,1 # Inicializo i
        for: bgt $t3,10,forFin 
            # std::cout << i << " x " << n << " ? ";
            li $v0,1
            move $a0,$t3
            syscall
            li $v0,4
            la $a0,cadx
            syscall
            li $v0,1
            move $a0,$t1
            syscall
            li $v0,4
            la $a0,cadinterrogante
            syscall
            li $v0,5 # Pide el resultado
            syscall
            move $t4,$v0 # Mueve el resultado al registro t4
            mul $t5,$t1,$t3 # i*n
            if2: bne $t4,$t5,if2Fin
                add $t2,$t2,1 # aciertos++
            if2Fin:
            add $t3,$t3,1 # i++
            b for # Se repite el bucle 
        forFin:
        mul $t6,$t2,10 # porcentaje == aciertos*10
        li $v0,4
        la $a0,cadaciertos # Muestra el porcentaje 
        syscall
        li $v0,1
        move $a0,$t6
        syscall
        li $v0,4
        la $a0,cadporcentaje
        syscall
        while: bnez $t1,do1 # si n es distinto de 0 se repite el programa 
    do1Fin:
    exit:
    li $v0,4
    la $a0,cadfin # Termina el programa 
    syscall
    li $v0,10
    syscall
# EXIT