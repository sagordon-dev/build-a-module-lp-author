param (
    [ValidateNotNullOrEmpty()]
    [string]$Username = "", #this is parameter

    [ValidateSet("all", "owner", "member")]
    [string]$Type = "owner",

    [ValidateSet("asc", "desc")]
    [string]$Direction = "desc",

    [int]$PerPage = 3,

    [int]$Page = 1
)

$params = @{
    Headers = @{accept = "aplication/vnd.github+json"} #this is a headers section. We pass headers as a hashtable
    Uri = "https://api.github.com/users/$($username)/repos?type=$($type)&per_page=$($PerPage)&direction=$($Direction)" #this is a full URL, which includes the username and some query parameters      
    Method = "Get" #this is a method
}

Invoke-RestMethod @params #, and this is passing parameters by a technique called splatting.