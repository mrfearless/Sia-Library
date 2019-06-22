;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; HostDbGet requests the /hostdb endpoint's resources.
;------------------------------------------------------------------------------
Sia_HostDbGet PROC hSia:DWORD, lpHostdbGet:DWORD
    Invoke sia_api_hostdb, hSia, lpHostdbGet
    ret
Sia_HostDbGet ENDP

;------------------------------------------------------------------------------
; HostDbActiveGet requests the /hostdb/active endpoint's resources.
;------------------------------------------------------------------------------
Sia_HostDbActiveGet PROC hSia:DWORD, lpHostdbActiveGet:DWORD
    Invoke sia_api_hostdb_active, hSia, lpHostdbActiveGet
    ret
Sia_HostDbActiveGet ENDP

;------------------------------------------------------------------------------
; HostDbAllGet requests the /hostdb/all endpoint's resources.
;------------------------------------------------------------------------------
Sia_HostDbAllGet PROC hSia:DWORD, lpHostdbAllGet:DWORD
    Invoke sia_api_hostdb_all, hSia, lpHostdbAllGet
    ret
Sia_HostDbAllGet ENDP

;------------------------------------------------------------------------------
; HostDbFilterModeGet requests the /hostdb/filtermode GET endpoint
;------------------------------------------------------------------------------
Sia_HostDbFilterModeGet PROC hSia:DWORD, lpHostdbFilterModeGet:DWORD
    Invoke sia_api_hostdb_filtermode, hSia, lpHostdbFilterModeGet, NULL
    ret
Sia_HostDbFilterModeGet ENDP

;------------------------------------------------------------------------------
; HostDbFilterModePost requests the /hostdb/filtermode POST endpoint
;------------------------------------------------------------------------------
Sia_HostDbFilterModePost PROC hSia:DWORD, FilterMode:DWORD, lpHosts:DWORD
    LOCAL lpszJsonText:DWORD
    ; todo contstruct lpszJsonText
    Invoke sia_api_hostdb_filtermode, hSia, NULL, lpszJsonText
    ret
Sia_HostDbFilterModePost ENDP

;------------------------------------------------------------------------------
; HostDbHostsGet request the /hostdb/hosts/:pubkey endpoint's resources.
;------------------------------------------------------------------------------
Sia_HostDbHostsGet PROC hSia:DWORD, lpszPublicKey:DWORD, lpHostdbHostsGet:DWORD
    Invoke sia_api_hostdb_hosts, hSia, lpHostdbHostsGet, lpszPublicKey
    ret
Sia_HostDbHostsGet ENDP











