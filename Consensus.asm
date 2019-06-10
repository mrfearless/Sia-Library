;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; ConsensusGet requests the /consensus api resource
;------------------------------------------------------------------------------
Sia_ConsensusGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_consensus, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF
    ret
Sia_ConsensusGet ENDP

;------------------------------------------------------------------------------
;  ConsensusBlocksIDGet requests the /consensus/blocks api resource
;------------------------------------------------------------------------------
Sia_ConsensusBlocksIDGet PROC dwBlockID:DWORD
    LOCAL hJSON:DWORD
    LOCAL szQuery[64]:BYTE
    
    Invoke NetUrlValues, Addr szQuery, CTEXT("id="), NULL, dwBlockID
    Invoke sia_api_consensus_blocks, Addr hJSON, Addr szQuery
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_ConsensusBlocksIDGet ENDP

;------------------------------------------------------------------------------
; ConsensusBlocksHeightGet requests the /consensus/blocks api resource
;------------------------------------------------------------------------------
Sia_ConsensusBlocksHeightGet PROC dwBlockHeight:DWORD
    LOCAL hJSON:DWORD
    LOCAL szQuery[64]:BYTE
    
    Invoke NetUrlValues, Addr szQuery, CTEXT("height="), NULL, dwBlockHeight
    Invoke sia_api_consensus_blocks, Addr hJSON, Addr szQuery
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF   
    ret
Sia_ConsensusBlocksHeightGet ENDP