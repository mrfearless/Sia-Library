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
; https://gitlab.com/NebulousLabs/Sia/blob/master/doc/api/index.html.md
; https://gitlab.com/NebulousLabs/Sia/tree/master/node/api/client
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; Sia Client Functions:
;------------------------------------------------------------------------------

; General Helper Functions:
Sia_CheckConnection             PROTO :DWORD, :DWORD, :DWORD                    ; lpszHostAddress, lpszPort, bSecure
Sia_Connect                     PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpszHostAddress, lpszPort
Sia_Disconnect                  PROTO :DWORD                                    ; hSia, 
Sia_Auth                        PROTO :DWORD, :DWORD                            ; hSia, lpszApiPassword

Sia_Constants                   PROTO :DWORD, :DWORD                            ; hSia, lpStructSiaConstants
Sia_Version                     PROTO :DWORD, :DWORD                            ; hSia, lpszSiadVersion

Sia_DefaultSiaDir               PROTO :DWORD                                    ; lpszSiaDefaultDir
Sia_PasswordFile                PROTO :DWORD                                    ; lpszSiaPasswordFilepath
Sia_FindApiPassword             PROTO                                           ; 
Sia_FreeJson                    PROTO :DWORD                                    ; hJSON

; Consensus:
Sia_ConsensusGet                PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpStructConsensusGet
Sia_ConsensusBlocksIDGet        PROTO :DWORD, :DWORD, :DWORD                    ; hSia, dwBlockID, (*cJSON) lpConsensusBlocksGet
Sia_ConsensusBlocksHeightGet    PROTO :DWORD, :DWORD, :DWORD                    ; hSia, dwBlockHeight, (*cJSON) lpConsensusBlocksGet

; Daemon:
Sia_DaemonGlobalRateLimitPost	PROTO :DWORD, :DWORD, :DWORD                    ; hSia, dwDownloadSpeed, dwUploadSpeed
Sia_DaemonSettingsGet	        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpDaemonSettingsGet
Sia_DaemonStopGet		        PROTO :DWORD                                    ; hSia
Sia_DaemonUpdateGet		        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpDaemonUpdateGet
Sia_DaemonUpdatePost	        PROTO :DWORD                                    ; hSia
Sia_DaemonVersionGet	        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpDaemonVersionGet

; Gateway:
Sia_GatewayConnectPost	        PROTO :DWORD, :DWORD                            ; hSia, lpszNetAddress
Sia_GatewayDisconnectPost	    PROTO :DWORD, :DWORD                            ; hSia, lpszNetAddress
Sia_GatewayGet			        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpGatewayGet
Sia_GatewayRateLimitPost	    PROTO :DWORD, :DWORD, :DWORD                    ; hSia, dwDownloadSpeed, dwUploadSpeed

; Host:
Sia_HostAnnounceAddrPost	    PROTO :DWORD, :DWORD                            ; hSia, lpszNetAdress
Sia_HostAnnouncePost	        PROTO :DWORD                                    ; hSia
Sia_HostContractInfoGet	        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpContractInfoGet
Sia_HostEstimateScoreGet	    PROTO :DWORD, :DWORD, :DWORD, :DWORD            ; hSia, lpszParam, lpszValue, (*cJSON) lpHostEstimateScoreGet
Sia_HostGet				        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpHostGet
Sia_HostModifySettingPost	    PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpHostParam, lpszValue
Sia_HostStorageFoldersAddPost	PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpszSiaPath
Sia_HostStorageFoldersRemovePost PROTO :DWORD, :DWORD                           ; hSia, lpszSiaPath
Sia_HostStorageFoldersResizePost PROTO :DWORD, :DWORD, :DWORD                   ; hSia, lpszSiaPath
Sia_HostStorageGet		        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpStorageGet
Sia_HostStorageSectorsDeletePost PROTO :DWORD, :DWORD                           ; hSia, lpszRootHash

; Hostdb:
Sia_HostDbGet                   PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpHostdbGet
Sia_HostDbActiveGet		        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpHostdbActiveGet
Sia_HostDbAllGet                PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpHostdbAllGet
Sia_HostDbFilterModeGet         PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpHostdbFilterModeGet
Sia_HostDbFilterModePost	    PROTO :DWORD, :DWORD, :DWORD                    ; hSia, Filermode, lpHosts
Sia_HostDbHostsGet		        PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpszPublicKey, (*cJSON) lpHostdbHostsGet

; Miner:
Sia_MinerGet			        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpMinerGet
Sia_MinerHeaderGet		        PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpdwTarget, lpdwBlockHeader
Sia_MinerHeaderPost		        PROTO :DWORD, :DWORD                            ; hSia, lpBlockHeader
Sia_MinerStartGet		        PROTO :DWORD                                    ; hSia
Sia_MinerStopGet		        PROTO :DWORD                                    ; hSia

; Renter:

; Transactionpool:
Sia_TransactionPoolFeeGet	    PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpTpoolFeeGet
Sia_TransactionPoolRawPost	    PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpszBase64Transaction, lpszBase64Parents

; Wallet:
Sia_WalletAddressGet	        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpWalletAddressGet
Sia_WalletAddressesGet	        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpWalletAddressesGet
Sia_WalletChangePasswordPost	PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpszCurrentPassword, lpszNewPassword
Sia_WalletGet			        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpWalletGet
Sia_WalletInitPost		        PROTO :DWORD, :DWORD, :DWORD, :DWORD            ; hSia, lpszPassword, bForce, lpWalletInitPost
Sia_WalletInitSeedPost	        PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpszPassword, bForce
Sia_WalletLastAddressesGet	    PROTO :DWORD, :DWORD, :DWORD                    ; hSia, dwCount, lpWalletAddressesGet
Sia_WalletLockPost		        PROTO :DWORD                                    ; hSia
Sia_WalletSeedPost		        PROTO :DWORD, :DWORD, :DWORD                    ; hSia, lpszSeed, lpszPassword
Sia_WalletSeedsGet		        PROTO :DWORD, :DWORD                            ; hSia, (*cJSON) lpWalletSeedsGet






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


.CONST
;------------------------------------------------------------------------------
; Sia Constants
;------------------------------------------------------------------------------
SIA_HASH_SIZE                   EQU 64
DEF_SIA_AGENT                   EQU "Sia-Agent",0
DEF_SIAD_ADDRESS_DEFAULT        EQU "localhost",0
DEF_SIAD_PORT_DEFAULT           EQU "9980",0












