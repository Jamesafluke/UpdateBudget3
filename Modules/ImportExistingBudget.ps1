
. "$PSScriptRoot\GetXlsxPath.ps1"


function ImportExistingBudget {
    param(
        $month #for $abbMonthName for worksheet of xlsx.
    )

    $source = "xlsx"

    if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
        LogMessage "ImportExistingBudget" "ImportExcel module not found. Installing now..."
        Install-Module -Name ImportExcel -Force -Scope CurrentUser
    }
    else {
        LogMessage "ImportExistingBudget" "ImportExcel module found."
    }

    if ($source -eq "csv") {
        $budgetcsvPath = "C:\PersonalMyCode\UpdateBudget\existingBudgetData.csv"
        LogMessage $MyInvocation.MyCommand.Name "Importing budget data from the local csv."
        return Import-Csv $budgetcsvPath  

    }
    elseif ($source -eq "xlsx") {
        $rawXlsxData = @()
        #Determine $abbMonthName
        $abbMonths = @("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
        $abbMonthName = $abbMonths[$month - 1]
        
        #Determine path.
        $xlsxPath = (GetXlsxPath)
        LogMessage $MyInvocation.MyCommand.Name "Importing budget data from 2026Budget.xlsx"
        LogMessage $MyInvocation.MyCommand.Name "abbMonthName is $abbMonthName"
        LogMessage $MyInvocation.MyCommand.Name "xlsx path is: $xlsxPath"
        while ($true) {
            try {
                Write-Host $xlsxPath
                Write-Host $abbMonthName
                $rawXlsxData = Import-Excel $xlsxPath -WorksheetName $abbMonthName -HeaderName @("Date", "Item", "Description", "Method", "Category", "Amount") -ImportColumns @(20, 21, 22, 23, 24, 25) -startrow 8 -endrow 200
                Write-Host $rawXlsxData
                break
            }
            catch {
                $userInput = Read-Host "Importing Excel data failed. Make sure it's closed. Try again? y/n"
                if ($userInput -ne "y") {
                    exit
                }
            }
        }

        #Remove blank items. Add to refined data.
        $refinedXlsxData = @()
        foreach ($item in $rawXlsxData) {
            if ($null -ne $item.Date) {
                $nonBlankExpense = [PSCustomObject]@{
                    Date        = (Get-Date $item.Date -Format "MM/dd/yyyy")
                    Item        = $item.Item
                    Description = $item.Description
                    Method      = $item.Method
                    Category    = $item.Category
                    Amount      = [decimal]$item.Amount
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
