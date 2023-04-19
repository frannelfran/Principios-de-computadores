# Autor: 
# Fecha ultima modificacion: 

size = 4     # bytes que ocupa cada elemento
maxdim = 40  # dimension maxima que puede tener un vector
    .data
v1:         .space 160
v2:         .space 160
n1:         .word 0 # numero eltos vector 1. Inicialmente suponemos vacios
n2:         .word 0 # numero eltos vector 2. Inicialmente suponemos vacios
space:      .asciiz " "
newline:    .asciiz "\n"
title:      .asciiz "\nPractica 4 de Principios de Computadores. Subrutinas.\n"
menu:       .ascii  "\n(1) Cambiar dimension de un vector\n(2) Cambiar un elemento de un vector\n"
            .ascii  "(3) Invertir un vector\n(4) Calcular el producto escalar de dos vectores\n"
            .asciiz "(0) Salir\n\nElija opcion: ";
cabvec:     .asciiz "\nVector con dimension "
error_op:   .asciiz "\nError: opcion incorrecta.\n"
elige_vec:  .asciiz "\nElija vector para realizar la operacion (1) para v1 (2) para v2: "
elige_elto: .asciiz "\nElija el indice del elemento a cambiar: "
newval:     .asciiz "\nIntroduce nuevo valor para el elemento elegido: "
newdim:     .asciiz "\nIntroduzca nueva dimension para el vector (1-40): "
error_dim:  .asciiz "\nError: Dimension incorrecta.\n"
error_ind:  .asciiz "\nError: Indice incorrecto.\n"
error_d_dim:    .asciiz "\nError: Los vectores tienen distinta dimension.\n"
msg_prodesc:    .asciiz "\nEl producto escalar de los vectores es: "
msg_fin:    .asciiz "\nFIN DEL PROGRAMA."


    .text

    # Registros utilizados
    # $f1 == Elementos del primer vector
    # $t1 == n1

main:
    li $t4,40 # Maximo número de elementos
    li $v0,4
    la $a0,title # Muestra el título de la práctica
    syscall
    # Mostrar el vector
    li $v0,4
    la $a0,cabvec # Muestra la dimensión del vector
    syscall
    li $v0,1
    move $a0,$t4
    syscall
    li $v0,4
    la $a0,newline
    syscall
    li.s $f1,10.0 # Primer elemento del vector
    lw $t1,n1 # Cargo el número de lementos de v1 en t1
    mostrar_v1:
        li $v0,2
        mov.s $f12,$f1
        syscall
        li $v0,4
        la $a0,space
        syscall
        li.s $f3,1.0 # Sumador
        add.s $f1,$f1,$f3 # Siguiente elemetno del vector
        addi $t1,$t1,1 # Incremento el número de elementos
        bne $t1,40,mostrar_vector
        sw $t1,n1 # Guardo el nuevo número de elemetnos del vector
    mostrar_v1_fin:



    li $v0,10 # Sale del programa
    syscall
# EXIT
        



