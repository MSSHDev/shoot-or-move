; Shoot or Move - Core

section .text
	global _main
	extern _printf, _strcmp, _strcpy, _getch, _exit
	
	; Import other stuff
	extern clear
	
	; Import board stuff
	extern boards
	extern board1_min_w, board1_max_w, board1_h
	extern board2_min_w, board2_max_w
	
	; Import player stuff
	extern player1_sprite, player1_x, player1_y
	extern player2_sprite, player2_x, player2_y
	extern turn, turn_counter, turn_s, draw_s
	

; Main
_main:
	; Some update stuff
	push clear
	call _printf
	add esp, 4

	push boards
	call _printf
	add esp, 4
	
	push [player1_x]
	push [player1_y]
	push player1_sprite
	call _printf
	add esp, 12
	
	push [player2_x]
	push [player2_y]
	push player2_sprite
	call _printf
	add esp, 12
	
	mov eax, [turn_counter]
	
	cmp eax, 16
	jg .exit
	
	; Get player 1's and 2's input
	mov eax, [turn]
	
	cmp eax, 0
	je .p1in
	
	jg .p2in

	jmp _main

; Exit
.exit:
	push 0
	call _exit


.p1in:
	call _getch
	
	cmp eax, 72 ; Check up arrow
	je .p1up
	
	cmp eax, 80 ; Check down arrow
	je .p1down
	
	cmp eax, 75 ; Check left arrow
	je .p1left
	
	cmp eax, 77 ; Check right arrow
	je .p1right
	
	cmp eax, 27 ; Check ESC button
	je .exit
	
	jmp _main

.p2in:
	call _getch
	
	cmp eax, 119 ; Check W key
	je .p2up
	
	cmp eax, 115 ; Check S key
	je .p2down
	
	cmp eax, 97 ; Check A key
	je .p2left
	
	cmp eax, 100 ; Check D key
	je .p2right
	
	cmp eax, 27 ; Check ESC button
	je .exit
	
	jmp _main


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
	jmp _main
.p1downdo:
	inc [turn_counter]
	inc [player1_y]
	mov [turn], 1
	jmp _main
.p1leftdo:
	inc [turn_counter]
	dec [player1_x]
	mov [turn], 1
	jmp _main
.p1rightdo:
	inc [turn_counter]
	inc [player1_x]
	mov [turn], 1
	jmp _main


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
	jmp _main
.p2downdo:
	inc [turn_counter]
	inc [player2_y]
	mov [turn], 0
	jmp _main
.p2leftdo:
	inc [turn_counter]
	dec [player2_x]
	mov [turn], 0
	jmp _main
.p2rightdo:
	inc [turn_counter]
	inc [player2_x]
	mov [turn], 0
	jmp _main


; Update
.update:
	push clear
	call _printf
	add esp, 4

	push boards
	call _printf
	add esp, 4
	
	push [player1_x]
	push [player1_y]
	push player1_sprite
	call _printf
	add esp, 12
	
	push [player2_x]
	push [player2_y]
	push player2_sprite
	call _printf
	add esp, 12
	
	jmp _main