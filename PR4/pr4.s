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

    .text

    # Mostrar vectores
    print_vec:
        add $sp,$sp,-24
        sw $ra, 20($sp)
        sw $s1, 16($sp)
        sw $s2, 12($sp)
        sw $s3, 8($sp)
        sw $s4, 4($sp)
        sw $s5, 0($sp)

        move $s1,$a0 # Carga la dirección base de v1 o v2 en s1
        move $s2,$a1 # Carga el número de elementos de v1 o v2 en s2
        move $s5,$a2 # Mueve el asciiz "space" a s5
        li $s3,0 # Inicializo el contador n

        vector:
            mul $s4,$s3,size
            addu $s4,$s4,$s1 # Busco el elemento
            l.s $f4,($s4) # Cargo el elemento en f4
            addi $s3,$s3,1 # n++

            li $v0,2
            mov.s $f12,$f4
            syscall

            li $v0,4
            move $a0,$s5
            syscall
            blt $s3,$s2,vector
        vector_fin:

        lw $s5, 0($sp)
        lw $s4, 4($sp)
        lw $s3, 8($sp)
        lw $s2, 12($sp)
        lw $s1, 16($sp)
        lw $ra, 20($sp)
        add $sp,$sp,24
        jr $ra
    print_vec_fin:

    # Cambiar elemento
    change_elto:

        move $t0,$a0 # Carga la dirección base de v1 o v2 en s0
        move $t1,$a1 # Muevo el índice a s1
        mov.s $f4,$f12

        mul $t2,$t1,size
        addu $t2,$t2,$t0 # Busca la dirección del índice marcado
        s.s $f4,($t2) # Cambia el elemento

        jr $ra
    change_elto_fin:

    # Invertir vector
    swap:

        move $t0,$a0 # Carga la dirección base de v1 o v2 en s0
        move $t1,$a1 # Carga el primer índice en s1
        move $t2,$a2 # Carga el segundo índice en s2
        
        # Cargo el primer elemento
        mul $t3,$t1,size
        addu $t3,$t3,$t0
        l.s $f4,($t3) # Cargo el elemento en s4

        mul $t5,$t2,size
        addu $t5,$t5,$t0
        l.s $f5,($t5) # Cargo el segundo elemento en f21

        # Intercambio elementos
        s.s $f4,($t5)
        s.s $f5,($t3)
        jr $ra
    swap_fin:

    # Suma del producto escalar
    mult_add:
        mul.s $f0,$f12,$f13 # Multiplico los elementos de ambos vectores
        add.s $f0,$f0,$f14 # Los sumo
        jr $ra
    mult_add_fin:

    # Producto escalar
    prod_esc:

        add $sp,$sp,-28
        sw $ra, 24($sp)
        sw $s0, 20($sp)
        sw $s1, 16($sp)
        sw $s2, 12($sp)
        sw $s3, 8($sp)
        sw $s4, 4($sp)
        s.s $f20, 0($sp)

        move $s0,$a0 # Dirección de memoria de v1
        move $s1,$a1 # Dirección de memoria de v2
        move $s2,$a2 # Número de elementos de v1 y v2
        li $s3,0 # Índice == n
        li.s $f20,0.0 # Inicializo la suma
        # Buscar elementos de v1
        for: bge $s3,$s2,for_fin
            mul $s4,$s3,size
            addu $s4,$s4,$s0
            l.s $f12,($s4) # Almaceno en f12 los elementos de v1
            # Buscar elementos de v2
            mul $s4,$s3,size
            addu $s4,$s4,$s1
            l.s $f13,($s4) # Almaceno en f13 los elementos de v2
            mov.s $f14,$f20
            addi $s3,$s3,1 #n++
            jal mult_add
            mov.s $f20,$f0
            b for
        for_fin:
        mov.s $f0,$f20

        l.s $f20, 0($sp)
        lw $s4, 4($sp)
        lw $s3, 8($sp)
        lw $s2, 12($sp)
        lw $s1, 16($sp)
        lw $s0, 20($sp)
        lw $ra, 24($sp) 
        add $sp,$sp,28
        jr $ra
    prod_esc_fin:

main:
    ##########################################################
    # PONER LOS VECTORES EN MEMORIA
    ##########################################################
    li.s $f5,1.0
    # Poner en memoria los vectores
    li.s $f4,10.0
    cargar_v1:
        s.s $f4,v1($v1) # Guardar los elementos
        add.s $f4,$f4,$f5 # Siguiente elemento
        addi $t1,$t1,1 # n++
        addi $v1,$v1,4 # Siguiente dirección de memoria
        blt $t1,40,cargar_v1
        sw $t1,n1 # Guardamos el número de elementos de v1
    cargar_v1_fin:
    # Reseteo de valores
    li.s $f4,40.0
    move $3,$zero
    move $t1,$zero
    cargar_v2:
        s.s $f4,v2($v1) # Guardar elementos
        sub.s $f4,$f4,$f5 # Siguiente elemento
        addi $t1,$t1,1 # n++
        addi $v1,$v1,4 # Siguiente direcció de memoria
        blt $t1,40,cargar_v2
        sw $t1,n2 # Guardamos el número de elementos de v2
    cargar_v2_fin:

    li $v0,4
    la $a0,title # Muestra el título del programa
    syscall
    ##########################################################
    # MOSTRAR VECTORES
    ##########################################################
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

        # Muestra v1 por consola
        vector_v1: 
            la $a0,v1 # Carga la dirección base de v1 en a0
            lw $a1,n1 # Carga en a1 el número de elementos de v1
            la $a2,space # Cargo el asciiz "space" en a2
            jal print_vec
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

        # Muestra v2 por consola
        vector_v2: 
            la $a0,v2 # Carga la dirección base de v1 en a0
            lw $a1,n2 # Carga en a1 el número de elementos de v1
            la $a2,space # Cargo el asciiz "space" en a2
            jal print_vec
        vector_v2_fin:

        li $v0,4
        la $a0,newline # Nueva línea
        syscall
    mostrar_vectores_fin:
    ##########################################################
    # MOSTRAR MENÚ
    ########################################################## 
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
        # beq $t2,3,opcion3 # Si la opción es 3 invertir el vector
        beq $t2,4,opcion4 # Si la opción es 4 realizar el producto escalar de los vectores
    opciones_menu_fin:
    ##########################################################
    # OPCIÓN 1 (CAMBIAR LA DIMENSIÓN DE UN VECTOR)
    ##########################################################
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
    ##########################################################
    # OPCIÓN 2 (CAMBIAR UN ELEMENTO)
    ##########################################################
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
            bge $t3,$s3,error_indice # Si el índice a cambiar es mayor o igual que los índice de v1 mostrar mensaje de error

            li $v0,4
            la $a0,newval # Introducir el nuevo valor para ese índice
            syscall
            li $v0,6
            syscall

            mov.s $f12,$f0 # Almacena en f12 el valor a cambiar por otro del vector 
            la $a0,v1 # Cargo la dirección base de v1 en a0
            move $a1,$t3 # Muevo el índice a a2
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
            bge $t3,$s4,error_indice # Si el índice a cambiar es mayor o igual que los índice de v1 mostrar mensaje de error

            li $v0,4
            la $a0,newval # Introducir el nuevo valor para ese índice
            syscall
            li $v0,6 # Almavcena en f0 el elemento a cambiar
            syscall

            mov.s $f12,$f0
            la $a0,v2 # Cargo la dirección base de v1 en a0
            move $a1,$t3 # Muevo el índice a a2
            jal change_elto
            j mostrar_vectores
        opcion2_v2_fin:
    opcion2_fin:

    ##########################################################
    # OPCIÓN 3 (INVERTIR EL VECTOR)
    ##########################################################
    opcion3:
        li $v0,4
        la $a0,elige_vec # Pregunta con que vector quiere realizar el cambio
        syscall
        li $v0,5
        syscall
        move $t2,$v0 # Almacena la opción en t2
        blez $t2,error_opcion # Si la opción es menor que 0 mostrar mensaje de error
        bgt $t2,2,error_opcion # Si la opción es mayor que 2 mostrar mensaje de error
        beq $t2,1,opcion3_v1 # Si la opcion es 1 realizar para v1
        beq $t2,2,opcion3_v2 # si la opción es 2 realizar para v2

        opcion3_v1:
            la $a0,v1
            li $t4,0 # Primer índice del vector
            move $a1,$t4
            lw $s4,n1
            sub $s4,$s4,1 # Me situo en el último índice
            move $a2,$s4
            jal swap










    ##########################################################
    # OPCIÓN 4 (PRODUCTO ESCALAR)
    ##########################################################
    opcion4:
        lw $s3,n1 # Cargo el número de elementos de v1
        lw $s4,n2 # Cargo el nñumero de elementos de v2
        bne $s3,$s4,error_dimension_distinta # Si los vectores tienen distinta dimensión mostrar mensaje de error
        la $a0,v1
        la $a1,v2
        lw $a2,n1
        jal prod_esc
        li $v0,4
        la $a0,msg_prodesc
        syscall
        li $v0,2
        mov.s $f12,$f0 # Muestro la suma
        syscall
        j mostrar_vectores
    opcion4_fin:

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
        la $a0,msg_fin # Muestra mensaje de salida
        syscall
        li $v0,10
        syscall
    opcion0_fin:
# EXIT