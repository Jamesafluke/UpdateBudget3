function DeleteAccountHistoryFiles {
    param(
        [string]$Path1,
        [string]$Path2
    )
    $userInput = Read-Host "Delete AccountHistory files? y/n"
    if ($userInput -eq 'y') {
        # Check and delete the first file
        if ($Path1 -and (Test-Path -Path $Path1 -PathType Leaf)) {
            LogMessage $MyInvocation.MyCommand.Name "Deleting $Path1"
            Remove-ItemSafely $Path1
        }

        # Check and delete the second file
        if ($Path2 -and (Test-Path -Path $Path2 -PathType Leaf)) {
            LogMessage $MyInvocation.MyCommand.Name "Deleting $Path2"
            Remove-ItemSafely $Path2
        }
    }
}