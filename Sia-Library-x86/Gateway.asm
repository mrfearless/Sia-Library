;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; GatewayConnectPost uses the /gateway/connect/:address endpoint to connect to 
; the gateway at address
;------------------------------------------------------------------------------
Sia_GatewayConnectPost PROC hSia:DWORD, lpszNetAddress:DWORD
    Invoke sia_api_gateway_connect, hSia, lpszNetAddress
    ret
Sia_GatewayConnectPost ENDP

;------------------------------------------------------------------------------
; GatewayDisconnectPost uses the /gateway/disconnect/:address endpoint to 
; disconnect the gateway from a peer.
;------------------------------------------------------------------------------
Sia_GatewayDisconnectPost PROC hSia:DWORD, lpszNetAddress:DWORD
    Invoke sia_api_gateway_disconnect, hSia, lpszNetAddress
    ret
Sia_GatewayDisconnectPost ENDP

;------------------------------------------------------------------------------
; GatewayGet requests the /gateway api resource
;------------------------------------------------------------------------------
Sia_GatewayGet PROC hSia:DWORD, lpGatewayGet:DWORD
    Invoke sia_api_gateway, hSia, lpGatewayGet
    ret
Sia_GatewayGet ENDP

;------------------------------------------------------------------------------
; GatewayRateLimitPost uses the /gateway endpoint to change the gateway's
; bandwidth rate limit. downloadSpeed and uploadSpeed are as bytes/second.
;------------------------------------------------------------------------------
Sia_GatewayRateLimitPost PROC hSia:DWORD, dwDownloadSpeed:DWORD, dwUploadSpeed:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("downloadSpeed"), NULL, dwDownloadSpeed
    Invoke RpcSetQueryParameters, hSia, CTEXT("uploadSpeed"), NULL, dwUploadSpeed
    Invoke sia_api_gateway, hSia, NULL
    ret
Sia_GatewayRateLimitPost ENDP


