. "$PSScriptRoot\GetXlsxPath.ps1"


function ImportExistingBudget{
    param(
        $month #for $abbMonthName for worksheet of xlsx.
    )

    #Determine csv or xlsx.   
    # $userInput = Read-Host "c for local csv, x for 2023Budget.xlsx"
    # if($userInput -eq "c"){
    #     $source = "csv"
    # }elseif($userInput -eq "x"){
    #     $source = "xlsx"
    # }
    $source = "xlsx"

    if($source -eq "csv"){
        $budgetcsvPath = "C:\PersonalMyCode\UpdateBudget\existingBudgetData.csv"
        LogMessage $MyInvocation.MyCommand.Name "Importing budget data from the local csv."
        return Import-Csv $budgetcsvPath  

    }elseif($source -eq "xlsx"){
        $rawXlsxData = @()
        #Determine $abbMonthName
        $abbMonths=@("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
        $abbMonthName = $abbMonths[$month -1]
        
        #Determine path.
        $xlsxPath = (GetXlsxPath)
        LogMessage $MyInvocation.MyCommand.Name "Importing budget data from 2024Budget.xlsx"
        LogMessage $MyInvocation.MyCommand.Name "abbmonthName is $abbMonthName"
        LogMessage $MyInvocation.MyCommand.Name "xlsx path is: $xlsxPath"
        while($true){
            try{
                $rawXlsxData = Import-Excel $xlsxPath -WorksheetName $abbMonthName -NoHeader -ImportColumns @(20,21,22,23,24,25) -startrow 8 -endrow 200
                break
            }catch{
                $userInput = Read-Host "Importing Excel data failed. Make sure it's closed. Try again? y/n"
                if($userInput -ne "y"){
                    exit
                }
            }
        }

        #Remove blank items. Add to refined data.
        $refinedXlsxData = @()
        foreach($item in $rawXlsxData){
            if($null -ne $item.P1){
                $nonBlankExpense = [PSCustomObject]@{
                    Date = [string](Get-Date $item.P1 -Format "MM/dd/yyyy")
                    Item = $item.P2
                    Description = $item.P3
                    Method = $item.P4
                    Category = $item.P5
                    Amount = [decimal]$item.P6
                }
            $refinedXlsxData += $nonBlankExpense
            }
        }
        # $i = 1
        # foreach($item in $refinedXlsxData){
        #     # LogMessage $MyInvocation.MyCommand.Name "$i : " -NoNewLine
        #     # LogMessage $MyInvocation.MyCommand.Name $item
        #     $i ++
        # }
        return $refinedXlsxData
    }
}
