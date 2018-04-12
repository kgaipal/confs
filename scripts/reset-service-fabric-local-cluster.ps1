# execute in admin in powershell
& "$ENV:ProgramFiles\Microsoft SDKs\Service Fabric\ClusterSetup\DevClusterSetup.ps1" -PathToClusterDataRoot "D:\SfDevCluster\Data"  -PathToClusterLogRoot "D:\SfDevCluster\Log" -CreateOneNodeCluster
& Remove-Item -Path "C:\SfDevCluster" -Recurse
