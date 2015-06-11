# Rapidly deploy ScaleIO in Azure!

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbkvarda%2Fsioazure%2Fmaster%2Fsioazure%2FTemplates%2FDeploymentTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

Built by: [bkvarda](https://github.com/bkvarda)

This template allows you to quickly deploy X number of VMs on Azure and automatically deploys ScaleIO.

Current Status: 
- VMs and all supported infrastructure up to thousands of VMs automatically provisioned (where X is the Resource Group limit imposed by your subscription)
- ScaleIO Management packages deployed to management VM (Gateway, GUI, Java), and accessible over public IP
- ScaleIO Storage Node packages deployed to X number of VMs (Python, C++ Python Compiler, PyWin32, Paramiko, WMI )  

ToDo:
- Make Mgmt private IP static
- Build out deployment CSV
- Initialize/Format data drives
- Automate cluster creation

Longer Term:
- Tweak availability zones for perf 
- Include benchmarking tools?

I'll list the parameters that the template expects soon. 


