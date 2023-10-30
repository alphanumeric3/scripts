# script.ps1 <ldap filter> <optional search root>
Param(
    [string]$Filter,
    # if this is empty, it defaults to where your account was made
    [string]$SearchRoot
)

$searcher = New-Object System.DirectoryServices.DirectorySearcher
$searcher.SearchRoot = New-Object System.DirectoryServices.DirectoryEntry($SearchRoot)
$searcher.Filter = "$Filter"
$searcher.FindAll()