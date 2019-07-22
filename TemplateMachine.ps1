
#https://stackoverflow.com/questions/9368305/disable-ie-security-on-windows-server-via-powershell
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer
Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install chocolatey -y
choco install sql-server-management-studio -y
choco install azure-data-studio -y
choco install git.install -y
choco install vscode -y
choco install vscode-powershell -y
choco install powerbi -y
choco install github-desktop -y
choco install googlechrome -y
choco install putty.install -y
choco install notepadplusplus.install -y
choco install vim -y
choco install powerbi -y

Install-WindowsFeature AD-Domain-Services,FS-iSCSITarget-Server,Web-Server,Web-Mgmt-Tools,NET-Framework-Core,Failover-Clustering,Telnet-Client -IncludeManagementTools -IncludeAllSubFeature

Set-TimeZone -Name "Eastern Standard Time"