function Backup([String] $Item) {
    if (Test-Path $Item -PathType Container) {
        if (Test-Path "$Item.backup") {
            Remove-Item "$Item.backup" -Force -Confirm:$false -Recurse
        }
        $itemName = Split-Path $Item -leaf
        Rename-Item $Item "${itemName}.backup" -Confirm:$false -Force
    }
    elseif (Test-Path $Item -PathType Leaf) {
        Move-Item -Path $Item -Destination "${Item}.backup" -Force
    }
}

function Link([String] $Target, [String] $Link) {
    $AbsTarget = Resolve-Path $Target
    New-Item -ItemType SymbolicLink -Path $Link -Target $AbsTarget
}

function BackupAndLink([String] $Target, [String] $Path) {
    Backup $Path
    Link $Target $Path
}