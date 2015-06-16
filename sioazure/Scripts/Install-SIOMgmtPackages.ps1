#
# Install.SIOMgmtPackages.ps1
#

Param(
  [int]$Nodes,
  [string]$Username,
  [string]$Password
)

Write-Host $Nodes

#Current URL for ScaleIO Windows Package Download#

$onegeturl = "http://oneget.org/install-oneget.exe"
$siourl = "http://bkvarda.blob.core.windows.net/sioazure/scaleio.zip"
$nodescripturl = "http://bkvarda.blob.core.windows.net/sioazure/Install-SIONodePackages.ps1"
$csvscripturl = "http://bkvarda.blob.core.windows.net/sioazure/Build-SIOCSV.ps1"
$clusterscripturl = "http://bkvarda.blob.core.windows.net/sioazure/Create-Cluster.ps1"
$rootdestination = "C:\scaleio"

#Give use unlimited power muahahah
Set-ExecutionPolicy Unrestricted

#Create the directory
Write-Host "Creating C:\scaleio..."
New-Item -Force -ItemType directory -Path $rootdestination

#Download Node script
Write-Host "Downloading Node Script"
$nodescriptdestination = $rootdestination + "\Install-SIONodePackages.ps1"
Invoke-WebRequest $nodescripturl -Outfile $nodescriptdestination

#Download CSV script
Write-Host "Downloading CSV Script"
$csvscriptdestination = $rootdestination + "\Build-SIOCSV.ps1"
Invoke-WebRequest $csvscripturl -Outfile $csvscriptdestination

#Download Create-Cluster script
Write-Host "Downloading Cluster Creation Script"
$clusterscriptdestination = $rootdestination + "\Create-Cluster.ps1"
Invoke-WebRequest $clusterscripturl -OutFile $clusterscriptdestination

#Download OneGet
Write-Host "Downloading OneGet"
$onegetdestination = $rootdestination + "\oneget.exe"
Invoke-WebRequest $onegeturl -Outfile $onegetdestination

#Install OneGet
Write-Host "Installing OneGet"
Start-Process "$rootdestination\oneget.exe" /s -Wait

#Install Java
Install-Package -Name javaruntime -Force


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
Invoke-Expression "$csvscriptdestination -Nodes $Nodes -Username $Username -Password $Password"






