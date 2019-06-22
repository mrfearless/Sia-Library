;==============================================================================
;
; Sia x86 Library by fearless
;
; http://github.com/mrfearless
;
;==============================================================================

.CODE

;------------------------------------------------------------------------------
; HostAnnouncePost uses the /host/announce endpoint to announce the host to the 
; network
;------------------------------------------------------------------------------
Sia_HostAnnouncePost PROC hSia:DWORD
    Invoke sia_api_host_announce, hSia
    ret
Sia_HostAnnouncePost ENDP

;------------------------------------------------------------------------------
; HostAnnounceAddrPost uses the /host/anounce endpoint to announce the host to 
; the network using the provided address
;------------------------------------------------------------------------------
Sia_HostAnnounceAddrPost PROC hSia:DWORD, lpszNetAddress:DWORD
    Invoke RpcSetQueryParameters, hSia, CTEXT("netaddress"), lpszNetAddress, 0
    Invoke sia_api_host_announce, hSia
    ret
Sia_HostAnnounceAddrPost ENDP

;------------------------------------------------------------------------------
; HostContractInfoGet uses the /host/contracts endpoint to get information 
; about contracts on the host.
;------------------------------------------------------------------------------
Sia_HostContractInfoGet PROC hSia:DWORD, lpContractInfoGet:DWORD
    Invoke sia_api_host_contracts, hSia, lpContractInfoGet
    ret
Sia_HostContractInfoGet ENDP

;------------------------------------------------------------------------------
; HostEstimateScoreGet requests the /host/estimatescore endpoint.
;------------------------------------------------------------------------------
Sia_HostEstimateScoreGet PROC hSia:DWORD, lpszParam:DWORD, lpszValue:DWORD, lpHostEstimateScoreGet:DWORD
    Invoke RpcSetQueryParameters, hSia, lpszParam, lpszValue, 0
    Invoke sia_api_host_estimatescore, hSia, lpHostEstimateScoreGet
    ret
Sia_HostEstimateScoreGet ENDP

;------------------------------------------------------------------------------
; HostGet requests the /host endpoint.
;------------------------------------------------------------------------------
Sia_HostGet PROC hSia:DWORD, lpHostGet:DWORD
    Invoke sia_api_host, hSia, lpHostGet
    ret
Sia_HostGet ENDP

;------------------------------------------------------------------------------
; HostModifySettingPost uses the /host endpoint to change a param of the host
; settings to a certain value
;------------------------------------------------------------------------------
Sia_HostModifySettingPost PROC hSia:DWORD, lpHostParam:DWORD, lpszValue:DWORD
    Invoke RpcSetQueryParameters, hSia, lpHostParam, lpszValue, 0
    Invoke sia_api_host, hSia, NULL
    ret
Sia_HostModifySettingPost ENDP

;------------------------------------------------------------------------------
; HostStorageFoldersAddPost uses the /host/storage/folders/add api endpoint to
;  add a storage folder to a host
;------------------------------------------------------------------------------
Sia_HostStorageFoldersAddPost PROC hSia:DWORD, lpszPath:DWORD, dwSize:DWORD
    .IF lpszPath == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetQueryParameters, hSia, CTEXT("path"), lpszPath, 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("size"), NULL, dwSize
    Invoke sia_api_host_storage_folders_add, hSia
    ret
Sia_HostStorageFoldersAddPost ENDP

;------------------------------------------------------------------------------
; HostStorageFoldersRemovePost uses the /host/storage/folders/remove api
; endpoint to remove a storage folder from a host
;------------------------------------------------------------------------------
Sia_HostStorageFoldersRemovePost PROC hSia:DWORD, lpszPath:DWORD
    .IF lpszPath == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetQueryParameters, hSia, CTEXT("path"), lpszPath, 0
    Invoke sia_api_host_storage_folders_remove, hSia
    ret
Sia_HostStorageFoldersRemovePost ENDP

;------------------------------------------------------------------------------
; HostStorageFoldersResizePost uses the /host/storage/folders/resize api
; endpoint to resize an existing storage folder.
;------------------------------------------------------------------------------
Sia_HostStorageFoldersResizePost PROC hSia:DWORD, lpszPath:DWORD, dwNewSize:DWORD
    .IF lpszPath == NULL
        xor eax, eax
        ret
    .ENDIF
    Invoke RpcSetQueryParameters, hSia, CTEXT("path"), lpszPath, 0
    Invoke RpcSetQueryParameters, hSia, CTEXT("newsize"), NULL, dwNewSize
    Invoke sia_api_host_storage_folders_resize, hSia
    ret
Sia_HostStorageFoldersResizePost ENDP

;------------------------------------------------------------------------------
; HostStorageGet requests the /host/storage endpoint.
;------------------------------------------------------------------------------
Sia_HostStorageGet PROC hSia:DWORD, lpStorageGet:DWORD
    Invoke sia_api_host_storage, hSia, lpStorageGet
    ret
Sia_HostStorageGet ENDP

;------------------------------------------------------------------------------
; HostStorageSectorsDeletePost uses the /host/storage/sectors/delete endpoint
; to delete a sector from the host
;------------------------------------------------------------------------------
Sia_HostStorageSectorsDeletePost PROC hSia:DWORD, lpszRootHash:DWORD
    Invoke sia_api_host_storage_sectors_delete, hSia, lpszRootHash
    ret
Sia_HostStorageSectorsDeletePost ENDP













