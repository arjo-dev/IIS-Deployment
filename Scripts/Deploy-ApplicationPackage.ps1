param
 (
   [string]$computerName,
   [string]$username,
   [string]$password,
   [string]$localDirectory
 )

 $msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe";

 $computerNameArgument = "https://" + $computerName + ':8172/MsDeploy.axd?site=' + $username
 
 #$directory = Split-Path -Path (Get-Location) -Parent
 #$baseName = (Get-Item $directory).BaseName
 #$contentPath = $directory + "\" + $source

 [string[]] $arguments = 
 "-verb:sync",
 "-allowUntrusted",
 "-skip:Directory=App_Data",
 "-skip:absolutePath=.*wwwroot\\media",
 "-enableRule:DoNotDeleteRule",

 "-source:contentPath=${localDirectory}",
 (
    "-dest:" + 
      "contentPath=${username}," +
      "computerName=${computerNameArgument}," + 
      "username='${username}'," +
      "password='${password}'," +
      "AuthType='Basic'"
)

 #if ($paramFile){
 #   $arguments += "-setParamFile:${contentPath}\${paramFile}"
 #}
 
  $fullCommand = """$msdeploy"" $arguments"
 Write-Host $fullCommand
 
 $result = cmd.exe /c "$fullCommand"
 
 Write-Host $result