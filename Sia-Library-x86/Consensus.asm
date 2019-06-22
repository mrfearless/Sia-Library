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
Sia_ConsensusGet PROC hSia:DWORD, lpConsensusGet:DWORD
    Invoke sia_api_consensus, hSia, lpConsensusGet
    ret
Sia_ConsensusGet ENDP

;------------------------------------------------------------------------------
;  ConsensusBlocksIDGet requests the /consensus/blocks api resource
;------------------------------------------------------------------------------
Sia_ConsensusBlocksIDGet PROC hSia:DWORD, dwBlockID:DWORD, lpConsensusBlocksGet:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("id"), NULL, dwBlockID
    Invoke sia_api_consensus_blocks, hSia, lpConsensusBlocksGet
    ret
Sia_ConsensusBlocksIDGet ENDP

;------------------------------------------------------------------------------
; ConsensusBlocksHeightGet requests the /consensus/blocks api resource
;------------------------------------------------------------------------------
Sia_ConsensusBlocksHeightGet PROC hSia:DWORD, dwBlockHeight:DWORD, lpConsensusBlocksGet:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("height"), NULL, dwBlockHeight
    Invoke sia_api_consensus_blocks, hSia, lpConsensusBlocksGet
    ret
Sia_ConsensusBlocksHeightGet ENDP



