; Shoot or Move - Core

section .text
	global main
	extern printf, strcmp, getch, exit, usleep
	
	; Import other stuff
	extern clear
	
	; Import board stuff
	extern boards
	extern board1_min_w, board1_max_w, board1_h
	extern board2_min_w, board2_max_w
	
	; Import player stuff
	extern player1_sprite, player1_x, player1_y, player1_atk_x, player1_atk_y, p1atk_s
	extern player2_sprite, player2_x, player2_y, player2_atk_x, player2_atk_y, p2atk_s
	extern turn, turn_counter, turns_s, draw_s
	
	extern win1, win2
	

; Main
main:
	; Some update stuff
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player1_x]
	push [player1_y]
	push player1_sprite
	call printf
	add esp, 12
	
	push [player2_x]
	push [player2_y]
	push player2_sprite
	call printf
	add esp, 12
	
	jmp .main_no_update

.main_no_update:
	push [turn]
	push turns_s
	call printf
	add esp, 8

	mov eax, [turn_counter]
	
	cmp eax, 16
	jge .exit
	
	; Get player 1's and 2's input
	mov eax, [turn]
	
	cmp eax, 0
	je .p1in
	
	jg .p2in

; Exit
.exit:
	push 0
	call exit


.p1in:
	call getch
	
	cmp eax, 72 ; Check up arrow
	je .p1up
	
	cmp eax, 80 ; Check down arrow
	je .p1down
	
	cmp eax, 75 ; Check left arrow
	je .p1left
	
	cmp eax, 77 ; Check right arrow
	je .p1right
	
	cmp eax, 97 ; Check A button
	je .p1atk
	
	cmp eax, 27 ; Check ESC button
	je .exit
	
	jmp .main_no_update

.p2in:
	call getch
	
	cmp eax, 119 ; Check W key
	je .p2up
	
	cmp eax, 115 ; Check S key
	je .p2down
	
	cmp eax, 97 ; Check A key
	je .p2left
	
	cmp eax, 100 ; Check D key
	je .p2right
	
	cmp eax, 13 ; Check Enter button
	je .p2atk
	
	cmp eax, 27 ; Check ESC button
	je .exit
	
	jmp main


; Player 1 support movement
.p1up:
	cmp [player1_y], 0
	jg .p1updo
	jl .p1downdo

.p1down:
	mov eax, [board1_h]
	cmp [player1_y], eax
	jl .p1downdo
	jg .p1updo

.p1left:
	mov eax, [board1_min_w]
	cmp [player1_x], eax
	jg .p1leftdo
	jl .p1rightdo

.p1right:
	mov eax, [board1_max_w]
	cmp [player1_x], eax
	jl .p1rightdo
	jg .p1leftdo


.p1updo:
	inc [turn_counter]
	dec [player1_y]
	mov [turn], 1
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp .p2in
.p1downdo:
	inc [turn_counter]
	inc [player1_y]
	mov [turn], 1
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp .p2in
.p1leftdo:
	inc [turn_counter]
	dec [player1_x]
	mov [turn], 1
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp .p2in
.p1rightdo:
	inc [turn_counter]
	inc [player1_x]
	mov [turn], 1
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp .p2in


.p1atk:
	push [player1_atk_x]
	push [player1_atk_y]
	push p1atk_s
	call printf
	add esp, 12
	
	call getch
	
	cmp eax, 72 ; Check up arrow
	je .p1atkup
	
	cmp eax, 80 ; Check down arrow
	je .p1atkdown
	
	cmp eax, 75 ; Check left arrow
	je .p1atkleft
	
	cmp eax, 77 ; Check right arrow
	je .p1atkright
	
	cmp eax, 13
	je .chkp1atk
	
	jmp .p1atk

.p1atkup:
	dec [player1_atk_y]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player1_atk_x]
	push [player1_atk_y]
	push p1atk_s
	call printf
	add esp, 12
	
	jmp .p1atk

.p1atkdown:
	inc [player1_atk_y]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player1_atk_x]
	push [player1_atk_y]
	push p1atk_s
	call printf
	add esp, 12
	
	jmp .p1atk

.p1atkleft:
	dec [player1_atk_x]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player1_atk_x]
	push [player1_atk_y]
	push p1atk_s
	call printf
	add esp, 12
	
	jmp .p1atk

.p1atkright:
	inc [player1_atk_x]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player1_atk_x]
	push [player1_atk_y]
	push p1atk_s
	call printf
	add esp, 12
	
	jmp .p1atk

.chkp1atk:
	mov [turn], 1

	mov eax, [player2_x]
	mov ebx, [player2_y]
	
	mov ecx, [player1_atk_x]
	mov edx, [player1_atk_y]
	
	cmp eax, ecx
	jne .main_no_update
	
	cmp ebx, edx
	jne .main_no_update
	
	je .win2
	

; Player 2 support movement
.p2up:
	cmp [player2_y], 1
	jg .p2updo
	jl .p2downdo

.p2down:
	mov eax, [board1_h]
	cmp [player2_y], eax
	jl .p2downdo
	jg .p2updo

.p2left:
	mov eax, [board2_min_w]
	cmp [player2_x], eax
	jg .p2leftdo
	jl .p2rightdo

.p2right:
	mov eax, [board2_max_w]
	cmp [player2_x], eax
	jl .p2rightdo
	jg .p2leftdo


.p2updo:
	inc [turn_counter]
	dec [player2_y]
	mov [turn], 0
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp main
.p2downdo:
	inc [turn_counter]
	inc [player2_y]
	mov [turn], 0
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp main
.p2leftdo:
	inc [turn_counter]
	dec [player2_x]
	mov [turn], 0
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp main
.p2rightdo:
	inc [turn_counter]
	inc [player2_x]
	mov [turn], 0
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	jmp main

.p2atk:
	push [player2_atk_x]
	push [player2_atk_y]
	push p2atk_s
	call printf
	add esp, 12
	
	call getch
	
	cmp eax, 72 ; Check up arrow
	je .p2atkup
	
	cmp eax, 80 ; Check down arrow
	je .p2atkdown
	
	cmp eax, 75 ; Check left arrow
	je .p2atkleft
	
	cmp eax, 77 ; Check right arrow
	je .p2atkright
	
	cmp eax, 13
	je .chkp2atk
	
	jmp .p2atk

.p2atkup:
	dec [player2_atk_y]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player2_atk_x]
	push [player2_atk_y]
	push p2atk_s
	call printf
	add esp, 12
	
	jmp .p2atk

.p2atkdown:
	inc [player2_atk_y]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player2_atk_x]
	push [player2_atk_y]
	push p2atk_s
	call printf
	add esp, 12
	
	jmp .p2atk

.p2atkleft:
	dec [player2_atk_x]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player2_atk_x]
	push [player2_atk_y]
	push p2atk_s
	call printf
	add esp, 12
	
	jmp .p2atk

.p2atkright:
	inc [player2_atk_x]
	
	push clear
	call printf
	add esp, 4

	push boards
	call printf
	add esp, 4
	
	push [turn]
	push turns_s
	call printf
	add esp, 8
	
	push [player2_atk_x]
	push [player2_atk_y]
	push p2atk_s
	call printf
	add esp, 12
	
	jmp .p2atk

.chkp2atk:
	mov [turn], 0

	mov eax, [player1_x]
	mov ebx, [player1_y]
	
	mov ecx, [player2_atk_x]
	mov edx, [player2_atk_y]
	
	cmp eax, ecx
	jne main
	
	cmp ebx, edx
	jne main
	
	je .win2


; Win conditions
.win1:
	push win1
	call printf
	add esp, 4
	
	push 2000
	call usleep
	
	push 0
	call exit


.win2:
	push win2
	call printf
	add esp, 4
	
	push 2000
	call usleep
	
	push 0
	call exit