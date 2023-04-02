# Esqueleto PR3

maximoElementos=400 # numero de enteros maximo reservado para la matriz 1600 bytes
size=4 # bytes que ocupa un entero

    .data
mat:   .word   100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119
       .word   120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139
       .word   140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
       .word   160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179
       .word   180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199
       .word   200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219
       .word   220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
       .word   240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259
       .word   260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279
       .word   280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299
       .word   300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319
       .word   320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339
       .word   340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359
       .word   360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379
       .word   380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399
       .word   400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419
       .word   420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439
       .word   440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459
       .word   460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479
       .word   480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499
       

nfil:   .word   20 # nuemro de filas de la matriz
ncol:   .word   10 # numero de columnas de la matriz

titulo:     .asciiz "\nPráctica PR3 de Principios de Computadores. Manejo de Matrices.\n"
msg_matriz: .asciiz "\nLa matriz es "
msg_x:      .asciiz "x"
separador:  .asciiz "  " # separador entre numeros
newline:    .asciiz "\n"
menu:       .ascii  "\n(1) Cambiar dimensiones\n(2) Intercambiar dos elemento\n"
            .ascii  "(3) Suma elementos del perimetro\n(4) Calcula max y min de la diagonal\n"
            .asciiz "(0) Salir\n\nElija opcion: "

error_op:   .asciiz "\nError: opcion incorrecta.\n"
msg_nfilas: .asciiz "Introduzca numero de filas: "
msg_ncols:  .asciiz "Introduzca numero de columnas: "
error_nfilas:   .asciiz "\nError: dimension incorrecta. Numero de fila incorrecto.\n"
error_ncols:    .asciiz "\nError: dimension incorrecta. Numero de columna incorrecto.\n"
error_dime:     .asciiz "\nError: dimension incorrecta. Excede el maximo numero de elementos (400).\n"
msg_i:      .asciiz "Introduzca fila del primer elemento a cambiar: "
msg_j:      .asciiz "Introduzca columna del primer elemento a cambiar: "
msg_r:      .asciiz "Introduzca fila del segundo elemento a cambiar: "
msg_s:      .asciiz "Introduzca columna del segundo elemento a cambiar: "
msg_suma:   .asciiz "\n\nSuma de los elementos del perímetro: "
msg_max:    .asciiz "\nEl máximo de la diagonal principal es "
msg_min:    .asciiz " y el mínimo "
msg_fin:    .asciiz "\nFin del programa.\n"

    # Registros utilizados
    # $s1 == nfil
    # $s2 == ncol
    # $t1 == filas
    # $t2 == columnas
    # $t3 == dirección [f][c]
    # $t4 == Teclear opción

.text
main:
    li $v0,4
    la $a0,titulo # Muestra el título de la práctica
    syscall
    # Mostrar por pantalla las dimensiones de la matriz
    li $v0,4
    la $a0,msg_matriz
    syscall
    lw $s1,nfil # Cargo lo que esta almacenado en la dirección de las filas de la matriz en s0
    li $v0,1
    move $a0,$s1 # Muestro por consola las filas de la matriz
    syscall
    li $v0,4
    la $a0,msg_x # Muestra "x"
    syscall
    lw $s2,ncol # Cargo lo que esta almacenado en la direccion de memoria de las columnas de la matriz en s1
    li $v0,1
    move $a0,$s2 # Muestro las columnas de la matriz 
    syscall
    li $v0,4
    la $a0,newline
    syscall

    # Mostrar Matriz
    la $s0,mat # Cargo la dirección base de la matriz en s0
    move $s3,$s0 # Muevo la dirección de la matriz a s3
    li $t1,0 # Inicializo las filas a 0
    li $t2,0 # Inicializo las columnas a 0
    bucle1:
        move $t2,$zero # Carga un 0 en t2
        bucle2:
            mul $t3,$t1,$s2 # f*ncol
            add $t3,$t3,$t2 # f*ncol+c
            mul $t3,$t3,size # (f*ncol+c)*size
            add $t3,$t3,$s3 # Carga la dirección donde se encuentra el elemento de la matriz
            lw $s4,($t3) # Cargamos el valor de la matriz en s4
            li $v0,1
            move $a0,$s4 # Muestra por consola el elemento
            syscall
            li $v0,4
            la $a0,separador # Deja un espacio entre los elementos de la matriz
            syscall
            addi $t2,$t2,1 #c++
            blt $t2,$s2,bucle2
            addi $t1,$t1,1
            li $v0,4
            la $a0,newline # Pasa a la siguiente fila de la matriz
            syscall
            blt $t1,$s1,bucle1
        bucle2Fin:
    bucle1Fin:
    # Menú
    Opciones:
        li $v0,4
        la $a0,menu # Muestra en consola el menú
        syscall
        li $v0,5
        syscall
        move $t4,$v0 # Muevo la opción a t4
    finOpciones:

    # Opción 1
    li $v0,4
    la $a0,msg_nfilas # Pregunta de cuántas filas tiene la matriz
    syscall
    li $v0,5
    syscall
    move $s1,$v0 # Mueve las filas a s1
    li $v0,4
    la $a0,msg_ncols # Pregunta de cuántas columnas tiene la matriz 
    syscall
    li $v0,5
    syscall
    move $s2,$v0 # Mueve las columnas a s2


    li $v0,10
    syscall
# EXIT