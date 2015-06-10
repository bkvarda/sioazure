#
# Install.SIOMgmtPackages.ps1
#

#Current URL for ScaleIO Windows Package Download#

$onegeturl = "http://oneget.org/install-oneget.exe"
$siourl = "ftp://ftp.emc.com/Downloads/ScaleIO/ScaleIO_Windows_SW_Download.zip"
$rootdestination = "C:\scaleio3"

#Give use unlimited power muahahah
Set-ExecutionPolicy Unrestricted

#Create the directory
Write-Host "Creating C:\scaleio..."
New-Item -Force -ItemType directory -Path $rootdestination

#Download OneGet
Write-Host "Downloading OneGet"
$onegetdestination = $rootdestination + "\oneget.exe"
Invoke-WebRequest $onegeturl -Outfile $onegetdestination

#Install OneGet
Write-Host "Installing OneGet"
Start-Process C:\scaleio\oneget.exe /s

#Install Java
Install-Package -Name javaruntime -Force
Get-Package -Name javaruntime

#Download the ScaleIO Zip
Write-Host "Downloading ScaleIO files..."
$siodestination = $rootdestination +"\scaleio.zip"
Invoke-WebRequest $siourl -Outfile $siodestination

#Extract the ScaleIO Zip
Write-Host "Extracting ScaleIO files..."
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($siodestination,$rootdestination)

#Install the GUI
Write-Host "Installing GUI"
Start-Process "$rootdestination\ScaleIO_1.32_GUI_for_Windows_Download\EMC-ScaleIO-gui-1.32-402.1.msi" /quiet -Wait

#Install 64-bit version of SIO Gateway
Write-Host "Intalling SIO Gateway"
msiexec.exe /i "$rootdestination\ScaleIO_1.32_Gateway_for_Windows_Download\EMC-ScaleIO-gateway-1.32-402.1-x64.msi" /quiet  GATEWAY_ADMIN_PASSWORD='Password123' GATEWAY_ADMIN_PWD_CNFRM='Password123'

#Build a CSV payload for creation of cluster

#Upload packages to the gateway

#Push the packages out

#Profit







