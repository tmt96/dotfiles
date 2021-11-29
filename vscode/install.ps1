. "$PSScriptRoot\..\function.ps1"

Write-Output ""
Write-Output "Configuring VSCode"
Write-Output "Installing your extensions"
foreach ($ext in Get-Content "$PSScriptRoot\extensions") {
    code --install-extension $ext | Out-Null
}

Write-Output "Configure settings & keybindings"
$destDir = "$ENV:APPDATA\Code\User"
foreach ($file in Get-Item "$PSScriptRoot/*.json") {
    $fileName = Split-Path $file -leaf
    Write-Output "Configuring $fileName"
    BackupAndLink $file "$destDir\$fileName"
}

Write-Output "Done configuring VSCode!!"
Write-Output ""
