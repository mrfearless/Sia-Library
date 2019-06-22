;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; TransactionPoolFeeGet uses the /tpool/fee endpoint to get a fee estimation.
;------------------------------------------------------------------------------
Sia_TransactionPoolFeeGet PROC hSia:DWORD, lpTpoolFeeGet:DWORD
    Invoke sia_api_tpool_fee, hSia, lpTpoolFeeGet
    ret
Sia_TransactionPoolFeeGet ENDP

;------------------------------------------------------------------------------
; TransactionPoolRawPost uses the /tpool/raw endpoint to send a raw transaction to the transaction pool.
;------------------------------------------------------------------------------
Sia_TransactionPoolRawPost PROC hSia:DWORD, lpszBase64Transaction:DWORD, lpszBase64Parents:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("transaction"), lpszBase64Transaction, 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("parents"), lpszBase64Parents, 0
    Invoke sia_api_tpool_raw, hSia
    ret
Sia_TransactionPoolRawPost ENDP











