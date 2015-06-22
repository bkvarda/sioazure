#
# Prepare-SIONode.ps1
#
$onegeturl = "http://oneget.org/install-oneget.exe"
$pycompileurl = "http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi"
$pythonurl = "http://bkvarda.blob.core.windows.net/sioazure/python-2.7.5.amd64.msi"
$nodescripturl = "http://bkvarda.blob.core.windows.net/sioazure/Install-SIONodePackages.ps1"
$sqliourl ="http://download.microsoft.com/download/f/3/f/f3f92f8b-b24e-4c2e-9e86-d66df1f6f83b/SQLIO.msi"
$iometerurl ="http://downloads.sourceforge.net/project/iometer/iometer-stable/1.1.0/iometer-1.1.0-win32.i386-setup.exe?r=http%3A%2F%2Fwww.iometer.org%2Fdoc%2Fdownloads.html&ts=1434469510&use_mirror=iweb"
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

#Download OneGet
Write-Host "Downloading OneGet"
$onegetdestination = $rootdestination + "\oneget.exe"
Invoke-WebRequest $onegeturl -Outfile $onegetdestination

#Download Python
$pythondestination = $rootdestination + "\python-2.7.5.amd64.msi"
Invoke-WebRequest $pythonurl -OutFile $pythondestination

#Install OneGet
Write-Host "Installing OneGet"
Start-Process "$rootdestination\oneget.exe" /s -Wait

#Set Chocolatey as trusted provider
Set-PackageSource -Name chocolatey -Trusted

#Install Python
msiexec.exe /i $pythondestination /quiet ALLUSERS='1' ADDLOCAL='DefaultFeature,SharedCRT,Extensions,TclTk,Documentation,Tools,Testsuite'

#Install Pywin32
Install-Package -Name pywin32 -Source Chocolatey -RequiredVersion 218.0 -Force

#Download SQLIO
$sqliodestination = $rootdestination + "\sqlio.msi"
Invoke-WebRequest $sqliourl -OutFile $sqliodestination

#Download Iometer
$iometerdestination = $rootdestination + "\iometer.exe"
Invoke-WebRequest $iometerurl -OutFile $iometerdestination

#Install SQLIO

msiexec.exe /i $sqliodestination /quiet