function Get-ADCSErrorFromLog {
    param (
        $ComputerName
    )
    get-content $env:SystemRoot\certocm.log -Tail 10
}