#
# Prepare-SIONode.ps1
#
$onegeturl = "http://oneget.org/install-oneget.exe"
$pycompileurl = "http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi"
$pythonurl = "http://bkvarda.blob.core.windows.net/sioazure/PythonModulesInstall.exe"
$nodescripturl = "http://bkvarda.blob.core.windows.net/sioazure/Install-SIONodePackages.ps1"
$rootdestination = "C:\scaleio"

Set-ExecutionPolicy Unrestricted

#Disable all of the firewalls! (this makes things easier)
Set-NetFirewallProfile -Profile Public,Private -Enabled False

#Set up our data drive
$disk = Get-Disk | Where partitionstyle -EQ 'raw'
$disk | Initialize-Disk -PartitionStyle MBR
$disk | New-Partition -AssignDriveLetter -UseMaximumSize


#Create the working directory
Write-Host "Creating $rootdestination"
New-Item -Force -ItemType directory -Path $rootdestination

#Download the Python Package
Write-Host "DL Python Package"
$pythondestination = "$rootdestination\PythonModuleInstall.exe"
Invoke-WebRequest $pythonurl -Outfile $pythondestination