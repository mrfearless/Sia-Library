;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================
;
; SIA Client Functions - General helper functions 
;
;------------------------------------------------------------------------------
include shell32.inc
includelib shell32.lib

include masm32.inc
includelib masm32.lib

.CODE

;------------------------------------------------------------------------------
; Sia_CheckConnection
;------------------------------------------------------------------------------
Sia_CheckConnection PROC lpszHostAddress:DWORD, lpszPort:DWORD, bSecure:DWORD
    Invoke RpcCheckConnection, lpszHostAddress, lpszPort, bSecure
    ret
Sia_CheckConnection ENDP


;------------------------------------------------------------------------------
; Sia_Connect - Connect to SIA Daemon (SIAD)
;------------------------------------------------------------------------------
Sia_Connect PROC lpszHostAddress:DWORD, lpszPort:DWORD, lpdwSiaHandle:DWORD
    LOCAL bFoundSiad:DWORD
    LOCAL nProcess:DWORD
    LOCAL hProcess:DWORD
    LOCAL processID:DWORD
    LOCAL cbNeeded:DWORD
    LOCAL nProcesses:DWORD
    LOCAL aProcesses[1024]:DWORD
    LOCAL szProcessName[MAX_PATH]:BYTE
    
    IFDEF DEBUG32
    PrintText 'Sia_Connect'
    ENDIF    
    
    .IF lpszHostAddress == NULL
        Invoke lstrcpyn, Addr SIAD_ADDRESS, Addr SIAD_ADDRESS_DEFAULT, SIZEOF SIAD_ADDRESS
    .ELSE
        Invoke lstrcpyn, Addr SIAD_ADDRESS, lpszHostAddress, SIZEOF SIAD_ADDRESS
    .ENDIF
    
    .IF lpszPort == NULL
        Invoke lstrcpyn, Addr SIAD_PORT, Addr SIAD_PORT_DEFAULT, SIZEOF SIAD_PORT
    .ELSE
        Invoke lstrcpyn, Addr SIAD_PORT, lpszPort, SIZEOF SIAD_PORT
    .ENDIF
    
    Invoke lstrcpy, Addr SIAD_ADDRESSPORT, Addr SIAD_ADDRESS
    Invoke lstrcat, Addr SIAD_ADDRESSPORT, CTEXT(":")
    Invoke lstrcat, Addr SIAD_ADDRESSPORT, Addr SIAD_PORT

    mov bFoundSiad, FALSE
    Invoke EnumProcesses, Addr aProcesses, SIZEOF aProcesses, Addr cbNeeded
    
    mov eax, cbNeeded
    shr eax, 2 ; cbNeeded / SIZEOF DWORD
    mov nProcesses, eax

    mov nProcess, 0
    mov eax, 0
    .WHILE eax < nProcesses
        
        lea ebx, aProcesses
        mov eax, nProcess
        lea eax,[ebx+eax*4]
        mov eax, [eax]
        mov processID, eax
        
        Invoke OpenProcess,PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, FALSE, processID
        mov hProcess, eax
        Invoke GetProcessImageFileName, hProcess, Addr szProcessName, SIZEOF szProcessName
        
        Invoke InString, 1, Addr szProcessName, CTEXT("siad.exe")
        .IF eax > 0
            mov bFoundSiad, TRUE
        .ENDIF
        
        inc nProcess
        mov eax, nProcess
    .ENDW
    
    .IF bFoundSiad == FALSE
        xor eax, eax
        ret
    .ENDIF
    
    Invoke RpcConnect, Addr SIAD_ADDRESS, Addr SIAD_PORT, FALSE, Addr SIA_AGENT, Addr lpdwSiaHandle
    ret
Sia_Connect ENDP

;------------------------------------------------------------------------------
; Sia_Disconnect - Disconnect from SIA Daemon (SIAD)
;------------------------------------------------------------------------------
Sia_Disconnect PROC hSia:DWORD
    Invoke RpcDisconnect, hSia
    ret
Sia_Disconnect ENDP

;------------------------------------------------------------------------------
; Sia_Auth - Prepare Header with Basic Auth for POST calls to SIA API URLs
;------------------------------------------------------------------------------
Sia_Auth PROC hSia:DWORD, lpszApiPassword:DWORD
    .IF lpszApiPassword == NULL
        Invoke Sia_FindApiPassword
        Invoke RpcSetAuthBasic, hSia, NULL, Addr SIA_API_PASSWORD
    .ELSE
        Invoke RpcSetAuthBasic, hSia, NULL, lpszApiPassword
    .ENDIF
    ret
Sia_Auth ENDP

;------------------------------------------------------------------------------
; Sia_Constants - Get and store SIA constants in a SIACONSTANTS structure
;------------------------------------------------------------------------------
Sia_Constants PROC USES EBX EDX hSia:DWORD, lpStructSiaConstants:DWORD
    LOCAL hJSON:DWORD
    
    .IF lpStructSiaConstants == NULL
        xor eax, eax
        ret
    .ENDIF    
    
    mov hJSON, NULL
    
    Invoke sia_api_daemon_constants, hSia, Addr hJSON
    .IF eax == FALSE
        xor eax, eax
        ret
    .ENDIF
    
    ; Get json data and store in lpStructSiaConstants (SIACONSTANTS)
    Invoke RtlZeroMemory, lpStructSiaConstants, SIZEOF SIACONSTANTS
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("blockfrequency")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.blockfrequency, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("blocksizelimit")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.blocksizelimit, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("extremefuturethreshold")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.extremefuturethreshold, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("futurethreshold")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.futurethreshold, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("genesistimestamp")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.genesistimestamp, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("maturitydelay")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.maturitydelay, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("mediantimestampwindow")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.mediantimestampwindow, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("siafundcount")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            lea edx, [edx].SIACONSTANTS.siafundcount
            Invoke lstrcpyn, edx, eax, SIZEOF SIACONSTANTS.siafundcount
        .ENDIF        
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("siafundportion")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            lea edx, [edx].SIACONSTANTS.siafundportion
            Invoke lstrcpyn, edx, eax, SIZEOF SIACONSTANTS.siafundportion
        .ENDIF    
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("targetwindow")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.targetwindow, eax
    .ENDIF

    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("initialcoinbase")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.initialcoinbase, eax
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("minimumcoinbase")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valueint
        mov [edx].SIACONSTANTS.minimumcoinbase, eax
    .ENDIF

    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("roottarget")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            lea edx, [edx].SIACONSTANTS.roottarget
            Invoke lstrcpyn, edx, eax, SIZEOF SIACONSTANTS.roottarget
        .ENDIF    
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("rootdepth")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            lea edx, [edx].SIACONSTANTS.rootdepth
            Invoke lstrcpyn, edx, eax, SIZEOF SIACONSTANTS.rootdepth
        .ENDIF  
    .ENDIF

    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("maxtargetadjustmentup")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            lea edx, [edx].SIACONSTANTS.maxtargetadjustmentup
            Invoke lstrcpyn, edx, eax, SIZEOF SIACONSTANTS.maxtargetadjustmentup
        .ENDIF  
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("maxtargetadjustmentdown")
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            lea edx, [edx].SIACONSTANTS.maxtargetadjustmentdown
            Invoke lstrcpyn, edx, eax, SIZEOF SIACONSTANTS.maxtargetadjustmentdown
        .ENDIF  
    .ENDIF

    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("siacoinprecision") 
    .IF eax != NULL
        mov edx, lpStructSiaConstants
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            lea edx, [edx].SIACONSTANTS.siacoinprecision
            Invoke lstrcpyn, edx, eax, SIZEOF SIACONSTANTS.siacoinprecision
        .ENDIF  
    .ENDIF
    
    Invoke cJSON_Delete, hJSON
    mov eax, TRUE
    ret
Sia_Constants ENDP

;------------------------------------------------------------------------------
; Sia_Version - Get SIA Daemon version
;------------------------------------------------------------------------------
Sia_Version PROC USES EBX hSia:DWORD, lpszSiadVersion:DWORD
    LOCAL hJSON:DWORD
    
    .IF lpszSiadVersion == NULL
        xor eax, eax
        ret
    .ENDIF    
    
    mov hJSON, NULL
    Invoke sia_api_daemon_version, hSia, Addr hJSON
    .IF eax == FALSE
        xor eax, eax
        ret
    .ENDIF
    
    Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("version")
    .IF eax != NULL
        mov ebx, eax
        mov eax, [ebx].cJSON.valuestring
        .IF eax != NULL
            Invoke lstrcpy, lpszSiadVersion, eax
        .ENDIF  
    .ENDIF    
    
    Invoke cJSON_Delete, hJSON
    mov eax, TRUE
    ret
Sia_Version ENDP

;------------------------------------------------------------------------------
; Sia_DefaultSiaDir - Returns the default data directory of siad 
; %LOCALAPPDATA%\Sia
;------------------------------------------------------------------------------
Sia_DefaultSiaDir PROC lpszSiaDefaultDir:DWORD
    LOCAL szLocalAppData[MAX_PATH]:BYTE
    
    .IF lpszSiaDefaultDir == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke SHGetFolderPath, 0, CSIDL_LOCAL_APPDATA, 0, 0, Addr szLocalAppData
    .IF eax != S_OK ; 0
        xor eax, eax
        ret
    .ENDIF
    
    Invoke lstrcpyn, lpszSiaDefaultDir, Addr szLocalAppData, MAX_PATH 
    Invoke lstrcat, lpszSiaDefaultDir, CTEXT("\Sia")
    
    mov eax, TRUE
    ret
Sia_DefaultSiaDir ENDP

;------------------------------------------------------------------------------
; Sia_PasswordFile - Returns the filepath to the API's password file
;------------------------------------------------------------------------------
Sia_PasswordFile PROC lpszSiaPasswordFilepath:DWORD
    LOCAL szSiaDefaultDir[MAX_PATH]:BYTE
    
    .IF lpszSiaPasswordFilepath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_DefaultSiaDir, Addr szSiaDefaultDir
    .IF eax == FALSE
        ret
    .ENDIF
    
    Invoke lstrcpyn, lpszSiaPasswordFilepath, Addr szSiaDefaultDir, MAX_PATH
    Invoke lstrcat, lpszSiaPasswordFilepath, CTEXT("\apipassword")
    
    mov eax, TRUE
    ret
Sia_PasswordFile ENDP

;------------------------------------------------------------------------------
; Sia_FindApiPassword - 
;------------------------------------------------------------------------------
Sia_FindApiPassword PROC
    LOCAL hSiaPasswordFile:DWORD
    LOCAL dwNumberBytesRead:DWORD
    LOCAL szSiaPasswordFile[MAX_PATH]:BYTE
    
    Invoke GetEnvironmentVariable, CTEXT("SIA_API_PASSWORD"), Addr SIA_API_PASSWORD, SIZEOF SIA_API_PASSWORD
    .IF eax > 0 ; Success
        ret
    .ELSEIF eax == SIZEOF SIA_API_PASSWORD ; fail, return size was same size as buffer (buffer too small)
        xor eax, eax 
        ret
    .ENDIF
    
    ; TODO - Get command line, check for -apipassword /apipassword ? 
    
    Invoke Sia_PasswordFile, Addr szSiaPasswordFile
    .IF eax == FALSE
        ret
    .ENDIF
    
    Invoke CreateFile, Addr szSiaPasswordFile, GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    .IF eax == INVALID_HANDLE_VALUE
        xor eax, eax
        ret
    .ENDIF
    mov hSiaPasswordFile, eax
    
    Invoke ReadFile, hSiaPasswordFile, Addr SIA_API_PASSWORD, SIZEOF SIA_API_PASSWORD, Addr dwNumberBytesRead, NULL
    .IF eax == 0
        Invoke CloseHandle, hSiaPasswordFile
        xor eax, eax
        ret
    .ENDIF
    
    Invoke CloseHandle, hSiaPasswordFile
    mov eax, TRUE
    ret
Sia_FindApiPassword ENDP

;------------------------------------------------------------------------------
; Sia_FreeJson - 
;------------------------------------------------------------------------------
Sia_FreeJson PROC hJSON:DWORD
    .IF hJSON != NULL
        Invoke cJSON_Delete, hJSON
    .ENDIF
    ret
Sia_FreeJson ENDP


















