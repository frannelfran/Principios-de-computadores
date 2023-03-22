# Programa que calcula cuantas iteraciones hacen falta para que el valor absoluto de un número entre 2 sea menor que 0.00005
    .data
    cadpedir: .asciiz "Ingresar un número cualquiera para ver cuantas iteraciones son necesarias para que su valor absoluto entre 2 sea menor que 0.00005 \n"
    cadsol: .asciiz "El número de interaciones necesarias es:"
    cadvalor_absoluto: .asciiz "El valor absoluto es:"
    cadespacio: .asciiz "\n"
    .text
    main:
    li $v0,4
    la $a0,cadpedir # Pedir un número entero por consola 
    syscall
    li $v0,6
    syscall
    mov.s $f1,$f0 # Mueve lo que está almacenado en f0 a f1
    li.s $f0,0.0 # Carga en el registro f0 un 0 en punto flotante (Simple precisión)
    if: c.le.s $f1,$f0 # Salta a la etiqueta "exit" si f1 es mayor que f0
    bc1f ifFin
    abs.s $f1,$f1 # Valor absoluto
    ifFin:
    li $v0,4
    la $a0,cadvalor_absoluto # Muestra por consola el valor absoluto del numero 
    syscall
    li $v0,2
    mov.s $f12,$f1
    syscall
    li $v0,4
    la $a0,cadespacio
    syscall
    li.s $f2,2.0 # Cargo en f2 2.0
    li.s $f3,0.00005 # cargo en f3 0.00005
    li $t1,0 # Inicializo el iterador en t1
    for: c.le.s $f1,$f3 # Si f1 es menor que f3 salta la condición 
        bc1t forFin
        div.s $f1,$f1,$f2 # División del valor absoluto entre 2
        add $t1,$t1,1 # Iterador++
        b for 
    forFin:
    li $v0,4
    la $a0,cadsol # Muestra por consola el número de interaciones 
    syscall
    li $v0,1
    move $a0,$t1
    syscall
    li $v0,10
    syscall
# EXIT