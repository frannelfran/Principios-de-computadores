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
    # $f4 == elementos de cada vector
    # $t3 == índice del elemento a cambiar
    # $f5 == 1.0

    .text

    # Mostrar vectores
    print_vec:
        move $s1,$a0 # Carga la dirección base de v1 o v2
        move $s3,$a1 # Carga el número de elementos de v1 o v2 en s3
        for1: bgt $t1,$s3,for1_fin
            mul $t4,$t1,size
            addu $t4,$t4,$s1 # Busco el elemento
            l.s $f4,($t4) # Cargo el elemento en f4
            addi $t1,$t1,1 # n++
        for1_fin:
        mov.s $f0,$f4
        jr $ra
    print_vec_fin:

    # Cambiar elemento
    change_elto:
        # Paso de parámetros
        move $s1,$a0 # Carga la dirección base de v1 o v2
        move $s3,$a1 # Carga el número de elementos de v1 o v2 en s3
        move $t3,$a2 # Muevo el índice a t3
        mov.s $f4,$f12 # Muevo el nuevo valor a f4

        mul $t4,$t3,size
        addu $t4,$t4,$s1 # Busco el valor
        s.s $f4,($t4) # Cargo el nuevo valor en la dirección de memoria indicada
        jr $ra
    change_elto_fin:

main:
    li.s $f5,1.0
    # Poner en memoria los vectores
    li.s $f4,10.0
    cargar_v1:
        s.s $f4,v1($3) # Guardar los elementos
        add.s $f4,$f4,$f5 # Siguiente elemento
        addi $t1,$t1,1 # n++
        addi $3,$3,4 # Siguiente dirección de memoria
        blt $t1,40,cargar_v1
        sw $t1,n1 # Guardamos el número de elementos de v1
    cargar_v1_fin:
    # Reseteo de valores
    li.s $f4,40.0
    move $3,$zero
    move $t1,$zero
    cargar_v2:
        s.s $f4,v2($3) # Guardar elementos
        sub.s $f4,$f4,$f5 # Siguiente elemento
        addi $t1,$t1,1 # n++
        addi $3,$3,4 # Siguiente direcció de memoria
        blt $t1,40,cargar_v2
        sw $t1,n2 # Guardamos el número de elementos de v2
    cargar_v2_fin:

    li $v0,4
    la $a0,title # Muestra el título del programa
    syscall

    mostrar_vectores:
        li $v0,4
        la $a0,cabvec
        syscall
        lw $s3,n1
        li $v0,1
        move $a0,$s3 # Muestra el número de elementos del vector
        syscall

        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        move $t1,$zero # Reseteo n

        # Muestra v1 por consola
        vector_v1: 
            bge $t1,$s3,vector_v1_fin
            la $a0,v1 # Carga la dirección base de v1 en a0
            lw $a1,n1 # Carga en a1 el número de elementos de v1
            jal print_vec
            li $v0,2
            mov.s $f12,$f0 # Muestra el elemento
            syscall
            li $v0,4
            la $a0,space # Deja un espacio entre los elementos
            syscall
            b vector_v1
        vector_v1_fin:

        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        li $v0,4
        la $a0,cabvec  # Muestra el número de elementos de v2
        syscall
        lw $s4,n2 # Carga el número de elementos de v2 en s4
        li $v0,1
        move $a0,$s4
        syscall
        li $v0,4
        la $a0,newline # Nueva línea
        syscall
        move $t1,$zero # Reseteo n

        # Muestra v2 por consola
        vector_v2:
            bge $t1,$s4,vector_v2_fin 
            la $a0,v2 # Carga la dirección base de v2 en a0
            lw $a1,n2 # Carga en a1 el número de elementos de v2
            jal print_vec # Llama a la función print_vec

            li $v0,2
            mov.s $f12,$f0 # Imprime el elemento
            syscall

            li $v0,4
            la $a0,space # Deja un espacio entre los elementos
            syscall
            b vector_v2
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
            beq $t2,2,opcion2 # Si la opción es 2 cambiar un elemento
        opciones_menu_fin:

        # Opción 1 (Cambiar dimensión de un vector)
    opcion1:
        li $v0,4
        la $a0,elige_vec # Pregunta con que vector quiere realizar la operación
        syscall
        li $v0,5
        syscall
        move $t2,$v0 # Mueve la opción a t2
        blez $t2,error_opcion # Si la opción es menor que 0 mostrar mensaje de error
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
        sw $t2,n2 # Guardar la nueva dimensión de v2
        j mostrar_vectores
    opcion1_fin:

    opcion2:
        li $v0,4
        la $a0,elige_vec # Pregunta con que vector quieres realizar la operación
        syscall
        li $v0,5
        syscall
        move $t2,$v0 # Almacena la opción en t2
        blez $t2,error_opcion # Si la opción es menor que 0 mostrar mensaje de error
        bgt $t2,2,error_opcion # Si la opción es mayor que 2 mostrar mensaje de error
        beq $t2,1,opcion2_v1 # Si la opcion es 1 realizar para v1
        beq $t2,2,opcion2_v2 # si la opción es 2 realizar para v2

        opcion2_v1:
            li $v0,4
            la $a0,elige_elto # Pregunta por el índice a cambiar
            syscall
            li $v0,5
            syscall
            move $t3,$v0 # Mueve el índice a t3
            bltz $t3,error_indice # Si el índice es menor o igual a 0 mostrar mensaje de error
            lw $s3,n1 # Cargar los elementos de v1
            bge $t3,$s3,error_indice # Si el índice a cambiar es mayor o igual que los índice de v1 mostrar mensaje de error
            li $v0,4
            la $a0,newval # Introducir el nuevo valor para ese índice
            syscall
            li $v0,6
            syscall
            # Cambiar el elemento
            la $a0,v1 # Cargo la dirección base de v1 en a0
            lw $a1,n1 # Cargo el número de elementos de v1 en a1
            move $a2,$t3 # Muevo el índice a a2
            mov.s $f12,$f0 # Mueve el nuevo valor a f12
            jal change_elto
            j mostrar_vectores
        opcion2_v1_fin:

        opcion2_v2:
            li $v0,4
            la $a0,elige_elto # Pregunta por el índice a cambiar
            syscall
            li $v0,5
            syscall
            move $t3,$v0 # Mueve el índice a t3
            bltz $t3,error_indice # Si el índice es menor o igual a 0 mostrar mensaje de error
            lw $s4,n2 # Cargar los elementos de v2
            bge $t3,$s4,error_indice # Si el índice a cambiar es mayor o igual que los índice de v2 mostrar mensaje de error
            li $v0,4
            la $a0,newval # Introducir el nuevo valor para ese índice
            syscall
            li $v0,6
            syscall
            # Cambiar el elemento
            la $a0,v2 # Cargo la dirección base de v2 en a0
            lw $a1,n2 # Cargo el número de elementos de v2 en a1
            move $a2,$t3 # Muevo el índice a a2
            mov.s $f12,$f0 # Mueve el nuevo valor a f12
            jal change_elto
            j mostrar_vectores
        opcion1_v2_fin:


        

        










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
        error_indice:
        li $v0,4
        la $a0,error_ind
        syscall
        j mostrar_vectores
        error_dimension_distinta:
        li $v0,4
        la $a0,error_d_dim
        syscall
        j mostrar_vectores
    errores_fin:

    # Opción 0 (Termina el programa)
    opcion0:
        li $v0,4
        la $a0,msg_fin
        syscall
        li $v0,10
        syscall
    opcion0_fin:
# EXIT




