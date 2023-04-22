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
    # Poner en memoria los vectores
    li $t4,10
    cargar_v1:
        sw $t4,v1($3) # Guardar los elementos
        addi $t4,$t4,1 # Siguiente elemento
        addi $t1,$t1,1 # n++
        addi $3,$3,4 # Siguiente dirección de memoria
        blt $t1,40,cargar_v1
        sw $t1,n1 # Guardamos el número de elementos de v1
    cargar_v1_fin:
    # Reseteo de valores
    li $t4,40
    move $3,$zero
    move $t1,$zero
    cargar_v2:
        sw $t4,v2($3) # Guardar elementos
        sub $t4,$t4,1 # Siguiente elemento
        addi $t1,$t1,1 # n++
        addi $3,$3,4 # Siguiente direcció de memoria
        blt $t1,40,cargar_v2
        sw $t1,n2 # Guardamos el número de elementos de v2
    cargar_v2_fin:
    li $v0,4
    la $a0,title # Muestra el título del programa
    syscall
    # Mostrar vectores
    move $t1,$zero # Reseteo el contador de elementos
    mostrar_vectores:
        li $v0,4
        la $a0,cabvec 
        syscall
        lw $s3,n1 # Carga el número de elementos de v1 en s3
        li $v0,1
        move $a0,$s3 # Lo muestra por consola
        syscall
        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        move $t1,$zero
        vector_v1:
            la $s1,v1 # Carga la dirección base de v1
            mul $t4,$t1,size
            addu $t4,$t4,$s1 # Busco el elemento
            lw $t4,($t4) # Cargo el elemento en t4
            # Conversión de entero a flotante
            mtc1 $t4,$f1
            cvt.s.w $f1,$f1
            li $v0,2
            mov.s $f12,$f1 # Mostrar el elemento
            syscall
            li $v0,4
            la $a0,space # Deja un espacio entre los elementos
            syscall
            addi $t1,$t1,1 # n++
            blt $t1,$s3,vector_v1
        vector_v1_fin:
        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        li $v0,4
        la $a0,cabvec # Muestra el número de elementos de v2
        syscall
        lw $s4,n2 # Carga el número de elementos de v2 en s4
        li $v0,1
        move $a0,$s4 # Lo muestra por consola
        syscall
        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        move $t1,$zero # Reseteo el contador de elementos
        vector_v2:
            la $s2,v2 # Carga la dirección base de v2
            mul $t4,$t1,size
            addu $t4,$t4,$s2 # Busco el elemento
            lw $t4,($t4) # Cargo el elemento en t4
            # Conversión de entero a flotante
            mtc1 $t4,$f1
            cvt.s.w $f1,$f1
            li $v0,2
            mov.s $f12,$f1 # Mostrar el elemento
            syscall
            li $v0,4
            la $a0,space # Deja un espacio entre los elementos
            syscall
            addi $t1,$t1,1 # n++
            blt $t1,$s4,vector_v2
        vector_v2_fin:
    mostrar_vectores_fin:
    
    li $v0,4
    la $a0,newline # Nueva línea
    syscall

    opciones_menu:
        li $v0,4
        la $a0,menu # Muestra el menú por consola
        syscall
        li $v0,5
        syscall
        move $t2,$v0 # Mueve la opción al registro t2
        bgt $t2,4,error_opcion # Si la opción es mayor que 4 mostrar mensaje de error
        bltz $t2,error_opcion # Si la opción es menor que 0 mostrar mensaje de error
        beqz $t2,opcion0 # Si la opción es 0 salir del programa
        beq $t2,1,opcion1 # Si la opción es 1 cambiar la dimensión de un vector

    opciones_menu_fin:

    # Opción 1 (Cambiar dimensión de un vector)
    opcion1:
        li $v0,4
        la $a0,elige_vec # Pregunta con que vector quiere realizar la operación
        syscall
        li $v0,5
        syscall
        move $t2,$v0 # Mueve la opción a t2
        bltz $t2,error_opcion # Si la opción es menor que 0 mostrar mensaje de error
        bgt $t2,2,error_opcion # Si la opción es mayor que 2 mostrar mensaje de error
        beq $t2,1,opcion1_v1 # Si la opcion es 1 realizar para v1
        beq $t2,2,opcion1_v2 # si la opción es 2 realizar para v2
        # Opcion1 para v1
        opcion1_v1:
        li $v0,4
        la $a0,newdim # Introducir nueva dimensión del vector
        syscall
        li $v0,5
        syscall
        move $t2,$v0
        bgt $t2,40,error_dimension # Si la dimensión intorducida es mayor que 40 mostrar mensaje de error
        blez $t2,error_dimension # Si la dimensión es menor o igual que 0 mostrar mensaje de error
        sw $t2,n1 # Guardar la nueva dimensión de v1
        j mostrar_vectores
        # Opción1 para v2
        opcion1_v2:
        li $v0,4
        la $a0,newdim # Introducir nueva dimensión del vector
        syscall
        li $v0,5
        syscall
        move $t2,$v0
        bgt $t2,40,error_dimension # Si la dimensión intorducida es mayor que 40 mostrar mensaje de error
        blez $t2,error_dimension # Si la dimensión es menor o igual que 0 mostrar mensaje de error
        sw $t2,n2 # Guardar la nueva dimensión de v1
        j mostrar_vectores
    opcion1_fin:



    # Posibles errores
    errores:
    error_opcion:
    li $v0,4
    la $a0,error_op
    syscall
    j mostrar_vectores
    error_dimension:
    li $v0,4
    la $a0,error_dim
    syscall
    j mostrar_vectores


    # Opción 0 (Salir del programa)
    opcion0:
        li $v0,4
        la $a0,msg_fin # Salir del programa
        syscall
        li $v0,10
        syscall
    opcion0_fin:
# EXIT