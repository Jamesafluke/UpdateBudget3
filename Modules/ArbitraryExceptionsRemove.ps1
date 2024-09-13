function ArbitraryExceptionsRemove {
    param(
        $verifiedExpenses
    )

    $trimmedExpenses = @()

    foreach($item in $verifiedExpenses){
        $remove = $false
        if($item.Item -eq "Fluckiger"){
            $remove = $true
        }
        elseif($item.Item -eq "Credit Card Payment"){
            $remove = $true
        }
        elseif($item.Item -eq "Dep Cloud Bee Direct Deposit"){
            $remove = $true
        }
        elseif($item.Item -eq "Dep Cloudbees Direct Deposit"){
            $remove = $true
        }
        elseif($item.Item -eq "loanDepot"){
            $remove = $true
        }
        elseif($item.Item -eq "Transfer To 100109572900"){
            $remove = $true
        }
        elseif($item.Item -eq "Transfer To 2900"){
            $remove = $true
        }
        
        


        if($remove -ne $true){
            $trimmedExpenses += $item
        }

    }

    $numberRemoved = $verifiedExpenses.count - $trimmedExpenses.count
    LogMessage $MyInvocation.MyCommand.Name "Removed $numberRemoved arbitrary exceptions."
    return $trimmedExpenses
}