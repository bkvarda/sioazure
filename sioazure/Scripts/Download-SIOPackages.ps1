#
# Download-SIOPackages.ps1
#

#Current URL for ScaleIO Windows Package Download#

$siourl = "ftp://ftp.emc.com/Downloads/ScaleIO/ScaleIO_Windows_SW_Download.zip"
$javaurl = "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jre-7u80-windows-i586.exe"
$rootdestination = "C:\scaleio"


#Create the directory
Write-Host "Creating C:\scaleio..."
New-Item -Force -ItemType directory -Path $rootdestination

#Download Java
Write-Host "Downloading Java..."
$javadestination = $rootdestination + "\java.exe"
$client = New-Object System.Net.WebClient
$client.DownloadFile($javaurl,$javadestination)

#Download the ScaleIO Zip
Write-Host "Downloading ScaleIO files..."
$siodestination = $rootdestination +"\scaleio.zip"
Invoke-WebRequest $siourl -Outfile $siodestination

#Extract the ScaleIO Zip
Write-Host "Extracting ScaleIO files..."
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($siodestination,$rootdestination)

#Install Java


#Install the Gateway

#Install the GUI


