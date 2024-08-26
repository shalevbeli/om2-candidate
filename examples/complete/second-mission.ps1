$computername = ((Get-Content -Path ".\terraform.tfvars" | Select-String -Pattern "instance_name") -split '"')[1];
Rename-Computer -ComputerName $computername -Force;
$windowsFeatures = ((Get-Content -Path ".\terraform.tfvars" | Select-String -Pattern "windows-features") -split '"');

foreach ($feature in $windowsFeatures){
    Install-WindowsFeature -name $feature -IncludeManagementTools;
}