;==============================================================================
;
; Sia x86 Library by fearless
;
; http:;github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; WithFunds adds the funds field to the request.
;------------------------------------------------------------------------------
Sia_WithFunds PROC hSia:DWORD, dwFunds:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("funds"), NULL, dwFunds
    ret
Sia_WithFunds ENDP

;------------------------------------------------------------------------------
; WithHosts adds the hosts field to the request.
;------------------------------------------------------------------------------
Sia_WithHosts PROC hSia:DWORD, dwHosts:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("hosts"), NULL, dwHosts
    ret
Sia_WithHosts ENDP

;------------------------------------------------------------------------------
; WithPeriod adds the period field to the request.
;------------------------------------------------------------------------------
Sia_WithPeriod PROC hSia:DWORD, dwPeriod:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("period"), NULL, dwPeriod
    ret
Sia_WithPeriod ENDP

;------------------------------------------------------------------------------
; WithRenewWindow adds the renewwindow field to the request.
;------------------------------------------------------------------------------
Sia_WithRenewWindow PROC hSia:DWORD, dwRenewWindow:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("renewwindow"), NULL, dwRenewWindow
    ret
Sia_WithRenewWindow ENDP

;------------------------------------------------------------------------------
; WithExpectedStorage adds the expected storage field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedStorage PROC hSia:DWORD, dwExpectedStorage:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("expectedstorage"), NULL, dwExpectedStorage
    ret
Sia_WithExpectedStorage ENDP

;------------------------------------------------------------------------------
; WithExpectedUpload adds the expected upload field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedUpload PROC hSia:DWORD, dwExpectedUpload:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("expectedupload"), NULL, dwExpectedUpload
    ret
Sia_WithExpectedUpload ENDP

;------------------------------------------------------------------------------
; WithExpectedDownload adds the expected download field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedDownload PROC hSia:DWORD, dwExpectedDownload:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("expecteddownload"), NULL, dwExpectedDownload
    ret
Sia_WithExpectedDownload ENDP

;------------------------------------------------------------------------------
; WithExpectedRedundancy adds the expected redundancy field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedRedundancy PROC hSia:DWORD, dwExpectedRedundancy:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("expectedredundancy"), NULL, dwExpectedRedundancy
    ret
Sia_WithExpectedRedundancy ENDP

;------------------------------------------------------------------------------
; Send finalizes and sends the request.
;------------------------------------------------------------------------------
Sia_AllowanceRequestPostSend PROC USES EBX hSia:DWORD
    Invoke sia_api_renter, hSia, NULL
    ret
Sia_AllowanceRequestPostSend ENDP

;------------------------------------------------------------------------------
; escapeSiaPath escapes the siapath to make it safe to use within a URL. This
; should only be used on SiaPaths which are used as part of the URL path.
; Paths within the query have to be escaped with url.PathEscape.
;------------------------------------------------------------------------------
Sia_escapeSiaPath PROC lpszSiaPath:DWORD, lpszEscapedSiaPath:DWORD
    ret
Sia_escapeSiaPath ENDP

;------------------------------------------------------------------------------
; RenterContractCancelPost uses the /renter/contract/cancel endpoint to cancel
; a contract
;------------------------------------------------------------------------------
Sia_RenterContractCancelPost PROC hSia:DWORD, lpszFileContractID:DWORD
    .IF lpszFileContractID == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("id"), lpszFileContractID, 0
    Invoke sia_api_renter_contract_cancel, hSia
    ret
Sia_RenterContractCancelPost ENDP

;------------------------------------------------------------------------------
; RenterAllContractsGet requests the /renter/contracts resource with all
; options set to true
;------------------------------------------------------------------------------
Sia_RenterAllContractsGet PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("disabled"), CTEXT("true"), 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("expired"), CTEXT("true"), 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("recoverable"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_RenterAllContractsGet ENDP

;------------------------------------------------------------------------------
; RenterContractsGet requests the /renter/contracts resource and returns
; Contracts and ActiveContracts
;------------------------------------------------------------------------------
Sia_RenterContractsGet PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke sia_api_renter_contracts, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_RenterContractsGet ENDP

;------------------------------------------------------------------------------
; RenterDisabledContractsGet requests the /renter/contracts resource with the
; disabled flag set to true
;------------------------------------------------------------------------------
Sia_RenterDisabledContractsGet PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("disabled"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_RenterDisabledContractsGet ENDP

;------------------------------------------------------------------------------
; RenterInactiveContractsGet requests the /renter/contracts resource with the
; inactive flag set to true
;------------------------------------------------------------------------------
Sia_RenterInactiveContractsGet PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("inactive"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_RenterInactiveContractsGet ENDP

;------------------------------------------------------------------------------
; RenterInitContractRecoveryScanPost initializes a contract recovery scan
; using the /renter/recoveryscan endpoint.
;------------------------------------------------------------------------------
Sia_RenterInitContractRecoveryScanPost PROC hSia:DWORD
    Invoke sia_api_renter_recoveryscan, hSia, NULL
    ret
Sia_RenterInitContractRecoveryScanPost ENDP

;------------------------------------------------------------------------------
; RenterContractRecoveryProgressGet returns information about potentially
; ongoing contract recovery scans.
;------------------------------------------------------------------------------
Sia_RenterContractRecoveryProgressGet PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke sia_api_renter_recoveryscan, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF  
    ret
Sia_RenterContractRecoveryProgressGet ENDP

;------------------------------------------------------------------------------
; RenterExpiredContractsGet requests the /renter/contracts resource with the
; expired flag set to true
;------------------------------------------------------------------------------
Sia_RenterExpiredContractsGet PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("expired"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_RenterExpiredContractsGet ENDP

;------------------------------------------------------------------------------
; RenterRecoverableContractsGet requests the /renter/contracts resource with the
; recoverable flag set to true
;------------------------------------------------------------------------------
Sia_RenterRecoverableContractsGet PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("recoverable"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_RenterRecoverableContractsGet ENDP

;------------------------------------------------------------------------------
; RenterCancelDownloadPost requests the /renter/download/cancel endpoint to
; cancel an ongoing doing.
;------------------------------------------------------------------------------
Sia_RenterCancelDownloadPost PROC hSia:DWORD, lpszId:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("id"), lpszId, 0
    Invoke sia_api_renter_download_cancel, hSia
    ret
Sia_RenterCancelDownloadPost ENDP

;------------------------------------------------------------------------------
; RenterDeletePost uses the /renter/delete endpoint to delete a file.
;------------------------------------------------------------------------------
Sia_RenterDeletePost PROC hSia:DWORD, lpszSiaPath:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_delete, hSia
    ret
Sia_RenterDeletePost ENDP

;------------------------------------------------------------------------------
; RenterDownloadGet uses the /renter/download endpoint to download a file to a
; destination on disk.
;------------------------------------------------------------------------------
Sia_RenterDownloadGet PROC hSia:DWORD, lpszSiaPath:DWORD, lpszDestination:DWORD, dwOffset:DWORD, dwLength:DWORD, bAsync:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    .IF lpszDestination == 0
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("destination"), lpszDestination, 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("offset"), 0, dwOffset
    Invoke RpcSetQueryParameters, hSia, CTEXT("length"), 0, dwLength
    .IF bAsync == TRUE
        Invoke RpcSetQueryParameters, hSia, CTEXT("async"), CTEXT("true"), 0
    .ELSE
        Invoke RpcSetQueryParameters, hSia, CTEXT("async"), CTEXT("false"), 0
    .ENDIF
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_download, hSia
    ret
Sia_RenterDownloadGet ENDP

;------------------------------------------------------------------------------
; RenterBackups lists the backups the renter has uploaded to hosts.
;------------------------------------------------------------------------------
Sia_RenterBackups PROC hSia:DWORD
    LOCAL hJSON:DWORD
    
    Invoke sia_api_renter_backups, hSia, Addr hJSON
    .IF eax == TRUE
        mov eax, hJSON
    .ELSE
        mov eax, NULL
    .ENDIF    
    ret
Sia_RenterBackups ENDP

;------------------------------------------------------------------------------
; RenterCreateBackupPost creates a backup of the SiaFiles of the renter and
; uploads it to hosts.
;------------------------------------------------------------------------------
Sia_RenterCreateBackupPost PROC hSia:DWORD, lpszBackupName:DWORD
    .IF lpszBackupName == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("name"), lpszBackupName, 0
    Invoke sia_api_renter_backups_create, hSia
    ret
Sia_RenterCreateBackupPost ENDP

;------------------------------------------------------------------------------
; RenterRecoverBackupPost downloads and restores the specified backup.
;------------------------------------------------------------------------------
Sia_RenterRecoverBackupPost PROC hSia:DWORD, lpszBackupName:DWORD
    .IF lpszBackupName == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("name"), lpszBackupName, 0
    Invoke sia_api_renter_backups_restore, hSia
    ret
Sia_RenterRecoverBackupPost ENDP

;------------------------------------------------------------------------------
; RenterCreateLocalBackupPost creates a local backup of the SiaFiles of the
; renter.
;
; Deprecated: Use RenterCreateBackupPost instead.
;------------------------------------------------------------------------------
Sia_RenterCreateLocalBackupPost PROC hSia:DWORD, lpszDestination:DWORD
    .IF lpszDestination == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("destination"), lpszDestination, 0
    Invoke sia_api_renter_backup, hSia
    ret
Sia_RenterCreateLocalBackupPost ENDP

;------------------------------------------------------------------------------
; RenterRecoverLocalBackupPost restores the specified backup.
;
; Deprecated: Use RenterCreateBackupPost instead.
;------------------------------------------------------------------------------
Sia_RenterRecoverLocalBackupPost PROC hSia:DWORD, lpszSource:DWORD
    .IF lpszSource == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("source"), lpszSource, 0
    Invoke sia_api_renter_recoverbackup, hSia
    ret
Sia_RenterRecoverLocalBackupPost ENDP

;------------------------------------------------------------------------------
; RenterDownloadFullGet uses the /renter/download endpoint to download a full
; file.
;------------------------------------------------------------------------------
Sia_RenterDownloadFullGet PROC hSia:DWORD, lpszSiaPath:DWORD, lpszDestination:DWORD, bAsync:DWORD
    ret
Sia_RenterDownloadFullGet ENDP

;------------------------------------------------------------------------------
; RenterClearAllDownloadsPost requests the /renter/downloads/clear resource
; with no parameters
;------------------------------------------------------------------------------
Sia_RenterClearAllDownloadsPost PROC hSia:DWORD
    ret
Sia_RenterClearAllDownloadsPost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsAfterPost requests the /renter/downloads/clear resource
; with only the after timestamp provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsAfterPost PROC hSia:DWORD ;after time.Time
    ret
Sia_RenterClearDownloadsAfterPost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsBeforePost requests the /renter/downloads/clear resource
; with only the before timestamp provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsBeforePost PROC hSia:DWORD ;before time.Time
    ret
Sia_RenterClearDownloadsBeforePost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsRangePost requests the /renter/downloads/clear resource
; with both before and after timestamps provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsRangePost PROC hSia:DWORD ;after, before time.Time
    ret
Sia_RenterClearDownloadsRangePost ENDP

;------------------------------------------------------------------------------
; RenterDownloadsGet requests the /renter/downloads resource
;------------------------------------------------------------------------------
Sia_RenterDownloadsGet PROC hSia:DWORD ;rdq api.RenterDownloadQueue, err error
    ret
Sia_RenterDownloadsGet ENDP

;------------------------------------------------------------------------------
; RenterDownloadHTTPResponseGet uses the /renter/download endpoint to download
; a file and return its data.
;------------------------------------------------------------------------------
Sia_RenterDownloadHTTPResponseGet PROC hSia:DWORD, lpszSiaPath:DWORD;, offset, length uint64) (resp []byte, err error
    ret
Sia_RenterDownloadHTTPResponseGet ENDP

;------------------------------------------------------------------------------
; RenterFileGet uses the /renter/file/:siapath endpoint to query a file.
;------------------------------------------------------------------------------
Sia_RenterFileGet PROC hSia:DWORD, lpszSiaPath:DWORD ;(rf api.RenterFile, err error
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    ret
Sia_RenterFileGet ENDP

;------------------------------------------------------------------------------
; RenterFilesGet requests the /renter/files resource.
;------------------------------------------------------------------------------
Sia_RenterFilesGet PROC hSia:DWORD ;cached bool) (rf api.RenterFiles, err error
    ret
Sia_RenterFilesGet ENDP

;------------------------------------------------------------------------------
; RenterGet requests the /renter resource.
;------------------------------------------------------------------------------
Sia_RenterGet PROC hSia:DWORD ;rg api.RenterGET, err error
    ret
Sia_RenterGet ENDP

;------------------------------------------------------------------------------
; RenterPostAllowance uses the /renter endpoint to change the renter's allowance
;------------------------------------------------------------------------------
Sia_RenterPostAllowance PROC hSia:DWORD ;allowance modules.Allowance
    ret
Sia_RenterPostAllowance ENDP

;------------------------------------------------------------------------------
; RenterCancelAllowance uses the /renter endpoint to cancel the allowance.
;------------------------------------------------------------------------------
Sia_RenterCancelAllowance PROC hSia:DWORD
    ret
Sia_RenterCancelAllowance ENDP

;------------------------------------------------------------------------------
; RenterPricesGet requests the /renter/prices endpoint's resources.
;------------------------------------------------------------------------------
Sia_RenterPricesGet PROC hSia:DWORD ;allowance modules.Allowance) (rpg api.RenterPricesGET, err error
    ret
Sia_RenterPricesGet ENDP

;------------------------------------------------------------------------------
; RenterPostRateLimit uses the /renter endpoint to change the renter's bandwidth rate
; limit.
;------------------------------------------------------------------------------
Sia_RenterPostRateLimit PROC hSia:DWORD ;readBPS, writeBPS int64
    ret
Sia_RenterPostRateLimit ENDP

;------------------------------------------------------------------------------
; RenterRenamePost uses the /renter/rename/:siapath endpoint to rename a file.
;------------------------------------------------------------------------------
Sia_RenterRenamePost PROC hSia:DWORD, lpszSiaPathOld:DWORD, lpszSiaPathNew:DWORD
    ret
Sia_RenterRenamePost ENDP

;------------------------------------------------------------------------------
; RenterSetStreamCacheSizePost uses the /renter endpoint to change the renter's
; streamCacheSize for streaming
;------------------------------------------------------------------------------
Sia_RenterSetStreamCacheSizePost PROC hSia:DWORD ;cacheSize uint64
    ret
Sia_RenterSetStreamCacheSizePost ENDP

;------------------------------------------------------------------------------
; RenterSetCheckIPViolationPost uses the /renter endpoint to enable/disable the IP
; violation check in the renter.
;------------------------------------------------------------------------------
Sia_RenterSetCheckIPViolationPost PROC hSia:DWORD ;enabled bool
    ret
Sia_RenterSetCheckIPViolationPost ENDP

;------------------------------------------------------------------------------
; RenterStreamGet uses the /renter/stream endpoint to download data as a
; stream.
;------------------------------------------------------------------------------
Sia_RenterStreamGet PROC hSia:DWORD, lpszSiaPath:DWORD ;(resp []byte, err error
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    ret
Sia_RenterStreamGet ENDP

;------------------------------------------------------------------------------
; RenterStreamPartialGet uses the /renter/stream endpoint to download a part
; of data as a stream.
;------------------------------------------------------------------------------
Sia_RenterStreamPartialGet PROC hSia:DWORD, lpszSiaPath:DWORD;, start, end uint64) (resp []byte, err error
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    ret
Sia_RenterStreamPartialGet ENDP

;------------------------------------------------------------------------------
; RenterSetRepairPathPost uses the /renter/tracking endpoint to set the repair
; path of a file to a new location. The file at newPath must exists.
;------------------------------------------------------------------------------
Sia_RenterSetRepairPathPost PROC hSia:DWORD, lpszSiaPath:DWORD, lpszSiaPathNew:DWORD
    ret
Sia_RenterSetRepairPathPost ENDP

;------------------------------------------------------------------------------
; RenterSetFileStuckPost sets the 'stuck' field of the siafile at siaPath to
; stuck.
;------------------------------------------------------------------------------
Sia_RenterSetFileStuckPost PROC hSia:DWORD, lpszSiaPath:DWORD;, stuck bool
    ret
Sia_RenterSetFileStuckPost ENDP

;------------------------------------------------------------------------------
; RenterUploadPost uses the /renter/upload endpoint to upload a file
;------------------------------------------------------------------------------
Sia_RenterUploadPost PROC hSia:DWORD ;path string, lpszSiaPath:DWORD;, dataPieces, parityPieces uint64
    ret
Sia_RenterUploadPost ENDP

;------------------------------------------------------------------------------
; RenterUploadForcePost uses the /renter/upload endpoint to upload a file
; and to overwrite if the file already exists
;------------------------------------------------------------------------------
Sia_RenterUploadForcePost PROC hSia:DWORD ;path string, lpszSiaPath:DWORD;, dataPieces, parityPieces uint64, force bool
    ret
Sia_RenterUploadForcePost ENDP

;------------------------------------------------------------------------------
; RenterUploadDefaultPost uses the /renter/upload endpoint with default
; redundancy settings to upload a file.
;------------------------------------------------------------------------------
Sia_RenterUploadDefaultPost PROC hSia:DWORD ;path string, lpszSiaPath:DWORDh
    ret
Sia_RenterUploadDefaultPost ENDP

;------------------------------------------------------------------------------
; RenterUploadStreamPost uploads data using a stream.
;------------------------------------------------------------------------------
Sia_RenterUploadStreamPost PROC hSia:DWORD ;r io.Reader, lpszSiaPath:DWORD, dataPieces, parityPieces uint64, force bool
    ret
Sia_RenterUploadStreamPost ENDP

;------------------------------------------------------------------------------
; RenterUploadStreamRepairPost a siafile using a stream. If the data provided
; by r is not the same as the previously uploaded data, the data will be
; corrupted.
;------------------------------------------------------------------------------
Sia_RenterUploadStreamRepairPost PROC hSia:DWORD ;r io.Reader, lpszSiaPath:DWORD
    ret
Sia_RenterUploadStreamRepairPost ENDP

;------------------------------------------------------------------------------
; RenterDirCreatePost uses the /renter/dir/ endpoint to create a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirCreatePost PROC hSia:DWORD, lpszSiaPath:DWORD
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    ret
Sia_RenterDirCreatePost ENDP

;------------------------------------------------------------------------------
; RenterDirDeletePost uses the /renter/dir/ endpoint to delete a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirDeletePost PROC hSia:DWORD, lpszSiaPath:DWORD
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    ret
Sia_RenterDirDeletePost ENDP

;------------------------------------------------------------------------------
; RenterDirRenamePost uses the /renter/dir/ endpoint to rename a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirRenamePost PROC hSia:DWORD, lpszSiaPath:DWORD, lpszSiaPathNew:DWORD
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    ret
Sia_RenterDirRenamePost ENDP

;------------------------------------------------------------------------------
; RenterGetDir uses the /renter/dir/ endpoint to query a directory
;------------------------------------------------------------------------------
Sia_RenterGetDir PROC hSia:DWORD, lpszSiaPath:DWORD ;(rd api.RenterDirectory, err error
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    ret
Sia_RenterGetDir ENDP






