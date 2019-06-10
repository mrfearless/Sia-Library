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
Sia_GatewayConnectPost PROC lpszNetAddress:DWORD
    ret
Sia_GatewayConnectPost ENDP

;------------------------------------------------------------------------------
; GatewayDisconnectPost uses the /gateway/disconnect/:address endpoint to 
; disconnect the gateway from a peer.
;------------------------------------------------------------------------------
Sia_GatewayDisconnectPost PROC lpszNetAddress:DWORD
    ret
Sia_GatewayDisconnectPost ENDP

;------------------------------------------------------------------------------
; GatewayGet requests the /gateway api resource
;------------------------------------------------------------------------------
Sia_GatewayGet PROC
    ret
Sia_GatewayGet ENDP

;------------------------------------------------------------------------------
; GatewayRateLimitPost uses the /gateway endpoint to change the gateway's
; bandwidth rate limit. downloadSpeed and uploadSpeed are as bytes/second.
;------------------------------------------------------------------------------
Sia_GatewayRateLimitPost PROC
    ret
Sia_GatewayRateLimitPost ENDP


