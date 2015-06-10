#
# Download-SIOPackages.ps1
#

#Current URL for ScaleIO Windows Package Download#

$url = "ftp://ftp.emc.com/Downloads/ScaleIO/ScaleIO_Windows_SW_Download.zip"
$destination = "C:\scaleio"


#Create the directory
New-Item -Force -ItemType directory -Path $destination

#Download the ScaleIO Zip
Invoke-WebRequest $url -Outfile $destination +"\scaleio.zip"

#Extract the ScaleIO Zip
[io.compression.zipfile]::ExtractToDirectory($destination+"\scaleio.zip",$destination)

#Install the Gateway

#Install the GUI


