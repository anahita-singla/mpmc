dosseg ;para align
.model small  ;64k of mem for code
.stack 100h  ;stack space 100 bytes for prgrm
.data ;variable storage section
menu db '*****************MENU*********************$'
menu1 db 'Press 1 for rikshw$'
menu2 db 'Press 2 for cars$'
menu3 db 'Press 3 for bus$'
menu4 db 'Press 4 to show the record$'
menu5 db 'Press 5 to delete the record$'
menu6 db 'Press 6 to exit$'
msg1 db 'Parking Is Full$'
msg2 db 'Wrong input$'
msg3 db 'car$'
msg4 db 'bus$'
msg5 db 'record$'
msg6 db 'there is more space$'
msg7 db 'the total amount is=$'
msg8 db 'the total numbers of vehicles parked=$'
msg9 db 'the total number of rikshws parked=$'
msg10 db 'the total number of cars parked=$'
msg11 db 'the total number of buses parked=$'
msg12 db '***Record deleted successfully***$'
amount dw 0   ;total amount 
count dw  '0'  ;total vehicles parked
amR db '200$'  ;amount of rikshaw
amC db '300$'  ;amount of car
amB db '400$'  ;amount of bus


r dw '0' ;total number of rikshaw
c db '0' ;total number of car
b db '0' ;total number of bus
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
je rikshw
cmp al,'2'
je car
cmp al,'3'
je bus
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

rikshw:
call rikshaw


car:
call caar


rec:
call recrd


del:
call delt


bus:
call buss



end_:
mov ah,4ch  ;end code segment
int 21h

main endp ;to end main procedure





rikshaw proc
cmp count,'8'  ;count<8 check condition
jle rikshw1    ;
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

rikshw1:
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


caar proc
cmp count,'8'
jle car1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

car1:
mov ax,300
add amount, ax
mov dx,offset amC
mov ah,9
int 21h

inc count
inc c
jmp while_
jmp end_




buss proc
cmp count,'8'
jle bus1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

bus1:
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

mov dx,r
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
