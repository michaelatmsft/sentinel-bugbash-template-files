param workspace string

resource workspace_SQL_MultipleFailedLogon_InShortSpan 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  name: '${workspace}/SQL-MultipleFailedLogon_InShortSpan'
  location: resourceGroup().location
  properties: {
    eTag: '*'
    displayName: 'Multiple Failed Logon on SQL Server in Short time Span'
    category: 'Hunting Queries'
    query: '\n// SQLEvent is not the table name, it is the function name that should already be imported into your workspace.\n// The underlying table where the data exists is the Event table.\n// the threshold can be changed below as per requirement\n//\nlet failedThreshold = 3;\nSQLEvent\n| where LogonResult has "failed"\n| summarize StartTime = min(TimeGenerated), EndTime = max(TimeGenerated), TotalFailedLogons = count() by CurrentUser, ClientIP\n| where TotalFailedLogons >= failedThreshold\n| project StartTime, CurrentUser, TotalFailedLogons, ClientIP\n| extend timestamp = StartTime, AccountCustomEntity = CurrentUser, IPCustomEntity = ClientIP\n'
    version: 1
    tags: [
      {
        name: 'description'
        value: 'his hunting queries looks for multiple failed logon attempts in short span of time.\nThis query is based on the SQLEvent KQL Parser function (link below)\nSQLEvent KQL Parser provided at https://github.com/Azure/Azure-Sentinel/tree/master/Par'
      }
      {
        name: 'tactics'
        value: 'CredentialAccess'
      }
      {
        name: 'relevantTechniques'
        value: 'T1110'
      }
    ]
  }
}
