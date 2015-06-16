#
# Install-SIONodePackages.ps1
#

#Current URL for ScaleIO Windows Package Download#

$nodescripturl = "http://bkvarda.blob.core.windows.net/sioazure/Install-SIONodePackages.ps1"
$rootdestination = "C:\scaleio"
$pythondestination = $rootdestination + "\python.msi"
$nodescriptdestination = $rootdestination + "\Install-SIONodePackages.ps1"
$pythondestination = "$rootdestination\PythonModuleInstall.exe"



#Install the Python Modules...this can't be done automatically yet :(


Write-Host "All Done!"



