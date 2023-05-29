DATA SEGMENT PARA PUBLIC 'DATA'
    array DB 1,2,3,5
    lengthArray DB $-array
    ten DW 10 
    buffer DB 3 DUP(0)
DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE, DS:DATA
START PROC FAR
PUSH DS
XOR AX,AX
PUSH AX
MOV AX,DATA
MOV DS,AX
; your code starts here
    XOR AX,AX
    XOR SI,SI
    XOR CX,CX
    MOV DL,lengthArray
    sumAction:
        MOV AL,array[SI] 
        ADD CX,AX
        INC SI
        CMP SI,DX
        JNE sumAction

    LEA DI,buffer+2 ;DI is a pointer and its now pointing to the final position in buffer
    MOV buffer+2,'$' ;In order to print a string ( numbers cant be printed ), we add NULL character
    XOR AX,AX ;Clear AX just to make sure
    XOR DX,DX
    MOV AX,CX ;move the sum to AX
    print_sum:
        DIV ten ;divide the sum by 10 and get the last digit ( if sum = 13 then DL will have 3 after division )
        ADD DL,'0' ;add '0' so we get ascii code
        DEC DI ;decrease DI so we add the ascii code to buffer in correct spot 
        MOV [DI],DL ;add the ascii code
        XOR DX,DX ;clear DX for next division
        OR AX,AX ;check if AX is 0 ( check if all digits have been converted to ascii )
        JNZ print_sum ; if not, repeat process
        MOV DX,OFFSET buffer ;buffer now contains all the digits of sum in ascii format
        MOV AH, 09H 
        INT 21H


; your code ends here
RET
START ENDP
CODE ENDS
END START