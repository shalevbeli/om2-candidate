function Install-Feature {
    <#
    .SYNOPSIS
        Returns a message with the function status weither it succeded or not, and why.

    .DESCRIPTION
        Install-Feature is a function that installs a list of features given by the user to the currently connected host.

    .PARAMETER ComputerName
        The remote computer(s) to install the services on.

    .PARAMETER Features
        The Features in a list format to be installed on the server.

    .PARAMETER Credential
        Specifies a user account that has permission to perform this action.

    .EXAMPLE
        Install-Feature -Features $features -ComputerName $computername -Credential $credential

    .EXAMPLE
        Install-Feature -Features $features -ComputerName $computername -Username $username -password $password
    
    .EXAMPLE
        Install-Feature -Features $features 

    .OUTPUTS
        Creates a file with the download state of all the features in the current working directory

    #>
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Features,
        [string]$ComputerName,
        [System.Management.Automation.PSCredential]$Credential,
        [string]$Username,
        [Security.SecureString]$password
    )
    
    $Status = @()

    Write-Host "Installing the following features: $($features -join ", ")"

    if ($Credential -eq $null){
        if ($Username -eq $null -or $password -eq $null){
            Write-Error "Credentials were not given." -WarningAction Stop
        }
        else{
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $password)
        }
    }

    foreach($feature in $Features){
        try{
            if ($ComputerName -ne $null){
                Install-WindowsFeature -Name $feature -ComputerName $ComputerName -Credential $Credential
            }
            else{
                Install-WindowsFeature -Name $feature
            }
            # Creates an object with the download state and saves it to the $status variable
            $current = [PSCustomObject]@{
                Name = $feature
                State = "Downloaded"
            }
            $Status += $current
            
        }
        catch{
            Write-Output "Can't install the following feature due to the following error: $($PSitem)"
            
            # Creates an object with the failed state and saves it to the $status variable
            $current = [PSCustomObject]@{
                Name = $feature
                State = "Failed"
            }
            $Status += $current
        }
    }
    
    $Status | Export-Csv -Path ".\Features.csv" -NoTypeInformation
}

function Rename-ComputerName {
    <#
    .DESCRIPTION
        Rename-ComputerName is a function that Changes the hostname and restarts the computer right after

    .PARAMETER ComputerName
        The remote computer(s) to change the name.

    .PARAMETER NewName
        The new name the server will obtain.

    .PARAMETER Credential
        Specifies a user account that has permission to perform this action.

    .EXAMPLE
        Install-Feature -Features $features -ComputerName $computername -Credential $credential

    .EXAMPLE
        Install-Feature -Features $features -ComputerName $computername -Username $username -password $password
    
    .EXAMPLE
        Install-Feature -Features $features 

    .OUTPUTS
        Creates a file with the download state of all the features in the current working directory
    #>

    param (
        [Parameter(Mandatory=$true)]
        [string]$NewName,
        [string]$ComputerName,
        [System.Management.Automation.PSCredential]$Credential,
        [string]$Username,
        [Security.SecureString]$password
    )

    if ($Credential -eq $null){
        if ($Username -eq $null -or $password -eq $null){
            Write-Error "Credentials were not given." -WarningAction Stop
        }
        else{
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $password)
        }
    }

    # Function Body
    try {
        if ($ComputerName -eq $null) {
            Rename-Computer -ComputerName $ComputerName -NewName $NewName -LocalCredential $Credential -Force
        }
        else{
            Rename-Computer -NewName $NewName -Force  
        }
        Restart-Computer -Wait 10 -Force
    }
    catch {
        Write-Output "Can't install the following feature due to the following error: $($PSitem)"
    }
    
}


