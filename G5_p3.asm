 DATA SEGMENT PARA PUBLIC 'DATA' 
 CHEESE  DB  "The cheese tax! The cheese tax!$" 
 lengthCheese DW $-CHEESE
 VERSE1  DB  "You've got to pay the cheese tax", 0AH, 0DH, "Every time you're cooking", 0AH, 0DH, "When the cheese comes out", 0AH, 0DH, "This puppy comes looking$" 
 lengthVERSE1 DW $-VERSE1
 VERSE2  DB  "The rules are the rules", 0AH, 0DH, "And the facts are the facts", 0AH, 0DH, "And when the cheese drawer opens", 0AH, 0DH, "You've got to pay the tax$" 
 VERSE3  DB  "Hand it over quick", 0AH, 0DH, "Or things might get ugly", 0AH, 0DH, "I can get really loud", 0AH, 0DH, "I'm a really barky puppy$" 
 VERSE4  DB  "I'm not just asking", 0AH, 0DH, "Because I'm looking for snacks", 0AH, 0DH, "This is real important business", 0AH, 0DH, "And you've got to pay the tax$" 
 VERSE5  DB  "Cheddar is acceptable, and Parmesan is fine", 0AH, 0DH, "But a little bit of Gouda would really blow my mind", 0AH, 0DH, "There's no escaping, so don't try to dodge", 0AH, 0DH, "Pay the dairy tarriff! The collection of fromage!$" 
 DATA ENDS 

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
    XOR AX,AX
    CALL FAR PTR TAXING
; your code ends here
RET
START ENDP

PRINT PROC NEAR
    MOV DX,OFFSET VERSE1
    MOV AH,09H
    INT 21H
    RET
PRINT ENDP

NEW_LINE PROC NEAR
    PUSH AX
    PUSH DX

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H

    POP DX
    POP AX
    RET
NEW_LINE ENDP

TAXING PROC FAR
    CALL PRINT
    XOR SI,SI
    change:
        change_C:
            CMP VERSE1[SI],63H
            JNE change_H
            MOV VERSE1[SI],23H
        change_H:
            CMP VERSE1[SI],68H
            JNE change_E
            MOV VERSE1[SI],40H
        change_E:
            CMP VERSE1[SI],65H
            JNE change_S
            MOV VERSE1[SI],2AH
        change_S:
            CMP VERSE1[SI],73H
            JNE continue
            MOV VERSE1[SI],25H
        continue:
            INC SI 
            CMP SI,lengthVERSE1
            JNE change
    CALL NEW_LINE
    CALL PRINT
    RET
TAXING ENDP

CODE ENDS
END START