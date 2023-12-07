section .data
    studentTable db "Sarah", "90",
                 db "James", "86",
                 db "Tom", "74",
                 db "Jane", "79",
                 db "Sally", "95",
                 db "John", "93",
                 db "Jack", "64",
                 db "Julie", "53",
                 db "Yasmin", "80",
                 db "Frank", "61"

section .text
    global _start

_start:
    ; Initialize registers
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    ; Calculate the length of the studentTable
    mov ecx, studentTable
    mov edx, 0
    count_length:
        cmp byte [ecx], 0
        je end_count_length
        inc edx
        inc ecx
        jmp count_length
    end_count_length:

    ; Sort the studentTable using selection sort
    mov esi, studentTable
    mov edi, 0
    outer_loop:
        cmp edi, edx
        jge end_outer_loop
        mov ecx, edi
        inc ecx
        mov ebx, ecx
        inner_loop:
            cmp ebx, edx
            jge end_inner_loop
            mov eax, ebx
            mov esi, studentTable
            mov edx, 0
            inner_loop2:
                cmp edx, eax
                jge end_inner_loop2
                add esi, 4
                inc edx
                jmp inner_loop2
            end_inner_loop2:
            mov edx, [esi]
            mov eax, [esi+4]
            cmp edx, eax
            jg swap
            inc ebx
            jmp inner_loop
        end_inner_loop:
        inc edi
        jmp outer_loop
    end_outer_loop:

    ; Display the sorted table
    mov esi, studentTable
    mov ecx, edx
    display_table:
        cmp ecx, 0
        je end_display_table
        mov edx, esi
        mov eax, 4
        mov ebx, 1
        mov ecx, edx
        mov edx, 4
        int 0x80
        add esi, 8
        dec ecx
        jmp display_table
    end_display_table:

    ; Print the letter grades
    mov esi, studentTable
    mov ecx, edx
    mov eax, 0
    mov ebx, 0
    mov edx, 0
    mov edi, 0
    print_letter_grade:
        cmp ecx, 0
        je end_print_letter_grade
        mov edx, esi
        mov eax, 4
        mov ebx, 1
        mov ecx, edx
        mov edx, 4
        int 0x80
        add esi, 8
        dec ecx
        jmp print_letter_grade
    end_print_letter_grade:

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80


