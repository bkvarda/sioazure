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


#Upload packages, deploy cluster

java -jar C:\scaleio\install-CLI.jar script --file C:\scaleio\siodeploy.txt

Start-Sleep -Seconds 10

#Add MDM to trusted hosts

Set-Item wsman:\localhost\Client\TrustedHosts -value 10.0.0.5 -Force

Enter-PSSession -ComputerName 10.0.0.5

#Login to MDM

scli --login --username admin --password Password123

#Add a volume to the mgmt host

scli --mdm_ip 10.0.0.5 --add_volume --protection_domain_name domain1 --storage_pool_name pool1 --size_gb 64 --volume_name vol1

#Map volume to mgmt host
scli --mdm_ip 10.0.0.5 --map_volume_to_sdc --volume_name vol1 --sdc_ip 10.0.0.4


