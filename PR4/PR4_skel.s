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

    # Registros utilizados
    # $s1 == dirección base de v1
    # $s2 == dirección base de s2
    # $t1 == contador de elementos de v1 y v2
    # $t2 == opciones del menú
    # $s3 == dimensión de v1
    # $s4 == dimensión de v2
    # $3 == direccionamiento de cada número
    # $t4 == elementos de cada vector

    .text
main:
    li $v0,4
    la $a0,title # Muestra el enunciado de la práctica
    syscall
    # Mostrar vectores
    li $s3,40 # Número de elementos del vector v1
    sw $s3,n1
    li $s4,40 # Número de elementos ddel vector v2
    sw $s4,n2
    mostrar_vectores:

        li $v0,4
        la $a0,cabvec # Muestra la dimensión del vector
        syscall
        li $v0,1
        move $a0,$s3
        syscall
        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        li $t4,10 # Primer elemento de v1
        lw $s3,n1 # Cargo el número de elementos de v1

        vector_v1:

            sw $t4,v1($3) # Guardar cada elemento
            mtc1 $t4,$f1
            cvt.s.w $f1,$f1 # Convierto a flotante el elemento
            li $v0,2
            mov.s $f12,$f1 # Muestro pòr consola el elemento
            syscall
            li $v0,4
            la $a0,space
            syscall
            addi $t4,$t4,1 # Siguiente elemento
            addi $t1,$t1,1 # Incremento el número de elementos
            addi $3,$3,4 # Siguiente dirección de memoria
            blt $t1,$s3,vector_v1 # Repetir hasta que el número de elemetos coincida con la dimensión máxima

        vector_v1_fin:

        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        li $v0,4
        la $a0,cabvec # Muestra la dimensión del vector
        syscall
        li $v0,1
        move $a0,$s3
        syscall
        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        # Resetear valores
        move $3,$zero
        move $t1,$zero # Reseteo el contador
        li $t4,40 # Primer elemento de v2
        lw $s4,n2 # Cargo el número de elementos del vector

        vector_v2:

            sw $t4,v2($3) # Guardar cada elemento
            mtc1 $t4,$f1
            cvt.s.w $f1,$f1 # Convierto a flotante el elemento
            li $v0,2
            mov.s $f12,$f1 # Muestro pòr consola el elemento
            syscall
            li $v0,4
            la $a0,space
            syscall
            sub $t4,$t4,1 # Siguiente elemento
            addi $t1,$t1,1 # Incremento el número de elementos
            addi $3,$3,4 # Siguiente dirección de memoria
            blt $t1,$s4,vector_v2 # Repetir hasta que el número de elemetos coincida con la dimensión máxima

        vector_v2_fin:
    mostrar_vectores_fin:

    li $v0,4
    la $a0,newline # Nueva línea
    syscall

    mostrar_menu:

        li $v0,4
        la $a0,menu
        syscall
        li $v0,5
        syscall
        move $t2,$v0 # Mueve la opción a t2
    mostrar_menu_fin:
    errores:
        error_opcion:


    li $v0,10
    syscall
# EXIT