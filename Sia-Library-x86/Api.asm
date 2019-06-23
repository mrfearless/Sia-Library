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

;------------------------------------------------------------------------------
; Sia RPC GET/POST Functions (For Internal Use):
;------------------------------------------------------------------------------
SIA_RPC_GET                     PROTO :DWORD,:DWORD,:DWORD,:DWORD               ; hSia,lpszSiaApiUrl,lpdwcJSONObject,lpszSiaApiJsonToFile
SIA_RPC_POST                    PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD ; hSia,lpszSiaApiUrl,lpSendData,dwSendDataSize,lpdwcJSONObject,lpszSiaApiJsonToFile


;------------------------------------------------------------------------------
; Sia API Endpoint Functions (For Internal Use):
;------------------------------------------------------------------------------
sia_api_consensus               PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_consensus_blocks        PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_consensus_validate_transactionset PROTO :DWORD,:DWORD                   ; hSia, lpszJsonTextTxnSet

sia_api_daemon_constants        PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_daemon_settings         PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_daemon_stop             PROTO :DWORD                                    ; hSia
sia_api_daemon_update           PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_daemon_version          PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject

sia_api_gateway                 PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_gateway_connect         PROTO :DWORD,:DWORD                             ; hSia, lpszNetAddress
sia_api_gateway_disconnect      PROTO :DWORD,:DWORD                             ; hSia, lpszNetAddress

sia_api_host                    PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_host_announce           PROTO :DWORD                                    ; hSia
sia_api_host_contracts          PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_host_estimatescore      PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_host_storage            PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_host_storage_folders_add PROTO :DWORD                                   ; hSia
sia_api_host_storage_folders_remove PROTO :DWORD                                ; hSia
sia_api_host_storage_folders_resize PROTO :DWORD                                ; hSia
sia_api_host_storage_sectors_delete PROTO :DWORD,:DWORD                         ; hSia, lpszMerkleroot

sia_api_hostdb                  PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_hostdb_active           PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_hostdb_all              PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_hostdb_filtermode       PROTO :DWORD,:DWORD,:DWORD                      ; hSia, lpdwcJSONObject, lpszJsonTextFiltermodeHosts
sia_api_hostdb_hosts            PROTO :DWORD,:DWORD,:DWORD                      ; hSia, lpdwcJSONObject, lpszPubkey

sia_api_miner                   PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_miner_header            PROTO :DWORD,:DWORD,:DWORD                      ; hSia, lpdwcJSONObject, lpBlockHeader
sia_api_miner_start             PROTO :DWORD                                    ; hSia
sia_api_miner_stop              PROTO :DWORD                                    ; hSia

sia_api_renter                  PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_backup           PROTO :DWORD                                    ; hSia
sia_api_renter_backups          PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_backups_create   PROTO :DWORD                                    ; hSia
sia_api_renter_backups_restore  PROTO :DWORD                                    ; hSia
sia_api_renter_contract_cancel  PROTO :DWORD                                    ; hSia
sia_api_renter_contracts        PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_delete           PROTO :DWORD                                    ; hSia
sia_api_renter_dir              PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_download         PROTO :DWORD                                    ; hSia
sia_api_renter_download_cancel  PROTO :DWORD                                    ; hSia
sia_api_renter_downloads        PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_downloads_clear  PROTO :DWORD                                    ; hSia
sia_api_renter_downloadsync     PROTO :DWORD                                    ; hSia
sia_api_renter_file             PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_files            PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_prices           PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_recoverbackup    PROTO :DWORD                                    ; hSia
sia_api_renter_recoveryscan     PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_renter_rename           PROTO :DWORD                                    ; hSia
sia_api_renter_stream           PROTO :DWORD                                    ; hSia
sia_api_renter_upload           PROTO :DWORD                                    ; hSia
sia_api_renter_uploadstream     PROTO :DWORD,:DWORD,:DWORD                      ; hSia, pStream, dwStreamSize

sia_api_tpool_confirmed         PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_tpool_fee               PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_tpool_raw               PROTO :DWORD                                    ; hSia
sia_api_tpool_raw_id            PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject

sia_api_wallet                  PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_033x             PROTO :DWORD                                    ; hSia
sia_api_wallet_address          PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_addresses        PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_backup           PROTO :DWORD                                    ; hSia
sia_api_wallet_changepassword   PROTO :DWORD                                    ; hSia
sia_api_wallet_init             PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_init_seed        PROTO :DWORD                                    ; hSia
sia_api_wallet_lock             PROTO :DWORD                                    ; hSia
sia_api_wallet_seed             PROTO :DWORD                                    ; hSia
sia_api_wallet_seedaddrs        PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_seeds            PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_siacoins         PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_siafunds         PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_siagkey          PROTO :DWORD                                    ; hSia
sia_api_wallet_sign             PROTO :DWORD                                    ; hSia
sia_api_wallet_sweep_seed       PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_transaction      PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_transactions     PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_transactions_address PROTO :DWORD,:DWORD                         ; hSia, lpdwcJSONObject
sia_api_wallet_unlock           PROTO :DWORD                                    ; hSia
sia_api_wallet_unlockconditions PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_unspent          PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_verify_address   PROTO :DWORD,:DWORD                             ; hSia, lpdwcJSONObject
sia_api_wallet_watch            PROTO :DWORD,:DWORD,:DWORD,:DWORD               ; hSia, lpdwcJSONObject, lpRequestBody, dwSizeRequestBody

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
SIA_API_URL_RENTER_DOWNLOAD_CANCEL              DB "/renter/download/cancel",0              ; <id> POST
SIA_API_URL_RENTER_DOWNLOADSYNC                 DB "/renter/downloadsync/",0                ; <siapath> GET
SIA_API_URL_RENTER_RECOVERYSCAN                 DB "/renter/recoveryscan",0                 ; GET, POST
SIA_API_URL_RENTER_RENAME                       DB "/renter/rename/",0                      ; <siapath> GET, POST
SIA_API_URL_RENTER_STREAM                       DB "/renter/stream/",0                      ; <siapath> GET
SIA_API_URL_RENTER_UPLOAD                       DB "/renter/upload/",0                      ; <siapath> POST
SIA_API_URL_RENTER_UPLOADSTREAM                 DB "/renter/uploadstream/",0                ; <siapath> POST

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

SIA_API_URL                                     DB 4096 DUP (0)                             ; Used to construct a Sia API URL
SiaApiUrlValues                                 DB 2048 DUP (0)                             ; Used to store url name=value strings

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
; SIA_RPC_GET
;------------------------------------------------------------------------------
SIA_RPC_GET PROC USES EBX hSia:DWORD, lpszSiaApiUrl:DWORD, lpdwcJSONObject:DWORD, lpszSiaApiJsonToFile:DWORD 
    LOCAL pJsonDataBuffer:DWORD
    LOCAL dwDataBufferSize:DWORD
    
    Invoke RpcEndpointCall, hSia, RPC_GET, lpszSiaApiUrl, NULL, NULL, Addr pJsonDataBuffer, Addr dwDataBufferSize, lpszSiaApiJsonToFile
    .IF eax == TRUE
        .IF lpdwcJSONObject != NULL
            ; Parse JSON data returned
            Invoke cJSON_Parse, pJsonDataBuffer
            .IF eax == NULL ; cleanup and exit
                mov ebx, lpdwcJSONObject
                mov eax, 0
                mov [ebx], eax
                Invoke RpcEndpointFreeData, Addr pJsonDataBuffer
                xor eax, eax    
                ret
            .ENDIF
            
            ; Return pointer to cJSON object via lpdwcJSONObject parameter 
            mov ebx, lpdwcJSONObject
            mov [ebx], eax
            
            ; Free Read Data
            Invoke RpcEndpointFreeData, Addr pJsonDataBuffer
            mov eax, TRUE
        .ENDIF
    .ENDIF
    ret
SIA_RPC_GET ENDP

;------------------------------------------------------------------------------
; SIA_RPC_POST
;------------------------------------------------------------------------------
SIA_RPC_POST PROC USES EBX hSia:DWORD, lpszSiaApiUrl:DWORD, lpSendData:DWORD, dwSendDataSize:DWORD, lpdwcJSONObject:DWORD, lpszSiaApiJsonToFile:DWORD
    LOCAL pJsonDataBuffer:DWORD
    LOCAL dwDataBufferSize:DWORD
    
    Invoke RpcSetContentType, hSia, NULL, RPC_MEDIATYPE_FORM
    
    Invoke RpcEndpointCall, hSia, RPC_POST, lpszSiaApiUrl, lpSendData, dwSendDataSize, Addr pJsonDataBuffer, Addr dwDataBufferSize, lpszSiaApiJsonToFile
    .IF eax == TRUE
        .IF lpdwcJSONObject != NULL
            ; Parse JSON data returned
            Invoke cJSON_Parse, pJsonDataBuffer
            .IF eax == NULL ; cleanup and exit
                mov ebx, lpdwcJSONObject
                mov eax, 0
                mov [ebx], eax
                Invoke RpcEndpointFreeData, Addr pJsonDataBuffer
                xor eax, eax    
                ret
            .ENDIF
            
            ; Return pointer to cJSON object via lpdwcJSONObject parameter 
            mov ebx, lpdwcJSONObject
            mov [ebx], eax
            
            ; Free Read Data
            Invoke RpcEndpointFreeData, Addr pJsonDataBuffer
            mov eax, TRUE
        .ENDIF
    .ENDIF
    ret
SIA_RPC_POST ENDP


;==============================================================================
; sia_api_* functions - calls to SIA_API_* functions
;==============================================================================

;### Consensus ###

;------------------------------------------------------------------------------
; [GET] Fetches consensus JSON data: 
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#consensus-get
;------------------------------------------------------------------------------
sia_api_consensus PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_CONSENSUS, lpdwcJSONObject, CTEXT(".\sia_api_consensus.txt")
    ret
sia_api_consensus ENDP

;------------------------------------------------------------------------------
; [GET] Fetches consensus blocks JSON data: 
; [REQ] Query: id, height
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#consensusblocks-get
;------------------------------------------------------------------------------
sia_api_consensus_blocks PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_CONSENSUS_BLOCKS, lpdwcJSONObject, CTEXT(".\sia_api_consensus_blocks.txt")
    ret
sia_api_consensus_blocks ENDP

;------------------------------------------------------------------------------
; [GET] Validates a set of transactions using the current utxo set.
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#consensusvalidatetransactionset-post
;------------------------------------------------------------------------------
sia_api_consensus_validate_transactionset PROC hSia:DWORD, lpszJsonTextTxnSet:DWORD
    .IF lpszJsonTextTxnSet == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_CONSENSUS_VALIDATE_TRANSACTIONSET, lpszJsonTextTxnSet, -1, NULL, NULL
    ret
sia_api_consensus_validate_transactionset ENDP


;### Daemon ###

;------------------------------------------------------------------------------
; [GET] Fetches daemon constants JSON data: 
;
; https://github.com/NebulousLabs/Sia/blob/master/doc/api/Daemon.md#daemonconstants-get
;------------------------------------------------------------------------------
sia_api_daemon_constants PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_DAEMON_CONSTANTS, lpdwcJSONObject, CTEXT(".\sia_api_daemon_constants.txt")
    ret
sia_api_daemon_constants ENDP

;------------------------------------------------------------------------------
; [GET|POST] Fetches or sets daemon settings JSON data: 
; [OPT POST] Query: maxdownloadspeed, maxuploadspeed 
; If lpdwcJSONObject != NULL then GET otherwise POST
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#daemonsettings-get
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#daemonsettings-post
;------------------------------------------------------------------------------
sia_api_daemon_settings PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL 
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_DAEMON_SETTINGS, lpdwcJSONObject, CTEXT(".\sia_api_daemon_constants.txt")
    .ELSE
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_DAEMON_SETTINGS, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_daemon_settings ENDP

;------------------------------------------------------------------------------
; [GET] Stops SIA daemon
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#daemonstop-get
;------------------------------------------------------------------------------
sia_api_daemon_stop PROC hSia:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_DAEMON_STOP, NULL, NULL
    ret
sia_api_daemon_stop ENDP

;------------------------------------------------------------------------------
; [GET|POST] Fetches daemon update JSON data, or updates daemon to latest version: 
; If lpdwcJSONObject != NULL then GET otherwise POST
; 
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#daemonupdate-get
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#daemonupdate-post
;------------------------------------------------------------------------------
sia_api_daemon_update PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_DAEMON_UPDATE, lpdwcJSONObject, CTEXT(".\sia_api_daemon_version.txt")
    .ELSE
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_DAEMON_UPDATE, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_daemon_update ENDP

;------------------------------------------------------------------------------
; [GET] Fetches daemon version JSON data: 
;
; https://sia.tech/docs/#daemon-version-get
;------------------------------------------------------------------------------
sia_api_daemon_version PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_DAEMON_VERSION, lpdwcJSONObject, CTEXT(".\sia_api_daemon_version.txt")
    ret
sia_api_daemon_version ENDP


;### Gateway ###

;------------------------------------------------------------------------------
; [GET|POST] Fetch gateway JSON data, or sets gateway data: 
; [OPT POST] Query: maxdownloadspeed, maxuploadspeed 
; If lpdwcJSONObject != NULL then GET otherwise POST
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#gateway-get
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#gateway-post
;------------------------------------------------------------------------------
sia_api_gateway PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL ; GET
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_GATEWAY, lpdwcJSONObject, CTEXT(".\sia_api_gateway.txt")
    .ELSE ; POST
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_GATEWAY, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_gateway ENDP

;------------------------------------------------------------------------------
; [POST] Connects the gateway to a peer: 
; [REQ] Path: :netaddress
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#gatewayconnectnetaddress-post
;------------------------------------------------------------------------------
sia_api_gateway_connect PROC hSia:DWORD, lpszNetAddress:DWORD
    .IF lpszNetAddress == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetPathVariable, hSia, lpszNetAddress
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_GATEWAY_CONNECT, NULL, NULL, NULL, NULL
    ret
sia_api_gateway_connect ENDP

;------------------------------------------------------------------------------
; [POST] Disconnects the gateway from a peer: 
; [REQ] Path: netaddress
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#gatewaydisconnectnetaddress-post
;------------------------------------------------------------------------------
sia_api_gateway_disconnect PROC hSia:DWORD, lpszNetAddress:DWORD
    .IF lpszNetAddress == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetPathVariable, hSia, lpszNetAddress
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_GATEWAY_DISCONNECT, NULL, NULL, NULL, NULL
    ret
sia_api_gateway_disconnect ENDP


;### Host ###

;------------------------------------------------------------------------------
; [GET|POST] Fetch Host JSON data or set host data: 
; [OPT POST] Query: acceptingcontracts, maxdownloadbatchsize, maxduration, 
; maxrevisebatchsize, netaddress, windowsize, collateral, collateralbudget, 
; maxcollateral, minbaserpcprice, mincontractprice, minsectoraccessprice, 
; mindownloadbandwidthprice, minstorageprice, minuploadbandwidthprice 
; if lpdwcJSONObject != NULL then GET otherwise POST
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#host-get
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#host-post
;------------------------------------------------------------------------------
sia_api_host PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL ; GET
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOST, lpdwcJSONObject, CTEXT(".\sia_api_host.txt")
    .ELSE ; POST
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_HOST, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_host ENDP

;------------------------------------------------------------------------------
; [POST] Announce the host to the network as a source of storage: 
; [OPT POST] Query: netaddress
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostannounce-post
;------------------------------------------------------------------------------
sia_api_host_announce PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_HOST_ANNOUNCE, NULL, NULL, NULL, NULL
    ret
sia_api_host_announce ENDP

;------------------------------------------------------------------------------
; [GET] Fetch Host Contracts JSON data: 
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostcontracts-get
;------------------------------------------------------------------------------
sia_api_host_contracts PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOST_CONTRACTS, lpdwcJSONObject, CTEXT(".\sia_api_host_contracts.txt")
    ret
sia_api_host_contracts ENDP

;------------------------------------------------------------------------------
; [GET] Fetch Host Estimate Score JSON data:
; [OPT] Query: acceptingcontracts, maxdownloadbatchsize, maxduration, 
; maxrevisebatchsize, netaddress, windowsize, collateral, collateralbudget, 
; maxcollateral, mincontractprice, mindownloadbandwidthprice, minstorageprice, 
; minuploadbandwidthprice
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostestimatescore-get
;------------------------------------------------------------------------------
sia_api_host_estimatescore PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOST_ESTIMATESCORE, lpdwcJSONObject, CTEXT(".\sia_api_host_estimatescore.txt")
    ret
sia_api_host_estimatescore ENDP

;------------------------------------------------------------------------------
; [GET] Fetch Host Storage JSON data: 
; 
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hoststorage-get
;------------------------------------------------------------------------------
sia_api_host_storage PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOST_STORAGE, lpdwcJSONObject, CTEXT(".\sia_api_host_storage.txt")
    ret
sia_api_host_storage ENDP

;------------------------------------------------------------------------------
; [POST] Adds a storage folder to the manager:
; [REQ] Query: path, size
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hoststoragefoldersadd-post
;------------------------------------------------------------------------------
sia_api_host_storage_folders_add PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_HOST_STORAGE_FOLDERS_ADD, NULL, NULL, NULL, NULL
    ret
sia_api_host_storage_folders_add ENDP

;------------------------------------------------------------------------------
; [POST] Remove a storage folder from the manager:
; [REQ] Query: path
; [OPT] Query: force

; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hoststoragefoldersremove-post
;------------------------------------------------------------------------------
sia_api_host_storage_folders_remove PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_HOST_STORAGE_FOLDERS_REMOVE, NULL, NULL, NULL, NULL
    ret
sia_api_host_storage_folders_remove ENDP

;------------------------------------------------------------------------------
; [POST] Grows or shrinks a storage file in the manager:
; [REQ] Query: path, newsize
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hoststoragefoldersresize-post
;------------------------------------------------------------------------------
sia_api_host_storage_folders_resize PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_HOST_STORAGE_FOLDERS_RESIZE, NULL, NULL, NULL, NULL
    ret
sia_api_host_storage_folders_resize ENDP

;------------------------------------------------------------------------------
; [POST] Deletes a sector:
; [REQ] Path: merkleroot
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hoststoragesectorsdeletemerkleroot-post
;------------------------------------------------------------------------------
sia_api_host_storage_sectors_delete PROC hSia:DWORD, lpszMerkleroot:DWORD
    .IF lpszMerkleroot == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetPathVariable, hSia, lpszMerkleroot
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_HOST_STORAGE_SECTORS_DELETE, NULL, NULL, NULL, NULL
    ret
sia_api_host_storage_sectors_delete ENDP


;### HostDB ###

;------------------------------------------------------------------------------
; [GET] Fetch general hostdb information JSON data: 
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostdb-get
;------------------------------------------------------------------------------
sia_api_hostdb PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOSTDB, lpdwcJSONObject, CTEXT(".\sia_api_hostdb.txt")
    ret
sia_api_hostdb ENDP

;------------------------------------------------------------------------------
; [GET] Fetch active hosts JSON data: 
; [OPT] Query: numhosts 
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostdbactive-get
;------------------------------------------------------------------------------
sia_api_hostdb_active PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOSTDB_ACTIVE, lpdwcJSONObject, CTEXT(".\sia_api_hostdb_active.txt")
    ret
sia_api_hostdb_active ENDP

;------------------------------------------------------------------------------
; [GET] Fetch all hosts JSON data: 
;
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostdball-get
;------------------------------------------------------------------------------
sia_api_hostdb_all PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOSTDB_ALL, lpdwcJSONObject, CTEXT(".\sia_api_hostdb_all.txt")
    ret
sia_api_hostdb_all ENDP

;------------------------------------------------------------------------------
; [GET] Fetch detailed information about a particular host JSON data: 
; [REQ] Path: pubkey
; 
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostdbhostspubkey-get
;------------------------------------------------------------------------------
sia_api_hostdb_hosts PROC hSia:DWORD, lpdwcJSONObject:DWORD, lpszPubkey:DWORD
    .IF lpszPubkey == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetPathVariable, hSia, lpszPubkey
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_CONSENSUS_BLOCKS, lpdwcJSONObject, CTEXT(".\sia_api_hostdb_hosts.txt")
    ret
sia_api_hostdb_hosts ENDP

;------------------------------------------------------------------------------
; [GET|POST] Returns or sets the current filter mode of the hostDB and any filtered hosts.
; [REQ POST] Query: filtermode hosts
; Note: lpszJsonTextFiltermodeHosts is a json text buffer with the filtermode 
; and the array of hosts to apply filter to.
; 
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostdbfiltermode-get
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md#hostdbfiltermode-post
;------------------------------------------------------------------------------
sia_api_hostdb_filtermode PROC hSia:DWORD, lpdwcJSONObject:DWORD, lpszJsonTextFiltermodeHosts:DWORD
    .IF lpdwcJSONObject != NULL ; GET
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_HOSTDB_FILTERMODE, lpdwcJSONObject, CTEXT(".\sia_api_host.txt")
    .ELSE ; POST
        .IF lpszJsonTextFiltermodeHosts == NULL
            xor eax, eax
            ret
        .ENDIF
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_HOSTDB_FILTERMODE, lpszJsonTextFiltermodeHosts, -1, NULL, NULL
    .ENDIF
    ret
sia_api_hostdb_filtermode ENDP


;### Miner ###

;------------------------------------------------------------------------------
; Fetch miner status JSON data: 
; https://sia.tech/docs/#miner-get
;------------------------------------------------------------------------------
sia_api_miner PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_MINER, lpdwcJSONObject, CTEXT(".\sia_api_miner.txt")
    ret
sia_api_miner ENDP

;------------------------------------------------------------------------------
; 
; https://sia.tech/docs/#miner-header-get / https://sia.tech/docs/#miner-header-post
;------------------------------------------------------------------------------
sia_api_miner_header PROC hSia:DWORD, lpdwcJSONObject:DWORD, lpBlockHeader:DWORD
    .IF lpdwcJSONObject != NULL
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_MINER_HEADER, lpdwcJSONObject, CTEXT(".\sia_api_miner_header.txt")
    .ELSE
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_MINER_HEADER, lpBlockHeader, SIA_MINER_BLOCKHEADER_SIZE, NULL, NULL
    .ENDIF
    ret
sia_api_miner_header ENDP

;------------------------------------------------------------------------------
; Starts a single threaded CPU miner:
; https://sia.tech/docs/#miner-start-get
;------------------------------------------------------------------------------
sia_api_miner_start PROC hSia:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_MINER_START, NULL, NULL
    ret
sia_api_miner_start ENDP

;------------------------------------------------------------------------------
; Stops the cpu miner:
; https://sia.tech/docs/#miner-stop-get
;------------------------------------------------------------------------------
sia_api_miner_stop PROC hSia:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_MINER_STOP, NULL, NULL
    ret
sia_api_miner_stop ENDP


;### Renter ###

;------------------------------------------------------------------------------
; Fetch or set metrics on the renter's spending JSON data: 
; https://sia.tech/docs/#renter-get / https://sia.tech/docs/#renter-post
; if lpszQueryStringParameters == NULL then GET otherwise POST
;------------------------------------------------------------------------------
sia_api_renter PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL ; GET
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER, lpdwcJSONObject, CTEXT(".\sia_api_renter.txt")
    .ELSE ; POST
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_renter ENDP

;------------------------------------------------------------------------------
; Cancels a specific contract of the Renter:
; https://sia.tech/docs/#renter-contract-cancel-post
;------------------------------------------------------------------------------
sia_api_renter_contract_cancel PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_CONTRACT_CANCEL, NULL, NULL, NULL, NULL
    ret
sia_api_renter_contract_cancel ENDP

;------------------------------------------------------------------------------
; Creates a backup of all siafiles in the renter at the specified path
; https://sia.tech/docs/#renter-backup-post
;------------------------------------------------------------------------------
sia_api_renter_backup PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_BACKUP, NULL, NULL, NULL, NULL
    ret
sia_api_renter_backup ENDP

;------------------------------------------------------------------------------
; Gets renter backups
;------------------------------------------------------------------------------
sia_api_renter_backups PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_BACKUPS, lpdwcJSONObject, CTEXT(".\sia_api_renter_backups.txt")
    ret
sia_api_renter_backups ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_renter_backups_create PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_BACKUPS_CREATE, NULL, NULL, NULL, NULL
    ret
sia_api_renter_backups_create ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_renter_backups_restore PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_BACKUPS_RESTORE, NULL, NULL, NULL, NULL
    ret
sia_api_renter_backups_restore ENDP

;------------------------------------------------------------------------------
; Fetch renter's contracts JSON data: 
; https://sia.tech/docs/#renter-contracts-get
;------------------------------------------------------------------------------
sia_api_renter_contracts PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_CONTRACTS, lpdwcJSONObject, CTEXT(".\sia_api_renter_contracts.txt")
    ret
sia_api_renter_contracts ENDP

;------------------------------------------------------------------------------
; Deletes a renter file entry
; https://sia.tech/docs/#renter-delete-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_delete PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_DELETE, NULL, NULL, NULL, NULL
    ret
sia_api_renter_delete ENDP

;------------------------------------------------------------------------------
; Retrieves or performs various functions on the contents of a directory on the
; sia network JSON data: 
; https://sia.tech/docs/#renter-dir-siapath-get / https://sia.tech/docs/#renter-dir-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_dir PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL ; GET
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_DIR, lpdwcJSONObject, CTEXT(".\sia_api_renter_dir.txt")
    .ELSE ; POST
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_DIR, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_renter_dir ENDP

;------------------------------------------------------------------------------
; Downloads a file to the local filesystem. This call blocks until the data is 
; received: 
; https://sia.tech/docs/#renter-download-siapath-get
;------------------------------------------------------------------------------
sia_api_renter_download PROC hSia:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_DOWNLOAD, NULL, NULL
    ret
sia_api_renter_download ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_renter_download_cancel PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_DOWNLOAD_CANCEL, NULL, NULL, NULL, NULL
    ret
sia_api_renter_download_cancel ENDP

;------------------------------------------------------------------------------
; Lists all files in the download queue JSON data: 
; https://sia.tech/docs/#renter-downloads-get
;------------------------------------------------------------------------------
sia_api_renter_downloads PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_DOWNLOADS, lpdwcJSONObject, CTEXT(".\sia_api_renter_downloads.txt")
    ret
sia_api_renter_downloads ENDP

;------------------------------------------------------------------------------
; Clears the download history of the renter for a range of unix time stamps
; https://sia.tech/docs/#renter-downloads-clear-post
;------------------------------------------------------------------------------
sia_api_renter_downloads_clear PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_DOWNLOADS_CLEAR, NULL, NULL, NULL, NULL
    ret
sia_api_renter_downloads_clear ENDP

;------------------------------------------------------------------------------
; Downloads a file to the local filesystem. The call will return immediately:
; https://sia.tech/docs/#renter-downloadsync-siapath-get
;------------------------------------------------------------------------------
sia_api_renter_downloadsync PROC hSia:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_DOWNLOADSYNC, NULL, NULL
    ret
sia_api_renter_downloadsync ENDP

;------------------------------------------------------------------------------
; Dndpoint for changing file metadata:
; https://sia.tech/docs/#renter-file-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_file PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL ; GET
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_FILE, lpdwcJSONObject, CTEXT(".\sia_api_renter_file.txt")
    .ELSE ; POST
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_FILE, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_renter_file ENDP
;------------------------------------------------------------------------------
; Lists the status of all files JSON data: 
; https://sia.tech/docs/#renter-files-get
;------------------------------------------------------------------------------
sia_api_renter_files PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_FILES, lpdwcJSONObject, CTEXT(".\sia_api_renter_files.txt")
    ret
sia_api_renter_files ENDP

;------------------------------------------------------------------------------
; Lists the estimated prices of performing various storage and data operations:
; https://sia.tech/docs/#renter-prices-get
;------------------------------------------------------------------------------
sia_api_renter_prices PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_PRICES, lpdwcJSONObject, CTEXT(".\sia_api_renter_prices.txt")
    ret
sia_api_renter_prices ENDP

;------------------------------------------------------------------------------
; Recovers an existing backup from the specified path:
; https://sia.tech/docs/#renter-recoverbackup-post
;------------------------------------------------------------------------------
sia_api_renter_recoverbackup PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_RECOVERBACKUP, NULL, NULL, NULL, NULL
    ret
sia_api_renter_recoverbackup ENDP

;------------------------------------------------------------------------------
; Returns some information about a potentially ongoing recovery scan
; https://sia.tech/docs/#renter-recoveryscan-get / https://sia.tech/docs/#renter-recoveryscan-post
; if lpdwcJSONObject != NULL then GET otherwise POST
;------------------------------------------------------------------------------
sia_api_renter_recoveryscan PROC hSia:DWORD, lpdwcJSONObject:DWORD
    .IF lpdwcJSONObject != NULL ; GET
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_RECOVERYSCAN, lpdwcJSONObject, CTEXT(".\sia_api_renter_recoveryscan.txt")
    .ELSE ; POST
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_RECOVERYSCAN, NULL, NULL, NULL, NULL
    .ENDIF
    ret
sia_api_renter_recoveryscan ENDP

;------------------------------------------------------------------------------
; Rename
; https://sia.tech/docs/#renter-rename-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_rename PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_RENAME, NULL, NULL, NULL, NULL
    ret
sia_api_renter_rename ENDP

;------------------------------------------------------------------------------
; Downloads a file using http streaming. This call blocks until the data is 
; received: 
; https://sia.tech/docs/#renter-stream-siapath-get
;------------------------------------------------------------------------------
sia_api_renter_stream PROC hSia:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_STREAM, NULL, NULL 
    ret
sia_api_renter_stream ENDP

;------------------------------------------------------------------------------
; uploads a file to the network from the local filesystem:
; https://sia.tech/docs/#renter-upload-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_upload PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_UPLOAD, NULL, NULL, NULL, NULL
    ret
sia_api_renter_upload ENDP

;------------------------------------------------------------------------------
; uploads a file to the network from the local filesystem:
; https://sia.tech/docs/#renter-upload-siapath-post
;------------------------------------------------------------------------------
sia_api_renter_uploadstream PROC hSia:DWORD, pStream:DWORD, dwStreamSize:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_RENTER_UPLOADSTREAM, pStream, dwStreamSize, NULL, NULL
    ret
sia_api_renter_uploadstream ENDP


;### Transaction Pool ###

;------------------------------------------------------------------------------
; Returns whether the requested transaction has been seen on the blockchain:
; https://sia.tech/docs/#tpool-confirmed-id-get
;------------------------------------------------------------------------------
sia_api_tpool_confirmed PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_TPOOL_CONFIRMED, lpdwcJSONObject, CTEXT(".\sia_api_tpool_confirmed.txt")
    ret
sia_api_tpool_confirmed ENDP

;------------------------------------------------------------------------------
; Returns the minimum and maximum estimated fees expected by the transaction 
; pool: https://sia.tech/docs/#tpool-fee-get
;------------------------------------------------------------------------------
sia_api_tpool_fee PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_TPOOL_FEE, lpdwcJSONObject, CTEXT(".\sia_api_tpool_fee.txt")
    ret
sia_api_tpool_fee ENDP

;------------------------------------------------------------------------------
; Submits a raw transaction to the transaction pool, broadcasting it to the transaction pool's peers
; https://sia.tech/docs/#tpool-raw-post
;------------------------------------------------------------------------------
sia_api_tpool_raw PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_TPOOL_RAW, NULL, NULL, NULL, NULL
    ret
sia_api_tpool_raw ENDP

;------------------------------------------------------------------------------
; Returns the ID for the requested transaction and its raw encoded parents and
; transaction data: 
; https://sia.tech/docs/#tpool-raw-id-get
;------------------------------------------------------------------------------
sia_api_tpool_raw_id PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_TPOOL_RAW_ID, lpdwcJSONObject, CTEXT(".\sia_api_tpool_raw_id.txt")
    ret
sia_api_tpool_raw_id ENDP


;### Wallter ###

;------------------------------------------------------------------------------
; Returns basic information about the wallet: 
; https://sia.tech/docs/#wallet-get
;------------------------------------------------------------------------------
sia_api_wallet PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET, lpdwcJSONObject, CTEXT(".\sia_api_wallet.txt")
    ret
sia_api_wallet ENDP

;------------------------------------------------------------------------------
; Loads a v0.3.3.x wallet into the current wallet, harvesting all of the secret keys
; https://sia.tech/docs/#wallet-033x-post
;------------------------------------------------------------------------------
sia_api_wallet_033x PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_033X, NULL, NULL, NULL, NULL
    ret
sia_api_wallet_033x ENDP

;------------------------------------------------------------------------------
; Gets a new address from the wallet generated by the primary seed:
; https://sia.tech/docs/#wallet-address-get
;------------------------------------------------------------------------------
sia_api_wallet_address PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_ADDRESS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_address.txt")
    ret
sia_api_wallet_address ENDP

;------------------------------------------------------------------------------
; Fetches the list of addresses from the wallet: 
; https://sia.tech/docs/#wallet-addresses-get
;------------------------------------------------------------------------------
sia_api_wallet_addresses PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_ADDRESSES, lpdwcJSONObject, CTEXT(".\sia_api_wallet_addresses.txt")
    ret
sia_api_wallet_addresses ENDP

;------------------------------------------------------------------------------
; Creates a backup of the wallet settings file:
; https://sia.tech/docs/#wallet-backup-get
;------------------------------------------------------------------------------
sia_api_wallet_backup PROC hSia:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_BACKUP, NULL, NULL
    ret
sia_api_wallet_backup ENDP

;------------------------------------------------------------------------------
; Changes the wallet's encryption key
; https://sia.tech/docs/#wallet-changepassword-post
;------------------------------------------------------------------------------
sia_api_wallet_changepassword PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_CHANGEPASSWORD, NULL, NULL, NULL, NULL
    ret
sia_api_wallet_changepassword ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_init PROC hSia:DWORD, lpdwcJSONObject:DWORD
 ; need api post param with json respone api
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_BACKUP, NULL, NULL, lpdwcJSONObject, CTEXT(".\sia_api_wallet_init.txt")
    ret
sia_api_wallet_init ENDP

;------------------------------------------------------------------------------
; Initializes the wallet using a preexisting seed.
; https://sia.tech/docs/#wallet-init-seed-post
;------------------------------------------------------------------------------
sia_api_wallet_init_seed PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_INIT_SEED, NULL, NULL, NULL, NULL
    ret
sia_api_wallet_init_seed ENDP

;------------------------------------------------------------------------------
; Locks the wallet, wiping all secret keys
; https://sia.tech/docs/#wallet-lock-post
;------------------------------------------------------------------------------
sia_api_wallet_lock PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_LOCK, NULL, NULL, NULL, NULL
    ret
sia_api_wallet_lock ENDP

;------------------------------------------------------------------------------
; Gives the wallet a seed to track when looking for incoming transactions
; https://sia.tech/docs/#wallet-seed-post
;------------------------------------------------------------------------------
sia_api_wallet_seed PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_SEED, NULL, NULL, NULL, NULL
    ret
sia_api_wallet_seed ENDP

;------------------------------------------------------------------------------
; Fetches addresses generated by the wallet in reverse order
; https://sia.tech/docs/#wallet-seedaddrs-get
;------------------------------------------------------------------------------
sia_api_wallet_seedaddrs PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_SEEDADDRS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_seedaddrs.txt")
    ret
sia_api_wallet_seedaddrs ENDP

;------------------------------------------------------------------------------
; Returns the list of seeds in use by the wallet:
; https://sia.tech/docs/#wallet-seeds-get
;------------------------------------------------------------------------------
sia_api_wallet_seeds PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_SEEDS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_seeds.txt")
    ret
sia_api_wallet_seeds ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_siacoins PROC hSia:DWORD, lpdwcJSONObject:DWORD
 ; need api post param with json respone api
    ret
sia_api_wallet_siacoins ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_siafunds PROC hSia:DWORD, lpdwcJSONObject:DWORD
 ; need api post param with json respone api
    ret
sia_api_wallet_siafunds ENDP

;------------------------------------------------------------------------------
; Loads a key into the wallet that was generated by siag
; https://sia.tech/docs/#wallet-siagkey-post
;------------------------------------------------------------------------------
sia_api_wallet_siagkey PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_SIAGKEY, NULL, NULL, NULL, NULL
    ret
sia_api_wallet_siagkey ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_sign PROC hSia:DWORD
 ; need api post param with data body and json respone api
    ret
sia_api_wallet_sign ENDP

;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------
sia_api_wallet_sweep_seed PROC hSia:DWORD, lpdwcJSONObject:DWORD
 ; need api post param with json respone api
    ret
sia_api_wallet_sweep_seed ENDP

;------------------------------------------------------------------------------
; Gets the transaction associated with a specific transaction id.
; https://sia.tech/docs/#wallet-transaction-id-get
;------------------------------------------------------------------------------
sia_api_wallet_transaction PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_TRANSACTION, lpdwcJSONObject, CTEXT(".\sia_api_wallet_transaction.txt")
    ret
sia_api_wallet_transaction ENDP

;------------------------------------------------------------------------------
; Returns a list of transactions related to the wallet in chronological order:
; https://sia.tech/docs/#wallet-transactions-get
;------------------------------------------------------------------------------
sia_api_wallet_transactions PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_TRANSACTIONS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_transactions.txt")
    ret
sia_api_wallet_transactions ENDP

;------------------------------------------------------------------------------
; Returns all of the transactions related to a specific address:
; https://sia.tech/docs/#wallet-transactions-addr-get
;------------------------------------------------------------------------------
sia_api_wallet_transactions_address PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_TRANSACTIONS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_transactions_address.txt")
    ret
sia_api_wallet_transactions_address ENDP

;------------------------------------------------------------------------------
; Unlocks the wallet. The wallet is capable of knowing whether the correct password was provided
; https://sia.tech/docs/#wallet-unlock-post
;------------------------------------------------------------------------------
sia_api_wallet_unlock PROC hSia:DWORD
    Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_UNLOCK, NULL, NULL, NULL, NULL
    ret
sia_api_wallet_unlock ENDP

;------------------------------------------------------------------------------
; Returns the unlock conditions of :addr, if they are known to the wallet:
; https://sia.tech/docs/#wallet-unlockconditions-addr-get
;------------------------------------------------------------------------------
sia_api_wallet_unlockconditions PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_UNLOCKCONDITIONS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_unlockconditions.txt")
    ret
sia_api_wallet_unlockconditions ENDP

;------------------------------------------------------------------------------
; Returns a list of outputs that the wallet can spend:
; https://sia.tech/docs/#wallet-unspent-get
;------------------------------------------------------------------------------
sia_api_wallet_unspent PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_UNSPENT, lpdwcJSONObject, CTEXT(".\sia_api_wallet_unspent.txt")
    ret
sia_api_wallet_unspent ENDP

;------------------------------------------------------------------------------
; Takes the address specified by address and returns a JSON response indicating
; if the address is valid:
; https://sia.tech/docs/#wallet-verify-address-addr-get
;------------------------------------------------------------------------------
sia_api_wallet_verify_address PROC hSia:DWORD, lpdwcJSONObject:DWORD
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_VERIFY_ADDRESS, lpdwcJSONObject, CTEXT(".\sia_api_wallet_verify_address.txt")
    ret
sia_api_wallet_verify_address ENDP

;------------------------------------------------------------------------------
; Returns the set of addresses that the wallet is watching
; https://sia.tech/docs/#wallet-watch-get / https://sia.tech/docs/#wallet-watch-post
; if lpRequestBody == NULL then GET otherwise POST (lpdwcJSONObject == NULL)
;------------------------------------------------------------------------------
sia_api_wallet_watch PROC hSia:DWORD, lpdwcJSONObject:DWORD, lpRequestBody:DWORD, dwSizeRequestBody:DWORD
    .IF lpdwcJSONObject != NULL
        Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_WALLET_WATCH, lpdwcJSONObject, CTEXT(".\sia_api_wallet_watch.txt")
    .ELSE
        Invoke SIA_RPC_POST, hSia, Addr SIA_API_URL_WALLET_WATCH, lpRequestBody, dwSizeRequestBody, NULL, NULL
    .ENDIF
    ret
sia_api_wallet_watch ENDP








