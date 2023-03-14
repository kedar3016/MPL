%macro print 2
 mov eax,04
 mov ebx,01
 mov ecx,%1
 mov edx,%2
 int 80h
%endmacro
section .data
 arr dd -18888888h,18888888h,22222222h,11111111h
 n equ 4
 pmsg db 10d,13d,"The Count of Positive No: ",10d,13d
 plen equ $-pmsg
 nmsg db 10d,13d,"The Count of Negative No: ",10d,13d
 nlen equ $-nmsg
 nwline db 10d,13d

section .bss
 pcnt resq 1
 ncnt resq 1
 char_answer resb 8

section .text
 global _start
 _start:
 mov esi,arr
 mov edi,n
 mov ebx,0
 mov ecx,0

 up:
 mov eax,[esi]
 cmp eax,00000000h
 js negative

 positive: inc ebx
 jmp next
 negative: inc ecx

 next: add esi,4
 dec edi
 jnz up
 mov [pcnt],ebx
 mov [ncnt],ecx
 print pmsg,plen
 mov eax,[pcnt]
1
 call display
 print nmsg,nlen
 mov eax,[ncnt]
 call display
 print nwline,1
 mov eax,1
 mov ebx,0
 int 80h


;display procedure for 32bit
display:
 mov esi,char_answer
 mov ecx,8
 cnt: mov ebx,04
 mov dl,bl
 and dl,0fh
 cmp dl,09h
 jbe add30
 add dl,07h
 add30: add dl,30h
 mov [esi],dl
 dec esi
 dec ecx
 jnz cnt
 print char_answer,8
ret
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
64 bit
%macro scall 4
 mov rax,%1
 mov rdi,%2
 mov rsi,%3
 mov rdx,%4
 syscall
%endmacro
section .data
 arr dq 7222222211111111h,-1111111100000000h,-
7999999999999999h,7FFFFFFFFFFFFFFFh
 n equ 4
 pmsg db 10d,13d,"The Count of Positive No: ",10d,13d
