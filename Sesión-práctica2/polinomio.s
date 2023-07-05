    .data
titulo: .ascii "\nEvaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n"
        .asciiz "\nIntroduzca los valores de a,b,c y d (separados por retorno de carro):\n"
cadrs: .asciiz "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n"
cadprimparen: .asciiz "\nf("
cadsegunparen: .asciiz ") = "
cadfinprogram: .asciiz "\n\nTermina el programa\n"

    .text
    # REGISTROS UTILIZADOS
    # $f1 == a
    # $f2 == b
    # $f3 == c
    # $f4 == d
    # $t1 == r
    # $t2 == s
    # $t3 == x == $f5

main:
    li $v0,4
    la $a0,titulo
    syscall
    # Introducir los parámetros
    li $v0,6
    syscall
    mov.s $f1,$f0 # Mueve el parámetro "a" a f2
    li $v0,6
    syscall
    mov.s $f2,$f0 # Mueve el parámetro "b" a f4
    li $v0,6
    syscall
    mov.s $f3,$f0 # Mueve el parámetro "c" a f6
    li $v0,6
    syscall
    mov.s $f4,$f0 # Mueve el parámetro "d" a f8

    do:
        li $v0,4
        la $a0,cadrs
        syscall
        # Pedir los valores de r y s
        li $v0,5
        syscall
        move $t1,$v0 # Mueve el valor de "r" a t1
        li $v0,5
        syscall
        move $t2,$v0 # Mueve el valor de "s" a t2
    while: bgt $t1,$t2,do
    move $t3,$t1 # x == r
    for:
        mtc1 $t3,$f0 # Copia cruda en flotante de simple precisión de la x
        cvt.s.w $f5,$f0 # Pasar el valor de x a flotante (simple precisión)
        mul.s $f6,$f5,$f5 # x*x
        # Multiplicar el parámetro "a"
        mul.s $f7,$f1,$f6 # a*x*x
        mul.s $f7,$f7,$f5 # a*x*x*x
        # Multiplicar el parametro "b"
        mul.s $f8,$f2,$f6 # b*x*x
        # Multiplicar el parámetro "c"
        mul.s $f9,$f3,$f5 # c*x
        # Sumar todo
        add.s $f10,$f7,$f8 # float f == a*x*x*x + b*x*x
        add.s $f10,$f10,$f9 # float f == a*x*x*x + b*x*x + c*x 
        add.s $f10,$f10,$f4 # float f == a*x*x*x + b*x*x + c*x + d
        if:
            li.s $f11,2.1
            c.le.s $f10,$f11
            bc1t exit
            # Mostrar solución
            li $v0,4
            la $a0,cadprimparen
            syscall
            li $v0,1
            move $a0,$t3 # Muestra el valor de la x
            syscall
            li $v0,4
            la $a0,cadsegunparen
            syscall
            li $v0,2
            mov.s $f12,$f10 # Muestra el valor del polinomio calculado
            syscall
        ifFin:
        add $t3,$t3,1 # x++
        ble $t3,$t2,for # x <= s se repite el bucle
    forFin:

    exit:
    li $v0,4
    la $a0,cadfinprogram # Fin del programa
    syscall
    li $v0,10
    syscall
# EXIT