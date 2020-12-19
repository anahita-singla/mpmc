
.model small  ;64k of mem for code
.stack 100h  ;stack space 100 bytes for prgrm
.data ;variable storage section
menu db 'MENU: Press the option you want to select$'
menu1 db '1 for rice$'
menu2 db '2 for cheese$'
menu3 db '3 for bread$'
menu4 db '4 to show your cart$'
menu5 db '5 to delete your cart$'
menu6 db 'Press 6 to exit$'
msg1 db 'Your cart Is Full$'
msg2 db 'Wrong input$'
msg3 db 'cheese$'
msg4 db 'bread$'
msg5 db 'record$'
msg6 db 'there is more space$'
msg7 db 'the total amount is=$'
msg8 db 'the total items bought=$'
msg9 db 'the total number of rice kilos bought=$'
msg10 db 'the total number of cheese packets bought=$'
msg11 db 'the total number of bread packets bought=$'
msg12 db '***Cart deleted successfully***$'
amount dw 0   ;total amount 
count dw  '0'  ;total items bought
amR db '200$'  ;amount of rice
amC db '300$'  ;amount of cheese
amB db '400$'  ;amount of bread


r db '0' ;total number of rice
c db '0' ;total number of cheese
b db '0' ;total number of bread
.code
main proc
mov ax,@data
mov ds,ax





while_:   
             ;Menu
mov dx,10  ;down key ascii 10
mov ah,2
int 21h
mov dx,13 ;enter key ascii 13
mov ah,2
int 21h

call newl

;printing menu statement
mov dx,offset menu  
mov ah,9      ;output of a string at DS:DX
int 21h

call newl


mov dx,offset menu1
mov ah,9
int 21h

call newl


mov dx,offset menu2
mov ah,9
int 21h

call newl


mov dx,offset menu3
mov ah,9
int 21h

call newl

mov dx,offset menu4
mov ah,9
int 21h

call newl



mov dx,offset menu5
mov ah,9
int 21h

call newl


mov dx,offset menu6
mov ah,9
int 21h

call newl



  ;userinput

  mov ah,1    ;input option number(1-6)
int 21h
mov bl,al

call newl

  ;now compare
mov al,bl
cmp al,'1'
je ricew
cmp al,'2'
je cheese
cmp al,'3'
je bread
cmp al,'4'
je rec
cmp al,'5'
je del
cmp al,'6'
je end_


mov dx,offset msg2 ;wrong input(we reach if no jump)
mov ah,9
int 21h

call newl
jmp while_

ricew:
call riceaw


cheese:
call cheesear


rec:
call recrd


del:
call delt


bread:
call breads



end_:
mov ah,4ch  ;end code segment
int 21h

main endp ;to end main procedure





riceaw proc
cmp count,'8'  ;count<8 check condition
jle ricew1    ;
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

ricew1:
mov ax,200
add amount, ax
mov dx,offset amR
mov ah,9
int 21h
inc count
;mov dx,count
inc r

jmp while_
jmp end_


cheesear proc
cmp count,'8'
jle cheese1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

cheese1:
mov ax,300
add amount, ax
mov dx,offset amC
mov ah,9
int 21h

inc count
inc c
jmp while_
jmp end_




breads proc
cmp count,'8'
jle bread1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

bread1:
mov ax,400
add amount, ax
mov dx,offset amB
mov ah,9
int 21h

inc count
inc b
jmp while_
jmp end_


recrd proc
mov dx,offset msg7
mov ah,9
int 21h


; print here the whole amount
mov ax, amount

mov dx,0
mov bx,10
mov cx,0
totalpush:
        div bx
       push dx
       mov dx,0
        mov ah,0
           inc cx
       cmp ax,0
      jne totalpush
   
totalprint:
      pop dx
       add dx,48
       mov ah,2
       int 21h
      loop totalprint


call newl





mov dx,offset msg8
mov ah,9
int 21h

mov dx,count
mov ah,2
int 21h

call newl


mov dx,offset msg9
mov ah,9
int 21h

mov dl,r
mov ah,2
int 21h

call newl



mov dx,offset msg10
mov ah,9
int 21h


mov dl,c
mov ah,2
int 21h

call newl



mov dx,offset msg11
mov ah,9
int 21h

mov dl,b
mov ah,2
int 21h

jmp while_
jmp end_


delt proc
mov r,'0'
mov c,'0'
mov b,'0'
mov amount,0
;sub amount,48
mov count,'0'
mov dx,offset msg12
mov ah,9
int 21h

call newl




jmp while_
jmp end_


newl proc
mov dx,10
mov ah,2 
int 21h
mov dx,13
mov ah,2
int 21h
ret
newl endp







end main
