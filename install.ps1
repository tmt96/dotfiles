Write-Output "Welcome to tmt's dotfiles."
Write-Output "Please be aware that this script is for Windows only & may require admin command prompt"

. "$PSScriptRoot\scoop\install.ps1"
. "$PSScriptRoot\pwsh\install.ps1"
. "$PSScriptRoot\emacs\install.ps1"
. "$PSScriptRoot\vscode\install.ps1"
. "$PSScriptRoot\rust\install.ps1"

Write-Output "Done installing tmt's dotfiles for Windows"