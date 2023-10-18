.include "constants.inc"
.include "header.inc"

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.segment "STARTUP"

.proc nmi_handler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
	LDA #$00
	STA $2005
	STA $2005
  RTI
.endproc

.proc reset_handler
  SEI
  CLD
  LDX #$00
  STX PPUCTRL
  STX PPUMASK

vblankwait:
  BIT PPUSTATUS
  BPL vblankwait

	LDX #$00
	LDA #$ff
clear_oam:
	STA $0200,X ; set sprite y-positions off the screen
	INX
	INX
	INX
	INX
	BNE clear_oam

vblankwait2:
	BIT PPUSTATUS
	BPL vblankwait2

  JMP main
.endproc

.export main
.proc main
  ; write a palette
  LDX PPUSTATUS
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR
load_palettes:
  LDA palettes,X
  STA PPUDATA
  INX
  CPX #$20
  BNE load_palettes

  ; write sprite data
  LDX #$00
load_sprites:
  LDA sprites,X
  STA $0200,X
  INX
  CPX #$10
  BNE load_sprites

	; write nametables
	; big stars first
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$52
	STA PPUADDR
	LDX #$1e
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$06
	STA PPUADDR
	LDX #$1e
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$27
	STA PPUADDR
	LDX #$1e
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$17
	STA PPUADDR
	LDX #$1e
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$80
	STA PPUADDR
	LDX #$1e
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$df
	STA PPUADDR
	LDX #$1e
	STX PPUDATA

	; ---- pink stars ----

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$45
	STA PPUADDR
	LDX #$20
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$8f
	STA PPUADDR
	LDX #$20
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$6D
	STA PPUADDR
	LDX #$20
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$ed
	STA PPUADDR
	LDX #$20
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$71
	STA PPUADDR
	LDX #$20
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$b3
	STA PPUADDR
	LDX #$20
	STX PPUDATA


	; ------- white stars

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$07
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$0f
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$34
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$60
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$69
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$4e
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$57
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$7e
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$c0
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$cf
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$f2
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$d6
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$da
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$df
	STA PPUADDR
	LDX #$1f
	STX PPUDATA
; --------- first LDA is 21 ----------
	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$03
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$0b
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$35
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$1d
	STA PPUADDR
	LDX #$1f
	STX PPUDATA
	
	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$42
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$43
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$6c
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$70
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$78
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$84
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$a4
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$a9
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$95
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$bd
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$e4
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$ea
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$f0
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$f5
	STA PPUADDR
	LDX #$1f
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$d9
	STA PPUADDR
	LDX #$1f
	STX PPUDATA






; ------------------------------ LOAD FLOOR LOOP
	LDY #$c0
	LDX #$40
	load_floor:
	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$df
	bne load_floor


	

; ------------------------------- LOAD BELOW GROUND
	LDY #$e0 ; Start of row
	LDX #$41 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$22 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$ff ; End of row
	bne :-

	; ------------------------------- LOAD BELOW GROUND
	LDY #$00 ; Start of row
	LDX #$41 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$23 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$1f ; End of row
	bne :-

	; ------------------------------- LOAD BELOW GROUND
	LDY #$20 ; Start of row
	LDX #$41 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$23 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$3f ; End of row
	bne :-

	; ------------------------------- LOAD BELOW GROUND
	LDY #$40 ; Start of row
	LDX #$41 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$23 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$5f ; End of row
	bne :-

	; ------------------------------- LOAD BELOW GROUND
	LDY #$60 ; Start of row
	LDX #$41 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$23 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$7f ; End of row
	bne :-

	; ------------------------------- LOAD BELOW GROUND
	LDY #$80 ; Start of row
	LDX #$41 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$23 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$9f ; End of row
	bne :-

	; ------------------------------- LOAD BELOW GROUND
	LDY #$a0 ; Start of row
	LDX #$41 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$23 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$bf ; End of row
	bne :-

	; ------------------------------- LOAD PLATFORM
	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$88
	STA PPUADDR
	LDX #$42
	STX PPUDATA
	LDY #$89 ; Start of row
	LDX #$43 ; Tile ID
	:
	LDA PPUSTATUS
	LDA #$22 ; 2200
	STA PPUADDR
	TYA
	INY
	STA PPUADDR
	STX PPUDATA
	cpy #$97 ; End of row
	bne :-


	LDA PPUSTATUS ; ---- THis should be changed to flip horizontal the first tile
	LDA #$22
	STA PPUADDR
	LDA #$97
	STA PPUADDR
	LDX #$44
	STX PPUDATA





; Set every 2x2 block in the attribute table to use the second palette
LDY #$e8
loop_attTable:
  LDA PPUSTATUS
  LDA #$23  
  STA PPUADDR
  TYA
  STA PPUADDR
  LDA #%01010101
  STA PPUDATA
  CPY #$ef
  INY
  BNE loop_attTable

vblankwait:       ; wait for another vblank before continuing
  BIT PPUSTATUS
  BPL vblankwait

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"
palettes:
.byte $0f, $30, $15, $2a
.byte $0f, $2a, $17, $38
.byte $0f, $0c, $07, $13
.byte $0f, $19, $09, $29

.byte $0f, $30, $15, $2a
.byte $0f, $19, $09, $29
.byte $0f, $19, $09, $29
.byte $0f, $19, $09, $29

sprites:
; .byte $70, $05, $00, $80
; .byte $70, $06, $00, $88
; .byte $78, $07, $00, $80
; .byte $78, $08, $00, $88

.segment "CHARS"
.incbin "graphics.chr"