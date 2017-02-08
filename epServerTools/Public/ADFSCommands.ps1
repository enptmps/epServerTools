function New-epADFSFarmConfig {
    <#
    FUTURES
    WORK IN PROGRESS
    FUTURES 
    #>
    [CmdletBinding()]
    Param(
        [Parameter][int]$ADFSServerCount,
        [Parameter][int]$WAPServerCount
    )
}

function New-epADFServerConfig {
    <#
    FUTURES
    WORK IN PROGRESS
    FUTURES
    #>
}

function New-epWAPServerConfig {
    <#
    FUTURES
    WORK IN PROGRESS
    FUTURES
    #>
}

function Install-epADFSServer {
    <#
    FUTURES
    WORK IN PROGRESS
    FUTURES 
    #>
}

function Install-epWAPServer {
    <#
    FUTURES
    WORK IN PROGRESS
    FUTURES 
    #>    
}

# From ADFS First Server
# 1. Install the feature
Install-WindowsFeature ADFS-Federation -IncludeManagementTools

# 2. Import the certificate with private key from PFX
$CertCN = "<Cert Name>"
$CertPassword = Get-Credential
$CertPath = Import-PFXCertificate -FilePath $PFXCertPath -Password $CertPassword.Password Cert:\LocalMachine\My

# 3. Deploy First ADFS Farm Node
$Cert = (Get-ChildItem Cert:\LocalMachine\My\)
$FederationDisplayName =
$FederationName =
$DeployCred = Get-Credential -Message "Deployment Credential"
$ServiceCred = Get-Credential -Message "Service Account Credential"

Install-ADFSFarm -Credential $DeployCred `
    -FederationServiceDisplayName $FederationDisplayName
    -FedetaionServiceName $FederationName `
    -ServiceAccountCredential $ServiceCred `
    -CertificateThumbprint $Cert

# 4. Deploy additional ADFS Farm Nodes
# DO LOCALLY FOR NOW
Install-WindowsFeature ADFS-Federation -IncludeManagementTools

$PrimaryADFSServer = ""
$CertCN = "<Cert Name>"
$CertPassword = Get-Credential
$CertPath = Import-PFXCertificate -FilePath $PFXCertPath -Password $CertPassword.Password Cert:\LocalMachine\My

$Cert = (Get-ChildItem Cert:\LocalMachine\My\)
Add-ADFSFarmNode -ServiceAccountCredential $ServiceCred `
    -PrimaryComputerName $PrimaryADFSServer
#Invoke-Command -Computer $ADFSNode2 -ScriptBlock {Install-WindowsFeature ADFS-Federation -IncludeManagementTools}
#Invoke-Command -Computer