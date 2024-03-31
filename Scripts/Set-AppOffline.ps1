param
(
  [string]$username,
  [string]$password,
  [string]$localDirectory,
  [string]$serverAddress
)

$msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe";

$directory = Split-Path -Path (Get-Location) -Parent
$baseName = (Get-Item $directory).BaseName
#$contentPath = $directory + "\" + $source

$computerNameArgument = 'https://' + $serverAddress + ':8172/MsDeploy.axd?site=' + $username

$msdeployArguments = 
    "-verb:sync",
    "-allowUntrusted",
    "-source:contentPath=${localDirectory}\App_offline.template.htm",
    
    ( 
      "-dest:" +
        "contentPath=${username}/App_offline.htm," +
        "computerName=${computerNameArgument}," +
        "username='${username}'," +
        "password='${password}'," +
        "AuthType='Basic'"
    )
    

& $msdeploy $msdeployArguments
