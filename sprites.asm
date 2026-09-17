; Shoot or Move - Sprites

section .data
	global clear

	global boards
	global board1_min_w
    global board1_max_w
	
	global board1_h
	global board2_min_w
    global board2_max_w
	
	global player1_sprite
	global player1_x
	global player1_y
	
	global player2_sprite
	global player2_x
	global player2_y
	
	global turn
	global turn_counter
	
	
	; Clear
	clear db 0x1B, "[2J", 0x1B, "[H", 0

	; Board
	boards db "......      ......", 0xA
	       db "......      ......", 0xA
		   db "......      ......", 0xA
		   db "......      ......", 0xA, 0
	
	board1_min_w dd 1
	board1_max_w dd 6
	board1_h dd 4
	
	board2_min_w dd 13
	board2_max_w dd 18
	board2_h dd 4
	
	; Player
	player1_sprite db 0x1B, "[%d;%dH", 0x1B, "[31mP", 0x1B, "[0m", 0
	player1_x dd 3
	player1_y dd 2
	
	
	player2_sprite db 0x1B, "[%d;%dH", 0x1B, "[32mP", 0x1B, "[0m", 0
	player2_x dd 15
	player2_y dd 2
	
	turn_s db 0x1B, "[6;1H%s's turn", 0
	draw_s db "Draw!", 0
	
	turn dd 0
	
	
	
	turn_counter dd 0