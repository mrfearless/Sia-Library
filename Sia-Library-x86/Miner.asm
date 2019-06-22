;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; MinerGet requests the /miner endpoint's resources.
;------------------------------------------------------------------------------
Sia_MinerGet PROC hSia:DWORD, lpMinerGet:DWORD
    Invoke sia_api_miner, hSia, lpMinerGet
    ret
Sia_MinerGet ENDP

;------------------------------------------------------------------------------
; MinerHeaderGet uses the /miner/header endpoint to get a header for work.
;------------------------------------------------------------------------------
Sia_MinerHeaderGet PROC hSia:DWORD, lpdwTarget:DWORD, lpdwBlockHeader:DWORD
    LOCAL BlockHeader[SIA_MINER_BLOCKHEADER_SIZE]:BYTE
    
    Invoke sia_api_miner_header, hSia, Addr BlockHeader, NULL
    .IF eax == TRUE
        lea ebx, BlockHeader
        .IF lpdwTarget != NULL
            mov eax, [ebx]
            mov ebx, lpdwTarget
            mov [ebx], eax
        .ENDIF
        .IF lpdwBlockHeader != NULL
            lea eax, BlockHeader
            mov ebx, lpdwBlockHeader
            Invoke RtlMoveMemory, ebx, eax, SIA_MINER_BLOCKHEADER_SIZE
        .ENDIF
        mov eax, TRUE
    .ENDIF
    ret
Sia_MinerHeaderGet ENDP

;------------------------------------------------------------------------------
; MinerHeaderPost uses the /miner/header endpoint to submit a solved block
; header that was previously received from the same endpoint
;------------------------------------------------------------------------------
Sia_MinerHeaderPost PROC hSia:DWORD, lpBlockHeader:DWORD
    Invoke sia_api_miner_header, hSia, NULL, lpBlockHeader
    ret
Sia_MinerHeaderPost ENDP

;------------------------------------------------------------------------------
; MinerStartGet uses the /miner/start endpoint to start the cpu miner
;------------------------------------------------------------------------------
Sia_MinerStartGet PROC hSia:DWORD
    Invoke sia_api_miner_start, hSia
    ret
Sia_MinerStartGet ENDP

;------------------------------------------------------------------------------
; MinerStopGet uses the /miner/stop endpoint to stop the cpu miner
;------------------------------------------------------------------------------
Sia_MinerStopGet PROC hSia:DWORD
    Invoke sia_api_miner_stop, hSia
    ret
Sia_MinerStopGet ENDP







