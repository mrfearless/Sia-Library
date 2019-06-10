;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
Sia_DaemonGlobalRateLimitPost PROC dwDownloadSpeed:DWORD, dwUploadSpeed:DWORD
    
    ret
Sia_DaemonGlobalRateLimitPost ENDP

;------------------------------------------------------------------------------
; DaemonVersionGet requests the /daemon/version resource
;------------------------------------------------------------------------------
Sia_DaemonVersionGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_daemon_version, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF
    ret
Sia_DaemonVersionGet ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
Sia_DaemonSettingsGet PROC
    
    ret
Sia_DaemonSettingsGet ENDP

;------------------------------------------------------------------------------
; DaemonStopGet stops the daemon using the /daemon/stop endpoint
;------------------------------------------------------------------------------
Sia_DaemonStopGet PROC
    Invoke sia_api_daemon_stop
    ret
Sia_DaemonStopGet ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
Sia_DaemonUpdateGet PROC
    
    ret
Sia_DaemonUpdateGet ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
Sia_DaemonUpdatePost PROC
    
    ret
Sia_DaemonUpdatePost ENDP
