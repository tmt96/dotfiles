. "$PSScriptRoot\..\function.ps1"

Write-Output ""
Write-Output "Configuring emacs..."


Backup ${HOME}/.emacs
Backup ${HOME}/.emacs.d

if (Test-Path -PathType Container ${HOME}\spacemacs) {
    git --git-dir=${HOME}\spacemacs\.git checkout develop
    git --git-dir=${HOME}\spacemacs\.git reset --hard
    git --git-dir=${HOME}\spacemacs\.git pull --rebase
}
else {
    Write-Output "You don't have an spacemacs config. Cloning spacemacs..."
    git clone --branch develop https://github.com/syl20bnr/spacemacs ${HOME}\spacemacs
}

Write-Output "Symlinking spacemacs config..."
BackupAndLink $PSScriptRoot\.spacemacs ${HOME}\.spacemacs

if (Test-Path -PathType Container ${HOME}\doom-emacs) {
    & "${HOME}\doom-emacs\bin\doom" upgrade -f
}
else {
    Write-Output "You don't have an Doom Emacs config. Cloning Doom Emacs..."
    git clone --depth 1 https://github.com/hlissner/doom-emacs ${HOME}\doom-emacs
}

Write-Output "Symlinking Doom emacs config..."
BackupAndLink $PSScriptRoot\.doom.d ${HOME}\.doom.d
. "${HOME}\doom-emacs\bin\doom" install -y

Write-Output "Installing chemacs & configuring profiles"
Invoke-WebRequest -OutFile $HOME\.emacs -URI https://raw.githubusercontent.com/plexus/chemacs/master/.emacs
BackupAndLink $PSScriptRoot\.emacs-profiles.el $HOME\.emacs-profiles.el
Link $HOME\doom-emacs ${HOME}\.emacs.d

Write-Output "Done configuring emacs!!"
Write-Output ""