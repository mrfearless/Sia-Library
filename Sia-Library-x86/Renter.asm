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
Sia_RenterAllContractsGet PROC hSia:DWORD, lpRenterContractsGet:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("disabled"), CTEXT("true"), 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("expired"), CTEXT("true"), 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("recoverable"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, lpRenterContractsGet
    ret
Sia_RenterAllContractsGet ENDP

;------------------------------------------------------------------------------
; RenterContractsGet requests the /renter/contracts resource and returns
; Contracts and ActiveContracts
;------------------------------------------------------------------------------
Sia_RenterContractsGet PROC hSia:DWORD, lpRenterContractsGet:DWORD
    Invoke sia_api_renter_contracts, hSia, lpRenterContractsGet
    ret
Sia_RenterContractsGet ENDP

;------------------------------------------------------------------------------
; RenterDisabledContractsGet requests the /renter/contracts resource with the
; disabled flag set to true
;------------------------------------------------------------------------------
Sia_RenterDisabledContractsGet PROC hSia:DWORD, lpRenterContractsGet:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("disabled"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, lpRenterContractsGet
    ret
Sia_RenterDisabledContractsGet ENDP

;------------------------------------------------------------------------------
; RenterInactiveContractsGet requests the /renter/contracts resource with the
; inactive flag set to true
;------------------------------------------------------------------------------
Sia_RenterInactiveContractsGet PROC hSia:DWORD, lpRenterContractsGet:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("inactive"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, lpRenterContractsGet
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
Sia_RenterContractRecoveryProgressGet PROC hSia:DWORD, lpRenterRecoveryStatusGet:DWORD
    Invoke sia_api_renter_recoveryscan, hSia, lpRenterRecoveryStatusGet
    ret
Sia_RenterContractRecoveryProgressGet ENDP

;------------------------------------------------------------------------------
; RenterExpiredContractsGet requests the /renter/contracts resource with the
; expired flag set to true
;------------------------------------------------------------------------------
Sia_RenterExpiredContractsGet PROC hSia:DWORD, lpRenterContractsGet:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("expired"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, lpRenterContractsGet
    ret
Sia_RenterExpiredContractsGet ENDP

;------------------------------------------------------------------------------
; RenterRecoverableContractsGet requests the /renter/contracts resource with the
; recoverable flag set to true
;------------------------------------------------------------------------------
Sia_RenterRecoverableContractsGet PROC hSia:DWORD, lpRenterContractsGet:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("recoverable"), CTEXT("true"), 0
    Invoke sia_api_renter_contracts, hSia, lpRenterContractsGet
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
Sia_RenterBackups PROC hSia:DWORD, lpRenterBackupsGet:DWORD
    Invoke sia_api_renter_backups, hSia, lpRenterBackupsGet
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
Sia_RenterDownloadFullGet PROC USES EBX hSia:DWORD, lpszSiaPath:DWORD, lpszDestination:DWORD, bAsync:DWORD
    LOCAL hJSON:DWORD
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
    Invoke RpcSetQueryParameters, hSia, CTEXT("httpresp"), CTEXT("false"), 0
    .IF bAsync == TRUE
        Invoke RpcSetQueryParameters, hSia, CTEXT("async"), CTEXT("true"), 0
    .ELSE
        Invoke RpcSetQueryParameters, hSia, CTEXT("async"), CTEXT("false"), 0
    .ENDIF
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    ;Invoke sia_api_renter_download, hSia
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_DOWNLOAD, Addr hJSON, NULL
    .IF eax == TRUE
        Invoke cJSON_GetObjectItemCaseSensitive, hJSON, CTEXT("ID") 
        .IF eax != NULL
            mov eax, [ebx].cJSON.valuestring
        .ELSE
            mov eax, NULL
        .ENDIF
    .ELSE
        mov eax, NULL
    .ENDIF
    ret
Sia_RenterDownloadFullGet ENDP

;------------------------------------------------------------------------------
; RenterClearAllDownloadsPost requests the /renter/downloads/clear resource
; with no parameters
;------------------------------------------------------------------------------
Sia_RenterClearAllDownloadsPost PROC hSia:DWORD
    Invoke sia_api_renter_downloads_clear, hSia
    ret
Sia_RenterClearAllDownloadsPost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsAfterPost requests the /renter/downloads/clear resource
; with only the after timestamp provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsAfterPost PROC hSia:DWORD, dwAfterTime:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("after"), NULL, dwAfterTime
    Invoke sia_api_renter_downloads_clear, hSia
    ret
Sia_RenterClearDownloadsAfterPost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsBeforePost requests the /renter/downloads/clear resource
; with only the before timestamp provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsBeforePost PROC hSia:DWORD, dwBeforeTime:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("before"), NULL, dwBeforeTime
    Invoke sia_api_renter_downloads_clear, hSia
    ret
Sia_RenterClearDownloadsBeforePost ENDP

;------------------------------------------------------------------------------
; RenterClearDownloadsRangePost requests the /renter/downloads/clear resource
; with both before and after timestamps provided
;------------------------------------------------------------------------------
Sia_RenterClearDownloadsRangePost PROC hSia:DWORD, dwAfterTime:DWORD, dwBeforeTime:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("after"), NULL, dwAfterTime
    Invoke RpcSetQueryParameters, hSia, CTEXT("before"), NULL, dwBeforeTime
    Invoke sia_api_renter_downloads_clear, hSia
    ret
Sia_RenterClearDownloadsRangePost ENDP

;------------------------------------------------------------------------------
; RenterDownloadsGet requests the /renter/downloads resource
;------------------------------------------------------------------------------
Sia_RenterDownloadsGet PROC hSia:DWORD, lpRenterDownloadQueueGet:DWORD
    Invoke sia_api_renter_downloads, hSia, lpRenterDownloadQueueGet
    ret
Sia_RenterDownloadsGet ENDP

;------------------------------------------------------------------------------
; RenterDownloadHTTPResponseGet uses the /renter/download endpoint to download
; a file and return its data.
;------------------------------------------------------------------------------
Sia_RenterDownloadHTTPResponseGet PROC hSia:DWORD, lpszSiaPath:DWORD, dwOffset:DWORD, dwLength:DWORD, lpResponse:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("httpresp"), CTEXT("true"), 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("offset"), 0, dwOffset
    Invoke RpcSetQueryParameters, hSia, CTEXT("length"), 0, dwLength
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    ;Invoke sia_api_renter_download, hSia
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_DOWNLOAD, lpResponse, NULL
    ret
Sia_RenterDownloadHTTPResponseGet ENDP

;------------------------------------------------------------------------------
; RenterFileGet uses the /renter/file/:siapath endpoint to query a file.
;------------------------------------------------------------------------------
Sia_RenterFileGet PROC hSia:DWORD, lpszSiaPath:DWORD, lpRenterFileGet:DWORD
    Invoke RpcSetPathVariable, hSia, lpszSiaPath
    Invoke sia_api_renter_file, hSia, lpRenterFileGet
    ret
Sia_RenterFileGet ENDP

;------------------------------------------------------------------------------
; RenterFilesGet requests the /renter/files resource.
;------------------------------------------------------------------------------
Sia_RenterFilesGet PROC hSia:DWORD, bCached:DWORD, lpRenterFilesGet:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    .IF bCached == TRUE
        Invoke RpcSetQueryParameters, hSia, CTEXT("cached"), CTEXT("true"), 0
    .ELSE
        Invoke RpcSetQueryParameters, hSia, CTEXT("cached"), CTEXT("false"), 0
    .ENDIF
    Invoke sia_api_renter_files, hSia, lpRenterFilesGet 
    ret
Sia_RenterFilesGet ENDP

;------------------------------------------------------------------------------
; RenterGet requests the /renter resource.
;------------------------------------------------------------------------------
Sia_RenterGet PROC hSia:DWORD, lpRenterGet:DWORD
    Invoke sia_api_renter, hSia, lpRenterGet
    ret
Sia_RenterGet ENDP

;------------------------------------------------------------------------------
; RenterPostAllowance uses the /renter endpoint to change the renter's allowance
;------------------------------------------------------------------------------
Sia_RenterPostAllowance PROC USES EBX hSia:DWORD, lpStructRenterAllowance:DWORD
    mov ebx, lpStructRenterAllowance
    Invoke Sia_WithFunds, hSia, [ebx].RENTER_ALLOWANCE.Funds
    Invoke Sia_WithHosts, hSia, [ebx].RENTER_ALLOWANCE.Hosts
	Invoke Sia_WithPeriod, hSia, [ebx].RENTER_ALLOWANCE.Period
	Invoke Sia_WithRenewWindow, hSia, [ebx].RENTER_ALLOWANCE.RenewWindow
	Invoke Sia_WithExpectedStorage, hSia, [ebx].RENTER_ALLOWANCE.ExpectedStorage
	Invoke Sia_WithExpectedUpload, hSia, [ebx].RENTER_ALLOWANCE.ExpectedUpload
	Invoke Sia_WithExpectedDownload, hSia, [ebx].RENTER_ALLOWANCE.ExpectedDownload
	Invoke Sia_WithExpectedRedundancy, hSia, [ebx].RENTER_ALLOWANCE.ExpectedRedundancy
	Invoke sia_api_renter, hSia, NULL ; send POST
    ret
Sia_RenterPostAllowance ENDP

;------------------------------------------------------------------------------
; RenterCancelAllowance uses the /renter endpoint to cancel the allowance.
;------------------------------------------------------------------------------
Sia_RenterCancelAllowance PROC hSia:DWORD
    Invoke RpcSetQueryParameters, hSia, NULL, NULL, NULL
    Invoke sia_api_renter, hSia, NULL ; send POST
    ret
Sia_RenterCancelAllowance ENDP

;------------------------------------------------------------------------------
; RenterPricesGet requests the /renter/prices endpoint's resources.
;------------------------------------------------------------------------------
Sia_RenterPricesGet PROC USES EBX hSia:DWORD, lpStructRenterAllowance:DWORD, lpRenterPricesGet:DWORD
    mov ebx, lpStructRenterAllowance
    Invoke Sia_WithFunds, hSia, [ebx].RENTER_ALLOWANCE.Funds
    Invoke Sia_WithHosts, hSia, [ebx].RENTER_ALLOWANCE.Hosts
	Invoke Sia_WithPeriod, hSia, [ebx].RENTER_ALLOWANCE.Period
	Invoke Sia_WithRenewWindow, hSia, [ebx].RENTER_ALLOWANCE.RenewWindow
    Invoke sia_api_renter_prices, hSia, lpRenterPricesGet
    ret
Sia_RenterPricesGet ENDP

;------------------------------------------------------------------------------
; RenterPostRateLimit uses the /renter endpoint to change the renter's bandwidth rate
; limit.
;------------------------------------------------------------------------------
Sia_RenterPostRateLimit PROC hSia:DWORD, dwReadBPS:DWORD, dwWriteBPS:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("maxdownloadspeed"), NULL, dwReadBPS
    Invoke RpcSetQueryParameters, hSia, CTEXT("maxuploadspeed"), NULL, dwWriteBPS
    Invoke sia_api_renter, hSia, NULL ; send POST
    ret
Sia_RenterPostRateLimit ENDP

;------------------------------------------------------------------------------
; RenterRenamePost uses the /renter/rename/:siapath endpoint to rename a file.
;------------------------------------------------------------------------------
Sia_RenterRenamePost PROC hSia:DWORD, lpszSiaPathOld:DWORD, lpszSiaPathNew:DWORD
    LOCAL szEscapedSiaPathOld[MAX_PATH]:BYTE
    LOCAL szEscapedSiaPathNew[MAX_PATH]:BYTE
    
    .IF lpszSiaPathOld == NULL && lpszSiaPathNew == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPathOld, Addr szEscapedSiaPathOld
    Invoke Sia_escapeSiaPath, lpszSiaPathNew, Addr szEscapedSiaPathNew
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("newsiapath"), Addr szEscapedSiaPathNew, 0
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPathOld
    Invoke sia_api_renter_rename, hSia
    ret
Sia_RenterRenamePost ENDP

;------------------------------------------------------------------------------
; RenterSetStreamCacheSizePost uses the /renter endpoint to change the renter's
; streamCacheSize for streaming
;------------------------------------------------------------------------------
Sia_RenterSetStreamCacheSizePost PROC hSia:DWORD, dwCacheSize:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    Invoke RpcSetQueryParameters, hSia, CTEXT("streamcachesize"), NULL, dwCacheSize
    Invoke sia_api_renter_rename, hSia
    ret
Sia_RenterSetStreamCacheSizePost ENDP

;------------------------------------------------------------------------------
; RenterSetCheckIPViolationPost uses the /renter endpoint to enable/disable the IP
; violation check in the renter.
;------------------------------------------------------------------------------
Sia_RenterSetCheckIPViolationPost PROC hSia:DWORD, bEnabled:DWORD
    Invoke RpcSetQueryParameters, hSia, 0, 0, 0 ; clear out previous
    .IF bEnabled == TRUE
        Invoke RpcSetQueryParameters, hSia, CTEXT("checkforipviolation"), CTEXT("true"), 0
    .ELSE
        Invoke RpcSetQueryParameters, hSia, CTEXT("checkforipviolation"), CTEXT("false"), 0
    .ENDIF
    Invoke sia_api_renter_rename, hSia
    ret
Sia_RenterSetCheckIPViolationPost ENDP

;------------------------------------------------------------------------------
; RenterStreamGet uses the /renter/stream endpoint to download data as a
; stream.
;------------------------------------------------------------------------------
Sia_RenterStreamGet PROC hSia:DWORD, lpszSiaPath:DWORD, lpResponse:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_STREAM, lpResponse, NULL
    ret
Sia_RenterStreamGet ENDP

;------------------------------------------------------------------------------
; RenterStreamPartialGet uses the /renter/stream endpoint to download a part
; of data as a stream.
;------------------------------------------------------------------------------
Sia_RenterStreamPartialGet PROC hSia:DWORD, lpszSiaPath:DWORD, dwStart:DWORD, dwEnd:DWORD, lpResponse:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    ; todo add range header: "Range: bytes=0-1023"
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke SIA_RPC_GET, hSia, Addr SIA_API_URL_RENTER_STREAM, lpResponse, NULL
    ret
Sia_RenterStreamPartialGet ENDP

;------------------------------------------------------------------------------
; RenterSetRepairPathPost uses the /renter/tracking endpoint to set the repair
; path of a file to a new location. The file at newPath must exists.
;------------------------------------------------------------------------------
Sia_RenterSetRepairPathPost PROC hSia:DWORD, lpszSiaPath:DWORD, lpszSiaPathNew:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    LOCAL szEscapedSiaPathNew[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL && lpszSiaPathNew == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke Sia_escapeSiaPath, lpszSiaPathNew, Addr szEscapedSiaPathNew
    Invoke RpcSetQueryParameters, hSia, CTEXT("trackingpath"), Addr szEscapedSiaPathNew, 0
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_file, hSia, NULL
    ret
Sia_RenterSetRepairPathPost ENDP

;------------------------------------------------------------------------------
; RenterSetFileStuckPost sets the 'stuck' field of the siafile at siaPath to
; stuck.
;------------------------------------------------------------------------------
Sia_RenterSetFileStuckPost PROC hSia:DWORD, lpszSiaPath:DWORD, bStuck:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    .IF bStuck == TRUE
        Invoke RpcSetQueryParameters, hSia, CTEXT("stuck"), CTEXT("true"), 0
    .ELSE
        Invoke RpcSetQueryParameters, hSia, CTEXT("stuck"), CTEXT("false"), 0
    .ENDIF
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_file, hSia, NULL
    ret
Sia_RenterSetFileStuckPost ENDP

;------------------------------------------------------------------------------
; RenterUploadPost uses the /renter/upload endpoint to upload a file
;------------------------------------------------------------------------------
Sia_RenterUploadPost PROC hSia:DWORD, lpszPath:DWORD, lpszSiaPath:DWORD, dwDataPieces:DWORD, dwParityPieces:DWORD
    Invoke Sia_RenterUploadForcePost, hSia, lpszPath, lpszSiaPath, dwDataPieces, dwParityPieces, FALSE
    ret
Sia_RenterUploadPost ENDP

;------------------------------------------------------------------------------
; RenterUploadForcePost uses the /renter/upload endpoint to upload a file
; and to overwrite if the file already exists
;------------------------------------------------------------------------------
Sia_RenterUploadForcePost PROC hSia:DWORD, lpszPath:DWORD, lpszSiaPath:DWORD, dwDataPieces:DWORD, dwParityPieces:DWORD, bForce:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszPath == NULL && lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, CTEXT("source"), lpszPath, 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("datapieces"), NULL, dwDataPieces
    Invoke RpcSetQueryParameters, hSia, CTEXT("paritypieces"), NULL, dwParityPieces
    .IF bForce == TRUE
        Invoke RpcSetQueryParameters, hSia, CTEXT("force"), CTEXT("true"), 0
    .ELSE
        Invoke RpcSetQueryParameters, hSia, CTEXT("force"), CTEXT("false"), 0
    .ENDIF
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_upload, hSia
    ret
Sia_RenterUploadForcePost ENDP

;------------------------------------------------------------------------------
; RenterUploadDefaultPost uses the /renter/upload endpoint with default
; redundancy settings to upload a file.
;------------------------------------------------------------------------------
Sia_RenterUploadDefaultPost PROC hSia:DWORD, lpszPath:DWORD, lpszSiaPath:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszPath == NULL && lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, CTEXT("source"), lpszPath, 0
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_upload, hSia
    ret
Sia_RenterUploadDefaultPost ENDP

;------------------------------------------------------------------------------
; RenterUploadStreamPost uploads data using a stream.
;------------------------------------------------------------------------------
Sia_RenterUploadStreamPost PROC hSia:DWORD, pStreamData:DWORD, lpszSiaPath:DWORD, dwDataPieces:DWORD, dwParityPieces:DWORD, bForce:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, CTEXT("datapieces"), NULL, dwDataPieces
    Invoke RpcSetQueryParameters, hSia, CTEXT("paritypieces"), NULL, dwParityPieces
    Invoke RpcSetQueryParameters, hSia, CTEXT("stream"), CTEXT("true"), 0
    .IF bForce == TRUE
        Invoke RpcSetQueryParameters, hSia, CTEXT("force"), CTEXT("true"), 0
    .ELSE
        Invoke RpcSetQueryParameters, hSia, CTEXT("force"), CTEXT("false"), 0
    .ENDIF
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_uploadstream, hSia, pStreamData, NULL ; todo handle stream?
    ret
Sia_RenterUploadStreamPost ENDP

;------------------------------------------------------------------------------
; RenterUploadStreamRepairPost a siafile using a stream. If the data provided
; by r is not the same as the previously uploaded data, the data will be
; corrupted.
;------------------------------------------------------------------------------
Sia_RenterUploadStreamRepairPost PROC hSia:DWORD, pStreamData:DWORD, lpszSiaPath:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, CTEXT("repair"), CTEXT("true"), 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("stream"), CTEXT("true"), 0
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_uploadstream, hSia, pStreamData, NULL ; todo handle stream?
    ret
Sia_RenterUploadStreamRepairPost ENDP

;------------------------------------------------------------------------------
; RenterDirCreatePost uses the /renter/dir/ endpoint to create a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirCreatePost PROC hSia:DWORD, lpszSiaPath:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, CTEXT("action"), CTEXT("create"), 0
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_dir, hSia, NULL ; POST
    ret
Sia_RenterDirCreatePost ENDP

;------------------------------------------------------------------------------
; RenterDirDeletePost uses the /renter/dir/ endpoint to delete a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirDeletePost PROC hSia:DWORD, lpszSiaPath:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, CTEXT("action"), CTEXT("delete"), 0
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_dir, hSia, NULL ; POST
    ret
Sia_RenterDirDeletePost ENDP

;------------------------------------------------------------------------------
; RenterDirRenamePost uses the /renter/dir/ endpoint to rename a directory for the
; renter
;------------------------------------------------------------------------------
Sia_RenterDirRenamePost PROC hSia:DWORD, lpszSiaPath:DWORD, lpszSiaPathNew:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetQueryParameters, hSia, CTEXT("action"), CTEXT("rename"), 0
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_dir, hSia, NULL ; POST
    ret
Sia_RenterDirRenamePost ENDP

;------------------------------------------------------------------------------
; RenterGetDir uses the /renter/dir/ endpoint to query a directory
;------------------------------------------------------------------------------
Sia_RenterGetDir PROC hSia:DWORD, lpszSiaPath:DWORD, lpRenterDirectoryGet:DWORD
    LOCAL szEscapedSiaPath[MAX_PATH]:BYTE
    
    .IF lpszSiaPath == NULL
        xor eax, eax
        ret
    .ENDIF
    
    Invoke Sia_escapeSiaPath, lpszSiaPath, Addr szEscapedSiaPath
    Invoke RpcSetPathVariable, hSia, Addr szEscapedSiaPath
    Invoke sia_api_renter_dir, hSia, lpRenterDirectoryGet ; GET
    ret
Sia_RenterGetDir ENDP






