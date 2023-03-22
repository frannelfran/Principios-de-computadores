# Programa que calcula la imagen de los distintos intervalos de un rango en un polinomio de grado 3
    .data
cadpregunta:    .asciiz "Evaluacion polinomio f(x) = a x^3  + b x^2 + c x + d  en un intervalo [r,s]\n"
cadpedirparam:  .asciiz "Introduzca los valores de a,b,c y d (separados por retorno de carro):\n"
cadpedir_r_s:   .asciiz "Introduzca [r,s] (r y s enteros, r <= s)  (separados por retorno de carro):\n"
cadsol1:        .asciiz "\nf("
cadsol2:        .asciiz ") = "
cadfinprogram:  .asciiz "\nTermina el programa\n"
    # Variables utilizadas     
    # $f1 == a
    # $f2 == b
    # $f3 == c
    # $f4 == d
    # $t1 == r
    # $t2 == s
    # $t3 == x == $f10
    .text
main:
    li $v0,4
    la $a0,cadpregunta # Muestra por pantalla el enunciado del problema 
    syscall
    li $v0,4
    la $a0,cadpedirparam # Pide por pantalla los parámetros a, b, c d
    syscall
    li $v0,6
    syscall
    mov.s $f1,$f0 # Carga el valor de a en f1
    mov.s $f20,$f1 # Copia de a
    li $v0,6
    syscall
    mov.s $f2,$f0 # Carga el valor de b en f2
    mov.s $f21,$f2 # Copia de b
    li $v0,6
    syscall
    mov.s $f3,$f0 # Carga el valor de la c en f3
    mov.s $f22,$f3 # Copia de c
    li $v0,6
    syscall
    mov.s $f4,$f0 # Carga el valor de la d en f4
    mov.s $f23,$f4 # Copia de d
    do1:
        li $v0,4
        la $a0,cadpedir_r_s
        syscall
        li $v0,5
        syscall
        move $t1,$v0 # Carga el valor de la r en t1
        li $v0,5
        syscall
        move $t2,$v0 # Carga el valor de la s en t2
        while: bgt $t1,$t2,do1 # Si r es mayor que s el bucle se repite 
    do1Fin:
    move $t3,$t1 # x == r
    li.s $f8,2.1 # Cargo en el registro f8 un 2.1
    for: bgt $t3,$t2,forFin 
        mtc1 $t3,$f10
        cvt.s.w $f10,$f10 # Convierto la x a flotante y la almaceno en f4
        mul.s $f5,$f10,$f10 # x * x
        mul.s $f6,$f5,$f10 # x * x * x
        mul.s $f2,$f2,$f5 # b * x * x
        mul.s $f1,$f1,$f6 # a * x * x * x
        mul.s $f3,$f3,$f10 # c * x
        add.s $f7,$f1,$f2
        add.s $f7,$f7,$f3
        add.s $f7,$f7,$f4 # float f == a*x*x*x + b*x*x + c*x*x + d
        if: c.le.s $f7,$f8
            bc1t ifFin
            li $v0,4
            la $a0,cadsol1
            syscall
            li $v0,1
            move $a0,$t3 # Muestra por consola la x
            syscall
            li $v0,4
            la $a0,cadsol2
            syscall
            li $v0,2
            mov.s $f12,$f7 # Muestra por consola la solución del polinomio
            syscall
        ifFin:
        # Restaurar los parámetros
        mov.s $f1,$f20
        mov.s $f2,$f21
        mov.s $f3,$f22
        mov.s $f4,$f23
        add $t3,$t3,1
        b for
    forFin:
    li $v0,4
    la $a0,cadfinprogram # Termina el programa 
    syscall
    li $v0,10
    syscall
# EXIT