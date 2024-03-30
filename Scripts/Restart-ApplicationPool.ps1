param
(
  [string]$recycleMode,
  [string]$computerName,
  [string]$username,
  [string]$password
)

$msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe";

$computerNameArgument = "https://" + $computerName + ':8172/MsDeploy.axd?site=' + $username

$msdeployArguments = 
    "-verb:sync",
    "-allowUntrusted",
    "-source:recycleApp",
    ("-dest:" + 
        "recycleApp=${username}," +
        "recycleMode=${recycleMode}," +
        "computerName=${computerNameArgument}," + 
        "username=`"${username}`"," +
        "password=`"${password}`"," +
        "AuthType=`"Basic`""
    )

& $msdeploy $msdeployArguments