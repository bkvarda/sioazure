#
# Install-SIONodePackages.ps1
#

#Current URL for ScaleIO Windows Package Download#

$onegeturl = "http://oneget.org/install-oneget.exe"
$siourl = "http://bkvarda.blob.core.windows.net/sioazure/scaleio.zip"
$pipurl = "https://bootstrap.pypa.io/get-pip.py"
$pycompileurl = "http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi"
$rootdestination = "C:\scaleio"

#Give use unlimited power muahahah
Set-ExecutionPolicy Unrestricted

#Disable all of the firewalls! (this makes things easier)
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#Create the directory
Write-Host "Creating $rootdestination"
New-Item -Force -ItemType directory -Path $rootdestination

#Download C++ Compiler for Python
Write-Host "Downloading C++ Compiler for Python"
$pycompiledestination = $rootdestination + "\python-compile.msi"
Invoke-WebRequest $pycompileurl -Outfile $pycompiledestination

#Install Compiler
Write-Host "Installing C++ Compiler for Python"
Start-Process $pycompiledestination /quiet -Wait

#Download OneGet
Write-Host "Downloading OneGet"
$onegetdestination = $rootdestination + "\oneget.exe"
Invoke-WebRequest $onegeturl -Outfile $onegetdestination

#Install OneGet
Write-Host "Installing OneGet"
Start-Process $onegetdestination /s -Wait

#Install Python 2.7.5
Write-Host "Installing Python"
Install-Package -Name python -RequiredVersion 2.7.5 -Force
Get-Package -Name python

#Install PyWin32
Install-Package -Name pywin32 -Force
Get-Package -Name pywin32

#Downloading Pip
$pipdestination = $rootdestination + "\get-pip.py"
Invoke-WebRequest $pipurl -Outfile $pipdestination

#Installing Pip
python $pipdestination

#Install Other Python Modules

#Install Paramiko
python -m pip install paramiko

#Install Crypto
python -m pip install pycrypto

#Install WMI
python -m pip install WMI

Write-Host "All Done!"



