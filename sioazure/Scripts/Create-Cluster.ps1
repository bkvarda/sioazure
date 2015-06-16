#
# Create-Cluster.ps1
#

$onegeturl = "http://oneget.org/install-oneget.exe"
$siourl = "http://bkvarda.blob.core.windows.net/sioazure/scaleio.zip"
$pipurl = "https://bootstrap.pypa.io/get-pip.py"
$pycompileurl = "http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi"
$pythonurl = "http://bkvarda.blob.core.windows.net/sioazure/python-2.7.5.amd64.msi"
$pywin32url = "http://bkvarda.blob.core.windows.net/sioazure/pywin32-216.0.win32-py2.7.msi"
$nodescripturl = "http://bkvarda.blob.core.windows.net/sioazure/Install-SIONodePackages.ps1"
$rootdestination = "C:\scaleio"
$pythondestination = $rootdestination + "\python.msi"
$nodescriptdestination = $rootdestination + "\Install-SIONodePackages.ps1"




#Do the thing

java -jar C:\scaleio\install-CLI.jar script --file C:\scaleio\siodeploy.txt