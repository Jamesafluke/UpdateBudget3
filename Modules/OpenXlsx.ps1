function OpenXlsx{
    param(
        $xlsxPath
    )
    $userInput = 'y'
    # $userInput = Read-Host "Open Budget? y/n"
    if($userInput -eq "y"){
        Invoke-Item $xlsxPath
    }
}
