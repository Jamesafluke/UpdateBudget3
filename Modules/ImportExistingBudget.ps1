
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
                # Columns T-Y correspond to indices 20-25. 
                # Since headers are on row 7, we start importing data from row 8.
                $rawXlsxData = Import-Excel $xlsxPath -WorksheetName $abbMonthName -HeaderName @("Date", "Item", "Description", "Method", "Category", "Amount") -ImportColumns @(20, 21, 22, 23, 24, 25) -StartRow 8 -EndRow 200
                # Write-Host $rawXlsxData
                break
            }
            catch {
                Write-Warning "Failed to import Excel: $($_.Exception.Message)"
                $userInput = Read-Host "Importing Excel data failed. Make sure it's closed. Try again? y/n"
                if ($userInput -ne "y") {
                    return @()
                }
            }
        }

        #Remove blank items. Add to refined data.
        $refinedXlsxData = foreach ($item in $rawXlsxData) {
            if ($null -ne $item.Date) {
                try {
                    [PSCustomObject]@{
                        Date        = (Get-Date $item.Date -Format "MM/dd/yyyy")
                        Item        = [string]$item.Item
                        Description = [string]$item.Description
                        Method      = [string]$item.Method
                        Category    = [string]$item.Category
                        Amount      = [decimal]("$($item.Amount)" -replace '[^\d.-]', '')
                    }
                }
                catch {
                    Write-Warning "Skipping row with invalid data: $($item.Date) - $($item.Amount)"
                }
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
