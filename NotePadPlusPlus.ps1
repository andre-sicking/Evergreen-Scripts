function get-NPPCurrentVersion {
    [cmdletbinding()]
    [outputtype([version])]
    $Url = "https://notepad-plus-plus.org/downloads/"
    $Content = Invoke-WebRequest -Uri $url
    $Matches = ($content.allelements | ? tagName -eq 'a').innerText -match "Current Version \d+\.\d+(\.\d+){0,1}$"
    $ver = [version]::new($Matches[0].TrimStart("Current Version "))
    Write-Output $ver
}

function get-NPPCurrentDownloadURL {
    [cmdletbinding()]
    [outputtype([string])]
    param (
        [validateSet("x86","x64")][string]$Architecture = "x64"
    )
    $version = get-NPPCurrentVersion
    if ("x86" -eq $Architecture) { $archcode = "" } else { $archcode = ".x64" }
    $url = "http://download.notepad-plus-plus.org/repository/$($version.major).x/$version/npp.$($version).Installer$($archcode).exe"
    Write-Output $url
}
#Example get-NPPCurrentDownloadURL -Architecture x64

#Example wget -uri (get-NPPCurrentDownloadURL) -OutFile .\npp.exe