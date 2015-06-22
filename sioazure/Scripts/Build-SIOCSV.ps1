#
# Build-SIOCSV.ps1
#

Param(
  [int]$Nodes,
  [string]$Username,
  [string]$Password

)

$rootdestination = "C:\scaleio"
$clusterscriptdestination = $rootdestination + "\Create-Cluster.ps1"

$csvobject = @()

$mgmt = New-Object PSObject

$mgmt = New-Object PSObject
	$mgmt | Add-Member NoteProperty -Name Domain -Value "localhost"
	$mgmt | Add-Member NoteProperty -Name Username -Value $Username
	$mgmt | Add-Member NoteProperty -Name Password -Value $Password
	$mgmt | Add-Member NoteProperty -Name "Operating System" -Value "windows"
	$mgmt | Add-Member NoteProperty -Name "Is MDM/TB" -Value $null
	$mgmt | Add-Member NoteProperty -Name "MDM Mgmt IP" -Value $null
	$mgmt | Add-Member NoteProperty -Name "MDM IPs" -Value $null
	$mgmt | Add-Member NoteProperty -Name "Is SDS" -Value "No"
	$mgmt | Add-Member NoteProperty -Name "SDS Name" -Value $null
	$mgmt | Add-Member NoteProperty -Name "SDS All IPs" -Value "10.0.0.4"
	$mgmt | Add-Member NoteProperty -Name "SDS-SDS Only IPs" -Value $null
	$mgmt | Add-Member NoteProperty -Name "SDS-SDC Only IPs" -Value $null
	$mgmt | Add-Member NoteProperty -Name "Protection Domain" -Value $null
	$mgmt | Add-Member NoteProperty -Name "Fault Set" -Value $null
	$mgmt | Add-Member NoteProperty -Name "SDS Device List" -Value $null
	$mgmt | Add-Member NoteProperty -Name "SDS Pool List" -Value $null
	$mgmt | Add-Member NoteProperty -Name "SDS Device Names" -Value $null
	$mgmt | Add-Member NoteProperty -Name Optimize  -Value "No"
	$mgmt | Add-Member NoteProperty -Name "Is SDC" -Value "Yes"

	$csvobject += $mgmt

$mdm1 = New-Object PSObject

$mdm1 = New-Object PSObject
	$mdm1 | Add-Member NoteProperty -Name Domain -Value "localhost"
	$mdm1 | Add-Member NoteProperty -Name Username -Value $Username
	$mdm1 | Add-Member NoteProperty -Name Password -Value $Password
	$mdm1 | Add-Member NoteProperty -Name "Operating System" -Value "windows"
	$mdm1 | Add-Member NoteProperty -Name "Is MDM/TB" -Value "Primary"
	$mdm1 | Add-Member NoteProperty -Name "MDM Mgmt IP" -Value $null
	$mdm1 | Add-Member NoteProperty -Name "MDM IPs" -Value "10.0.0.5"
	$mdm1 | Add-Member NoteProperty -Name "Is SDS" -Value "Yes"
	$mdm1 | Add-Member NoteProperty -Name "SDS Name" -Value "SDSMDM01"
	$mdm1 | Add-Member NoteProperty -Name "SDS All IPs" -Value "10.0.0.5"
	$mdm1 | Add-Member NoteProperty -Name "SDS-SDS Only IPs" -Value $null
	$mdm1 | Add-Member NoteProperty -Name "SDS-SDC Only IPs" -Value $null
	$mdm1 | Add-Member NoteProperty -Name "Protection Domain" -Value "domain1"
	$mdm1 | Add-Member NoteProperty -Name "Fault Set" -Value $null
	$mdm1 | Add-Member NoteProperty -Name "SDS Device List" -Value "F"
	$mdm1 | Add-Member NoteProperty -Name "SDS Pool List" -Value "pool1"
	$mdm1 | Add-Member NoteProperty -Name "SDS Device Names" -Value $null
	$mdm1 | Add-Member NoteProperty -Name Optimize  -Value "No"
	$mdm1 | Add-Member NoteProperty -Name "Is SDC" -Value "Yes"

	$csvobject += $mdm1

	$mdm2 = New-Object PSObject

$mdm2 = New-Object PSObject
	$mdm2 | Add-Member NoteProperty -Name Domain -Value "localhost"
	$mdm2 | Add-Member NoteProperty -Name Username -Value $Username
	$mdm2 | Add-Member NoteProperty -Name Password -Value $Password
	$mdm2 | Add-Member NoteProperty -Name "Operating System" -Value "windows"
	$mdm2 | Add-Member NoteProperty -Name "Is MDM/TB" -Value "Secondary"
	$mdm2 | Add-Member NoteProperty -Name "MDM Mgmt IP" -Value $null
	$mdm2 | Add-Member NoteProperty -Name "MDM IPs" -Value "10.0.0.6"
	$mdm2 | Add-Member NoteProperty -Name "Is SDS" -Value "Yes"
	$mdm2 | Add-Member NoteProperty -Name "SDS Name" -Value "SDSMDM02"
	$mdm2 | Add-Member NoteProperty -Name "SDS All IPs" -Value "10.0.0.6"
	$mdm2 | Add-Member NoteProperty -Name "SDS-SDS Only IPs" -Value $null
	$mdm2 | Add-Member NoteProperty -Name "SDS-SDC Only IPs" -Value $null
	$mdm2 | Add-Member NoteProperty -Name "Protection Domain" -Value "domain1"
	$mdm2 | Add-Member NoteProperty -Name "Fault Set" -Value $null
	$mdm2 | Add-Member NoteProperty -Name "SDS Device List" -Value "F"
	$mdm2 | Add-Member NoteProperty -Name "SDS Pool List" -Value "pool1"
	$mdm2 | Add-Member NoteProperty -Name "SDS Device Names" -Value $null
	$mdm2 | Add-Member NoteProperty -Name Optimize  -Value "No"
	$mdm2 | Add-Member NoteProperty -Name "Is SDC" -Value "Yes"

	$csvobject += $mdm2

		$tb = New-Object PSObject

$tb = New-Object PSObject
	$tb | Add-Member NoteProperty -Name Domain -Value "localhost"
	$tb | Add-Member NoteProperty -Name Username -Value $Username
	$tb | Add-Member NoteProperty -Name Password -Value $Password
	$tb | Add-Member NoteProperty -Name "Operating System" -Value "windows"
	$tb | Add-Member NoteProperty -Name "Is MDM/TB" -Value "TB"
	$tb | Add-Member NoteProperty -Name "MDM Mgmt IP" -Value $null
	$tb | Add-Member NoteProperty -Name "MDM IPs" -Value "10.0.0.7"
	$tb | Add-Member NoteProperty -Name "Is SDS" -Value "Yes"
	$tb | Add-Member NoteProperty -Name "SDS Name" -Value "SDSTB"
	$tb | Add-Member NoteProperty -Name "SDS All IPs" -Value "10.0.0.7"
	$tb | Add-Member NoteProperty -Name "SDS-SDS Only IPs" -Value $null
	$tb | Add-Member NoteProperty -Name "SDS-SDC Only IPs" -Value $null
	$tb | Add-Member NoteProperty -Name "Protection Domain" -Value "domain1"
	$tb | Add-Member NoteProperty -Name "Fault Set" -Value $null
	$tb | Add-Member NoteProperty -Name "SDS Device List" -Value "F"
	$tb | Add-Member NoteProperty -Name "SDS Pool List" -Value "pool1"
	$tb | Add-Member NoteProperty -Name "SDS Device Names" -Value $null
	$tb | Add-Member NoteProperty -Name Optimize  -Value "No"
	$tb | Add-Member NoteProperty -Name "Is SDC" -Value "Yes"

	$csvobject += $tb





For($i = 8; $i -le $Nodes+4; $i++){

	$obj = New-Object PSObject
	$obj | Add-Member NoteProperty -Name Domain -Value "localhost"
	$obj | Add-Member NoteProperty -Name Username -Value $Username
	$obj | Add-Member NoteProperty -Name Password -Value $Password
	$obj | Add-Member NoteProperty -Name "Operating System" -Value "windows"
	$obj | Add-Member NoteProperty -Name "Is MDM/TB" -Value $null
	$obj | Add-Member NoteProperty -Name "MDM Mgmt IP" -Value $null
	$obj | Add-Member NoteProperty -Name "MDM IPs" -Value $null
	$obj | Add-Member NoteProperty -Name "Is SDS" -Value "Yes"
	$obj | Add-Member NoteProperty -Name "SDS Name" -Value "SDS$i"
	$obj | Add-Member NoteProperty -Name "SDS All IPs" -Value "10.0.0.$i"
	$obj | Add-Member NoteProperty -Name "SDS-SDS Only IPs" -Value $null
	$obj | Add-Member NoteProperty -Name "SDS-SDC Only IPs" -Value $null
	$obj | Add-Member NoteProperty -Name "Protection Domain" -Value "domain1"
	$obj | Add-Member NoteProperty -Name "Fault Set" -Value $null
	$obj | Add-Member NoteProperty -Name "SDS Device List" -Value "F"
	$obj | Add-Member NoteProperty -Name "SDS Pool List" -Value "pool1"
	$obj | Add-Member NoteProperty -Name "SDS Device Names" -Value $null
	$obj | Add-Member NoteProperty -Name Optimize  -Value "No"
	$obj | Add-Member NoteProperty -Name "Is SDC" -Value "Yes"

	$csvobject += $obj

	Write-Host $i
}

$csvobject | Export-CSV C:\scaleio\install_csv.csv -NoTypeInformation

#Create the cluster
powershell.exe -ExecutionPolicy Unrestricted -File $clusterscriptdestination