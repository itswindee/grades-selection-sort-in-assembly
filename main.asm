INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
DumpRegs PROTO

.data
	teamName db   "--------Team EMO/ Team 9 Project--------", 0
	theprocess db "-----Selection Sort Process------", 0
	initialTable db "-----Original Student Table-----", 0
	endResult db "-------Result/Sorted Table-------", 0
	distribution db "-------Grade Distribution-------", 0
	gradeLetters db "A's:,B's:,C's:,D's:,F's:,", 0
	gradeArray db 0, 0, 0 , 0, 0
	lettergrade1 db ' - A',0
	lettergrade2 db ' - B',0
	lettergrade3 db ' - C',0
	lettergrade4 db ' - D',0
	lettergrade5 db ' - F',0
	nameswap1 dword 0
	nameswap2 dword 0
	tempstorage dword 0
	myData db 90, 86, 74, 79, 95, 93, 64, 53, 80, 61
    names db ",Sarah,James,Tom,Jane,Sally,John,Jack,Julie,Yasmin,Frank,",0
	swappedNames db 60 DUP(0)
	studentName db 0, 0
	mylength equ 10
	num1 dword 0
	num2 dword 0
	num3 dword 0
	num4 dword 0

.code
main PROC
;Initializing registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor edi, edi

;Print the team name
print_TeamName:								;Printing out team name
	mov edx, offset teamName				;Load data teamName into the edx register
	call writestring						;Print
	call crlf								;Go to next line
	call crlf								;Go to next line

;Print out "Original Table"
print_initialTable:							;Printing out "Original Table"
	mov edx, offset initialTable			;Load data initialTable into the edx register
	call writestring						;Print
	call crlf								;Go to next line

;Printing out Unsorted Table
print_originalTable:						
	cmp ebx, 10								;Compare value in ebx register to value 10
	je selection_sort						;If equal, jump to selection_sort
	mov al, [names + esi]					;Load an element from the names array into al
	mov [studentName], al					;Store al into data studentName
	cmp studentName, ','					;Compare value in data studentName and ','(used as an index for names Array)
	je check_for_index_original				;If equal, jump to check_for_index_original	
	mov edx, offset studentName				;Load offset of data studentName (studentName is of type Byte) into the edx register
	call writestring						;Print
	inc esi									;Increment value in esi register by 1
	inc ecx									;Increment value in ecx register by 1
	jmp print_originalTable					;Jump to print_originalTable unconditionally

check_for_index_original:                   
	cmp ecx, 0                              ;Compare value in ebx register to 0
	jne print_original_grade                ;If not equal, jump to print_original_grade
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	jmp print_originalTable                 ;Jump to print_originalTable unconditionally

print_original_grade:
	mov [studentName], ' '                  ;Print a space between studentName and grade
	mov edx, offset studentName             ;Load offset of data studentName (studentName is of type Byte) into the edx register
	call writestring                        ;Print
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	xor eax, eax                            ;Perform exclusive or with eax register which zeros out
	mov al, [myData + ebx]                  ;Load an element from the myData array into al
	call writedec                           ;Print
	call crlf                               ;Go to next line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_originalTable                 ;Jump to print_originalTable unconditionally

;Printing out "Selection Sort Process" and preparing to sort
selection_sort:
	xor eax, eax                            ;Perform exclusive or with eax register which zeros out
	xor ebx, ebx                            ;Perform exclusive or with ebx register which zeros out
	xor ecx, ecx                            ;Perform exclusive or with ecx register which zeros out
	xor edx, edx                            ;Perform exclusive or with edx register which zeros out
	xor esi, esi                            ;Perform exclusive or with esi register which zeros out
	xor edi, edi                            ;Perform exclusive or with edi register which zeros out
	call crlf                               ;Go to next line
	mov edx, offset theprocess              ;Load offset of data theprocess (theprocess is of type Byte) into the edx register
	call writestring                        ;Print
	call crlf                               ;Go to next line

;Implementing Selection Sort
outer_loop:
	cmp ecx, mylength                       ;Compare value in ecx and mylength (equal to 10)
	je print_Result                         ;If equal, jump to print_Result
	mov esi, ecx                            ;Move content from ecx register to esi register
	mov ebx, esi                            ;Move content from esi register to ebx register
	inc ebx                                 ;Increment value in ebx register by 1

inner_loop:
	cmp ebx, mylength                       ;Compare value in ebx and mylength
	je swap_grades                          ;If equal, jump to swap_grades
	mov al, [myData + ebx]                  ;Load an element from the myData array into ebx
	mov dl, [myData + esi]                  ;Load an element from the myData array into esi
	cmp al, dl                              ;Compare value in al to value in dl
	jge increment_inner_loop                ;If greater than or equal, jump to increment_inner_loop
	mov esi, ebx                            ;Load data from ebx register into the esi register

increment_inner_loop:
	inc ebx                                 ;Increment value in ebx register by 1
	jmp inner_loop                          ;Jump to inner_loop unconditionally

;Swapping identified grades
swap_grades:
	cmp ecx, esi                            ;Compare value in ecx with value in esi
	je increment_outer_loop_no_sort         ;If equal, jump to increment_outer_loop_no_sort
	mov al, [myData + esi]                  ;Move data from [myData + esi] (calculated memory address) into al
	mov dl, [myData + ecx]                  ;Move data from [myData + ecx] (calculated memory address) into dl
	mov [myData + ecx], al                  ;Move data from al into [myData + ecx] (calculated memory address)
	mov [myData + esi], dl                  ;Move data from dl into [myData + esi] (calculated memory address)
	mov [nameswap1], ecx                    ;Move data from ecx to [nameswap1] (memory location)
	mov [nameswap2], esi                    ;Move data from esi to [nameswap2] (memory location)
	mov tempstorage, ecx                    ;Move data from ecx to tempstorage
	xor eax, eax                            ;Zero out eax
	xor edx, edx                            ;Zero out edx
	xor ebx, ebx                            ;Zero out ebx
	xor ecx, ecx                            ;Zero out ecx
	xor esi, esi                            ;Zero out esi

;Swapping names accordingly
start_swap:
	cmp ebx, 10                             ;Compare value in ebx register to value 10
	je complete_transfer                    ;If equal, jump to complete_transfer
	cmp ebx, nameswap1                      ;Compare value in ebx register to value in nameswap1
	je first_instance                       ;If equal, jump to first_instance
	cmp ebx, nameswap2                      ;Compare value in ebx register to value in nameswap2
	je prepare_final                        ;If equal, jump to prepare_final 
	mov al, [names + ecx]                   ;Move data from [names + ecx] (calculated memory address) into al
	mov [swappedNames + esi], al            ;Move data from al into [swappedNames + esi] (calculated memory address)
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je next_index                           ;If equal, jump to next_index
	jmp start_swap                          ;Jump to start_swap unconditionally

next_index:
	cmp ecx, 1                              ;Compare value in register ecx to value 1
	jle start_swap                          ;If less than or equal, jump to start_swap
	inc ebx                                 ;Increment value in ebx register by 1
	jmp start_swap                          ;Jump to start_swap unconditionally

first_instance:
	mov [num1], ecx                         ;Move value in ecx into [num1] (memory location)
	mov [num2], ebx                         ;Move value in ebx into [num2] (memory location)
	jmp first_swap                          ;Jump to first_swap unconditionally

minor_interlude:
	cmp num1, 0                             ;Compare value in num1 to value 0
	jne finish_first_swap                   ;If not equal, jump to finish_first_swap      
	dec ecx                                 ;Decrement value in ecx register by 1
	jmp finish_first_swap                   ;Jump to finish_first_swap unconditionally

first_swap:
	cmp ebx, nameswap2                      ;Compare value in ebx register to value in nameswap2
	je minor_interlude                      ;If equal, jump to minor_interlude
	mov al, [names + ecx]                   ;Move data from [names + ecx] (calculated memory address) into al
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	jne first_swap                          ;If not equal, jump to first_swap
	inc ebx                                 ;Increment value in ebx register by 1
	jmp first_swap                          ;Jump to first_swap unconditionally

finish_first_swap:
	mov al, [names + ecx]                   ;Move data from [names + ecx] (calculated memory address) into al
	mov [swappedNames + esi], al            ;Move data from al into [swappedNames + esi] (calculated memory address)
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je second_instance                      ;If equal, jump to second_instance
	jmp finish_first_swap                   ;Jump to finish_first_swap unconditionally

second_instance:
	mov [num3], ecx                         ;Move data from register ecx to [num3] (memory location)
	mov edi, ebx                            ;Move data from ebx register to edi register
	mov ecx, [num1]                         ;Move data from [num1] (memory location) to ecx register
	mov ebx, [num2]                         ;Move data from [num2] (memory location) to ebx register
	jmp iterate                             ;Jump to iterate unconditionally

iterate:
	mov al, [names + ecx]                   ;Move data from [names + ecx] (calculated memory address) into al
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je next_index                           ;If equal, jump to next_index
	jmp iterate                             ;Jump to iterate unconditionally

prepare_final:
	mov ecx, [num1]                         ;Move data from [num1] (memory location) to ecx register
	mov ebx, [num2]                         ;Move data from [num2] (memory location) to ebx register
	jmp second_swap                         ;Jump to second_swap unconditionally

second_swap:
	mov al, [names + ecx]                   ;Move data from [names + ecx] (calculated memory address) into al
	mov [swappedNames + esi], al            ;Move data from al into [swappedNames + esi] (calculated memory address)
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je final                                ;If equal, jump to final
	jmp second_swap                         ;Jump to second_swap unconditionally

final:
	mov ecx, [num3]                         ;Move data from [num3] (memory location) to ecx register
	mov ebx, edi                            ;Move data from edi register to ebx register
	jmp next_index                          ;Jump to next_index unconditionally

complete_transfer:
	xor ecx, ecx                            ;Zero out ecx
	xor ebx, ebx                            ;Zero out ebx

little_loop:
	cmp ebx, mylength                       ;Compare value in ebx register to mylength (10)
	jg prepare_printer                      ;If greater than, jump to prepare_printer
	mov al, [swappedNames + ecx]            ;Move data from [swappedNames + ecx] (calculated memory address) into al
	mov [names + ecx], al                   ;Move data from al into [names + ecx] (calculated memory address)
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	inc ecx                                 ;Increment value in ecx register by 1
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	jne little_loop                         ;If not equal, jump to little_loop
	inc ebx                                 ;Increment value in ebx register by 1
	jmp little_loop                         ;Jump to little_loop unconditionally

increment_outer_loop:
	call crlf                               ;New line
	mov ecx, tempstorage                    ;Move data from ttempstorage) to ecx register
	xor ebx, ebx                            ;Zero out ebx
	xor esi, esi                            ;Zero out esi
	inc ecx                                 ;Increment value in ecx register by 1
	jmp outer_loop                          ;Jump to outer_loop unconditionally

increment_outer_loop_no_sort:
	call crlf                               ;New line
	xor ebx, ebx                            ;Zero out ebx
	xor esi, esi                            ;Zero out esi
	inc ecx                                 ;Increment value in ecx register by 1
	jmp outer_loop                          ;Jump to outer_loop unconditionally

;Printing out the table after each sort to show the process
prepare_printer:
	xor edx, edx                            ;Zero out edx
	xor ecx, ecx                            ;Zero out ecx
	xor eax, eax                            ;Zero out eax
	xor ebx, ebx                            ;Zero out ebx
	xor esi, esi                            ;Zero out esi
	jmp print_studentTable                  ;Jump to print_studentTable unconditionally

;Printing names first
print_studentTable:
	cmp ebx, 10                             ;Compare value in register ebx to value 10
	je increment_outer_loop                 ;If equal, jump to increment_outer_loop  
	mov al, [names + esi]                   ;Move data from [names + esi] (calculated memory address) into al
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je check_for_index                      ;If equal, jump to check_for_index
	mov edx, offset studentName             ;Load offset of data studentName into the edx register
	call writestring                        ;Print message from edx (studentName)
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	jmp print_studentTable                  ;Jump to print_studentTable unconditionally

check_for_index:
	cmp ecx, 0                              ;Compare value in register ecx with value 0
	jne print_grade                         ;If not equal, jump to print_grade
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	jmp print_studentTable                  ;Jump to print_studentTable unconditionally

;Printing grades after names
print_grade:
	mov [studentName], ' '                  ;Print a space between studentName and grade
	mov edx, offset studentName             ;Load offset of data studentName into the edx register
	call writestring                        ;Print message from edx (studentName)
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	xor eax, eax                            ;Zero out eax
	mov al, [myData + ebx]                  ;Move data from [myData + ebx] (calculated memory address) into al
	call writedec                           ;Prints value from al
	cmp al, 90								;Compare value in al to value 90
	jge assign_A							;If greater than or equal, jump to assign_A
	cmp al, 80								;Compare value in al to value 80
	jge assign_B							;If greater than or equal, jump to assign_B
	cmp al, 70								;Compare value in al to value 70
	jge assign_C							;If greater than or equal, jump to assign_C
	cmp al, 60								;Compare value in al to value 60
	jge assign_D							;If greater than or equal, jump to assign_D
	cmp al, 60								;Compare value in al to value 60
	jl assign_F								;If less than, jump to assign_F

;Printing and assigning letter grades after grades
assign_A:
	mov edx, offset lettergrade1            ;Load offset of data lettergrade1 into the edx register
	call writestring                        ;Print message from edx (lettergrade1)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_studentTable					;Jump to print_studentTable unconditionally

assign_B:
	mov edx, offset lettergrade2            ;Load offset of data lettergrade2 into the edx register
	call writestring                        ;Print message from edx (lettergrade2)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_studentTable					;Jump to print_studentTable unconditionally

assign_C:
	mov edx, offset lettergrade3            ;Load offset of data lettergrade3 into the edx register
	call writestring                        ;Print message from edx (lettergrade3)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_studentTable					;Jump to print_studentTable unconditionally

assign_D:
	mov edx, offset lettergrade4            ;Load offset of data lettergrade4 into the edx register
	call writestring                        ;Print message from edx (lettergrade4)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_studentTable					;Jump to print_studentTable unconditionally

assign_F:
	mov edx, offset lettergrade5            ;Load offset of data lettergrade5 into the edx register
	call writestring                        ;Print message from edx (lettergrade5)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_studentTable					;Jump to print_studentTable unconditionally

;Printing the final result (Same process of printing during the sort)
print_Result:
	xor eax, eax                            ;Zero out eax    
	xor ebx, ebx                            ;Zero out ebx
	xor ecx, ecx                            ;Zero out ecx
	xor edx, edx                            ;Zero out edx
	xor esi, esi                            ;Zero out esi
	xor edi, edi                            ;Zero out edi
	mov edx, offset endResult               ;Load offset of data endResult into the edx register
	call writestring                        ;Print message from edx (endResult)
	call crlf                               ;New line

print_finalTable:
	cmp ebx, 10                             ;Compare value from register ebx to value 10
	je print_distribution                   ;If equal, jump to print_distribution
	mov al, [names + esi]                   ;Move data from [names + esi] (calculated memory address) into al
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location)
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je check_for_index_final                ;If equal, jump to check_for_index_final    
	mov edx, offset studentName             ;Load offset of data studentName into the edx register
	call writestring                        ;Print message from edx (studentName)
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	jmp print_finalTable                    ;Jump to print_finalTable unconditionally

check_for_index_final:                      
	cmp ecx, 0                              ;Compare value from register ecx to value 0
	jne print_final_grade                   ;If not equal, jump to print_final_grade 
	inc ecx                                 ;Increment value in ecx register by 1
	inc esi                                 ;Increment value in esi register by 1
	jmp print_finalTable                    ;Jump to print_finalTable unconditionally

print_final_grade:
	mov [studentName], ' '                  ;Print a space between studentName and grade
	mov edx, offset studentName             ;Load offset of data studentName into the edx register
	call writestring                        ;Print message from edx (studentName)
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	xor eax, eax                            ;Zero out eax
	mov al, [myData + ebx]                  ;Move data from [myData + ebx] (calculated memory address) into al
	call writedec                           ;Prints value from al
	cmp al, 90                              ;Compare value in al to value 90
	jge assign_A_1                          ;If greater than or equal, jump to assign_A_1   
	cmp al, 80                              ;Compare value in al to value 80
	jge assign_B_1                          ;If greater than or equal, jump to assign_B_1 
	cmp al, 70                              ;Compare value in al to value 70
	jge assign_C_1                          ;If greater than or equal, jump to assign_C_1 
	cmp al, 60                              ;Compare value in al to value 60
	jge assign_D_1                          ;If greater than or equal, jump assign_D_1        
	cmp al, 60                              ;Compare value in al to value 60
	jl assign_F_1                           ;If less than, jump to assign_F_1   


assign_A_1:
	mov edx, offset lettergrade1            ;Load offset of data lettergrade1 into the edx register
	call writestring                        ;Print message from edx (lettergrade1)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_finalTable					;Jump to print_studentTable unconditionally

assign_B_1:
	mov edx, offset lettergrade2            ;Load offset of data lettergrade2 into the edx register
	call writestring                        ;Print message from edx (lettergrade2)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_finalTable					;Jump to print_studentTable unconditionally

assign_C_1:
	mov edx, offset lettergrade3            ;Load offset of data lettergrade3 into the edx register
	call writestring                        ;Print message from edx (lettergrade3)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_finalTable					;Jump to print_studentTable unconditionally

assign_D_1:
	mov edx, offset lettergrade4            ;Load offset of data lettergrade4 into the edx register
	call writestring                        ;Print message from edx (lettergrade4)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_finalTable					;Jump to print_studentTable unconditionally

assign_F_1:
	mov edx, offset lettergrade5            ;Load offset of data lettergrade5 into the edx register
	call writestring                        ;Print message from edx (lettergrade5)
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_finalTable					;Jump to print_studentTable unconditionally

;Counting number of a letter grades
print_distribution:
	call crlf                               ;New line
	xor eax, eax                            ;Zero out eax
	xor ebx, ebx                            ;Zero out ebx
	xor ecx, ecx                            ;Zero out ecx
	xor edx, edx                            ;Zero out edx
	xor esi, esi                            ;Zero out esi
	xor edi, edi                            ;Zero out edi
	mov edx, offset distribution            ;Load offset of data distribution into the edx register
	call writestring                        ;Print message from edx (distribution)
	call crlf                               ;New line

count_grades:
	cmp ecx, 10                             ;Compare value from ecx register to value 10
	je print_letter_gradeArray              ;If equal, jump to print_letter_gradeArray        
	cmp [myData + ecx], 90                  ;Compare data from [myData + ecx] (calculated memory address) to value 90
	jge next_grade_A                        ;If greater than or equal, jump to next_grade_A    
	cmp [myData + ecx], 80                  ;Compare data from [myData + ecx] (calculated memory address) to value 80
	jge next_grade_B                        ;If greater than or equal, jump to next_grade_B 
	cmp [myData + ecx], 70                  ;Compare data from [myData + ecx] (calculated memory address) to value 70
	jge next_grade_C                        ;If greater than or equal, jump to next_grade_C
	cmp [myData + ecx], 60                  ;Compare data from [myData + ecx] (calculated memory address) to value 60
	jge next_grade_D                        ;If greater than or equal, jump to next_grade_D
	cmp [myData + ecx], 60                  ;Compare data from [myData + ecx] (calculated memory address) to value 60
	jl next_grade_F                         ;If less than, jump to next_grade_F 

next_grade_A:
	add gradeArray[0], 1                    ;Add value 1 to index 0 of array gradeArray
	inc ecx                                 ;Increment value in ecx register by 1
	jmp count_grades                        ;Jump to count_grades unconditionally

next_grade_B:
	add gradeArray[1], 1                    ;Add value 1 to index 1 of array gradeArray
	mov al, gradeArray[1]                   ;Move data from gradeArray[1] into al
	inc ecx                                 ;Increment value in ecx register by 1
	jmp count_grades                        ;Jump to count_grades unconditionally

next_grade_C:
	add gradeArray[2], 1                    ;Add value 1 to index 2 of array gradeArray
	inc ecx                                 ;Increment value in ecx register by 1
	jmp count_grades                        ;Jump to count_grades unconditionally

next_grade_D: 
	add gradeArray[3], 1                    ;Add value 1 to index 3 of array gradeArray
	inc ecx                                 ;Increment value in ecx register by 1
	jmp count_grades                        ;Jump to count_grades unconditionally

next_grade_F:
	add gradeArray[4], 1                    ;Add value 1 to index 4 of array gradeArray
	inc ecx                                 ;Increment value in ecx register by 1
	jmp count_grades                        ;Jump to count_grades unconditionally

;Printing number of each letter grade
print_letter_gradeArray:
	cmp ebx, 5                              ;Compare value in ebx register to value 5
	je ending_all                           ;If equal, jump to ending_all
	mov al, [gradeLetters + esi]            ;Move [gradeLetters + esi] (calculated memory location) into al 
	mov [studentName], al                   ;Move data from al to [StudentName] (memory location) 
	cmp studentName, ','                    ;Compare value in data studentName and ','(used as an index for names Array)
	je print_integer_gradeArray             ;If equal, jump to print_integer_gradeArray 
	mov edx, offset studentName             ;Load offset of data studentName into the edx register
	call writestring                        ;Print message from edx (studentName)
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	jmp print_letter_gradeArray             ;Jump to print_letter_gradeArray unconditionally

print_integer_gradeArray:
	mov [studentName], ' '                  ;Print a space between studentName and grade
	mov edx, offset studentName             ;Load offset of data studentName into the edx register
	call writestring                        ;Print message from edx (studentName)
	inc esi                                 ;Increment value in esi register by 1
	inc ecx                                 ;Increment value in ecx register by 1
	xor eax, eax                            ;Zero out eax
	mov al, [gradeArray + ebx]              ;Move data from [gradeArray + ebx] (calculated memory address) into al
	call writedec                           ;Prints value from al
	call crlf                               ;New line
	inc ebx                                 ;Increment value in ebx register by 1
	jmp print_letter_gradeArray             ;Jump to print_letter_gradeArray unconditionally

;Representing number of each letter grades based off requested format
ending_all:
	xor ecx, ecx                            ;Zero out ecx
	call crlf                               ;New line

final_form:
	cmp ecx, 5                              ;Compare value from register ecx to value 5
	je ending                               ;If equal, jump to ending
	xor eax, eax                            ;Zero out eax
	mov al, [gradeArray + ecx]              ;Move data from [gradeArray + ecx] (calculated memory address) into al
	call writedec                           ;Prints value from al
	inc ecx                                 ;Increment value in ecx register by 1
	jmp final_form                          ;Jump to final_form unconditionally

;Ending the program
ending:
	call crlf                               ;New line

    INVOKE ExitProcess, 0
main ENDP
END main