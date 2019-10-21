function get-FZCurrentVersion {
    [cmdletbinding()]
    [outputtype([version])]
    $Url = "https://filezilla-project.org/download.php?show_all=1"
    $Content = Invoke-WebRequest -Uri $url
	# Determine version number
    $Matches = ($content.allelements | ? tagName -eq 'p').innerText -match "The latest stable version of FileZilla Client is (\d+){1,2}\.(\d+){1,2}(\.(\d+){1,2}){0,1}$"
    $Version = [version]::new($Matches[0].TrimStart("The latest stable version of FileZilla Client is "))
    Write-Output $Version
}
 
function get-FZCurrentDownloadURL {
    [cmdletbinding()]
    [outputtype([string])]
    $Url = "https://filezilla-project.org/download.php?show_all=1"
    $Content = Invoke-WebRequest -Uri $url
	# Determine version number
    $Matches = ($content.allelements | ? tagName -eq 'p').innerText -match "The latest stable version of FileZilla Client is (\d+){1,2}\.(\d+){1,2}(\.(\d+){1,2}){0,1}$"
    $Version = [version]::new($Matches[0].TrimStart("The latest stable version of FileZilla Client is "))
	# Determine download URL
    $cdnurl = ($content.allelements | ? tagName -eq 'a' | ? innerText -match "FileZilla_${Version}_win64-setup.exe").href
    # Extract download filename only
    $filename = (Split-Path ($cdnurl) -leaf).Split("?")[0]
    # Combine with non-CDN download source URL
    $url = "https://download.filezilla-project.org/client/$filename"
    Write-Output $url
}
# Example: Get-FZCurrentVersion
# At the moment only 64-Bit download implemented. The version without adware will be downloaded.

# Example: Get-FZCurrentDownloadURL
# wget -uri (Get-FZCurrentDownloadURL) -OutFile .\fz.exe
