;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================
;
; https://sia.tech/docs/
; https://github.com/NebulousLabs/Sia/blob/master/doc/API.md
; https://gitlab.com/NebulousLabs/Sia/tree/master/node/api/client
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; Sia API Endpoint Functions (For Internal Use):
;------------------------------------------------------------------------------
sia_api_consensus               PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_consensus_blocks        PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_consensus_validate_transactionset PROTO                                 ;

sia_api_daemon_constants        PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_daemon_stop             PROTO                                           ;
sia_api_daemon_version          PROTO :DWORD                                    ; lpdwcJSONObject

sia_api_gateway                 PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_gateway_connect         PROTO :DWORD                                    ; lpszPathParameters
sia_api_gateway_disconnect      PROTO :DWORD                                    ; lpszPathParameters

sia_api_host                    PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_host_announce           PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_host_contracts          PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_host_estimatescore      PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_host_storage            PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_host_storage_folders_add PROTO :DWORD                                   ; lpszQueryStringParameters
sia_api_host_storage_folders_remove PROTO :DWORD                                ; lpszQueryStringParameters
sia_api_host_storage_folders_resize PROTO :DWORD                                ; lpszQueryStringParameters
sia_api_host_storage_sectors_delete PROTO :DWORD                                ; lpszPathParameters

sia_api_hostdb                  PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_hostdb_active           PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_hostdb_all              PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_hostdb_filtermode       PROTO
sia_api_hostdb_hosts            PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszPathParameters

sia_api_miner                   PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_miner_header            PROTO :DWORD                                    ; lpdwRawBytes
sia_api_miner_start             PROTO                                           ;
sia_api_miner_stop              PROTO                                           ;

sia_api_renter                  PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_renter_backup           PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_renter_backups          PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_renter_backups_create   PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_renter_backups_restore  PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_renter_contract_cancel  PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_renter_contracts        PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_renter_delete           PROTO :DWORD                                    ; lpszPathParameters
sia_api_renter_dir              PROTO :DWORD, :DWORD, :DWORD                    ; lpdwcJSONObject, lpszPathParameters, lpszQueryStringParameters
sia_api_renter_download         PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_renter_download_cancel  PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_renter_downloads        PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_renter_downloads_clear  PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_renter_downloadsync     PROTO :DWORD, :DWORD                            ; lpszPathParameters, lpszQueryStringParameters
sia_api_renter_file             PROTO :DWORD, :DWORD, :DWORD                    ; lpdwcJSONObject, lpszPathParameters, lpszQueryStringParameters
sia_api_renter_files            PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_renter_prices           PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_renter_recoverbackup    PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_renter_recoveryscan     PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_renter_rename           PROTO :DWORD, :DWORD                            ; lpszPathParameters, lpszQueryStringParameters
sia_api_renter_stream           PROTO :DWORD                                    ; lpszPathParameters
sia_api_renter_upload           PROTO :DWORD, :DWORD                            ; lpszPathParameters, lpszQueryStringParameters

sia_api_tpool_confirmed         PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszPathParameters
sia_api_tpool_fee               PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_tpool_raw               PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_tpool_raw_id            PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszPathParameters

sia_api_wallet                  PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_wallet_033x             PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_wallet_address          PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_wallet_addresses        PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_wallet_backup           PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_wallet_changepassword   PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_wallet_init             PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_wallet_init_seed        PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_wallet_lock             PROTO
sia_api_wallet_seed             PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_wallet_seedaddrs        PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_wallet_seeds            PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_wallet_siacoins         PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_wallet_siafunds         PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_wallet_siagkey          PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_wallet_sign             PROTO
sia_api_wallet_sweep_seed       PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_wallet_transaction      PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszPathParameters
sia_api_wallet_transactions     PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszQueryStringParameters
sia_api_wallet_transactions_address PROTO :DWORD, :DWORD                        ; lpdwcJSONObject, lpszPathParameters
sia_api_wallet_unlock           PROTO :DWORD                                    ; lpszQueryStringParameters
sia_api_wallet_unlockconditions PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszPathParameters
sia_api_wallet_unspent          PROTO :DWORD                                    ; lpdwcJSONObject
sia_api_wallet_verify_address   PROTO :DWORD, :DWORD                            ; lpdwcJSONObject, lpszPathParameters
sia_api_wallet_watch            PROTO :DWORD, :DWORD, :DWORD                    ; lpdwcJSONObject, lpRequestBody, dwSizeRequestBody

sia_api_url_values              PROTO :DWORD, :DWORD, :DWORD, :DWORD            ; lpszUrlQuery, lpszName, lpszValue, dwValue

;------------------------------------------------------------------------------
; Sia Client Functions:
;------------------------------------------------------------------------------

; General Helper Functions:
Sia_Connect                     PROTO :DWORD, :DWORD                            ; lpszHostAddress, lpszPort
Sia_Disconnect                  PROTO                                           ;
Sia_Auth                        PROTO :DWORD                                    ; lpszApiPassword

Sia_Constants                   PROTO :DWORD                                    ; lpStructSiaConstants
Sia_Version                     PROTO :DWORD                                    ; lpszSiadVersion

Sia_DefaultSiaDir               PROTO :DWORD                                    ; lpszSiaDefaultDir
Sia_PasswordFile                PROTO :DWORD                                    ; lpszSiaPasswordFilepath
Sia_FindApiPassword             PROTO                                           ; 

; Consensus:
Sia_ConsensusGet                PROTO                                           ;
Sia_ConsensusBlocksIDGet        PROTO :DWORD                                    ; dwBlockID
Sia_ConsensusBlocksHeightGet    PROTO :DWORD                                    ; dwBlockHeight

; Daemon:
Sia_DaemonGlobalRateLimitPost	PROTO :DWORD, :DWORD                            ; dwDownloadSpeed, dwUploadSpeed
Sia_DaemonSettingsGet	        PROTO                                           ; 
Sia_DaemonStopGet		        PROTO                                           ; 
Sia_DaemonUpdateGet		        PROTO                                           ; 
Sia_DaemonUpdatePost	        PROTO                                           ; 
Sia_DaemonVersionGet	        PROTO                                           ; 

; Gateway:
Sia_GatewayConnectPost	        PROTO :DWORD                                    ; 
Sia_GatewayDisconnectPost	    PROTO :DWORD                                    ; 
Sia_GatewayGet			        PROTO                                           ; 
Sia_GatewayRateLimitPost	    PROTO                                           ; 

; Host:
Sia_HostAnnounceAddrPost	    PROTO :DWORD                                    ; 
Sia_HostAnnouncePost	        PROTO                                           ; 
Sia_HostContractInfoGet	        PROTO                                           ; 
Sia_HostEstimateScoreGet	    PROTO :DWORD, :DWORD                            ; 
Sia_HostGet				        PROTO                                           ; 
Sia_HostModifySettingPost	    PROTO :DWORD, :DWORD                            ; 
Sia_HostStorageFoldersAddPost	PROTO :DWORD, :DWORD                            ; 
Sia_HostStorageFoldersRemovePost PROTO :DWORD                                   ;
Sia_HostStorageFoldersResizePost PROTO :DWORD, :DWORD                           ; 
Sia_HostStorageGet		        PROTO                                           ; 
Sia_HostStorageSectorsDeletePost PROTO :DWORD                                   ; 

; Hostdb:
Sia_HostDbActiveGet		        PROTO                                           ; 
Sia_HostDbFilterModePost	    PROTO :DWORD, :DWORD                            ; 
Sia_HostDbGet			        PROTO                                           ; 
Sia_HostDbHostsGet		        PROTO :DWORD                                    ; 

; Miner:

; Renter:

; Transactionpool:

; Wallet:





;------------------------------------------------------------------------------
; Sia Structures
;------------------------------------------------------------------------------
SIACONSTANTS                    STRUCT
    blockfrequency              DD 0            ; Target for how frequently new blocks should be mined (seconds per block)
    blocksizelimit              DD 0            ; Maximum size, in bytes, of a block. Blocks larger than this will be rejected by peers
    extremefuturethreshold      DD 0            ; Farthest a block's timestamp can be in the future before the block is rejected outright (seconds)
    futurethreshold             DD 0            ; How far in the future a block can be without being rejected (seconds)
    genesistimestamp            DD 0            ; Timestamp of the genesis block (Unix time)
    maturitydelay               DD 0            ; Number of children a block must have before it is considered "mature" (blocks)
    mediantimestampwindow       DD 0            ; Duration of the window used to adjust the difficulty (blocks)
    siafundcount                DB 32 DUP (0)   ; Total number of siafunds
    siafundportion              DB 32 DUP (0)   ; Fraction of each file contract payout given to siafund holders
    targetwindow                DD 0            ; Height of the window used to adjust the difficulty (blocks)
    initialcoinbase             DD 0            ; Number of coins given to the miner of the first block.
    minimumcoinbase             DD 0            ; Minimum number of coins paid out to the miner of a block (the coinbase decreases with each block)
    roottarget                  DB 256 DUP (0)  ; Initial target
    rootdepth                   DB 256 DUP (0)  ; Initial depth
    maxtargetadjustmentup       DB 8 DUP (0)    ; Largest allowed ratio between the old difficulty and the new difficulty
    maxtargetadjustmentdown     DB 8 DUP (0)    ; Smallest allowed ratio between the old difficulty and the new difficulty
    siacoinprecision            DB 32 DUP (0)   ; Number of Hastings in one siacoin (hastings per siacoin)
SIACONSTANTS                    ENDS


AllowanceRequestPost            STRUCT
		lpClient                DWORD 0
		BoolSent                DWORD 0
		lpUrlValues             DWORD 0
AllowanceRequestPost            ENDS




.CONST
;------------------------------------------------------------------------------
; Sia Constants
;------------------------------------------------------------------------------
DEF_SIA_AGENT                   EQU "Sia-Agent",0
DEF_SIAD_ADDRESS_DEFAULT        EQU "localhost",0
DEF_SIAD_PORT_DEFAULT           EQU "9980",0
















