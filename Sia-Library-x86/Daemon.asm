;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; DaemonGlobalRateLimitPost uses the /daemon/settings endpoint to change the
; siad's bandwidth rate limit. downloadSpeed and uploadSpeed are interpreted
; as bytes/second.
;------------------------------------------------------------------------------
Sia_DaemonGlobalRateLimitPost PROC hSia:DWORD, dwDownloadSpeed:DWORD, dwUploadSpeed:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("downloadSpeed"), NULL, dwDownloadSpeed
    Invoke RpcSetQueryParameters, hSia, CTEXT("uploadSpeed"), NULL, dwUploadSpeed
    Invoke sia_api_daemon_settings, hSia, NULL
    ret
Sia_DaemonGlobalRateLimitPost ENDP

;------------------------------------------------------------------------------
; DaemonSettingsGet requests the /daemon/settings api resource.
;------------------------------------------------------------------------------
Sia_DaemonSettingsGet PROC hSia:DWORD, lpDaemonSettingsGet:DWORD
    Invoke sia_api_daemon_settings, hSia, lpDaemonSettingsGet
    ret
Sia_DaemonSettingsGet ENDP

;------------------------------------------------------------------------------
; DaemonStopGet stops the daemon using the /daemon/stop endpoint
;------------------------------------------------------------------------------
Sia_DaemonStopGet PROC hSia:DWORD
    Invoke sia_api_daemon_stop, hSia
    ret
Sia_DaemonStopGet ENDP

;------------------------------------------------------------------------------
; DaemonUpdateGet checks for an available daemon update.
;------------------------------------------------------------------------------
Sia_DaemonUpdateGet PROC hSia:DWORD, lpDaemonUpdateGet:DWORD
    Invoke sia_api_daemon_update, hSia, lpDaemonUpdateGet
    ret
Sia_DaemonUpdateGet ENDP

;------------------------------------------------------------------------------
; DaemonUpdatePost updates the daemon
;------------------------------------------------------------------------------
Sia_DaemonUpdatePost PROC hSia:DWORD
    Invoke sia_api_daemon_update, hSia, NULL
    ret
Sia_DaemonUpdatePost ENDP

;------------------------------------------------------------------------------
; DaemonVersionGet requests the /daemon/version resource
;------------------------------------------------------------------------------
Sia_DaemonVersionGet PROC hSia:DWORD, lpDaemonVersionGet:DWORD
    Invoke sia_api_daemon_version, hSia, lpDaemonVersionGet
    ret
Sia_DaemonVersionGet ENDP