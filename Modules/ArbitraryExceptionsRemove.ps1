function ArbitraryExceptionsRemove {
    param(
        $verifiedExpenses
    )

    $trimmedExpenses = @()

    foreach ($item in $verifiedExpenses) {
        $remove = $false
        if ($item.Item -eq "Fluckiger") {
            $remove = $true
        }
        elseif ($item.Item -eq "Credit Card Payment") {
            $remove = $true
        }
        elseif ($item.Item -eq "Dep Cloud Bee Direct Deposit") {
            $remove = $true
        }
        elseif ($item.Item -eq "Dep Cloudbees Direct Deposit") {
            $remove = $true
        }
        elseif ($item.Item -eq "loanDepot") {
            $remove = $true
        }
        elseif ($item.Item -eq "Payment to Loandepot") {
            $remove = $true
        }
        elseif ($item.Item -eq "Transfer To 100109572900") {
            $remove = $true
        }
        elseif ($item.Item -eq "Transfer To 2900") {
            $remove = $true
        }
        elseif ($item.Item -eq "Salary/Regular Income from Insight Global") {
            $remove = $true
        }
        elseif ($item.Item -eq "Withdrawal Trans") {
            $remove = $true
        }
        elseif ($item.Item -eq "Salary/Regular Income from Classic Vacations") {
            $remove = $true
        }
        elseif ($item.Item -eq "From Share 50") {
            $remove = $true
        }
        elseif ($item.Item -eq "Salary/Regular Income from Halo") {
            $remove = $true
        }
        elseif ($item.Item -eq "Deposit Ach 1563 Type: Payroll CO: XX6350 Cloudbees Entry Class Code: Ach Trace Number: 1") {
            $remove = $true
        }
        elseif ($item.Item -eq "Ach Deposit Comment: Type: Payroll CO: Halomd, Llc - Halomd, Llc") {
            $remove = $true
        }
        elseif ($item.Item -eq "Ach Deposit Company: Halomd, Llc Entry: Payroll Fluckiger James") {
            $remove = $true
        }
        elseif ($item.Item -eq "Withdrawal Transfer To L0001") {
            $remove = $true
        }
        elseif ($item.Item -eq "Credit Card Payment Received") {
            $remove = $true
        }


        if ($remove -ne $true) {
            $trimmedExpenses += $item
        }

    }

    $numberRemoved = $verifiedExpenses.count - $trimmedExpenses.count
    LogMessage $MyInvocation.MyCommand.Name "Removed $numberRemoved arbitrary exceptions."
    return $trimmedExpenses
}