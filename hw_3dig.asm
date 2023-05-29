DATA SEGMENT PARA PUBLIC 'DATA'
  zece DB 10
DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
 ASSUME CS:CODE, DS: DATA
 START PROC FAR
 PUSH DS
 XOR AX,AX
 PUSH AX
 MOV AX, DATA 
 MOV DS, AX


 MOV BX, 0 
 MOV CX, 0
 
number1:
   MOV AH, 1
   INT 21H
   CMP AL, 13     
   JZ enterVerify_1 
   CMP CX, 3   
   JZ number1  
   ADD CX, 1
   SUB AL, '0'
   MOV AH, 0
   PUSH AX
   MOV AX, BX
   MUL zece
   POP BX
   ADD BX, AX
   JMP number1

 enterVerify_1:
   CMP CX, 3
   JNZ number1 
 

 PUSH BX 
 MOV BX, 0
 MOV CX, 0
 
 number2:
   MOV AH, 1
   INT 21H
   CMP AL, 13
   JZ enterVerify_2
   CMP CX, 3
   JZ number2
   ADD CX, 1
   SUB AL, '0'
   MOV AH, 0
   PUSH AX
   MOV AX, BX
   MUL zece
   POP BX
   ADD BX, AX
   JMP number2

 enterVerify_2:
   CMP CX, 3
   JNZ number2


 MOV AX, BX
 POP BX
 ADD AX, BX 
 

 MOV CX, 0
 deconstruct:
    MOV BX, 10
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE deconstruct


 display_sum:
    POP BX
    MOV DX, BX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    DEC CX
    CMP CX, 0
    JE FINISHED
    JMP display_sum

 FINISHED :
   RET

START ENDP
CODE ENDS
END START 
