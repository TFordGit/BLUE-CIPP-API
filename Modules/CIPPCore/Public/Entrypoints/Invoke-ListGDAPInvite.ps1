using namespace System.Net

Function Invoke-ListGDAPInvite {
    <#
    .FUNCTIONALITY
    Entrypoint
    #>
    [CmdletBinding()]
    param($Request, $TriggerMetadata)

    $APIName = $TriggerMetadata.FunctionName
    Write-LogMessage -user $request.headers.'x-ms-client-principal' -API $APINAME -message 'Accessed this API' -Sev 'Debug'


    # Write to the Azure Functions log stream.
    Write-Host 'PowerShell HTTP trigger function processed a request.'

    Write-Host ($Request | ConvertTo-Json)
    if (![string]::IsNullOrEmpty($Request.Query.RelationshipId)) {
        $Table = Get-CIPPTable -TableName 'GDAPInvites'
        $Invite = Get-CIPPAzDataTableEntity @Table -Filter "RowKey eq '$($Request.Query.RelationshipId)'"
        Write-Host $Invite
    } else {
        $Invite = @{}
    }
    # Associate values to output bindings by calling 'Push-OutputBinding'.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = $Invite
        })

}
