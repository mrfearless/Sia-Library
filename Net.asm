;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================
;
; Wininet Network Functions
;
;------------------------------------------------------------------------------
include wininet.inc
includelib wininet.lib
include masm32.inc
includelib masm32.lib

NetConnect                      PROTO :DWORD, :DWORD, :DWORD, :DWORD
NetDisconnect                   PROTO
NetBasicAuth                    PROTO :DWORD, :DWORD

NetOpenUrl                      PROTO :DWORD, :DWORD, :DWORD, :DWORD
NetPostUrl                      PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
NetCloseUrl                     PROTO :DWORD

NetReadUrlData                  PROTO :DWORD, :DWORD, :DWORD
NetFreeUrlData                  PROTO :DWORD

NetGetRemoteFileSize            PROTO :DWORD, :DWORD
NetBase64Encode                 PROTO :DWORD, :DWORD, :DWORD
NetUrlValues                    PROTO :DWORD, :DWORD, :DWORD, :DWORD

IFDEF SIA_API_JSON_TO_LOCALFILE
NetWriteDataToLocalFile         PROTO :DWORD, :DWORD, :DWORD
ENDIF

atou_ex                         PROTO :DWORD
utoa_ex                         PROTO :DWORD, :DWORD 



.CONST
TIMER_INFINITE                  EQU 0FFFFFFFEh
FLAG_ICC_FORCE_CONNECTION       EQU 00000001h 
HTTP_QUERY_FLAG_NUMBER          EQU 20000000h
HTTP_QUERY_CONTENT_LENGTH       EQU 5
ERROR_WINHTTP_CANNOT_CONNECT    EQU 12029d ; Returned if connection to the server failed.
DEFAULT_PORT                    EQU 80d

NET_DOWNLOAD_BUFFER_SIZE        EQU 4096d
NET_DOWNLOAD_BUFFER_SIZE_EX     EQU 4096d
NET_BUFFER_SIZE                 EQU 4096d


.DATA
Base64Alphabet                  DB "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",0
TimeoutPeriod                   DD 1200d
RetryInterval                   DD 30000d ; secs
szAuthBasicHeader               DB "Authorization: Basic ",0
szAcceptPostAuth                DB "application/x-www-form-urlencoded",0
ppszAcceptPost                  DD offset szAcceptPostAuth,0
szAcceptJson                    DB "application/json",0,0
szAccept                        DB "*/*",0,0
ppszAccept                      DD offset szAcceptJson,0
szGetVerb                       DB "GET",0
szPostVerb                      DB "POST",0
szHttp                          DB "http://",0
szHttps                         DB "https://",0
szDash                          DB "-",0
szDot                           DB ".",0
szDefaultPort                   DB "80",0

hConnect                        DD 0
hInternet                       DD 0
hUrl                            DD 0

bNetExitFromThread              DD FALSE

AUTH_BASIC_HEADER               DB 256 DUP (0)


.CODE

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------
NetConnect PROC lpszHostAddress:DWORD, lpszPort:DWORD, dwSecure:DWORD, lpszDownloadAgent:DWORD
    LOCAL dwPort:DWORD
    
    IFDEF DEBUG32
    PrintText 'NetConnect'
    ENDIF
    
    Invoke NetDisconnect
    
    .IF lpszHostAddress == NULL
        mov eax, FALSE
        ret
    .ENDIF

    Invoke InternetOpen, lpszDownloadAgent, INTERNET_OPEN_TYPE_DIRECT, NULL, NULL, 0 ;INTERNET_FLAG_NO_COOKIES + INTERNET_FLAG_NO_UI + INTERNET_FLAG_PRAGMA_NOCACHE
    .IF eax == NULL
        IFDEF DEBUG32
            PrintText 'InternetOpen Error'
        ENDIF
        mov eax, FALSE
        ret
    .ENDIF
    mov hInternet, eax
    
    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF
    
    Invoke InternetSetOption, hInternet, INTERNET_OPTION_RECEIVE_TIMEOUT, Addr TimeoutPeriod, SIZEOF TimeoutPeriod

    .IF dwSecure == TRUE
        mov dwPort, 443d
    .ELSE    
        .IF lpszPort == 0
            mov dwPort, DEFAULT_PORT
        .ELSE    
            Invoke atou_ex, lpszPort
            mov dwPort, eax
        .ENDIF
    .ENDIF

    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF
    
    mov eax, lpszHostAddress
    ;DbgDump eax, 8
    ;PrintDec dwPort
    Invoke InternetConnect, hInternet, lpszHostAddress, dwPort, 0, 0, INTERNET_SERVICE_HTTP, 0, 0
    .IF eax == NULL
        IFDEF DEBUG32
            PrintText 'InternetConnect Error'
        ENDIF    
        .IF hInternet != NULL
            Invoke InternetCloseHandle, hInternet
        .ENDIF
        mov hInternet, NULL
        mov eax, FALSE
        ret
    .ENDIF
    mov hConnect, eax

    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF
    
    ;PrintDec hInternet
    ;PrintDec hConnect
    mov eax, TRUE
    ret
NetConnect ENDP

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------
NetDisconnect PROC
    IFDEF DEBUG32
    PrintText 'NetDisconnect'
    ENDIF
    .IF hConnect != NULL
        Invoke InternetCloseHandle, hConnect
    .ENDIF

    .IF hInternet != NULL
        Invoke InternetCloseHandle, hInternet
    .ENDIF
    
    mov hConnect, NULL
    mov hInternet, NULL    
    ret
NetDisconnect ENDP

;------------------------------------------------------------------------------
; NetBasicAuth - Base64 encode user/pass and add to a Auth Basic Header for use
; in NetPostUrl (POST)
;------------------------------------------------------------------------------
NetBasicAuth PROC USES EBX lpszUsername:DWORD, lpszPassword:DWORD
    LOCAL szBase64Auth[128]:BYTE
    LOCAL szPreBase64Auth[128]:BYTE

    Invoke RtlZeroMemory, Addr AUTH_BASIC_HEADER, SIZEOF AUTH_BASIC_HEADER
    
    .IF lpszPassword == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke lstrlen, lpszPassword
    .IF eax == 0
        xor eax, eax
        ret
    .ENDIF
    
    .IF lpszUsername != NULL
        Invoke lstrlen, lpszUsername
        .IF eax == 0
            Invoke lstrcpy, Addr szPreBase64Auth, CTEXT(":")
        .ELSE
            Invoke lstrcpy, Addr szPreBase64Auth, lpszUsername
        .ENDIF
    .ELSE
        Invoke lstrcpy, Addr szPreBase64Auth, CTEXT(":")
    .ENDIF
    Invoke lstrcat, Addr szPreBase64Auth, lpszPassword
    
    ; base 64 encode auth
    Invoke lstrlen, Addr szPreBase64Auth
    Invoke NetBase64Encode, Addr szPreBase64Auth, Addr szBase64Auth, eax

    ; Add header
    Invoke lstrcpy, Addr AUTH_BASIC_HEADER, Addr szAuthBasicHeader
    Invoke lstrcat, Addr AUTH_BASIC_HEADER, Addr szBase64Auth
    
    mov eax, TRUE
    ret
NetBasicAuth ENDP

;------------------------------------------------------------------------------
; NetOpenUrl - Opens a URL for reading or writing, lpszUrl is the long pointer
; to a zero terminated string containing the url to open. lpdwhOpenUrl is an 
; addessr of a buffer to store the handle to the open url if succesful. 
; Returns: TRUE if succesful and lpdwhOpenUrl will contain the handle. 
; Otherwise EAX returns FALSE and lpdwhOpenUrl will contain NULL. 
;------------------------------------------------------------------------------
NetOpenUrl PROC USES EBX lpszUrl:DWORD, lpdwhOpenUrl:DWORD, lpdwStatusCode:DWORD, dwSecure:DWORD
    LOCAL hRequest:DWORD
    LOCAL dwStatusCode:DWORD
    
    IFDEF DEBUG32
        PrintText 'NetOpenUrl'
    ENDIF

    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF
    
    .IF lpszUrl == NULL || lpdwhOpenUrl == NULL
        mov eax, FALSE
        ret
    .ENDIF
    
    mov hRequest, 0
    mov dwStatusCode, 0
    
    IFDEF DEBUG32
    PrintText 'NetOpenUrl--HttpOpenRequest'
    ENDIF
    .IF dwSecure == TRUE
        Invoke HttpOpenRequest, hConnect, Addr szGetVerb, lpszUrl, NULL, NULL, Offset ppszAccept, INTERNET_FLAG_SECURE or INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_PRAGMA_NOCACHE or INTERNET_FLAG_RELOAD, 0 ;+ INTERNET_FLAG_EXISTING_CONNECTINTERNET_FLAG_NO_CACHE_WRITE + INTERNET_FLAG_RELOAD
    .ELSE
        Invoke HttpOpenRequest, hConnect, Addr szGetVerb, lpszUrl, NULL, NULL, Offset ppszAccept, INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_PRAGMA_NOCACHE or INTERNET_FLAG_RELOAD, 0 ;+ INTERNET_FLAG_EXISTING_CONNECTINTERNET_FLAG_NO_CACHE_WRITE + INTERNET_FLAG_RELOAD
    .ENDIF
    .IF eax == NULL
        IFDEF DEBUG32
            Invoke GetLastError
            PrintDec eax
            PrintText 'NetOpenUrl--HttpOpenRequest Error'
            PrintStringByAddr lpszUrl
        ENDIF
        .IF lpdwStatusCode != NULL
            mov ebx, lpdwStatusCode
            mov eax, 0
            mov [ebx], eax
        .ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, 0
        mov [ebx], eax
        mov eax, FALSE
        ret
    .ENDIF
    mov hRequest, eax

    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF

    IFDEF DEBUG32
    PrintText 'NetOpenUrl--HttpSendRequest'
    ENDIF
    Invoke HttpSendRequest, hRequest, NULL, NULL, NULL, 0
    .IF eax != TRUE
        Invoke HttpQueryInfo, hRequest, HTTP_QUERY_STATUS_CODE or HTTP_QUERY_FLAG_NUMBER, Addr dwStatusCode, SIZEOF DWORD, NULL
        Invoke HttpEndRequest, hRequest, NULL, 0, 0
        IFDEF DEBUG32
            Invoke GetLastError
            PrintDec eax
            PrintText 'NetOpenUrl--HttpSendRequest Error'
        ENDIF
        .IF lpdwStatusCode != NULL
            mov ebx, lpdwStatusCode
            mov eax, dwStatusCode
            mov [ebx], eax
        .ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, 0
        mov [ebx], eax
        mov eax, FALSE
        ret
    .ENDIF
    
    Invoke HttpQueryInfo, hRequest, HTTP_QUERY_STATUS_CODE or HTTP_QUERY_FLAG_NUMBER, Addr dwStatusCode, SIZEOF DWORD, NULL
    Invoke HttpEndRequest, hRequest, NULL, 0, 0
    .IF lpdwStatusCode != NULL
        mov ebx, lpdwStatusCode
        mov eax, dwStatusCode
        mov [ebx], eax
    .ENDIF
    
    .IF dwStatusCode >= 400 && dwStatusCode <= 500
        IFDEF DEBUG32
        PrintText 'NetOpenUrl--HttpSendRequest finished - Status 400-500'
        ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, 0
        mov [ebx], eax
        mov eax, FALSE
    .ELSE
        IFDEF DEBUG32
        PrintText 'NetOpenUrl--HttpSendRequest finished'
        ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, hRequest
        mov [ebx], eax
        mov eax, TRUE
    .ENDIF
    ret
NetOpenUrl ENDP

;------------------------------------------------------------------------------
;
;------------------------------------------------------------------------------
NetPostUrl PROC USES EBX lpszUrl:DWORD, lpdwhOpenUrl:DWORD, lpdwStatusCode:DWORD, dwSecure:DWORD, dwBasicAuth:DWORD
    LOCAL hRequest:DWORD
    LOCAL dwStatusCode:DWORD
    LOCAL dwLenHeader:DWORD

    IFDEF DEBUG32
        PrintText 'NetPostUrl'
    ENDIF

    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF
    
    .IF lpszUrl == NULL || lpdwhOpenUrl == NULL
        mov eax, FALSE
        ret
    .ENDIF

    mov hRequest, 0
    mov dwStatusCode, 0

    .IF dwBasicAuth == TRUE
        Invoke lstrlen, Addr AUTH_BASIC_HEADER
        mov dwLenHeader, eax
        .IF eax == 0
            IFDEF DEBUG32
            PrintText 'NetPostUrl No Auth Information Provided'
            ENDIF
            mov eax, FALSE
            ret
        .ENDIF
    .ENDIF

    IFDEF DEBUG32
    PrintText 'NetPostUrl--HttpOpenRequest'
    ENDIF
    .IF dwSecure == TRUE
        Invoke HttpOpenRequest, hConnect, Addr szPostVerb, lpszUrl, NULL, NULL, Offset ppszAcceptPost, INTERNET_FLAG_SECURE or INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_PRAGMA_NOCACHE or INTERNET_FLAG_RELOAD, 0 ;+ INTERNET_FLAG_EXISTING_CONNECTINTERNET_FLAG_NO_CACHE_WRITE + INTERNET_FLAG_RELOAD
    .ELSE
        Invoke HttpOpenRequest, hConnect, Addr szPostVerb, lpszUrl, NULL, NULL, Offset ppszAcceptPost, INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_PRAGMA_NOCACHE or INTERNET_FLAG_RELOAD, 0 ;+ INTERNET_FLAG_EXISTING_CONNECTINTERNET_FLAG_NO_CACHE_WRITE + INTERNET_FLAG_RELOAD
    .ENDIF
    .IF eax == NULL
        IFDEF DEBUG32
            Invoke GetLastError
            PrintDec eax
            PrintText 'NetPostUrl--HttpOpenRequest Error'
            PrintStringByAddr lpszUrl
        ENDIF
        .IF lpdwStatusCode != NULL
            mov ebx, lpdwStatusCode
            mov eax, 0
            mov [ebx], eax
        .ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, 0
        mov [ebx], eax
        mov eax, FALSE
        ret
    .ENDIF
    mov hRequest, eax

    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF

    .IF dwBasicAuth == TRUE
        Invoke HttpAddRequestHeaders, hRequest, Addr AUTH_BASIC_HEADER, dwLenHeader, HTTP_ADDREQ_FLAG_ADD or HTTP_ADDREQ_FLAG_REPLACE
    .ENDIF
    
    IFDEF DEBUG32
    PrintText 'NetPostUrl--HttpSendRequest'
    ENDIF
    Invoke HttpSendRequest, hRequest, NULL, NULL, NULL, 0
    .IF eax != TRUE
        Invoke HttpQueryInfo, hRequest, HTTP_QUERY_STATUS_CODE or HTTP_QUERY_FLAG_NUMBER, Addr dwStatusCode, SIZEOF DWORD, NULL
        Invoke HttpEndRequest, hRequest, NULL, 0, 0
        IFDEF DEBUG32
            Invoke GetLastError
            PrintDec eax
            PrintText 'NetPostUrl--HttpSendRequest Error'
        ENDIF
        .IF lpdwStatusCode != NULL
            mov ebx, lpdwStatusCode
            mov eax, dwStatusCode
            mov [ebx], eax
        .ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, 0
        mov [ebx], eax
        mov eax, FALSE
        ret
    .ENDIF
    
    Invoke HttpQueryInfo, hRequest, HTTP_QUERY_STATUS_CODE or HTTP_QUERY_FLAG_NUMBER, Addr dwStatusCode, SIZEOF DWORD, NULL
    Invoke HttpEndRequest, hRequest, NULL, 0, 0
    .IF lpdwStatusCode != NULL
        mov ebx, lpdwStatusCode
        mov eax, dwStatusCode
        mov [ebx], eax
    .ENDIF
    
    .IF dwStatusCode >= 400 && dwStatusCode <= 500
        IFDEF DEBUG32
        PrintText 'NetPostUrl--HttpSendRequest finished - Status 400-500'
        ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, 0
        mov [ebx], eax
        mov eax, FALSE
    .ELSE
        IFDEF DEBUG32
        PrintText 'NetPostUrl--HttpSendRequest finished'
        ENDIF
        mov ebx, lpdwhOpenUrl
        mov eax, hRequest
        mov [ebx], eax
        mov eax, TRUE
    .ENDIF
    ret
NetPostUrl ENDP

;------------------------------------------------------------------------------
; NetCloseUrl - closes url request opened by NetOpenUrl or NetPostUrl
;------------------------------------------------------------------------------
NetCloseUrl PROC hOpenUrl:DWORD
    IFDEF DEBUG32
        PrintText 'CloseUrl'
    ENDIF        
    
    .IF hOpenUrl != NULL
        Invoke InternetCloseHandle, hOpenUrl
    .ENDIF
    ret
NetCloseUrl ENDP

;------------------------------------------------------------------------------
; NetReadUrlData - Read url file and return pointer to file data in lpdwDataBuffer
; along with size of file data in lpdwTotalBytesRead. 
; Returns TRUE if succesful or FALSE otherwise.
; Notes: Use NetFreeUrlData after finishing processing file data to free memory  
;------------------------------------------------------------------------------
NetReadUrlData PROC USES EBX EDX EDI hOpenUrl:DWORD, lpdwDataBuffer:DWORD, lpdwTotalBytesRead:DWORD
    LOCAL BytesRead:DWORD
    LOCAL Position:DWORD
    LOCAL DataBuffer:DWORD
    LOCAL SizeDataBuffer:DWORD
    LOCAL looptrue:DWORD
    LOCAL DataBufferChunkSize:DWORD

    IFDEF DEBUG32
        PrintText 'NetReadUrlData'
    ENDIF
    
    .IF lpdwDataBuffer == NULL
        mov eax, FALSE
        ret
    .ENDIF
    
    Invoke NetGetRemoteFileSize, hOpenUrl, Addr DataBufferChunkSize
    .IF eax == TRUE && DataBufferChunkSize != 0
        mov eax, DataBufferChunkSize
        mov SizeDataBuffer, eax
    .ELSE
        mov DataBufferChunkSize, NET_BUFFER_SIZE
        mov SizeDataBuffer, NET_BUFFER_SIZE
    .ENDIF
    mov DataBuffer, 0
    mov BytesRead, 1
    mov Position, 0    
    
    Invoke GlobalAlloc, GMEM_FIXED+GMEM_ZEROINIT, DataBufferChunkSize
    .IF eax == NULL
        IFDEF DEBUG32
            PrintText 'ReadUrl-GlobalAlloc Error'
        ENDIF
        mov ebx, lpdwDataBuffer
        mov eax, 0
        mov [ebx], eax
        .IF lpdwTotalBytesRead != NULL
            mov ebx, lpdwTotalBytesRead
            mov eax, 0
            mov [ebx], eax
        .ENDIF
        
        mov eax, FALSE
        ret
    .ENDIF
    mov DataBuffer, eax

    .IF bNetExitFromThread == TRUE
        mov eax, FALSE
        ret
    .ENDIF

    mov eax, TRUE
    .WHILE eax == TRUE && BytesRead != 0 ; continue
    
        .IF bNetExitFromThread == TRUE
            mov eax, FALSE
            ret
        .ENDIF

        mov edi, DataBuffer
        add edi, Position

        Invoke InternetReadFile, hOpenUrl, edi, DataBufferChunkSize, Addr BytesRead
        .IF eax == FALSE
            IFDEF DEBUG32
                PrintText 'ReadUrl-InternetReadFile Error'
                Invoke GetLastError
                PrintDec eax
            ENDIF
            .IF DataBuffer != NULL
                Invoke GlobalFree, DataBuffer
            .ENDIF
            
            mov ebx, lpdwDataBuffer
            mov eax, 0
            mov [ebx], eax
            .IF lpdwTotalBytesRead != NULL
                mov ebx, lpdwTotalBytesRead
                mov eax, 0
                mov [ebx], eax
            .ENDIF
            
            mov eax, FALSE
            ret
        .endif

        mov looptrue, eax
        mov edx, BytesRead
        add Position, edx
        mov eax, looptrue
        .IF eax == TRUE
            mov eax, DataBufferChunkSize
            add SizeDataBuffer, eax

            Invoke GlobalReAlloc, DataBuffer, SizeDataBuffer, GMEM_ZEROINIT + GMEM_MOVEABLE ; eax new pointer to mem
            .IF eax == NULL
                IFDEF DEBUG32
                    PrintText 'ReadUrl-GlobalReAlloc Error'
                    Invoke GetLastError
                    PrintDec eax
                ENDIF
                .IF DataBuffer != NULL
                    Invoke GlobalFree, DataBuffer
                .ENDIF
                mov ebx, lpdwDataBuffer
                mov eax, 0
                mov [ebx], eax
                .IF lpdwTotalBytesRead != NULL
                    mov ebx, lpdwTotalBytesRead
                    mov eax, 0
                    mov [ebx], eax
                .ENDIF
                
                mov eax, FALSE
                ret                
            .ENDIF
            mov DataBuffer, eax
        .ENDIF
        mov eax, looptrue
    .ENDW
    
    mov ebx, lpdwDataBuffer
    mov eax, DataBuffer
    mov [ebx], eax
    .IF lpdwTotalBytesRead != NULL
        mov ebx, lpdwTotalBytesRead
        mov eax, Position
        mov [ebx], eax
    .ENDIF
    
    mov eax, TRUE
    ret
NetReadUrlData ENDP

;------------------------------------------------------------------------------
; NetFreeUrlData - Frees allocated memory used by NetReadUrlData
;------------------------------------------------------------------------------
NetFreeUrlData PROC USES EBX lpdwDataBuffer:DWORD
    .IF lpdwDataBuffer != NULL
        mov ebx, lpdwDataBuffer
        mov eax, [ebx]
        .IF eax != NULL
            Invoke GlobalFree, eax
        .ENDIF
        mov ebx, lpdwDataBuffer
        mov eax, 0
        mov [ebx], eax
    .ENDIF
    xor eax, eax
    ret
NetFreeUrlData ENDP

;------------------------------------------------------------------------------
; NetGetRemoteFileSize
;------------------------------------------------------------------------------
NetGetRemoteFileSize PROC USES EBX hOpenUrl:DWORD, lpdwRemoteFileSize:DWORD
    LOCAL BytesToGet:DWORD
    LOCAL BytesToGetSize:DWORD
    LOCAL lpdwIndex:DWORD

    IFDEF DEBUG32
        PrintText 'NetGetRemoteFileSize'
    ENDIF
    
    mov BytesToGetSize, 4d
    mov lpdwIndex, 0

    Invoke HttpQueryInfo, hOpenUrl, HTTP_QUERY_FLAG_NUMBER + HTTP_QUERY_CONTENT_LENGTH, Addr BytesToGet, Addr BytesToGetSize, Addr lpdwIndex ; HTTP_QUERY_FLAG_NUMBER +
    .IF eax == FALSE
        mov eax, 0
        mov ebx, lpdwRemoteFileSize
        mov [ebx], eax          
        mov eax, FALSE
        ret       
    .endif
    mov eax, BytesToGet
    mov ebx, lpdwRemoteFileSize
    mov [ebx], eax
    mov eax, TRUE    
    ret
NetGetRemoteFileSize ENDP

;------------------------------------------------------------------------------
; NetBase64Encode
;------------------------------------------------------------------------------
NetBase64Encode PROC lpszSource:DWORD, lpszDestination:DWORD, dwSourceLength:DWORD
    push edi
    push esi
    push ebx
    mov  esi, lpszSource
    mov  edi, lpszDestination
@@base64loop:
    xor eax, eax
    .IF dwSourceLength == 1
        lodsb                           ;source ptr + 1
        mov ecx, 2                      ;bytes to output = 2
        mov edx, 03D3Dh                 ;padding = 2 byte
        dec dwSourceLength              ;length - 1
    .ELSEIF dwSourceLength == 2
        lodsw                           ;source ptr + 2
        mov ecx, 3                      ;bytes to output = 3
        mov edx, 03Dh                   ;padding = 1 byte
        sub dwSourceLength, 2           ;length - 2
    .ELSE
        lodsd
        mov ecx, 4                      ;bytes to output = 4
        xor edx, edx                    ;padding = 0 byte
        dec esi                         ;source ptr + 3 (+4-1)
        sub dwSourceLength, 3           ;length - 3 
    .ENDIF

    xchg al,ah                          ; flip eax completely
    rol  eax, 16                        ; can this be done faster
    xchg al,ah                          ; ??

    @@:
    push  eax
    and   eax, 0FC000000h               ;get the last 6 high bits
    rol   eax, 6                        ;rotate them into al
    mov   al, byte ptr [offset Base64Alphabet+eax]      ;get encode character
    stosb                               ;write to destination
    pop   eax
    shl   eax, 6                        ;shift left 6 bits
    dec   ecx
    jnz   @B                            ;loop
    
    cmp   dwSourceLength, 0
    jnz   @@base64loop                  ;main loop
    
    mov   eax, edx                      ;add padding and null terminate
    stosd                               ;  "     "    "     "     "

    pop   ebx
    pop   esi
    pop   edi
    ret
NetBase64Encode ENDP

;------------------------------------------------------------------------------
; NetWriteDataToLocalFile
;------------------------------------------------------------------------------
NetWriteDataToLocalFile PROC lpszLocalFilename:DWORD, pDataBuffer:DWORD, dwDataBufferSize:DWORD
    LOCAL hFile:DWORD
    LOCAL hMapFile:DWORD
    LOCAL pViewFile:DWORD
    
    IFDEF DEBUG32
        PrintText 'NetWriteDataToLocalFile'
    ENDIF      
    
    .IF lpszLocalFilename == NULL || pDataBuffer == NULL || dwDataBufferSize == NULL
        IFDEF DEBUG32
            PrintText 'NetWriteDataToLocalFile null params'
        ENDIF      
        mov eax, FALSE
        ret
    .ENDIF
    
    Invoke CreateFile, lpszLocalFilename, GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    .IF eax == INVALID_HANDLE_VALUE
        IFDEF DEBUG32
            PrintText 'NetWriteDataToLocalFile CreateFile Error'
        ENDIF   
        mov eax, FALSE
        ret
    .ENDIF
    mov hFile, eax
    
    Invoke CreateFileMapping, hFile, NULL, PAGE_READWRITE, 0, dwDataBufferSize, NULL
    .IF eax == NULL
        IFDEF DEBUG32
            PrintText 'NetWriteDataToLocalFile CreateFileMapping Error'
        ENDIF        
        mov eax, FALSE
        ret
    .ENDIF
    mov hMapFile, eax    
    
    Invoke MapViewOfFileEx, hMapFile, FILE_MAP_ALL_ACCESS, 0, 0, 0, NULL
    .IF eax == NULL
        IFDEF DEBUG32
            PrintText 'NetWriteDataToLocalFile MapViewOfFile Error'
        ENDIF
        Invoke CloseHandle, hMapFile       
        mov eax, FALSE
        ret
    .ENDIF
    mov pViewFile, eax    

    Invoke RtlMoveMemory, pViewFile, pDataBuffer, dwDataBufferSize
    
    Invoke UnmapViewOfFile, pViewFile
    Invoke CloseHandle, hMapFile    
    
    mov eax, TRUE
    ret
NetWriteDataToLocalFile ENDP

;------------------------------------------------------------------------------
; NetUrlValues - Constructs and adds ?name=value pairs to lpszUrlQuery
; If lpszUrlQuery is only provided, the buffer pointed to by lpszUrlQuery is
; zeroed out (based on previous length)
;------------------------------------------------------------------------------
NetUrlValues PROC USES EBX lpszUrlQuery:DWORD, lpszName:DWORD, lpszValue:DWORD, dwValue:DWORD
    LOCAL LenUrlQuery:DWORD
    LOCAL szValue[32]:BYTE
    
    .IF lpszUrlQuery == NULL
        mov eax, FALSE
        ret
    .ENDIF
    
    Invoke lstrlen, lpszUrlQuery
    mov LenUrlQuery, eax
    
    .IF lpszName == NULL && lpszValue == NULL && dwValue == NULL ; clear query string
        .IF LenUrlQuery != 0
            Invoke RtlZeroMemory, lpszUrlQuery, LenUrlQuery
        .ENDIF
        mov eax, TRUE
        ret
    .ENDIF
    
    .IF LenUrlQuery == 0
        Invoke lstrcpy, lpszUrlQuery, CTEXT("?")
    .ELSE
        Invoke lstrcat, lpszUrlQuery, CTEXT("?")
    .ENDIF
    
    Invoke lstrcat, lpszUrlQuery, lpszName
    Invoke lstrcat, lpszUrlQuery, CTEXT("=")
    .IF lpszValue != NULL
        Invoke lstrcat, lpszUrlQuery, lpszValue
    .ELSE
        Invoke utoa_ex, dwValue, Addr szValue
        Invoke lstrcat, lpszUrlQuery, Addr szValue
    .ENDIF
    
    mov eax, TRUE
    ret
NetUrlValues ENDP


;------------------------------------------------------------------------------
; Convert ascii string pointed to by String param to unsigned dword value. 
; Returns dword value in eax.
;------------------------------------------------------------------------------
OPTION PROLOGUE:NONE
OPTION EPILOGUE:NONE
ALIGN 16
atou_ex proc String:DWORD

  ; ------------------------------------------------
  ; Convert decimal string into UNSIGNED DWORD value
  ; ------------------------------------------------

    mov edx, [esp+4]

    xor ecx, ecx
    movzx eax, BYTE PTR [edx]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+1]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+2]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+3]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+4]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+5]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+6]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+7]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+8]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+9]
    test eax, eax
    jz quit

    lea ecx, [ecx+ecx*4]
    lea ecx, [eax+ecx*2-48]
    movzx eax, BYTE PTR [edx+10]
    test eax, eax
    jnz out_of_range

  quit:
    lea eax, [ecx]      ; return value in EAX
    or ecx, -1          ; non zero in ECX for success
    ret 4

  out_of_range:
    xor eax, eax        ; zero return value on error
    xor ecx, ecx        ; zero in ECX is out of range error
    ret 4

atou_ex endp
OPTION PROLOGUE:PrologueDef
OPTION EPILOGUE:EpilogueDef

;------------------------------------------------------------------------------
; Convert unsigned dword value to an ascii string. 
;------------------------------------------------------------------------------
OPTION PROLOGUE:NONE
OPTION EPILOGUE:NONE
ALIGN 16
utoa_ex proc uvar:DWORD,pbuffer:DWORD

  ; --------------------------------------------------------------------------------
  ; this algorithm was written by Paul Dixon and has been converted to MASM notation
  ; --------------------------------------------------------------------------------

    mov eax, [esp+4]                ; uvar      : unsigned variable to convert
    mov ecx, [esp+8]                ; pbuffer   : pointer to result buffer

    push esi
    push edi

    jmp udword

  align 4
  chartab:
    dd "00","10","20","30","40","50","60","70","80","90"
    dd "01","11","21","31","41","51","61","71","81","91"
    dd "02","12","22","32","42","52","62","72","82","92"
    dd "03","13","23","33","43","53","63","73","83","93"
    dd "04","14","24","34","44","54","64","74","84","94"
    dd "05","15","25","35","45","55","65","75","85","95"
    dd "06","16","26","36","46","56","66","76","86","96"
    dd "07","17","27","37","47","57","67","77","87","97"
    dd "08","18","28","38","48","58","68","78","88","98"
    dd "09","19","29","39","49","59","69","79","89","99"

  udword:
    mov esi, ecx                    ; get pointer to answer
    mov edi, eax                    ; save a copy of the number

    mov edx, 0D1B71759h             ; =2^45\10000    13 bit extra shift
    mul edx                         ; gives 6 high digits in edx

    mov eax, 68DB9h                 ; =2^32\10000+1

    shr edx, 13                     ; correct for multiplier offset used to give better accuracy
    jz short skiphighdigits         ; if zero then don't need to process the top 6 digits

    mov ecx, edx                    ; get a copy of high digits
    imul ecx, 10000                 ; scale up high digits
    sub edi, ecx                    ; subtract high digits from original. EDI now = lower 4 digits

    mul edx                         ; get first 2 digits in edx
    mov ecx, 100                    ; load ready for later

    jnc short next1                 ; if zero, supress them by ignoring
    cmp edx, 9                      ; 1 digit or 2?
    ja   ZeroSupressed              ; 2 digits, just continue with pairs of digits to the end

    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dh                   ; but only write the 1 we need, supress the leading zero
    inc esi                         ; update pointer by 1
    jmp  ZS1                        ; continue with pairs of digits to the end

  align 16
  next1:
    mul ecx                         ; get next 2 digits
    jnc short next2                 ; if zero, supress them by ignoring
    cmp edx, 9                      ; 1 digit or 2?
    ja   ZS1a                       ; 2 digits, just continue with pairs of digits to the end

    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dh                   ; but only write the 1 we need, supress the leading zero
    add esi, 1                      ; update pointer by 1
    jmp  ZS2                        ; continue with pairs of digits to the end

  align 16
  next2:
    mul ecx                         ; get next 2 digits
    jnc short next3                 ; if zero, supress them by ignoring
    cmp edx, 9                      ; 1 digit or 2?
    ja   ZS2a                       ; 2 digits, just continue with pairs of digits to the end

    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dh                   ; but only write the 1 we need, supress the leading zero
    add esi, 1                      ; update pointer by 1
    jmp  ZS3                        ; continue with pairs of digits to the end

  align 16
  next3:

  skiphighdigits:
    mov eax, edi                    ; get lower 4 digits
    mov ecx, 100

    mov edx, 28F5C29h               ; 2^32\100 +1
    mul edx
    jnc short next4                 ; if zero, supress them by ignoring
    cmp edx, 9                      ; 1 digit or 2?
    ja  short ZS3a                  ; 2 digits, just continue with pairs of digits to the end

    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dh                   ; but only write the 1 we need, supress the leading zero
    inc esi                         ; update pointer by 1
    jmp short  ZS4                  ; continue with pairs of digits to the end

  align 16
  next4:
    mul ecx                         ; this is the last pair so don; t supress a single zero
    cmp edx, 9                      ; 1 digit or 2?
    ja  short ZS4a                  ; 2 digits, just continue with pairs of digits to the end

    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dh                   ; but only write the 1 we need, supress the leading zero
    mov byte ptr [esi+1], 0         ; zero terminate string

    pop edi
    pop esi
    ret 8

  align 16
  ZeroSupressed:
    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dx
    add esi, 2                      ; write them to answer

  ZS1:
    mul ecx                         ; get next 2 digits
  ZS1a:
    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dx                   ; write them to answer
    add esi, 2

  ZS2:
    mul ecx                         ; get next 2 digits
  ZS2a:
    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dx                   ; write them to answer
    add esi, 2

  ZS3:
    mov eax, edi                    ; get lower 4 digits
    mov edx, 28F5C29h               ; 2^32\100 +1
    mul edx                         ; edx= top pair
  ZS3a:
    mov edx, chartab[edx*4]         ; look up 2 digits
    mov [esi], dx                   ; write to answer
    add esi, 2                      ; update pointer

  ZS4:
    mul ecx                         ; get final 2 digits
  ZS4a:
    mov edx, chartab[edx*4]         ; look them up
    mov [esi], dx                   ; write to answer

    mov byte ptr [esi+2], 0         ; zero terminate string

  sdwordend:

    pop edi
    pop esi

    ret 8

utoa_ex endp
OPTION PROLOGUE:PrologueDef
OPTION EPILOGUE:EpilogueDef





