DATA SEGMENT PARA PUBLIC 'DATA'
    userInput db 100, ?, 100 DUP(?)
    SUM DW 0
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
ASSUME CS:CODE, DS:DATA
START PROC FAR
PUSH DS
XOR AX, AX
MOV DS, AX
PUSH AX
MOV AX, DATA
MOV DS, AX
; your code starts here
CALL HEXING
; your code ends here
RET
START ENDP

READ PROC NEAR
    MOV AH, 0AH
    MOV DX,OFFSET userInput
    INT 21H
    RET
READ ENDP

PRINT PROC NEAR
    XOR DX,DX
    XOR SI,SI
    XOR DI,DI

    MOV DI,3
    MOV AX,SUM
    MOV BX,SP
    spin:
        XOR DX,DX
        DIV ten
        ADD DL,'0'
        PUSH DX
        INC SI
        CMP SI,DI
        JNE spin

    MOV AH,02H
    unload:
        POP DX
        INT 21H
        CMP BX,SP
        JNE unload
    RET
PRINT ENDP

PROCESS PROC NEAR
    MOV CL,userInput[1]
    MOV DI,CX
    ADD DI,2
    ADD SI,2
    analyze:
        XOR CX,CX
        MOV CL, userInput[SI]
        ADD SUM,CX
        INC SI
        CMP SI,DI
        JNE analyze
    RET
PROCESS ENDP

HEXING PROC NEAR
    CALL READ
    CALL PROCESS
    NEW_LINE
    CALL PRINT
    RET
HEXING ENDP

CODE ENDS
END START