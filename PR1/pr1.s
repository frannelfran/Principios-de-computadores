# Autor: Franco Alla
# Correo electrónico: alu0101571669@ull.edu.es
# Fecha: 10-03-2023

    .data
titulo: .asciiz "\n\nAproximación a sen(x) (-1 <= x <= 1) con un error máximo, usando Taylor\n"
petx:   .asciiz "\n\nIntroduzca el valor de x (-1 <= x <= 1): "
pete:   .asciiz "\nIntroduzca el error maximo permitido en la aproximación (0 < error < 1) (error <= 0 sale del programa): "
cadsen: .asciiz "\n\n\nsen(x) calculado: "
caderr: .asciiz "\nerror calculado: "
cadite: .asciiz "\nnumero de iteraciones calculadas: "
cadfin: .asciiz "\nFin del programa\n"

    # Registros utilizados  
    # $f2 == x
    # $f4 y $f6 == rango permitido == 2*n+1
    # $f8 == error
    # $f10 == n
    # $f12 == 2*n
    # $f14 == numerador
    # $f16 == denominador 
    # $f18 == signo
    # $f20 == sen_x
    # $f22 == double xx
    # $f24 == old_senx
    # $f26 == error_calculado
    # $f28 == término

    .text
main:
    li $v0,4
    la $a0,titulo # Muestra el título del problema 
    syscall
    do1:
        do2:
            li $v0,4
            la $a0,petx # Pide x
            syscall
            li $v0,7
            syscall
            mov.d $f2,$f0 # Mueve x al registro f2
                # Inicializo el rango
            li.d $f4,-1.0
            li.d $f6,1.0
            while: c.lt.d $f2,$f4 # x < -1
                bc1t do2
                while2: c.le.d $f2,$f6 # x > 1
                    bc1f do2
                while2Fin:
            whileFin:
        do2Fin:
        do3:
            li $v0,4
            la $a0,pete # Pide el error
            syscall
            li $v0,7
            syscall
            mov.d $f8,$f0 # Mueve el error al registro f8
            while3: c.lt.d $f8,$f6 # error >= 1
                bc1f do3
            while3Fin:
        do3Fin:
        li.d $f0,0.0 
        if: c.le.d $f8,$f0 # error <= 0
            bc1t exit
        ifFin:

        li $t1,0 # Inicializo iteracciones (n)
        mov.d $f14,$f2 # numerador == x
        li.d $f16,1.0 # denominador == 1
        li.d $f18,1.0 # signo == 1
        mov.d $f20,$f2 # sen_x == x
        mul.d $f22,$f2,$f2 # double xx == x*x

        do4:
            mov.d $f24,$f20 # old_senx == sen_x
            add $t1,$t1,1 # n++
            neg.d $f18,$f18 # signo == -signo
            mul.d $f14,$f14,$f22 # numerador *= x*x
            # Calculo del denominador
            li.d $f12,2.0
            mtc1 $t1,$f10
            cvt.d.w $f10,$f10 # Conversión a double de n
            mul.d $f12,$f12,$f10 # 2*n
            add.d $f4,$f12,$f6 # 2*n+1
            mul.d $f4,$f12,$f4 # (2*n+1) * 2*n
            mul.d $f4,$f4,$f16 # (2*n+1) * 2*n * denominador
            mov.d $f16,$f4 # denominador = (2*n+1) * 2*n * denominador
            # Calculo del término
            mul.d $f28,$f18,$f14 # signo * numerador 
            div.d $f28,$f28,$f16 # término = signo * numerador / denominador
            # Calculo del sen_x
            add.d $f20,$f20,$f28 # sen_x += término
            # Calculo del error_calculado
            sub.d $f26,$f20,$f24 # sen_x - old_senx
            div.d $f26,$f26,$f20 # (sen_x - old_senx) / sen_x
            abs.d $f26,$f26 # error_calculado == fabs((sen_x - old_senx) / sen_x)
            while4: c.le.d $f26,$f8
                bc1f do4
            while4Fin:
        do4Fin:
        # Muestra por consola 
        li $v0,4
        la $a0,cadsen # Muestra el sen_x calculado
        syscall
        li $v0,3
        mov.d $f12,$f20
        syscall
        li $v0,4
        la $a0,caderr # Muestra el error calculado
        syscall
        li $v0,3
        mov.d $f12,$f26
        syscall
        li $v0,4
        la $a0,cadite # Muestra el número de iteracciones
        syscall
        li $v0,1
        move $a0,$t1
        syscall
        while5: b do2
    do1Fin:
    exit:
    li $v0,4
    la $a0,cadfin # Fin del programa 
    syscall
    li $v0,10
    syscall
    li $v0,10
    syscall
# EXIT