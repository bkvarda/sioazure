# SIOAzure

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbkvarda%2Fsioazure%2Fmaster%2Fsioazure%2FTemplates%2FDeploymentTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

Built by: [bkvarda](https://github.com/bkvarda)

This template allows you to quickly deploy X number of VMs on Azure, installs ScaleIO dependencies, and initializes the cluster so that the environment is ready to go as soon as you log in. 

Click below for a video demo

<a href="http://www.youtube.com/watch?feature=player_embedded&v=2WzeKM_tcIw
" target="_blank"><img src="http://img.youtube.com/vi/2WzeKM_tcIw/0.jpg" 
alt="Deploy ScaleIO in Azure" width="640" height="480" border="10" /></a>

###Usage
Simply click the "Deploy to Azure" button above and fill out the required parameters. Deployment requires an Azure account, which you can get for free (with 300$ free credit if it is a new account). 

Once deployment completes, the gateway, API, and MDM credentials are all "admin"/"Password123". The primary MDM's IP is 10.0.0.5, and the secondary is 10.0.0.6. You can use the ScaleIO GUI from the management machine currently. Soon I will add the ability to access the MDM without remoting into the mgmt machine.

From PowerShell on the management machine, you can use "Enter-PSSession -ComputerName 10.0.0.5" to remote to the primary MDM and then run "scli" commands from there.

###Parameters
|  Parameter | Description  |
|---|---|
| newStorageAccountName | Name of the storage account that will be created to store resources. Must be unique |
| newStorageAccountType  | Type of storage account - locally redundant or greater |
| newStorageAccountLocation  | Location of storage account (region)  |
| siovnetLocation  | Location of virtual network to be created (region). Should use the same location throughout  |
| siomgmtName  | Name of the ScaleIO management machine  |
| adminUserName  | Windows Username  |
| adminPassword  | Windows Password - must meet Azure password complexity standards  |
| nodeWindowsOSVersion  | Windows version to be deployed |
| sioNodeVMSize  | Azure VM SKU to be used for storage nodes  |
| sioNodeDiskSize  | Disk size to be used for storage nodes  |
| sioMgmtNodeVMSize  | Azure VM SKU to be used as management machine  |
| publicIPAddressNameDnsName  | DNS name to be used to expose management machine - must be unique  |


###How Does it Work?
SIOAzure uses a new Azure concept called Resource Groups to create a self-contained environment that has all of the resources required to create a ScaleIO environment in Azure - A virtual network, virtual NICs, a storage account, virtual machines, extensions, and a public IP/DNS name so that you can remote into the management machine. A custom JSON template defines the resources that will be deployed and the parameters that are needed in order to deploy those resources, as well as the order in which they are deployed. ScaleIO dependencies are downloaded and installed on the fly using scripts that run once the VMs are created (also known as Custom Script Extensions). The automated deployment leverages the ScaleIO gateway to handle the installation of packages and initialization of the cluster.

###Why Would I Use This?
There are a ton of things you could use it for, but a few examples would be API development (the API is exposed to the internet using a public IP/DNS), as a lab environment for experimenting, for ScaleIO demonstrations, or for performance/scenario testing in Azure.

###Limitations 
- Resource groups are currently limited to 10 cores by default - you can increase it by opening a ticket in Azure. 
- Because of the above - depending on your chosen SKUs - you may not be able to create a large environment until you get your quota increased. Try starting with 3 node clusters until your quota is increased or quota limits are increased/eliminated when Resource Groups become GA
- Make sure your chosen VM password meets Azure password strength requirements or the deployment will fail
- Make sure your DNS Name is unique, or the creation of public IP/DNS will fail and you won't be able to access the environment
- Basic SKUs have unpredictable network conditions, and will result in cluster issues.
- The drive size chosen must be supported by the VM SKUs you choose, or else Azure deployment will fail.  


###Current Status: 
- VMs and all supported infrastructure up to hundreds of VMs automatically provisioned (limit is # of cores per Resource Group imposed by your subscription)
- ScaleIO Management packages deployed to management VM (Gateway, GUI, Java), and accessible over public IP
- ScaleIO Storage Node packages deployed to X number of VMs (Python, C++ Python Compiler, PyWin32, Paramiko, WMI )
- SQLIO and IOmeter deployed to all machines
- A volume is created and attached to the mgmt machine.   

ToDo:
- Execute cluster creation as part of deployment so everything is ready when you begin
- Allow for more than 1 disk per VM
- Create caching or separate pools for VM SKUs with non-persistent SSD included


Longer Term:
- Tweak availability zones for perf 
- Refactor to make it possible to support new releases without modifications



