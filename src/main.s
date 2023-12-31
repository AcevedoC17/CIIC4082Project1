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



  JSR AnimationPlayer
  JSR update



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
	; Initialize values in ZEROPAGE // MARK: ZPInit

	LDA #$00
	STA animCount
	LDA #$00
	STA animDelay
	LDA #$08
	STA satrina_x
	LDA #$01
	STA satrina_dir
	LDA #$97
	STA satrina_y
	LDA #$00
	STA satrina_y_velocity
	LDA #$01
	STA satrina_on_ground
	LDA #$01
	STA gravity
	LDA #$00
	STA currently_in_x_range
	LDA #$00
	STA ProperGroundFix
	LDA #$00
	STA LockLeft
	LDA #$00
	STA LockRight
	LDA #$00
	STA attack_render

	LDA #%00000001
  	STA pad1
	;LDA #$10

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
  CPX #$ff
  BNE load_sprites







	; write nametables
	; LOAD BIG GREEN STARS -----------------------------------------------------
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

	; ---- LOAD SMALL PINK STARS ------------------

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


	; ------- LOAD WHITE SMALL STARS ----------------------

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






; ------------------------------ LOAD FLOOR LOOP -----------------------------
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


	

; ------------------------------- LOAD BELOW GROUND ---------------------------
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

	; ------------------------------- LOAD BELOW GROUND ------------------------
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

	; ------------------------------- LOAD BELOW GROUND --------------------------
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

	; ------------------------------- LOAD BELOW GROUND --------------------------
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

	; ------------------------------- LOAD BELOW GROUND -------------------------
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

	; ------------------------------- LOAD BELOW GROUND ------------------------
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

	; ------------------------------- LOAD BELOW GROUND ------------------------
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


	; ------------------------------ LOAD STAR CLUSTER ---------------------

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$0a
	STA PPUADDR
	LDX #$1c
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$38
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$5b
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$84
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$c8
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$2e
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$ac
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$e6
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$fd
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$3a
	STA PPUADDR
	STX PPUDATA


	; ----------------- LOADD YELLOW STARS -------------

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$00
	STA PPUADDR
	LDX #$21
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$02
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$34
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$37
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$62
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$44
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$67
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$4b
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$51
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$7b
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$5f
	STA PPUADDR
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$bd
	STA PPUADDR
	STX PPUDATA

	
	



	; ------------------------------- LOAD PLATFORM ---------------------
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



;Set every 2x2 block in the attribute table to use the second palette
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

	LDA satrina_y ; Y default: #$97
	STA $0200
	LDA #$02
	STA $0201
	LDA #$01
	STA $0202 ; ATTRIBUTE TABLE, to FLIP, do $41	
	LDA satrina_x
	STA $0203 ; X Location LEFT HEAD

	LDA satrina_y; Y default #$97
	STA $0204
	LDA #$03
	STA $0205
	LDA #$01
	STA $0206 ; ATTRIBUTE TABLE, to FLIP, do $41	
	LDA satrina_x ; X
	CLC
	ADC #$08
	STA $0207 ; X Location RIGHT HEAD

	LDA satrina_y ; Y default #$9f
	STA $0208
	LDA #$12
	STA $0209
	LDA #$01
	STA $020a ; ATTRIBUTE TABLE, to FLIP, do $41	
	LDA satrina_x ; X
	STA $020b ; X Location LEFT BODY

	LDA satrina_y; Y default #$9f
	STA $020c
	LDA #$13
	STA $020d
	LDA #$01
	STA $020e ; ATTRIBUTE TABLE, to FLIP, do $41	
	LDA satrina_x ; X
	CLC
	ADC #$08 ; X
	STA $020f ; X Location RIGHT BODY

	LDA satrina_y; Y default #$a7
	STA $0210
	LDA #$24 ; LEFT FOOT RUN
	STA $0211
	LDA #$01
	STA $0212 ; ATTRIBUTE TABLE, to FLIP, do $41	
	LDA satrina_x ; X
	STA $0213; X Location LEFT LEG

	LDA satrina_y ; Y default #$a7
	STA $0214
	LDA #$23 ; RIGHT FOOT IDLE
	STA $0215
	LDA #$01
	STA $0216 ; ATTRIBUTE TABLE, to FLIP, do $41	
	LDA satrina_x ; X
	CLC
	ADC #$08 ; X
	STA $0217  ; X Location RIGHT LEG



;JSR AnimationPlayer
forever:
  JMP forever
.endproc
.proc AnimationPlayer ; This function is named improperly, should be renamed to Draw()

; TODO Jump animation, Platform collision




 
	PHP
	PHA
	TXA
	PHA
	TYA
	PHA
	

; .byte $70, $02, $01, $80 ; Satrina body (middle running sprite) 0200
; .byte $70, $03, $01, $88 0204
; .byte $78, $12, $01, $80 0208
; .byte $78, $13, $01, $88 020c
; .byte $80, $22, $01, $80 0210
; .byte $80, $23, $01, $88 0214
	; 0
; Middle running sprite
; -------------- X MOVEMENT LOGIC HERE ----------------------
	; LDA satrina_x
	; STA $0203 ; X Location LEFT HEAD

	; LDA satrina_x ; X
	; CLC
	; ADC #$08
	; STA $0207 ; X Location RIGHT HEAD

	; LDA satrina_x ; X
	; STA $020b ; X Location LEFT BODY

	; LDA satrina_x ; X
	; CLC
	; ADC #$08 ; X
	; STA $020f ; X Location RIGHT BODY

	; LDA satrina_x ; X
	; STA $0213; X Location LEFT LEG

	; LDA satrina_x ; X
	; CLC
	; ADC #$08 ; X
	; STA $0217  ; X Location RIGHT LEG

	LDA pad1
	AND #BTN_B
	BNE SetRenderAttack
	LDA #$00
	STA attack_render
	JMP YLogic
SetRenderAttack:
	LDA #$01
	STA attack_render



YLogic:
;----------------------------- y COORDINATE LOGIC ----------
	LDA satrina_y
	SEC
	SBC satrina_y_velocity
	STA $0200
	STA $0204



	CLC
	ADC #$08
	STA $0208
	STA $020c


	CLC
	ADC #$08
	STA $0210
	STA $0214
	


	; ---------------- DIRECTION FLIPPING ------------------------


	LDA satrina_dir
	CMP #$00
	BEQ flip_left
	CMP #$01
	BEQ flip_right


	flip_left: ; Gotta swap the X rendering
		LDA satrina_x ; X
		CLC
		ADC #$08 ; X
		STA $0203 ; X Location LEFT HEAD
		LDA satrina_x
		STA $0207 ; X Location RIGHT HEAD
		LDA satrina_x ; X
		CLC
		ADC #$08 ; X
		STA $020b ; X Location LEFT BODY
		LDA satrina_x
		STA $020f ; X Location RIGHT BODY
		LDA satrina_x ; X
		CLC
		ADC #$08 ; X
		STA $0213; X Location LEFT LEG
		LDA satrina_x
		STA $0217  ; X Location RIGHT LEG


		LDA #$41
		STA $0202 ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $0206 ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $020a ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $020e ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $0212 ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $0216 ; ATTRIBUTE TABLE, to FLIP, do $41
		JMP JumpRenderCheck
	
	flip_right:
		LDA satrina_x
		STA $0203 ; X Location LEFT HEAD

		LDA satrina_x ; X
		CLC
		ADC #$08
		STA $0207 ; X Location RIGHT HEAD

		LDA satrina_x ; X
		STA $020b ; X Location LEFT BODY

		LDA satrina_x ; X
		CLC
		ADC #$08 ; X
		STA $020f ; X Location RIGHT BODY

		LDA satrina_x ; X
		STA $0213; X Location LEFT LEG

		LDA satrina_x ; X
		CLC
		ADC #$08 ; X
		STA $0217  ; X Location RIGHT LEG



		LDA #$01
		STA $0202 ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $0206 ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $020a ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $020e ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $0212 ; ATTRIBUTE TABLE, to FLIP, do $41

		STA $0216 ; ATTRIBUTE TABLE, to FLIP, do $41

JumpRenderCheck:
	LDA satrina_on_ground
	CMP #$00
	BEQ RenderJump
	JMP pass

RenderJump:
	LDA #$24
	STA $0211
	LDA #$25
	STA $0215
	JMP endRender


pass:


	LDX animDelay
	cpx #$0f  ; Delay between frames
	beq executeAnim 
	INX
	STX animDelay
	jmp endRender


executeAnim:
	LDA satrina_dir
	CMP #$00
	beq flipped
	LDA #$01
	STA $0202
	STA $0206
	STA $020a
	STA $020e
	LDX #$00
	STX animDelay
	LDX animCount
	cpx #$00
	beq RunFirstStage
	cpx #$01 
	beq RunIdleStage
	cpx #$02
	beq RunFinalStage
flipped:
	LDA #$41
	STA $0202
	STA $0206
	STA $020a
	STA $020e
	LDX #$00
	STX animDelay
	LDX animCount
	cpx #$00
	beq RunFirstStage
	cpx #$01 
	beq RunIdleStage
	cpx #$02
	beq RunFinalStage


RunFirstStage:
	LDA #$24
	STA $0211
	LDA #$23
	STA $0215
	LDX #$01
	STX animCount
	JMP endRender

RunIdleStage:
	LDA #$22
	STA $0211
	LDA #$23
	STA $0215
	LDX #$02
	STX animCount
	JMP endRender
	
RunFinalStage:
	LDA #$22
	STA $0211
	LDA #$25
	STA $0215
	LDX #$00
	STX animCount
	JMP endRender
endRender:
	LDA attack_render
	CMP #$01
	BEQ renderAttack
	LDA #$47
	STA $0219
	JMP RenderReturn
	; PLA
	; TAY
	; PLA
	; TAX
	; PLA
	; PLP
	; RTS
renderAttack:
	LDA satrina_dir
	CMP #$00
	BEQ FlipAttack
	LDA satrina_y
	CLC
	ADC #$08 
	STA $0218
	LDA #$08
	STA $0219
	LDA #$01
	STA $021a
	LDA satrina_x
	CLC
	ADC #$0f
	STA $021b
	JMP RenderReturn

FlipAttack:
	LDA satrina_y
	CLC
	ADC #$08 
	STA $0218
	LDA #$08
	STA $0219
	LDA #$41
	STA $021a
	LDA satrina_x
	SEC
	SBC #$07
	STA $021b

RenderReturn:
	PLA
	TAY
	PLA
	TAX
	PLA
	PLP
	RTS
.endproc

.proc update
	PHP
	PHA
	TXA
	PHA
	TYA
	PHA

	; Will grab current controller state:
	LDA #$01
	STA CONTROLLER1
	LDA #$00
	STA CONTROLLER1
	LDA #%00000001 ; Clear last state
  	STA pad1
	get_controller_state:
		LDA CONTROLLER1
		LSR A
		ROL pad1
		BCC get_controller_state


check_controller:
	LDA pad1
	AND #BTN_RIGHT
	bne holding_right
	LDA pad1
	AND #BTN_LEFT
	BNE holding_left

JumpCheck:
	LDA satrina_on_ground
	CMP #$01
	beq RegisterJump
	JMP GroundCheck
	RegisterJump:
		LDA pad1
		AND #BTN_A
		BNE jumping_pressed
		JMP GroundCheck
	GroundCheck:
		LDA satrina_x
		CMP #$3e 
		BCS PlatformGroundCheck ; Greater or equal to #$3e
		LDA #$00 ; NOT IN RANGE OF PLATFORM, GROUND IS $97
		STA currently_in_x_range
		LDA satrina_y
		CMP #$97
		bcs	on_ground
		LDA #$00
		STA satrina_on_ground
		JMP exit

	PlatformGroundCheck:
		LDA satrina_x 
		CMP #$b3 ; Less or equal to #$bf -77
		BCC PlatformSetGround 
		BEQ PlatformSetGround
		LDA #$00 ; NOT IN RANGE OF PLATFORM, GROUND IS $97
		STA currently_in_x_range
		LDA satrina_y
		CMP #$97
		bcs on_ground
		LDA #$00
		STA satrina_on_ground
		JMP exit
		
	PlatformSetGround: ; IN RANGE OF PLATFORM, NEW GROUND IS $87
		LDA #$01
		STA currently_in_x_range
		LDA satrina_y
		CMP #$83
		beq on_ground
		bcs on_ground
		JMP exit



on_ground:
	LDA #$00
	STA satrina_y_velocity
	LDA #$01
	STA satrina_on_ground
	JMP exit

holding_right:
	LDA #$01
	STA satrina_dir
	LDA LockRight
	CMP #$00
	BEQ movement
	JMP JumpCheck

holding_left:
	LDA #$00
	STA satrina_dir
	LDA LockLeft
	CMP #$00
	BEQ movement
	JMP JumpCheck




	
jumping_pressed:
	; LDA satrina_y
	; CLC
	; SBC #$01
	; STA satrina_y
	LDA #$0f
	STA satrina_y_velocity
	LDA #$00
	STA satrina_on_ground
	JMP exit


movement:
	LDA satrina_x
	CMP #$2d ; Platform initial wall
	BEQ PlatformCheckRight
	LDA satrina_x
	CMP #$bf ; Platform final wall
	BEQ PlatformCheckLeft
	LDA satrina_x 
	CMP #$e7
	BCC not_right_edge
	LDA #$00
	STA NOTATRIGHTEDGE
	LDA $01
	STA LockRight
	LDA #$00
	STA LockLeft
	JMP move_in_direction 	 	

	not_right_edge:
		LDA #$01
		STA NOTATRIGHTEDGE
		LDA satrina_x
		CMP #$08
		BCS move_in_direction ; if satrina_x less than $10
		LDA #$01
		STA LockLeft
		LDA #$00
		STA LockRight

	move_in_direction:
		LDA satrina_dir
		CMP #$01 ; check if dir is RIGHT
		beq move_right
		DEC satrina_x
		LDA #$00
		STA LockRight ; move left
		JMP JumpCheck 

	move_right:
		LDA NOTATRIGHTEDGE
		CMP #$00
		BEQ exit
		INC satrina_x
		LDA #$00
		STA LockLeft
		JMP JumpCheck

	PlatformCheckRight:
		LDA satrina_y
		CMP #$8f
		BCC move_in_direction
		LDA #$01
		STA LockRight
		JMP move_in_direction


	PlatformCheckLeft:
		LDA satrina_y
		CMP #$8f
		BCC move_in_direction
		LDA #$01
		STA LockLeft
		JMP move_in_direction
exit:

	LDA satrina_y
	SEC
	SBC satrina_y_velocity
	STA satrina_y
	LDA satrina_on_ground
	CMP #$01
	beq GroundFixCheck
	LDA satrina_y_velocity
	SEC
	SBC gravity
	STA satrina_y_velocity

	
	LDA satrina_on_ground
	CMP #$01
	BEQ GroundFixCheck
	JMP Return
GroundFixCheck:
	LDA currently_in_x_range
	CMP #$00
	BEQ GroundFixFinalCheck
	JMP Return
GroundFixFinalCheck:
	LDA satrina_y
	CMP #$98
	BCS GroundFix
	JMP Return
GroundFix:
	LDA #$01
	STA ProperGroundFix
	LDA #$97
	STA satrina_y
	JMP Return
	


Return:
	PLA
	TAY
	PLA
	TAX
	PLA
	PLP
	RTS
.endproc



.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"
palettes:
.byte $0f, $30, $15, $2a
.byte $0f, $2a, $17, $38
.byte $0f, $0c, $07, $13
.byte $0f, $0f, $0f, $0f

.byte $0f, $30, $15, $2a
.byte $0f, $24, $11, $30
.byte $0f, $19, $09, $29
.byte $0f, $19, $09, $29

sprites:
; .byte $70, $02, $01, $80 ; Satrina body (middle running sprite)
; .byte $70, $03, $01, $88
; .byte $78, $12, $01, $80
; .byte $78, $13, $01, $88 
; .byte $80, $22, $01, $80
; .byte $80, $23, $01, $88
.segment "CHARS"
.incbin "graphics.chr"


.segment "ZEROPAGE"
animCount: .res 1 ; 1
animDelay: .res 1 ; 2
satrina_x: .res 1 ; 3
satrina_y: .res 1 ; 4
satrina_dir: .res 1 ; 5
pad1: .res 1 ; 6
gravity: .res 1 ; 7
satrina_on_ground: .res 1 ; 8 
satrina_y_velocity: .res 1 ; 9 
currently_in_x_range: .res 1 ; a
ProperGroundFix: .res 1 ; b
LockRight: .res 1 ; c
LockLeft: .res 1 ; d
attack_render: .res 1  ; e
NOTATRIGHTEDGE: .res 1 ; f
