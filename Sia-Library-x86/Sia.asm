;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================
;
;  Hierarchy of functions
;
;  --------------------------------------
;  | Functions: Sia_*                   |
;  | Purpose: Calls sia_api_* functions |
;  | Files: Client.asm                  |
;  |        Consensus.asm               |
;  |        Daemon.asm                  |
;  |        Gateway.asm                 |
;  |        Host.asm                    |
;  |        Hostdb.asm                  |
;  |        Miner.asm                   |
;  |        Renter.asm                  |
;  |        Transactionpool.asm         |
;  |        Wallet.asm                  |
;  --------------------------------------
;                    |
;                    V
;  --------------------------------------
;  | Functions: sia_api_*               |
;  | Purpose: Calls SIA_RPC_* functions |
;  | Files: Api.asm                     |
;  --------------------------------------
;                    |
;                    V
;  --------------------------------------
;  | Functions: SIA_RPC_*               |
;  | Purpose: Calls Rpc* functions      |
;  | Files: Api.asm                     |
;  --------------------------------------
;                    |
;                    V
;  --------------------------------------
;  | Functions: Rpc*                    |
;  | Purpose: Calls WinInet functions   |
;  | Files: Rpc.lib                     |
;  --------------------------------------
;
;
;------------------------------------------------------------------------------
.686
.MMX
.XMM
.model flat,stdcall
option casemap:none
include \masm32\macros\macros.asm

;------------------------------------------------------------------------------
; Debugging - comment or remove comments to disable/enable
;------------------------------------------------------------------------------

;DEBUG32 EQU 1
;IFDEF DEBUG32
;    PRESERVEXMMREGS equ 1
;    includelib M:\Masm32\lib\Debug32.lib
;    DBG32LIB equ 1
;    DEBUGEXE textequ <'M:\Masm32\DbgWin.exe'>
;    include M:\Masm32\include\debug32.inc
;ENDIF


;------------------------------------------------------------------------------
; Main includes and libraries
;------------------------------------------------------------------------------
Include windows.inc

Include user32.inc
Includelib user32.lib

Include kernel32.inc
Includelib kernel32.lib

;Include libcjson.inc
;Includelib libcjson.lib

Include cjson_x86.inc
Includelib cjson_x86.lib

Include psapi.inc
Includelib psapi.lib

include RPC.inc
includelib RPC.lib

Include Sia.inc                 ; Main Sia include file

.CONST
SIA_MINER_BLOCKHEADER_SIZE      EQU 112d


;------------------------------------------------------------------------------
; Data Section
;------------------------------------------------------------------------------
.DATA
; Sia Defaults
SIA_AGENT                       DB DEF_SIA_AGENT,0
SIAD_ADDRESS_DEFAULT            DB DEF_SIAD_ADDRESS_DEFAULT,0
SIAD_PORT_DEFAULT               DB DEF_SIAD_PORT_DEFAULT,0

; Sia Buffers
SIAD_ADDRESS                    DB 32 DUP (0)
SIAD_PORT                       DB 8 DUP (0)
SIAD_ADDRESSPORT                DB 48 DUP (0)
SIAD_FILEPATH                   DB MAX_PATH DUP (0) 
SIA_API_PASSWORD                DB 128 DUP (0)



;------------------------------------------------------------------------------
; Code section - Wrap all other source files
;------------------------------------------------------------------------------
.CODE


Include Api.asm                 ; Sia low level api functions that call to SIAD url endpoints: SIA_RPC_* and sia_api_*

Include Client.asm              ; Sia general functions
Include Consensus.asm           ; Sia consensus functions
Include Daemon.asm              ; Sia daemon functions
Include Gateway.asm             ; Sia gateway functions
Include Host.asm                ; Sia host functions
Include Hostdb.asm              ; Sia hostdb functions
Include Miner.asm               ; Sia Miner functions
Include Renter.asm              ; Sia renter functions
Include Transactionpool.asm     ; Sia transaction pool functions
Include Wallet.asm              ; Sia wallet functions

END

