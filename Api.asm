;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================
;
; SIA API Endpoint Functions
;
;------------------------------------------------------------------------------
SIA_API_GET                                     PROTO :DWORD, :DWORD, :DWORD
SIA_API_GET_PARAM                               PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
SIA_API_POST                                    PROTO :DWORD, :DWORD
SIA_API_POST_PARAM                              PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD


.DATA
;-----------------------------------------------
; Sia API URL endpoint strings
;-----------------------------------------------
SIA_API_URL_CONSENSUS                           DB "/consensus",0                           ; GET
SIA_API_URL_CONSENSUS_BLOCKS                    DB "/consensus/blocks",0                    ; GET
SIA_API_URL_CONSENSUS_VALIDATE_TRANSACTIONSET   DB "/consensus/validate/transactionset",0   ; POST

SIA_API_URL_DAEMON_CONSTANTS                    DB "/daemon/constants",0                    ; GET
SIA_API_URL_DAEMON_STOP                         DB "/daemon/stop",0                         ; GET
SIA_API_URL_DAEMON_VERSION                      DB "/daemon/version",0                      ; GET
SIA_API_URL_DAEMON_SETTINGS                     DB "/daemon/settings",0                     ; GET, POST
SIA_API_URL_DAEMON_UPDATE                       DB "/daemon/update",0                       ; GET, POST

SIA_API_URL_GATEWAY                             DB "/gateway",0                             ; GET, POST
SIA_API_URL_GATEWAY_CONNECT                     DB "/gateway/connect/",0                    ; <netaddress> POST
SIA_API_URL_GATEWAY_DISCONNECT                  DB "/gateway/disconnect/",0                 ; <netaddress> POST

SIA_API_URL_HOST                                DB "/host",0                                ; GET, POST
SIA_API_URL_HOST_ANNOUNCE                       DB "/host/announce",0                       ; POST
SIA_API_URL_HOST_CONTRACTS                      DB "/host/contracts",0                      ; GET
SIA_API_URL_HOST_STORAGE                        DB "/host/storage",0                        ; GET
SIA_API_URL_HOST_STORAGE_FOLDERS_ADD            DB "/host/storage/folders/add",0            ; POST
SIA_API_URL_HOST_STORAGE_FOLDERS_REMOVE         DB "/host/storage/folders/remove",0         ; POST
SIA_API_URL_HOST_STORAGE_FOLDERS_RESIZE         DB "/host/storage/folders/resize",0         ; POST
SIA_API_URL_HOST_STORAGE_SECTORS_DELETE         DB "/host/storage/sectors/delete/",0        ; <merkleroot> POST
SIA_API_URL_HOST_ESTIMATESCORE                  DB "/host/estimatescore",0                  ; GET

SIA_API_URL_HOSTDB                              DB "/hostdb",0                              ; GET
SIA_API_URL_HOSTDB_ACTIVE                       DB "/hostdb/active",0                       ; GET
SIA_API_URL_HOSTDB_ALL                          DB "/hostdb/all",0                          ; GET
SIA_API_URL_HOSTDB_HOSTS                        DB "/hostdb/hosts/",0                       ; <pubkey> GET
SIA_API_URL_HOSTDB_FILTERMODE                   DB "/hostdb/filtermode",0                   ; POST

SIA_API_URL_MINER                               DB "/miner",0                               ; GET
SIA_API_URL_MINER_START                         DB "/miner/start",0                         ; GET
SIA_API_URL_MINER_STOP                          DB "/miner/stop",0                          ; GET
SIA_API_URL_MINER_HEADER                        DB "/miner/header",0                        ; GET, POST

SIA_API_URL_RENTER                              DB "/renter",0                              ; GET, POST
SIA_API_URL_RENTER_CONTRACT_CANCEL              DB "/renter/contract/cancel",0              ; POST
SIA_API_URL_RENTER_BACKUP                       DB "/renter/backup",0                       ; POST
SIA_API_URL_RENTER_BACKUPS                      DB "/renter/backups",0                      ; GET
SIA_API_URL_RENTER_BACKUPS_CREATE               DB "/renter/backups/create",0               ; POST
SIA_API_URL_RENTER_BACKUPS_RESTORE              DB "/renter/backups/restore",0              ; POST
SIA_API_URL_RENTER_RECOVERBACKUP                DB "/renter/recoverbackup",0                ; POST
SIA_API_URL_RENTER_CONTRACTS                    DB "/renter/contracts",0                    ; GET
SIA_API_URL_RENTER_DIR                          DB "/renter/dir/",0                         ; <siapath> GET, POST
SIA_API_URL_RENTER_DOWNLOADS                    DB "/renter/downloads",0                    ; GET
SIA_API_URL_RENTER_DOWNLOADS_CLEAR              DB "/renter/downloads/clear",0              ; POST
SIA_API_URL_RENTER_PRICES                       DB "/renter/prices",0                       ; GET
SIA_API_URL_RENTER_FILES                        DB "/renter/files",0                        ; GET
SIA_API_URL_RENTER_FILE                         DB "/renter/file/",0                        ; <siapath> GET, POST
SIA_API_URL_RENTER_DELETE                       DB "/renter/delete/",0                      ; <siapath> POST
SIA_API_URL_RENTER_DOWNLOAD                     DB "/renter/download/",0                    ; <siapath> GET
SIA_API_URL_RENTER_DOWNLOAD_CANCEL              DB "/renter/download/cencel",0              ; <id> POST
SIA_API_URL_RENTER_DOWNLOADSYNC                 DB "/renter/downloadsync/",0                ; <siapath> GET
SIA_API_URL_RENTER_RECOVERYSCAN                 DB "/renter/recoveryscan",0                 ; GET, POST
SIA_API_URL_RENTER_RENAME                       DB "/renter/rename/",0                      ; <siapath> GET, POST
SIA_API_URL_RENTER_STREAM                       DB "/renter/stream/",0                      ; <siapath> GET
SIA_API_URL_RENTER_UPLOAD                       DB "/renter/upload/",0                      ; <siapath> POST

SIA_API_URL_TPOOL_CONFIRMED                     DB "/tpool/confirmed/",0                    ; <id> GET
SIA_API_URL_TPOOL_FEE                           DB "/tpool/fee",0                           ; GET
SIA_API_URL_TPOOL_RAW                           DB "/tpool/raw",0                           ; POST
SIA_API_URL_TPOOL_RAW_ID                        DB "/tpool/raw/",0                          ; <id> GET

SIA_API_URL_WALLET                              DB "/wallet",0                              ; GET
SIA_API_URL_WALLET_033X                         DB "/wallet/033x",0                         ; POST
SIA_API_URL_WALLET_ADDRESS                      DB "/wallet/address",0                      ; GET
SIA_API_URL_WALLET_ADDRESSES                    DB "/wallet/addresses",0                    ; GET
SIA_API_URL_WALLET_SEEDADDRS                    DB "/wallet/seedaddrs",0                    ; GET
SIA_API_URL_WALLET_BACKUP                       DB "/wallet/backup",0                       ; GET
SIA_API_URL_WALLET_CHANGEPASSWORD               DB "/wallet/changepassword",0               ; POST
SIA_API_URL_WALLET_INIT                         DB "/wallet/init",0                         ; POST
SIA_API_URL_WALLET_INIT_SEED                    DB "/wallet/init/seed",0                    ; POST
SIA_API_URL_WALLET_SEED                         DB "/wallet/seed",0                         ; POST
SIA_API_URL_WALLET_SEEDS                        DB "/wallet/seeds",0                        ; GET
SIA_API_URL_WALLET_SIACOINS                     DB "/wallet/siacoins",0                     ; POST
SIA_API_URL_WALLET_SIAFUNDS                     DB "/wallet/siafunds",0                     ; POST
SIA_API_URL_WALLET_SIAGKEY                      DB "/wallet/siagkey",0                      ; POST
SIA_API_URL_WALLET_SIGN                         DB "/wallet/sign",0                         ; POST
SIA_API_URL_WALLET_SWEEP_SEED                   DB "/wallet/sweep/seed",0                   ; POST
SIA_API_URL_WALLET_LOCK                         DB "/wallet/lock",0                         ; POST
SIA_API_URL_WALLET_TRANSACTION                  DB "/wallet/transaction/",0                 ; <id> GET
SIA_API_URL_WALLET_TRANSACTIONS                 DB "/wallet/transactions",0                 ; GET
SIA_API_URL_WALLET_UNLOCK                       DB "/wallet/unlock",0                       ; POST
SIA_API_URL_WALLET_UNLOCKCONDITIONS             DB "/wallet/unlockconditions/",0            ; <addr> GET
SIA_API_URL_WALLET_UNSPENT                      DB "/wallet/unspent",0                      ; GET
SIA_API_URL_WALLET_VERIFY_ADDRESS               DB "/wallet/verify/address/",0              ; <addr> GET
SIA_API_URL_WALLET_WATCH                        DB "/wallet/watch",0                        ; GET, POST

SIA_API_URL                                     DB MAX_PATH DUP (0)                         ; Used to construct a Sia API URL
SiaApiUrlValues                                 DB 4096 DUP (0)                             ; Used to store url name=value strings

.CODE

;-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!
; NOTE: For functions that return a cJSON Object via a lpdwcJSONObject param, 
; use the cJSON_Delete function to free up the memory when the cJSON Object is
; no longer required. 
;-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!-!

;==============================================================================
; SIA_API_* functions - Calls to Net* functions
;==============================================================================

;------------------------------------------------------------------------------
; SIA_API_GET
;------------------------------------------------------------------------------
SIA_API_GET PROC USES EBX lpszSiaApiUrl:DWORD, lpdwcJSONObject:DWORD, lpszSiaApiJsonToFile:DWORD 
    LOCAL hOpenUrl:DWORD
    LOCAL pJsonDataBuffer:DWORD
    LOCAL dwDataBufferSize:DWORD
    LOCAL dwHttpStatusCode:DWORD
    
    .IF lpszSiaApiUrl == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke NetOpenUrl, lpszSiaApiUrl, Addr hOpenUrl, Addr dwHttpStatusCode, FALSE
    .IF eax == FALSE
        ret
    .ENDIF
    
    .IF lpdwcJSONObject != NULL
        ; Read JSON data if status is 200 (HTTP_STATUS_OK)
        .IF dwHttpStatusCode == HTTP_STATUS_OK
            Invoke NetReadUrlData, hOpenUrl, Addr pJsonDataBuffer, Addr dwDataBufferSize
            .IF eax == FALSE || pJsonDataBuffer == NULL
                Invoke NetCloseUrl, hOpenUrl
                xor eax, eax
                ret
            .ENDIF
            
            IFDEF SIA_API_JSON_TO_LOCALFILE
            .IF lpszSiaApiJsonToFile != NULL
                Invoke NetWriteDataToLocalFile, lpszSiaApiJsonToFile, pJsonDataBuffer, dwDataBufferSize
            .ENDIF
            ENDIF
            
            ; Parse JSON data returned
            Invoke cJSON_Parse, pJsonDataBuffer
            .IF eax == NULL ; cleanup and exit
                Invoke NetFreeUrlData, Addr pJsonDataBuffer
                Invoke NetCloseUrl, hOpenUrl
                xor eax, eax    
                ret
            .ENDIF
            
            ; Return pointer to cJSON object via lpdwcJSONObject parameter 
            mov ebx, lpdwcJSONObject
            mov [ebx], eax
            
            ; Free Read Data
            Invoke NetFreeUrlData, Addr pJsonDataBuffer
            Invoke NetCloseUrl, hOpenUrl
            mov eax, TRUE
        .ELSE
            ; Return null data if status was not 200 (HTTP_STATUS_OK)
            mov ebx, lpdwcJSONObject
            mov eax, 0
            mov [ebx], eax
            Invoke NetCloseUrl, hOpenUrl
            mov eax, FALSE
        .ENDIF
    .ELSE
        .IF dwHttpStatusCode == HTTP_STATUS_OK
            mov eax, TRUE
        .ELSE
            mov eax, FALSE
        .ENDIF
    .ENDIF
    ret
SIA_API_GET ENDP

;------------------------------------------------------------------------------
; SIA_API_GET_PARAM
;------------------------------------------------------------------------------
SIA_API_GET_PARAM PROC USES EBX lpszSiaApiUrl:DWORD, lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD, lpdwcJSONObject:DWORD, lpszSiaApiJsonToFile:DWORD 
    LOCAL hOpenUrl:DWORD
    LOCAL pJsonDataBuffer:DWORD
    LOCAL dwDataBufferSize:DWORD
    LOCAL dwHttpStatusCode:DWORD
    
    .IF lpszSiaApiUrl == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke lstrcpyn, Addr SIA_API_URL, lpszSiaApiUrl, SIZEOF SIA_API_URL
    .IF lpszPathParameters != NULL
        Invoke lstrcat, Addr SIA_API_URL, lpszPathParameters
    .ENDIF
    .IF lpszQueryStringParameters != NULL
        Invoke lstrcat, Addr SIA_API_URL, lpszQueryStringParameters
    .ENDIF
     
    Invoke NetOpenUrl, Addr SIA_API_URL, Addr hOpenUrl, Addr dwHttpStatusCode, FALSE
    .IF eax == FALSE
        ret
    .ENDIF
    
    .IF lpdwcJSONObject != NULL
        ; Read JSON data if status is 200 (HTTP_STATUS_OK)
        .IF dwHttpStatusCode == HTTP_STATUS_OK
            Invoke NetReadUrlData, hOpenUrl, Addr pJsonDataBuffer, Addr dwDataBufferSize
            .IF eax == FALSE || pJsonDataBuffer == NULL
                Invoke NetCloseUrl, hOpenUrl
                xor eax, eax
                ret
            .ENDIF
            
            IFDEF SIA_API_JSON_TO_LOCALFILE
            .IF lpszSiaApiJsonToFile != NULL
                Invoke NetWriteDataToLocalFile, lpszSiaApiJsonToFile, pJsonDataBuffer, dwDataBufferSize
            .ENDIF
            ENDIF
            
            ; Parse JSON data returned
            Invoke cJSON_Parse, pJsonDataBuffer
            .IF eax == NULL ; cleanup and exit
                Invoke NetFreeUrlData, Addr pJsonDataBuffer
                Invoke NetCloseUrl, hOpenUrl
                xor eax, eax    
                ret
            .ENDIF
            
            ; Return pointer to cJSON object via lpdwcJSONObject parameter 
            mov ebx, lpdwcJSONObject
            mov [ebx], eax
            
            ; Free Read Data
            Invoke NetFreeUrlData, Addr pJsonDataBuffer
            Invoke NetCloseUrl, hOpenUrl
            mov eax, TRUE
        .ELSE
            ; Return null data if status was not 200 (HTTP_STATUS_OK)
            mov ebx, lpdwcJSONObject
            mov eax, 0
            mov [ebx], eax
            Invoke NetCloseUrl, hOpenUrl
            mov eax, FALSE
        .ENDIF
    .ELSE
        .IF dwHttpStatusCode == HTTP_STATUS_OK
            mov eax, TRUE
        .ELSE
            mov eax, FALSE
        .ENDIF
    .ENDIF
    ret
SIA_API_GET_PARAM ENDP

;------------------------------------------------------------------------------
; SIA_API_POST
;------------------------------------------------------------------------------
SIA_API_POST PROC USES EBX lpszSiaApiUrl:DWORD, dwBasicAuth:DWORD
    LOCAL hOpenUrl:DWORD
    LOCAL dwHttpStatusCode:DWORD
    
    .IF lpszSiaApiUrl == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke NetPostUrl, lpszSiaApiUrl, Addr hOpenUrl, Addr dwHttpStatusCode, FALSE, dwBasicAuth
    .IF eax == FALSE
        ret
    .ENDIF

    Invoke NetCloseUrl, hOpenUrl
    
    .IF dwHttpStatusCode == HTTP_STATUS_OK  
        mov eax, TRUE
    .ELSE       
        mov eax, FALSE
    .ENDIF
    ret
SIA_API_POST ENDP

;------------------------------------------------------------------------------
; SIA_API_POST_PARAM
;------------------------------------------------------------------------------
SIA_API_POST_PARAM PROC USES EBX lpszSiaApiUrl:DWORD, lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD, lpData:DWORD, dwSizeData:DWORD, dwBasicAuth:DWORD
    LOCAL hOpenUrl:DWORD
    LOCAL pJsonDataBuffer:DWORD
    LOCAL dwDataBufferSize:DWORD
    LOCAL dwHttpStatusCode:DWORD
    
    .IF lpszSiaApiUrl == NULL
        xor eax, eax
        ret
    .ENDIF    
    
    Invoke lstrcpyn, Addr SIA_API_URL, lpszSiaApiUrl, SIZEOF SIA_API_URL
    .IF lpszPathParameters != NULL
        Invoke lstrcat, Addr SIA_API_URL, lpszPathParameters
    .ENDIF
    .IF lpszQueryStringParameters != NULL
        Invoke lstrcat, Addr SIA_API_URL, lpszQueryStringParameters
    .ENDIF
    
    .IF lpData != NULL && dwSizeData != 0
        ; todo add data to body post
    .ENDIF
    
    Invoke NetPostUrl, Addr SIA_API_URL, Addr hOpenUrl, Addr dwHttpStatusCode, FALSE, dwBasicAuth
    .IF eax == FALSE
        ret
    .ENDIF

    Invoke NetCloseUrl, hOpenUrl
    
    .IF dwHttpStatusCode == HTTP_STATUS_OK  
        mov eax, TRUE
    .ELSE       
        mov eax, FALSE
    .ENDIF
    ret
SIA_API_POST_PARAM ENDP


;==============================================================================
; sia_api_* functions - calls to SIA_API_* functions
;==============================================================================

;### Consensus ###

;------------------------------------------------------------------------------
; Fetches consensus JSON data: 
; https://sia.tech/docs/#consensus
;------------------------------------------------------------------------------
sia_api_consensus PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_CONSENSUS, lpdwcJSONObject, CTEXT(".\sia_api_consensus.txt")
    ret
sia_api_consensus ENDP

;------------------------------------------------------------------------------
; Fetches consensus blocks JSON data: 
; https://sia.tech/docs/#consensus-blocks-get
;------------------------------------------------------------------------------
sia_api_consensus_blocks PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_CONSENSUS_BLOCKS, NULL, lpszQueryStringParameters, lpdwcJSONObject, CTEXT(".\sia_api_consensus_blocks.txt")
    ret
sia_api_consensus_blocks ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_consensus_validate_transactionset PROC

    ret
sia_api_consensus_validate_transactionset ENDP


;### Daemon ###

;------------------------------------------------------------------------------
; Fetches daemon constants JSON data: 
; https://github.com/NebulousLabs/Sia/blob/master/doc/api/Daemon.md#daemonconstants-get
;------------------------------------------------------------------------------
sia_api_daemon_constants PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_DAEMON_CONSTANTS, lpdwcJSONObject, CTEXT(".\sia_api_daemon_constants.txt")
    ret
sia_api_daemon_constants ENDP

;------------------------------------------------------------------------------
; Stops SIA daemon
;------------------------------------------------------------------------------
sia_api_daemon_stop PROC
    Invoke SIA_API_GET, Addr SIA_API_URL_DAEMON_STOP, NULL, NULL
    ret
sia_api_daemon_stop ENDP

;------------------------------------------------------------------------------
; Fetches daemon version JSON data: 
; https://sia.tech/docs/#daemon-version-get
;------------------------------------------------------------------------------
sia_api_daemon_version PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_DAEMON_VERSION, lpdwcJSONObject, CTEXT(".\sia_api_daemon_version.txt")
    ret
sia_api_daemon_version ENDP


;### Gateway ###

;------------------------------------------------------------------------------
; Fetch gateway JSON data: 
; https://sia.tech/docs/#gateway
; if lpszQueryStringParameters == NULL then GET, otherwise POST
;------------------------------------------------------------------------------
sia_api_gateway PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    .IF lpszQueryStringParameters == NULL ; GET
        Invoke SIA_API_GET, Addr SIA_API_URL_GATEWAY, lpdwcJSONObject, CTEXT(".\sia_api_gateway.txt")
    .ELSE ; POST
        Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_GATEWAY, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    .ENDIF
    ret
sia_api_gateway ENDP

;------------------------------------------------------------------------------
; Connects the gateway to a peer: 
; https://sia.tech/docs/#gateway-connect-netaddress-post
;------------------------------------------------------------------------------
sia_api_gateway_connect PROC lpszPathParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_GATEWAY_CONNECT, lpszPathParameters, NULL, NULL, NULL, TRUE
    ret
sia_api_gateway_connect ENDP

;------------------------------------------------------------------------------
; Disconnects the gateway from a peer: 
; https://sia.tech/docs/#gateway-disconnect-netaddress-post
;------------------------------------------------------------------------------
sia_api_gateway_disconnect PROC lpszPathParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_GATEWAY_DISCONNECT, lpszPathParameters, NULL, NULL, NULL, TRUE
    ret
sia_api_gateway_disconnect ENDP


;### Host ###

;------------------------------------------------------------------------------
; Fetch Host JSON data: 
; https://sia.tech/docs/#host-get
; if lpszQueryStringParameters == NULL then GET otherwise POST
;------------------------------------------------------------------------------
sia_api_host PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    .IF lpszQueryStringParameters == NULL ; GET
        Invoke SIA_API_GET, Addr SIA_API_URL_HOST, lpdwcJSONObject, CTEXT(".\sia_api_host.txt")
    .ELSE ; POST
        Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_HOST, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    .ENDIF
    ret
sia_api_host ENDP

;------------------------------------------------------------------------------
; Announce the host to the network as a source of storage: 
; https://sia.tech/docs/#host-announce-post
;------------------------------------------------------------------------------
sia_api_host_announce PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_HOST_ANNOUNCE, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_host_announce ENDP

;------------------------------------------------------------------------------
; Fetch Host Contracts JSON data: 
; https://sia.tech/docs/#host-contracts-get
;------------------------------------------------------------------------------
sia_api_host_contracts PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_HOST_CONTRACTS, lpdwcJSONObject, CTEXT(".\sia_api_host_contracts.txt")
    ret
sia_api_host_contracts ENDP

;------------------------------------------------------------------------------
; Fetch Host Estimate Score JSON data: 
; https://sia.tech/docs/#host-estimatescore-get
;------------------------------------------------------------------------------
sia_api_host_estimatescore PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_HOST_ESTIMATESCORE, lpdwcJSONObject, CTEXT(".\sia_api_host_estimatescore.txt")
    ret
sia_api_host_estimatescore ENDP

;------------------------------------------------------------------------------
; Fetch Host Storage JSON data: 
; https://sia.tech/docs/#host-storage-get
;------------------------------------------------------------------------------
sia_api_host_storage PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_HOST_STORAGE, lpdwcJSONObject, CTEXT(".\sia_api_host_storage.txt")
    ret
sia_api_host_storage ENDP

;------------------------------------------------------------------------------
; Adds a storage folder to the manager:
; https://sia.tech/docs/#host-storage-folders-add-post
;------------------------------------------------------------------------------
sia_api_host_storage_folders_add PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_HOST_STORAGE_FOLDERS_ADD, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_host_storage_folders_add ENDP

;------------------------------------------------------------------------------
; Remove a storage folder from the manager:
; https://sia.tech/docs/#host-storage-folders-remove-post
;------------------------------------------------------------------------------
sia_api_host_storage_folders_remove PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_HOST_STORAGE_FOLDERS_REMOVE, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_host_storage_folders_remove ENDP

;------------------------------------------------------------------------------
; Grows or shrinks a storage file in the manager:
; https://sia.tech/docs/#host-storage-folders-resize-post
;------------------------------------------------------------------------------
sia_api_host_storage_folders_resize PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_HOST_STORAGE_FOLDERS_RESIZE, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_host_storage_folders_resize ENDP

;------------------------------------------------------------------------------
; Deletes a sector:
; https://sia.tech/docs/#host-storage-sectors-delete-merkleroot-post
;------------------------------------------------------------------------------
sia_api_host_storage_sectors_delete PROC lpszPathParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_HOST_STORAGE_SECTORS_DELETE, lpszPathParameters, NULL, NULL, NULL, TRUE
    ret
sia_api_host_storage_sectors_delete ENDP


;### HostDB ###

;------------------------------------------------------------------------------
; Fetch general hostdb information JSON data: 
; https://sia.tech/docs/#hostdb-get
;------------------------------------------------------------------------------
sia_api_hostdb PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_HOSTDB, lpdwcJSONObject, CTEXT(".\sia_api_hostdb.txt")
    ret
sia_api_hostdb ENDP

;------------------------------------------------------------------------------
; Fetch active hosts JSON data: 
; https://sia.tech/docs/#hostdb-active-get
;------------------------------------------------------------------------------
sia_api_hostdb_active PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_HOSTDB_ACTIVE, NULL, lpszQueryStringParameters, lpdwcJSONObject, CTEXT(".\sia_api_hostdb_active.txt")
    ret
sia_api_hostdb_active ENDP

;------------------------------------------------------------------------------
; Fetch all hosts JSON data: 
; https://sia.tech/docs/#hostdb-all-get
;------------------------------------------------------------------------------
sia_api_hostdb_all PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_HOSTDB_ALL, lpdwcJSONObject, CTEXT(".\sia_api_hostdb_all.txt")
    ret
sia_api_hostdb_all ENDP

;------------------------------------------------------------------------------
; Fetch detailed information about a particular host JSON data: 
; https://sia.tech/docs/#hostdb-hosts-pubkey-get
;------------------------------------------------------------------------------
sia_api_hostdb_hosts PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_CONSENSUS_BLOCKS, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_hostdb_hosts.txt")
    ret
sia_api_hostdb_hosts ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_hostdb_filtermode PROC

    ret
sia_api_hostdb_filtermode ENDP


;### Miner ###

;------------------------------------------------------------------------------
; Fetch miner status JSON data: 
; https://sia.tech/docs/#miner-get
;------------------------------------------------------------------------------
sia_api_miner PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_MINER, lpdwcJSONObject, CTEXT(".\sia_api_miner.txt")
    ret
sia_api_miner ENDP

;------------------------------------------------------------------------------
; 
; https://sia.tech/docs/#miner-header-get / https://sia.tech/docs/#miner-header-post
;------------------------------------------------------------------------------
sia_api_miner_header PROC lpdwRawBytes:DWORD

    ret
sia_api_miner_header ENDP

;------------------------------------------------------------------------------
; Starts a single threaded CPU miner:
; https://sia.tech/docs/#miner-start-get
;------------------------------------------------------------------------------
sia_api_miner_start PROC
    Invoke SIA_API_GET, Addr SIA_API_URL_MINER_START, NULL, NULL
    ret
sia_api_miner_start ENDP

;------------------------------------------------------------------------------
; Stops the cpu miner:
; https://sia.tech/docs/#miner-stop-get
;------------------------------------------------------------------------------
sia_api_miner_stop PROC
    Invoke SIA_API_GET, Addr SIA_API_URL_MINER_STOP, NULL, NULL
    ret
sia_api_miner_stop ENDP


;### Renter ###

;------------------------------------------------------------------------------
; Fetch or set metrics on the renter's spending JSON data: 
; https://sia.tech/docs/#renter-get / https://sia.tech/docs/#renter-post
; if lpszQueryStringParameters == NULL then GET otherwise POST
;------------------------------------------------------------------------------
sia_api_renter PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    .IF lpszQueryStringParameters == NULL ; GET
        Invoke SIA_API_GET, Addr SIA_API_URL_RENTER, lpdwcJSONObject, CTEXT(".\sia_api_renter.txt")
    .ELSE ; POST
        Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    .ENDIF
    ret
sia_api_renter ENDP

;------------------------------------------------------------------------------
; Cancels a specific contract of the Renter:
; https://sia.tech/docs/#renter-contract-cancel-post
;------------------------------------------------------------------------------
sia_api_renter_contract_cancel PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_CONTRACT_CANCEL, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_contract_cancel ENDP

;------------------------------------------------------------------------------
; Creates a backup of all siafiles in the renter at the specified path
; https://sia.tech/docs/#renter-backup-post
;------------------------------------------------------------------------------
sia_api_renter_backup PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_BACKUP, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_backup ENDP

;------------------------------------------------------------------------------
; Gets renter backups
;------------------------------------------------------------------------------
sia_api_renter_backups PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_RENTER_BACKUPS, lpdwcJSONObject, CTEXT(".\sia_api_renter_backups.txt")
    ret
sia_api_renter_backups ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_renter_backups_create PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_BACKUPS_CREATE, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_backups_create ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_renter_backups_restore PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_BACKUPS_RESTORE, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_backups_restore ENDP

;------------------------------------------------------------------------------
; Fetch renter's contracts JSON data: 
; https://sia.tech/docs/#renter-contracts-get
;------------------------------------------------------------------------------
sia_api_renter_contracts PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    .IF lpszQueryStringParameters == NULL
        Invoke SIA_API_GET, Addr SIA_API_URL_RENTER_CONTRACTS, lpdwcJSONObject, CTEXT(".\sia_api_renter_contracts.txt")
    .ELSE
        Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_RENTER_CONTRACTS, NULL, lpszQueryStringParameters, lpdwcJSONObject, CTEXT(".\sia_api_renter_contracts.txt")
    .ENDIF
    ret
sia_api_renter_contracts ENDP

;------------------------------------------------------------------------------
; Deletes a renter file entry
; https://sia.tech/docs/#renter-delete-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_delete PROC lpszPathParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_DELETE, lpszPathParameters, NULL, NULL, NULL, TRUE
    ret
sia_api_renter_delete ENDP

;------------------------------------------------------------------------------
; Retrieves or performs various functions on the contents of a directory on the
; sia network JSON data: 
; https://sia.tech/docs/#renter-dir-siapath-get / https://sia.tech/docs/#renter-dir-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_dir PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD
    .IF lpszQueryStringParameters == NULL ; GET
        Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_RENTER_DIR, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_renter_dir.txt")
    .ELSE ; POST
        Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_DIR, lpszPathParameters, lpszQueryStringParameters, NULL, NULL, TRUE
    .ENDIF
    ret
sia_api_renter_dir ENDP

;------------------------------------------------------------------------------
; Downloads a file to the local filesystem. This call blocks until the data is 
; received: 
; https://sia.tech/docs/#renter-download-siapath-get
;------------------------------------------------------------------------------
sia_api_renter_download PROC lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_RENTER_DOWNLOAD, NULL, lpszQueryStringParameters, NULL, NULL
    ret
sia_api_renter_download ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_renter_download_cancel PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_DOWNLOAD_CANCEL, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_download_cancel ENDP

;------------------------------------------------------------------------------
; Lists all files in the download queue JSON data: 
; https://sia.tech/docs/#renter-downloads-get
;------------------------------------------------------------------------------
sia_api_renter_downloads PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_RENTER_DOWNLOADS, lpdwcJSONObject, CTEXT(".\sia_api_renter_downloads.txt")
    ret
sia_api_renter_downloads ENDP

;------------------------------------------------------------------------------
; Clears the download history of the renter for a range of unix time stamps
; https://sia.tech/docs/#renter-downloads-clear-post
;------------------------------------------------------------------------------
sia_api_renter_downloads_clear PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_DOWNLOADS_CLEAR, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_downloads_clear ENDP

;------------------------------------------------------------------------------
; Downloads a file to the local filesystem. The call will return immediately:
; https://sia.tech/docs/#renter-downloadsync-siapath-get
;------------------------------------------------------------------------------
sia_api_renter_downloadsync PROC lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_RENTER_DOWNLOADSYNC, lpszPathParameters, lpszQueryStringParameters, NULL, NULL
    ret
sia_api_renter_downloadsync ENDP

;------------------------------------------------------------------------------
; Dndpoint for changing file metadata:
; https://sia.tech/docs/#renter-file-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_file PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD
    .IF lpszQueryStringParameters == NULL ; GET
        Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_RENTER_FILE, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_renter_file.txt")
    .ELSE ; POST
        Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_DOWNLOADS_CLEAR, lpszPathParameters, lpszQueryStringParameters, NULL, NULL, TRUE
    .ENDIF
    ret
sia_api_renter_file ENDP
;------------------------------------------------------------------------------
; Lists the status of all files JSON data: 
; https://sia.tech/docs/#renter-files-get
;------------------------------------------------------------------------------
sia_api_renter_files PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_RENTER_FILES, lpdwcJSONObject, CTEXT(".\sia_api_renter_files.txt")
    ret
sia_api_renter_files ENDP

;------------------------------------------------------------------------------
; Lists the estimated prices of performing various storage and data operations:
; https://sia.tech/docs/#renter-prices-get
;------------------------------------------------------------------------------
sia_api_renter_prices PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    .IF lpszQueryStringParameters == NULL
        Invoke SIA_API_GET, Addr SIA_API_URL_RENTER_PRICES, lpdwcJSONObject, CTEXT(".\sia_api_renter_prices.txt")
    .ELSE
        Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_RENTER_PRICES, NULL, lpszQueryStringParameters, lpdwcJSONObject, CTEXT(".\sia_api_renter_prices.txt")
    .ENDIF
    ret
sia_api_renter_prices ENDP

;------------------------------------------------------------------------------
; Recovers an existing backup from the specified path:
; https://sia.tech/docs/#renter-recoverbackup-post
;------------------------------------------------------------------------------
sia_api_renter_recoverbackup PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_RECOVERBACKUP, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_recoverbackup ENDP

;------------------------------------------------------------------------------
; Returns some information about a potentially ongoing recovery scan
; https://sia.tech/docs/#renter-recoveryscan-get / https://sia.tech/docs/#renter-recoveryscan-post
; if lpdwcJSONObject == NULL then GET otherwise POST
;------------------------------------------------------------------------------
sia_api_renter_recoveryscan PROC lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject == NULL ; POST
        Invoke SIA_API_POST, Addr SIA_API_URL_RENTER_RECOVERYSCAN, TRUE
    .ELSE ; GET
        Invoke SIA_API_GET, Addr SIA_API_URL_RENTER_RECOVERYSCAN, lpdwcJSONObject, CTEXT(".\sia_api_renter_recoveryscan.txt")
    .ENDIF
    ret
sia_api_renter_recoveryscan ENDP

;------------------------------------------------------------------------------
; Rename
; https://sia.tech/docs/#renter-rename-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_rename PROC lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_RENAME, lpszPathParameters, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_rename ENDP

;------------------------------------------------------------------------------
; Downloads a file using http streaming. This call blocks until the data is 
; received: 
; https://sia.tech/docs/#renter-stream-siapath-get
;------------------------------------------------------------------------------
sia_api_renter_stream PROC lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_RENTER_STREAM, lpszPathParameters, NULL, NULL, NULL
    ret
sia_api_renter_stream ENDP

;------------------------------------------------------------------------------
; uploads a file to the network from the local filesystem:
; https://sia.tech/docs/#renter-upload-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_upload PROC lpszPathParameters:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_RENTER_RENAME, lpszPathParameters, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_renter_upload ENDP


;### Transaction Pool ###

;------------------------------------------------------------------------------
; Returns whether the requested transaction has been seen on the blockchain:
; https://sia.tech/docs/#tpool-confirmed-id-get
;------------------------------------------------------------------------------
sia_api_tpool_confirmed PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_TPOOL_CONFIRMED, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_tpool_confirmed.txt")
    ret
sia_api_tpool_confirmed ENDP

;------------------------------------------------------------------------------
; Returns the minimum and maximum estimated fees expected by the transaction 
; pool: https://sia.tech/docs/#tpool-fee-get
;------------------------------------------------------------------------------
sia_api_tpool_fee PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_TPOOL_FEE, lpdwcJSONObject, CTEXT(".\sia_api_tpool_fee.txt")
    ret
sia_api_tpool_fee ENDP

;------------------------------------------------------------------------------
; Submits a raw transaction to the transaction pool, broadcasting it to the transaction pool's peers
; https://sia.tech/docs/#tpool-raw-post
;------------------------------------------------------------------------------
sia_api_tpool_raw PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_TPOOL_RAW, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_tpool_raw ENDP

;------------------------------------------------------------------------------
; Returns the ID for the requested transaction and its raw encoded parents and
; transaction data: 
; https://sia.tech/docs/#tpool-raw-id-get
;------------------------------------------------------------------------------
sia_api_tpool_raw_id PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_TPOOL_RAW_ID, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_tpool_raw_id.txt")
    ret
sia_api_tpool_raw_id ENDP


;### Wallter ###

;------------------------------------------------------------------------------
; Returns basic information about the wallet: 
; https://sia.tech/docs/#wallet-get
;------------------------------------------------------------------------------
sia_api_wallet PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_WALLET, lpdwcJSONObject, CTEXT(".\sia_api_wallet.txt")
    ret
sia_api_wallet ENDP

;------------------------------------------------------------------------------
; Loads a v0.3.3.x wallet into the current wallet, harvesting all of the secret keys
; https://sia.tech/docs/#wallet-033x-post
;------------------------------------------------------------------------------
sia_api_wallet_033x PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_WALLET_033X, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_wallet_033x ENDP

;------------------------------------------------------------------------------
; Gets a new address from the wallet generated by the primary seed:
; https://sia.tech/docs/#wallet-address-get
;------------------------------------------------------------------------------
sia_api_wallet_address PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_WALLET_ADDRESS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_address.txt")
    ret
sia_api_wallet_address ENDP

;------------------------------------------------------------------------------
; Fetches the list of addresses from the wallet: 
; https://sia.tech/docs/#wallet-addresses-get
;------------------------------------------------------------------------------
sia_api_wallet_addresses PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_WALLET_ADDRESSES, lpdwcJSONObject, CTEXT(".\sia_api_wallet_addresses.txt")
    ret
sia_api_wallet_addresses ENDP

;------------------------------------------------------------------------------
; Creates a backup of the wallet settings file:
; https://sia.tech/docs/#wallet-backup-get
;------------------------------------------------------------------------------
sia_api_wallet_backup PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_BACKUP, NULL, lpszQueryStringParameters, NULL, NULL
    ret
sia_api_wallet_backup ENDP

;------------------------------------------------------------------------------
; Changes the wallet's encryption key
; https://sia.tech/docs/#wallet-changepassword-post
;------------------------------------------------------------------------------
sia_api_wallet_changepassword PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_WALLET_CHANGEPASSWORD, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_wallet_changepassword ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_init PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
 ; need api post param with json respone api
    ret
sia_api_wallet_init ENDP

;------------------------------------------------------------------------------
; Initializes the wallet using a preexisting seed.
; https://sia.tech/docs/#wallet-init-seed-post
;------------------------------------------------------------------------------
sia_api_wallet_init_seed PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_WALLET_INIT_SEED, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_wallet_init_seed ENDP

;------------------------------------------------------------------------------
; Locks the wallet, wiping all secret keys
; https://sia.tech/docs/#wallet-lock-post
;------------------------------------------------------------------------------
sia_api_wallet_lock PROC
    Invoke SIA_API_POST, Addr SIA_API_URL_WALLET_LOCK, TRUE
    ret
sia_api_wallet_lock ENDP

;------------------------------------------------------------------------------
; Gives the wallet a seed to track when looking for incoming transactions
; https://sia.tech/docs/#wallet-seed-post
;------------------------------------------------------------------------------
sia_api_wallet_seed PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_WALLET_SEED, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_wallet_seed ENDP

;------------------------------------------------------------------------------
; Fetches addresses generated by the wallet in reverse order
; https://sia.tech/docs/#wallet-seedaddrs-get
;------------------------------------------------------------------------------
sia_api_wallet_seedaddrs PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_SEEDADDRS, NULL, lpszQueryStringParameters, lpdwcJSONObject, CTEXT(".\sia_api_wallet_seedaddrs.txt")
    ret
sia_api_wallet_seedaddrs ENDP

;------------------------------------------------------------------------------
; Returns the list of seeds in use by the wallet:
; https://sia.tech/docs/#wallet-seeds-get
;------------------------------------------------------------------------------
sia_api_wallet_seeds PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_SEEDS, NULL, lpszQueryStringParameters, lpdwcJSONObject, CTEXT(".\sia_api_wallet_seeds.txt")
    ret
sia_api_wallet_seeds ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_siacoins PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
 ; need api post param with json respone api
    ret
sia_api_wallet_siacoins ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_siafunds PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
 ; need api post param with json respone api
    ret
sia_api_wallet_siafunds ENDP

;------------------------------------------------------------------------------
; Loads a key into the wallet that was generated by siag
; https://sia.tech/docs/#wallet-siagkey-post
;------------------------------------------------------------------------------
sia_api_wallet_siagkey PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_WALLET_SIAGKEY, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_wallet_siagkey ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_sign PROC
 ; need api post param with data body and json respone api
    ret
sia_api_wallet_sign ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_sweep_seed PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
 ; need api post param with json respone api
    ret
sia_api_wallet_sweep_seed ENDP

;------------------------------------------------------------------------------
; Gets the transaction associated with a specific transaction id.
; https://sia.tech/docs/#wallet-transaction-id-get
;------------------------------------------------------------------------------
sia_api_wallet_transaction PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_TRANSACTION, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_wallet_transaction.txt")
    ret
sia_api_wallet_transaction ENDP

;------------------------------------------------------------------------------
; Returns a list of transactions related to the wallet in chronological order:
; https://sia.tech/docs/#wallet-transactions-get
;------------------------------------------------------------------------------
sia_api_wallet_transactions PROC lpdwcJSONObject:DWORD, lpszQueryStringParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_TRANSACTIONS, NULL, lpszQueryStringParameters, lpdwcJSONObject, CTEXT(".\sia_api_wallet_transactions.txt")
    ret
sia_api_wallet_transactions ENDP

;------------------------------------------------------------------------------
; Returns all of the transactions related to a specific address:
; https://sia.tech/docs/#wallet-transactions-addr-get
;------------------------------------------------------------------------------
sia_api_wallet_transactions_address PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_TRANSACTIONS, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_wallet_transactions_address.txt")
    ret
sia_api_wallet_transactions_address ENDP

;------------------------------------------------------------------------------
; Unlocks the wallet. The wallet is capable of knowing whether the correct password was provided
; https://sia.tech/docs/#wallet-unlock-post
;------------------------------------------------------------------------------
sia_api_wallet_unlock PROC lpszQueryStringParameters:DWORD
    Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_WALLET_UNLOCK, NULL, lpszQueryStringParameters, NULL, NULL, TRUE
    ret
sia_api_wallet_unlock ENDP

;------------------------------------------------------------------------------
; Returns the unlock conditions of :addr, if they are known to the wallet:
; https://sia.tech/docs/#wallet-unlockconditions-addr-get
;------------------------------------------------------------------------------
sia_api_wallet_unlockconditions PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_UNLOCKCONDITIONS, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_wallet_unlockconditions.txt")
    ret
sia_api_wallet_unlockconditions ENDP

;------------------------------------------------------------------------------
; Returns a list of outputs that the wallet can spend:
; https://sia.tech/docs/#wallet-unspent-get
;------------------------------------------------------------------------------
sia_api_wallet_unspent PROC lpdwcJSONObject:DWORD
    Invoke SIA_API_GET, Addr SIA_API_URL_WALLET_UNSPENT, lpdwcJSONObject, CTEXT(".\sia_api_wallet_unspent.txt")
    ret
sia_api_wallet_unspent ENDP

;------------------------------------------------------------------------------
; Takes the address specified by address and returns a JSON response indicating
; if the address is valid:
; https://sia.tech/docs/#wallet-verify-address-addr-get
;------------------------------------------------------------------------------
sia_api_wallet_verify_address PROC lpdwcJSONObject:DWORD, lpszPathParameters:DWORD
    Invoke SIA_API_GET_PARAM, Addr SIA_API_URL_WALLET_VERIFY_ADDRESS, lpszPathParameters, NULL, lpdwcJSONObject, CTEXT(".\sia_api_wallet_verify_address.txt")
    ret
sia_api_wallet_verify_address ENDP

;------------------------------------------------------------------------------
; Returns the set of addresses that the wallet is watching
; https://sia.tech/docs/#wallet-watch-get / https://sia.tech/docs/#wallet-watch-post
; if lpRequestBody == NULL then GET otherwise POST (lpdwcJSONObject == NULL)
;------------------------------------------------------------------------------
sia_api_wallet_watch PROC lpdwcJSONObject:DWORD, lpRequestBody:DWORD, dwSizeRequestBody:DWORD
    .IF lpdwcJSONObject != NULL
        Invoke SIA_API_GET, Addr SIA_API_URL_WALLET_WATCH, lpdwcJSONObject, CTEXT(".\sia_api_wallet_watch.txt")
    .ELSE
        Invoke SIA_API_POST_PARAM, Addr SIA_API_URL_WALLET_WATCH, NULL, NULL, lpRequestBody, dwSizeRequestBody, TRUE
    .ENDIF
    ret
sia_api_wallet_watch ENDP


;==============================================================================
; sia_api_* Other utility functions - calls to Net* and/or SIA_API_* functions
;==============================================================================

;------------------------------------------------------------------------------
; sia_api_url_values
;------------------------------------------------------------------------------
sia_api_url_values PROC lpszUrlQuery:DWORD, lpszName:DWORD, lpszValue:DWORD, dwValue:DWORD
    Invoke NetUrlValues, lpszUrlQuery, lpszName, lpszValue, dwValue
    ret
sia_api_url_values ENDP





