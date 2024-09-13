function ArbitraryExceptionsModify {
    param (
        $verifiedExpenses
    )

    forEach($entry in $verifiedExpenses){
        if ($entry.Item -eq "loanDepot") {
            $entry.Description = "Mortgage"
            $entry.Category = "Mortgage"
        }
        if ($entry.Item -eq "Walmart") {
            $entry.Category = "Groceries"
        }
        if ($entry.Item -eq "Rocky Mountain Power") {
            $entry.Description = "Electricity"
            $entry.Category = "Electricity"
        }
        if ($entry.Item -eq "Tooele City Corpor Ut Visa") {
            $entry.Description = "Utilities"
            $entry.Category = "Utilities"
        }        
        if ($entry.Item -eq "Maverik") {
            $entry.Description = "Gasoline"
            $entry.Category = "Gasoline"
        }
        if ($entry.Item -eq "American Funds") {
            $entry.Description = "This will become millions"
            $entry.Category = "Investment"
        }
        if ($entry.Item -eq "Allstate") {
            $entry.Description = "Car Insurance"
            $entry.Category = "Car Insurance"
        }
        if ($entry.Item -eq "Fast Gas Convenience Store") {
            $entry.Description = ""
            $entry.Category = ""
        }
        if ($entry.Item -eq "Dominion Energy") {
            $entry.Description = "Dominion Energy"
            $entry.Category = "Dominion"
        }
        if ($entry.Item -eq "Costa Vida") {
            $entry.Description = ""
            $entry.Category = "Eating Out/Fun"
        }
        if ($entry.Item -eq "Xfinity Mobile") {
            $entry.Description = "Phones"
            $entry.Category = "Phones"
        }
        if ($entry.Item -eq "YouTube Premium") {
            $entry.Description = "YouTube Premium"
            $entry.Category = "YouTube Premium"
        }
        if ($entry.Item -eq "Costco Gas") {
            $entry.Description = "Gasoline"
            $entry.Category = "Gasoline"
        }
        if ($entry.Item -eq "Comcast") { # Irrelevant after Tooele Move?
            $entry.Description = "Internet"
            $entry.Category = "Internet"
        }
        if ($entry.Item -eq "Chevron") {
            $entry.Description = "Gasoline"
            $entry.Category = "Gasoline"
        }
        if ($entry.Item -eq "Beehive Smart Ut Visa") {
            $entry.Description = "Internet"
            $entry.Category = "Internet"
        }
        if ($entry.Item -eq "Fast Gas Convenience Store") {
            $entry.Description = "Gasoline"
            $entry.Category = "Gasoline"
        }




        

        

    }
    #Remove some entries.
    # for ($i = $verifiedExpenses.Count - 1; $i -ge 0; $i--) {
    #     if ($verifiedExpenses[$i].Item -eq "Fluckiger") {
    #         $verifiedExpenses.RemoveAt($i)
    #     }
    # }
    # $verifiedExpenses = $verifiedExpenses | Where-Object {
    #     $entry.Description = "Fluckiger"
    # }


    return $verifiedExpenses
}