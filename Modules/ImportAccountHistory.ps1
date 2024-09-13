function ImportAccountHistory{
    param(
        $year,
        $month,
        $accountHistoryPath
    )
    
    $accountHistory = Import-Csv $accountHistoryPath
    LogMessage $MyInvocation.MyCommand.Name "$($accountHistory.Count) items in ExportedTransactions"
    
    $filteredAccountHistory = $accountHistory | Where-Object {
        $entry = $_
        $postDate = Get-Date $entry."Posting Date"
                
        # Check if the year and month match
        if ([int]$postDate.Year -ne $year) {
            return $false
        }   
        if ([int]$postDate.Month -ne $month){
            return $false
        }
        return $true
    }

    #Make single digit month double digit by adding a zero.
    if($month.tostring().Length -eq 1){
        foreach($entry in $filteredAccountHistory){
            $entry."Post Date" = "0" + $entry."Posting Date"
        }
    }
    #Make single digit day double digit by adding a zero.
    foreach($entry in $filteredAccountHistory){
        if($entry."Posting Date".Length -eq 9){
            $entry."Posting Date" = $entry."Post Date".Insert(3, "0")
        }
    }

    LogMessage $MyInvocation.MyCommand.Name "After trimming extraneous months and years there are $($filteredAccountHistory.Count)."
    return $filteredAccountHistory
}