
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


#https://www.mssqltips.com/sqlservertip/6017/build-docker-containers-with-external-storage-on-your-desktop/
Install-Module SqlServer
$releases = Invoke-RestMethod https://api.github.com/repos/microsoft/sql-server-samples/releases
$BaksToDownload = ($releases | where {$_.name -eq 'AdventureWorks sample databases' -or $_.name -eq 'Wide World Importers sample database v1.0'}).assets |
WHERE { $_.name -like 'AdventureWorksDW201*bak' -and $_.name -notlike '*EXT*' } |
SELECT name, browser_download_url, size, updated_at
 
FOREACH( $BakInfo in $BaksToDownload )
{
"$($BakInfo.name)";
Invoke-WebRequest -Uri $BakInfo.browser_download_url -OutFile "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\$($BakInfo.name)"
Restore-SqlDatabase -ServerInstance 'localhost' -Credential (Get-Credential sa) -BackupFile "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\$($BakInfo.name)" -Database ($BakInfo.name -replace '.bak') -AutoRelocateFile
}