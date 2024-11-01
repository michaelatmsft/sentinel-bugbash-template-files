param workspace string

resource workspace_imProcess_Certutil_LOLBins 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  name: '${workspace}/imProcess_Certutil-LOLBins'
  location: resourceGroup().location
  properties: {
    eTag: '*'
    displayName: 'Certutil (LOLBins and LOLScripts, Normalized Process Events)'
    category: 'Hunting Queries'
    query: 'imProcessCreate\n| where Process has "certutil.exe"\n// Uncomment the next line and add your commandLine Whitelisted/ignore terms.For example "urlcache"\n// | where CommandLine !contains ("urlcache") \n| extend HostCustomEntity = Dvc, AccountCustomEntity = User\n'
    version: 1
    tags: [
      {
        name: 'description'
        value: 'This detection uses Normalized Process Events to hunt Certutil activities'
      }
      {
        name: 'tactics'
        value: 'CommandAndControl'
      }
      {
        name: 'relevantTechniques'
        value: 'T1105'
      }
    ]
  }
}
