Param(
    [string]$Filter,
    # if this is empty, it defaults to where your account was made
    [string]$SearchRoot,
    [string]$OutputFile
)

# create a searcher and set it to search the <domain> directory
$searcher = New-Object System.DirectoryServices.DirectorySearcher
# i needed to use this, otherwise it would only look in students.<domain>
$searcher.SearchRoot = New-Object System.DirectoryServices.DirectoryEntry($SearchRoot)

# get the initial list of servers
$searcher.Filter = "$Filter"
# i didn't know about foreach statements until today
$list = foreach ($result in $searcher.FindAll()) {
    echo $result.Properties.dnshostname
}

# create a separate list of servers that respond
foreach ($server in $list) {
    echo "Checking $server"
    ping -n 1 -w 50 $server
    if ("$?" -eq "True") {
        echo "$server" >> $OutputFile
    }
}