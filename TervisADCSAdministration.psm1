function Invoke-TervisCAProvision {
    Invoke-ApplicationProvision -ApplicationName "CertificateAuthority"

    #Errors when run from etsn, currently must be run via powershell prompt opened via RDP
    Install-AdcsCertificationAuthority -CAType EnterpriseRootCa -CryptoProviderName "ECDSA_P256#Microsoft Software Key Storage Provider" -KeyLength 256 -HashAlgorithmName SHA256 -ValidityPeriod Years -ValidityPeriodUnits 99 -Force
    $ThumbPrint = gci Cert:\LocalMachine\My\ | Where-Object {$_.subject} | Select-Object -ExpandProperty ThumbPrint
    Install-AdcsEnrollmentPolicyWebService -AuthenticationType Kerberos -SSLCertThumbprint $ThumbPrint -Force
}

function Get-ADCSErrorFromLog {
    param (
        $ComputerName
    )
    get-content $env:SystemRoot\certocm.log -Tail 10
}