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
.byte $70, $05, $00, $80
.byte $70, $06, $00, $88
.byte $78, $07, $00, $80
.byte $78, $08, $00, $88

.segment "CHARS"
.incbin "graphics.chr"
