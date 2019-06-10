;==============================================================================
;
; Sia x86 Library by fearless
;
; http:;github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; RenterPostPartialAllowance starts an allowance request which can be extended
; using its methods.
;------------------------------------------------------------------------------
RenterPostPartialAllowance PROC lpAllowanceRequest:DWORD
    .IF lpAllowanceRequest == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, 4096d
    .IF eax == NULL
        ret
    .ENDIF
    mov ebx, lpAllowanceRequest
    mov [ebx], eax
    mov eax, TRUE
    ret
RenterPostPartialAllowance ENDP

;------------------------------------------------------------------------------
; WithFunds adds the funds field to the request.
;------------------------------------------------------------------------------
Sia_WithFunds PROC dwFunds:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("funds"), NULL, dwFunds
    ret
Sia_WithFunds ENDP

;------------------------------------------------------------------------------
; WithHosts adds the hosts field to the request.
;------------------------------------------------------------------------------
Sia_WithHosts PROC dwHosts:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("hosts"), NULL, dwHosts
    ret
Sia_WithHosts ENDP

;------------------------------------------------------------------------------
; WithPeriod adds the period field to the request.
;------------------------------------------------------------------------------
Sia_WithPeriod PROC dwPeriod:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("period"), NULL, dwPeriod
    ret
Sia_WithPeriod ENDP

;------------------------------------------------------------------------------
; WithRenewWindow adds the renewwindow field to the request.
;------------------------------------------------------------------------------
Sia_WithRenewWindow PROC dwRenewWindow:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("renewwindow"), NULL, dwRenewWindow
    ret
Sia_WithRenewWindow ENDP

;------------------------------------------------------------------------------
; WithExpectedStorage adds the expected storage field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedStorage PROC dwExpectedStorage:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("expectedstorage"), NULL, dwExpectedStorage
    ret
Sia_WithExpectedStorage ENDP

;------------------------------------------------------------------------------
; WithExpectedUpload adds the expected upload field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedUpload PROC dwExpectedUpload:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("expectedupload"), NULL, dwExpectedUpload
    ret
Sia_WithExpectedUpload ENDP

;------------------------------------------------------------------------------
; WithExpectedDownload adds the expected download field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedDownload PROC dwExpectedDownload:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("expecteddownload"), NULL, dwExpectedDownload
    ret
Sia_WithExpectedDownload ENDP

;------------------------------------------------------------------------------
; WithExpectedRedundancy adds the expected redundancy field to the request.
;------------------------------------------------------------------------------
Sia_WithExpectedRedundancy PROC dwExpectedRedundancy:DWORD, AllowanceRequest:DWORD
    Invoke sia_api_url_values, AllowanceRequest, CTEXT("expectedredundancy"), NULL, dwExpectedRedundancy
    ret
Sia_WithExpectedRedundancy ENDP

;------------------------------------------------------------------------------
; Send finalizes and sends the request.
;------------------------------------------------------------------------------
Sia_AllowanceRequestPostSend PROC USES EBX lpAllowanceRequest:DWORD
    LOCAL AllowanceRequest:DWORD
    LOCAL RetVal:DWORD
    
    .IF lpAllowanceRequest != NULL
        mov ebx, lpAllowanceRequest
        mov eax, [ebx]
        .IF eax == 0
            ret
        .ENDIF
        mov AllowanceRequest, eax
        Invoke sia_api_renter, NULL, AllowanceRequest
        mov RetVal, eax
        mov ebx, lpAllowanceRequest
        mov eax, 0
        mov [ebx], eax        
        mov eax, AllowanceRequest
        Invoke GlobalFree, eax
        mov eax, RetVal
    .ELSE
        xor eax, eax
    .ENDIF
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
Sia_RenterContractCancelPost PROC lpszFileContractID:DWORD
    .IF lpszFileContractID == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("id"), lpszFileContractID, 0
    Invoke sia_api_renter_contract_cancel, Addr SiaApiUrlValues
    ret
Sia_RenterContractCancelPost ENDP

;------------------------------------------------------------------------------
; RenterAllContractsGet requests the /renter/contracts resource with all
; options set to true
;------------------------------------------------------------------------------
Sia_RenterAllContractsGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("disabled"), CTEXT("true"), 0
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("expired"), CTEXT("true"), 0
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("recoverable"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, Addr hJSON, Addr SiaApiUrlValues
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
Sia_RenterContractsGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_renter_contracts, Addr hJSON, NULL
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
Sia_RenterDisabledContractsGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("disabled"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, Addr hJSON, Addr SiaApiUrlValues
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
Sia_RenterInactiveContractsGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("inactive"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, Addr hJSON, Addr SiaApiUrlValues
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
Sia_RenterInitContractRecoveryScanPost PROC
    Invoke sia_api_renter_recoveryscan, NULL
    ret
Sia_RenterInitContractRecoveryScanPost ENDP

;------------------------------------------------------------------------------
; RenterContractRecoveryProgressGet returns information about potentially
; ongoing contract recovery scans.
;------------------------------------------------------------------------------
Sia_RenterContractRecoveryProgressGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_renter_recoveryscan, Addr hJSON
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
Sia_RenterExpiredContractsGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("expired"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, Addr hJSON, Addr SiaApiUrlValues
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
Sia_RenterRecoverableContractsGet PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("recoverable"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, Addr hJSON, Addr SiaApiUrlValues
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
Sia_RenterCancelDownloadPost PROC lpszId:DWORD
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("id"), lpszId, 0
    Invoke sia_api_renter_download_cancel, Addr SiaApiUrlValues
    ret
Sia_RenterCancelDownloadPost ENDP

;------------------------------------------------------------------------------
; RenterDeletePost uses the /renter/delete endpoint to delete a file.
;------------------------------------------------------------------------------
Sia_RenterDeletePost PROC lpszSiaPath:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke sia_api_renter_delete, Addr szEscapedSiaPath
    ret
Sia_RenterDeletePost ENDP

;------------------------------------------------------------------------------
; RenterDownloadGet uses the /renter/download endpoint to download a file to a
; destination on disk.
;------------------------------------------------------------------------------
Sia_RenterDownloadGet PROC lpszSiaPath:DWORD, lpszDestination:DWORD, dwOffset:DWORD, dwLength:DWORD, bAsync:DWORD
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
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("destination"), lpszDestination, 0
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("offset"), 0, dwOffset
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("length"), 0, dwLength
    .IF bAsync == TRUE
        Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("async"), CTEXT("true"), 0
    .ELSE
        Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("async"), CTEXT("false"), 0
    .ENDIF
    Invoke sia_api_renter_download, Addr szEscapedSiaPath, Addr SiaApiUrlValues
    ret
Sia_RenterDownloadGet ENDP

;------------------------------------------------------------------------------
; RenterBackups lists the backups the renter has uploaded to hosts.
;------------------------------------------------------------------------------
Sia_RenterBackups PROC
    LOCAL hJSON:DWORD
    
    Invoke sia_api_renter_backups, Addr hJSON
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
Sia_RenterCreateBackupPost PROC lpszBackupName:DWORD
    .IF lpszBackupName == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("name"), lpszBackupName, 0
    Invoke sia_api_renter_backups_create, Addr SiaApiUrlValues
    ret
Sia_RenterCreateBackupPost ENDP

;------------------------------------------------------------------------------
; RenterRecoverBackupPost downloads and restores the specified backup.
;------------------------------------------------------------------------------
Sia_RenterRecoverBackupPost PROC lpszBackupName:DWORD
    .IF lpszBackupName == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("name"), lpszBackupName, 0
    Invoke sia_api_renter_backups_restore, Addr SiaApiUrlValues
    ret
Sia_RenterRecoverBackupPost ENDP

;------------------------------------------------------------------------------
; RenterCreateLocalBackupPost creates a local backup of the SiaFiles of the
; renter.
;
; Deprecated: Use RenterCreateBackupPost instead.
;------------------------------------------------------------------------------
Sia_RenterCreateLocalBackupPost PROC lpszDestination:DWORD
    .IF lpszDestination == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("destination"), lpszDestination, 0
    Invoke sia_api_renter_backup, Addr SiaApiUrlValues
    ret
Sia_RenterCreateLocalBackupPost ENDP

;------------------------------------------------------------------------------
; RenterRecoverLocalBackupPost restores the specified backup.
;
; Deprecated: Use RenterCreateBackupPost instead.
;------------------------------------------------------------------------------
Sia_RenterRecoverLocalBackupPost PROC lpszSource:DWORD
    .IF lpszSource == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke sia_api_url_values, Addr SiaApiUrlValues, 0, 0, 0 ; clear out previous
    Invoke sia_api_url_values, Addr SiaApiUrlValues, CTEXT("source"), lpszSource, 0
    Invoke sia_api_renter_recoverbackup, Addr SiaApiUrlValues
    ret
Sia_RenterRecoverLocalBackupPost ENDP

;------------------------------------------------------------------------------
; RenterDownloadFullGet uses the /renter/download endpoint to download a full
; file.
;------------------------------------------------------------------------------
Sia_RenterDownloadFullGet PROC lpszSiaPath:DWORD, destination string, async bool
    ret
Sia_RenterDownloadFullGet ENDP

;------------------------------------------------------------------------------
; RenterClearAllDownloadsPost requests the /renter/downloads/clear resource
; with no parameters
;------------------------------------------------------------------------------
Sia_RenterClearAllDownloadsPost PROC
    ret
Sia_RenterClearAllDownloadsPost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsAfterPost requests the /renter/downloads/clear resource
; with only the after timestamp provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsAfterPost PROC after time.Time
    ret
Sia_RenterClearDownloadsAfterPost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsBeforePost requests the /renter/downloads/clear resource
; with only the before timestamp provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsBeforePost PROC before time.Time
    ret
Sia_RenterClearDownloadsBeforePost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsRangePost requests the /renter/downloads/clear resource
; with both before and after timestamps provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsRangePost PROC after, before time.Time
    ret
Sia_RenterClearDownloadsRangePost ENDP

;------------------------------------------------------------------------------
; RenterDownloadsGet requests the /renter/downloads resource
;------------------------------------------------------------------------------
Sia_RenterDownloadsGet PROC rdq api.RenterDownloadQueue, err error
    ret
Sia_RenterDownloadsGet ENDP

;------------------------------------------------------------------------------
; RenterDownloadHTTPResponseGet uses the /renter/download endpoint to download
; a file and return its data.
;------------------------------------------------------------------------------
Sia_RenterDownloadHTTPResponseGet PROC lpszSiaPath:DWORD, offset, length uint64) (resp []byte, err error
    ret
Sia_RenterDownloadHTTPResponseGet ENDP

;------------------------------------------------------------------------------
; RenterFileGet uses the /renter/file/:siapath endpoint to query a file.
;------------------------------------------------------------------------------
Sia_RenterFileGet PROC lpszSiaPath:DWORD (rf api.RenterFile, err error
    ret
Sia_RenterFileGet ENDP

;------------------------------------------------------------------------------
; RenterFilesGet requests the /renter/files resource.
;------------------------------------------------------------------------------
Sia_RenterFilesGet PROC cached bool) (rf api.RenterFiles, err error
    ret
Sia_RenterFilesGet ENDP

;------------------------------------------------------------------------------
; RenterGet requests the /renter resource.
;------------------------------------------------------------------------------
Sia_RenterGet PROC rg api.RenterGET, err error
    ret
Sia_RenterGet ENDP

;------------------------------------------------------------------------------
; RenterPostAllowance uses the /renter endpoint to change the renter's allowance
;------------------------------------------------------------------------------
Sia_RenterPostAllowance PROC allowance modules.Allowance
    ret
Sia_RenterPostAllowance ENDP

;------------------------------------------------------------------------------
; RenterCancelAllowance uses the /renter endpoint to cancel the allowance.
;------------------------------------------------------------------------------
Sia_RenterCancelAllowance PROC
    ret
Sia_RenterCancelAllowance ENDP

;------------------------------------------------------------------------------
; RenterPricesGet requests the /renter/prices endpoint's resources.
;------------------------------------------------------------------------------
Sia_RenterPricesGet PROC allowance modules.Allowance) (rpg api.RenterPricesGET, err error
    ret
Sia_RenterPricesGet ENDP

;------------------------------------------------------------------------------
; RenterPostRateLimit uses the /renter endpoint to change the renter's bandwidth rate
; limit.
;------------------------------------------------------------------------------
Sia_RenterPostRateLimit PROC readBPS, writeBPS int64
    ret
Sia_RenterPostRateLimit ENDP

;------------------------------------------------------------------------------
; RenterRenamePost uses the /renter/rename/:siapath endpoint to rename a file.
;------------------------------------------------------------------------------
Sia_RenterRenamePost PROC lpszSiaPathOld:DWORD, lpszSiaPathNew:DWORD
    ret
Sia_RenterRenamePost ENDP

;------------------------------------------------------------------------------
; RenterSetStreamCacheSizePost uses the /renter endpoint to change the renter's
; streamCacheSize for streaming
;------------------------------------------------------------------------------
Sia_RenterSetStreamCacheSizePost PROC cacheSize uint64
    ret
Sia_RenterSetStreamCacheSizePost ENDP

;------------------------------------------------------------------------------
; RenterSetCheckIPViolationPost uses the /renter endpoint to enable/disable the IP
; violation check in the renter.
;------------------------------------------------------------------------------
Sia_RenterSetCheckIPViolationPost PROC enabled bool
    ret
Sia_RenterSetCheckIPViolationPost ENDP

;------------------------------------------------------------------------------
; RenterStreamGet uses the /renter/stream endpoint to download data as a
; stream.
;------------------------------------------------------------------------------
Sia_RenterStreamGet PROC lpszSiaPath:DWORD (resp []byte, err error
    ret
Sia_RenterStreamGet ENDP

;------------------------------------------------------------------------------
; RenterStreamPartialGet uses the /renter/stream endpoint to download a part
; of data as a stream.
;------------------------------------------------------------------------------
Sia_RenterStreamPartialGet PROC lpszSiaPath:DWORD, start, end uint64) (resp []byte, err error
    ret
Sia_RenterStreamPartialGet ENDP

;------------------------------------------------------------------------------
; RenterSetRepairPathPost uses the /renter/tracking endpoint to set the repair
; path of a file to a new location. The file at newPath must exists.
;------------------------------------------------------------------------------
Sia_RenterSetRepairPathPost PROC lpszSiaPath:DWORD, lpszSiaPathNew:DWORD
    ret
Sia_RenterSetRepairPathPost ENDP

;------------------------------------------------------------------------------
; RenterSetFileStuckPost sets the 'stuck' field of the siafile at siaPath to
; stuck.
;------------------------------------------------------------------------------
Sia_RenterSetFileStuckPost PROC lpszSiaPath:DWORD, stuck bool
    ret
Sia_RenterSetFileStuckPost ENDP

;------------------------------------------------------------------------------
; RenterUploadPost uses the /renter/upload endpoint to upload a file
;------------------------------------------------------------------------------
Sia_RenterUploadPost PROC path string, lpszSiaPath:DWORD, dataPieces, parityPieces uint64
    ret
Sia_RenterUploadPost ENDP

;------------------------------------------------------------------------------
; RenterUploadForcePost uses the /renter/upload endpoint to upload a file
; and to overwrite if the file already exists
;------------------------------------------------------------------------------
Sia_RenterUploadForcePost PROC path string, lpszSiaPath:DWORD, dataPieces, parityPieces uint64, force bool
    ret
Sia_RenterUploadForcePost ENDP

;------------------------------------------------------------------------------
; RenterUploadDefaultPost uses the /renter/upload endpoint with default
; redundancy settings to upload a file.
;------------------------------------------------------------------------------
Sia_RenterUploadDefaultPost PROC path string, lpszSiaPath:DWORDh
    ret
Sia_RenterUploadDefaultPost ENDP

;------------------------------------------------------------------------------
; RenterUploadStreamPost uploads data using a stream.
;------------------------------------------------------------------------------
Sia_RenterUploadStreamPost PROC r io.Reader, lpszSiaPath:DWORD, dataPieces, parityPieces uint64, force bool
    ret
Sia_RenterUploadStreamPost ENDP

;------------------------------------------------------------------------------
; RenterUploadStreamRepairPost a siafile using a stream. If the data provided
; by r is not the same as the previously uploaded data, the data will be
; corrupted.
;------------------------------------------------------------------------------
Sia_RenterUploadStreamRepairPost PROC r io.Reader, lpszSiaPath:DWORD
    ret
Sia_RenterUploadStreamRepairPost ENDP

;------------------------------------------------------------------------------
; RenterDirCreatePost uses the /renter/dir/ endpoint to create a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirCreatePost PROC lpszSiaPath:DWORD
    ret
Sia_RenterDirCreatePost ENDP

;------------------------------------------------------------------------------
; RenterDirDeletePost uses the /renter/dir/ endpoint to delete a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirDeletePost PROC lpszSiaPath:DWORD
    ret
Sia_RenterDirDeletePost ENDP

;------------------------------------------------------------------------------
; RenterDirRenamePost uses the /renter/dir/ endpoint to rename a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirRenamePost PROC lpszSiaPath:DWORD, lpszSiaPathNew:DWORD
    ret
Sia_RenterDirRenamePost ENDP

;------------------------------------------------------------------------------
; RenterGetDir uses the /renter/dir/ endpoint to query a directory
;------------------------------------------------------------------------------
Sia_RenterGetDir PROC lpszSiaPath:DWORD (rd api.RenterDirectory, err error
    ret
Sia_RenterGetDir ENDP












;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; 
;------------------------------------------------------------------------------









