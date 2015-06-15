#
# Install-SIONodePackages.ps1
#

#Current URL for ScaleIO Windows Package Download#

$onegeturl = "http://oneget.org/install-oneget.exe"
$siourl = "http://bkvarda.blob.core.windows.net/sioazure/scaleio.zip"
$pipurl = "https://bootstrap.pypa.io/get-pip.py"
$pycompileurl = "http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi"
$pythonurl = "http://bkvarda.blob.core.windows.net/sioazure/python-2.7.5.amd64.msi"
$pywin32url = "http://bkvarda.blob.core.windows.net/sioazure/pywin32-216.0.win32-py2.7.msi"
$rootdestination = "C:\scaleio"


#Disable all of the firewalls! (this makes things easier)
Set-NetFirewallProfile -Profile Public,Private -Enabled False

#Set up our data drive
$disk = Get-Disk | Where partitionstyle -EQ 'raw'
$disk | Initialize-Disk -PartitionStyle MBR
$disk | New-Partition -AssignDriveLetter -UseMaximumSize


#Create the working directory
Write-Host "Creating $rootdestination"
New-Item -Force -ItemType directory -Path $rootdestination

#Download Python
$pythondestination = $rootdestination + "\python.msi"
Invoke-WebRequest $pythonurl -OutFile $pythondestination

#Install Python 2.7.5
Write-Host "Installing Python"
Start-Process -FilePath msiexec.exe -ArgumentList "/i $pythondestination /passive" -Wait

#Download PyWin32
$pywin32destination = $rootdestination + "\pywin32.msi" 
Invoke-WebRequest $pywin32url -OutFile $pywin32destination

#Install PyWin32
Write-Host "Installing PyWin"
Start-Process -FilePath msiexec.exe -ArgumentList "/i $pywin32destination /passive" -Wait

Write-Host "All Done!"



