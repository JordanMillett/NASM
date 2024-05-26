section .text
    global _start
    extern  _ExitProcess@4
    extern  _WriteFile@20
    extern  _GetStdHandle@4

_start:
    ; DWORD  bytes;    
    mov     ebp, esp
    sub     esp, 4

    ; hStdOut = GetstdHandle( STD_OUTPUT_HANDLE)
    push    -11
    call    _GetStdHandle@4
    mov     ebx, eax   
    
    ; WriteFile( hstdOut, message, length(message), &bytes, 0);
    push    0
    lea     eax, [ebp-4]
    push    eax
    push    (message_end - message)
    push    message
    push    ebx
    call    _WriteFile@20
    
    ; exit
    push    0
    call    _ExitProcess@4
    
    hlt
message:
    db      'Hello, World', 10
message_end:
; exit
;    mov     eax, 0          ; Return 0 (exit code)
;    ret                     ; Return from _start