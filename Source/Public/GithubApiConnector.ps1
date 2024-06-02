$securePatToken = ConvertTo-SecureString -String $env:GITHUB_PAT -AsPlainText -Force
$serverUrl = "https://api.github.com"
$apiVersion = "2022-11-28"

function Connect {
    param (
        $patToken,
        $serverUrl,
        $apiVersion
    )

    # Convert the secure string PAT token to plain text (only for use in the header, avoid storing it as plain text)
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePatToken)
    $plainTextPatToken = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    # Create the headers for the request
    $headers = @{
        "Authorization"        = "Authorization $plainTextPatToken"
        "X-GitHub-Api-Version" = $apiVersion
    }

    $response = Invoke-RestMethod -Uri $serverUrl -Method Get -Headers $headers

    # Branching logic to check if the connection was successful
    if ($response) {
        Write-Output "Connection successful"
    }
    else {
        Write-Output "Connection failed"
    }

    return $response
    
}

Connect -patToken $securePatToken -serverUrl $serverUrl -apiVersion $apiVersion