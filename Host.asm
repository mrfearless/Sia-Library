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
Sia_HostAnnouncePost PROC
    ret
Sia_HostAnnouncePost ENDP

;------------------------------------------------------------------------------
; HostAnnounceAddrPost uses the /host/anounce endpoint to announce the host to 
; the network using the provided address
;------------------------------------------------------------------------------
Sia_HostAnnounceAddrPost PROC lpszNetAddress:DWORD
    ret
Sia_HostAnnounceAddrPost ENDP

;------------------------------------------------------------------------------
; HostContractInfoGet uses the /host/contracts endpoint to get information 
; about contracts on the host.
;------------------------------------------------------------------------------
Sia_HostContractInfoGet PROC
    ret
Sia_HostContractInfoGet ENDP

;------------------------------------------------------------------------------
; HostEstimateScoreGet requests the /host/estimatescore endpoint.
;------------------------------------------------------------------------------
Sia_HostEstimateScoreGet PROC lpszParam:DWORD, lpszValue:DWORD
    ret
Sia_HostEstimateScoreGet ENDP

;------------------------------------------------------------------------------
; HostGet requests the /host endpoint.
;------------------------------------------------------------------------------
Sia_HostGet PROC
    ret
Sia_HostGet ENDP

;------------------------------------------------------------------------------
; HostModifySettingPost uses the /host endpoint to change a param of the host
; settings to a certain value
;------------------------------------------------------------------------------
Sia_HostModifySettingPost PROC lpHostParam:DWORD, lpszValue:DWORD
    ret
Sia_HostModifySettingPost ENDP

;------------------------------------------------------------------------------
; HostStorageFoldersAddPost uses the /host/storage/folders/add api endpoint to
;  add a storage folder to a host
;------------------------------------------------------------------------------
Sia_HostStorageFoldersAddPost PROC lpszPath:DWORD, dwSize:DWORD
    ret
Sia_HostStorageFoldersAddPost ENDP

;------------------------------------------------------------------------------
; HostStorageFoldersRemovePost uses the /host/storage/folders/remove api
; endpoint to remove a storage folder from a host
;------------------------------------------------------------------------------
Sia_HostStorageFoldersRemovePost PROC lpszPath:DWORD
    ret
Sia_HostStorageFoldersRemovePost ENDP

;------------------------------------------------------------------------------
; HostStorageFoldersResizePost uses the /host/storage/folders/resize api
; endpoint to resize an existing storage folder.
;------------------------------------------------------------------------------
Sia_HostStorageFoldersResizePost PROC lpszPath:DWORD, dwSize:DWORD
    ret
Sia_HostStorageFoldersResizePost ENDP

;------------------------------------------------------------------------------
; HostStorageGet requests the /host/storage endpoint.
;------------------------------------------------------------------------------
Sia_HostStorageGet PROC
    ret
Sia_HostStorageGet ENDP

;------------------------------------------------------------------------------
; HostStorageSectorsDeletePost uses the /host/storage/sectors/delete endpoint
; to delete a sector from the host
;------------------------------------------------------------------------------
Sia_HostStorageSectorsDeletePost PROC lpszRootHash:DWORD
    ret
Sia_HostStorageSectorsDeletePost ENDP













