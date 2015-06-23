#
# Install.SIOMgmtPackages.ps1
#

Param(
  [int]$Nodes,
  [string]$Username,
  [string]$Password
)

"$Nodes, $Username, $Password" | Out-File C:\scaleio\test.txt

#Current URL for ScaleIO Windows Package Download#

$onegeturl = "http://oneget.org/install-oneget.exe"
$siourl = "http://bkvarda.blob.core.windows.net/sioazure/scaleio.zip"
$siocliurl = "http://bkvarda.blob.core.windows.net/sioazure/install-CLI.jar"
$nodescripturl = "http://bkvarda.blob.core.windows.net/sioazure/Install-SIONodePackages.ps1"
$csvscripturl = "http://bkvarda.blob.core.windows.net/sioazure/Build-SIOCSV.ps1"
$clusterscripturl = "http://bkvarda.blob.core.windows.net/sioazure/Create-Cluster.ps1"
$sqliourl ="http://download.microsoft.com/download/f/3/f/f3f92f8b-b24e-4c2e-9e86-d66df1f6f83b/SQLIO.msi"
$iometerurl ="http://downloads.sourceforge.net/project/iometer/iometer-stable/1.1.0/iometer-1.1.0-win32.i386-setup.exe?r=http%3A%2F%2Fwww.iometer.org%2Fdoc%2Fdownloads.html&ts=1434469510&use_mirror=iweb"
$siodeployurl = "http://bkvarda.blob.core.windows.net/sioazure/siodeploy.txt"

$rootdestination = "C:\scaleio"

#Give use unlimited power muahahah
Set-ExecutionPolicy Unrestricted

#Create the directory
Write-Host "Creating C:\scaleio..."
New-Item -Force -ItemType directory -Path $rootdestination

#Download SIOdeploy.txt
$siodeploydestination = $rootdestination + "\siodeploy.txt"
Invoke-WebRequest $siodeployurl -OutFile $siodeploydestination


#Download SQLIO
$sqliodestination = $rootdestination + "\sqlio.msi"
Invoke-WebRequest $sqliourl -OutFile $sqliodestination

#Download Iometer
$iometerdestination = $rootdestination + "\iometer.exe"
Invoke-WebRequest $iometerurl -OutFile $iometerdestination

#Install SQLIO

msiexec.exe /i $sqliodestination /quiet

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

#Download CLI JAR
Write-Host "Downloading CLI JAR"
$sioclidestination = $rootdestination + "\Install-CLI.jar"
Invoke-WebRequest $siocliurl -OutFile $sioclidestination


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

#Install 64-bit version of SIO Gateway
Write-Host "Intalling SIO Gateway"
$argstring = "/i $rootdestination\ScaleIO_1.32_Gateway_for_Windows_Download\EMC-ScaleIO-gateway-1.32-402.1-x64.msi /quiet GATEWAY_ADMIN_PASSWORD=Password123 GATEWAY_ADMIN_PWD_CNFRM=Password123"
Start-Process msiexec -ArgumentList $argstring -Wait

#Install the GUI
Write-Host "Installing GUI"
Start-Process "$rootdestination\ScaleIO_1.32_GUI_for_Windows_Download\EMC-ScaleIO-gui-1.32-402.1.msi" /quiet -Wait


#Build a CSV payload for creation of cluster
powershell.exe -ExecutionPolicy Unrestricted -File $csvscriptdestination -Nodes $Nodes -Username $Username -Password $Password

Start-Sleep -Seconds 10

#Create the cluster
powershell.exe -ExecutionPolicy Unrestricted -File $clusterscriptdestination | Out-File C:\scaleio\clusterlog.txt





