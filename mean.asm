DATA SEGMENT PARA PUBLIC 'DATA'
    buffer db 100, ?, 100 DUP(?)
    ten DW 10
DATA ENDS

NEW_LINE MACRO
    ; Print a new line to the console
    PUSH AX
    PUSH DX

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H

    POP DX
    POP AX
ENDM

CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE,DS:DATA
START PROC FAR
PUSH DS
XOR AX, AX
MOV DS, AX
PUSH AX
MOV AX, DATA
MOV DS, AX
; your code starts here
CALL MEAN
; your code ends here
RET
START ENDP

READ PROC NEAR
    MOV DX,OFFSET buffer
    MOV AH,0AH
    INT 21H
    RET
READ ENDP

PROCESS PROC NEAR
    XOR AX,AX
    XOR DX,DX
    XOR BX,BX
    XOR DI,DI
    XOR SI,SI
    MOV CL,buffer[1]
    MOV SI,CX
    ADD SI,2
    MOV DI,2
    get_digit:
        MOV AL,buffer[DI]
        SUB AL,'0'
        ADD BX,AX
        INC DI
        CMP DI,SI
        JNE get_digit 
    
    MOV AX,BX
    DIV buffer[1]
    MOV AH,0
    RET
PROCESS ENDP

PRINT PROC NEAR
    XOR DX,DX
    MOV SI,SP
    div_digit:
        DIV ten
        ADD DL,'0'
        PUSH DX
        OR AX,AX
        JNZ div_digit

    XOR AX,AX
    MOV AH,02H
    print_digit:
        POP DX
        INT 21H
        CMP SI,SP
        JNE print_digit

    RET 
PRINT ENDP

MEAN PROC NEAR
    CALL READ
    NEW_LINE
    CALL PROCESS
    CALL PRINT
    RET
MEAN ENDP

CODE ENDS
END START