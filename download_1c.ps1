$login = user
$pass = pass
$url = "https://login.1c.ru/login"
$version = "8.3.17.1496"
$version_mutate = $version.Replace('.','_')
$thin_client_url = "https://releases.1c.ru/version_file?nick=Platform83&ver=$version&path=Platform\$version_mutate\setuptc64_$version_mutate.rar"
$full_client_url = "https://releases.1c.ru/version_file?nick=Platform83&ver=$version&path=Platform\$version_mutate\windows64full_$version_mutate.rar"
$thin_client_file = "C:\download\setuptc64_$version_mutate.rar"
$full_client_file = "C:\download\windows64full_$version_mutate.rar"




$creds = Invoke-WebRequest $url -SessionVariable fb
$form = $creds.Forms[0]
$form.fields["username"] = $login
$form.fields["password"] = $password
$creds = Invoke-WebRequest  -Uri ($url) -WebSession $fb -Method POST -Body $form.Fields
$download_url_thin = (Invoke-WebRequest  -Uri $thin_client_url -WebSession $fb).Links.href | Where-Object {$_ -like '*public/file/get*'} | select -Last 1
$download_url_full = (Invoke-WebRequest  -Uri $full_client_url -WebSession $fb).Links.href | Where-Object {$_ -like '*public/file/get*'} | select -Last 1
