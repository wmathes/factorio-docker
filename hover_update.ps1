#Update which Hover record?
$dnsID =     "dns19556599"
$dnsdomain = "tailstorm.io"

#Get current public IP (pretty cool little trick, don't adjust this line)
# $myIP = Resolve-DnsName -Name myip.opendns.com -Server resolver1.opendns.com
docker-machine ip factorio | Tee-Object -Variable myIP
if($myIP -NotMatch '\d+\.\d+\.\d+\.\d+') 
{
    Write-Host "IP couldn't be determined"
	Exit 1
}

#Connect to HoverAPI
$Headers = @{   "accept"="application/json";
                "content-type"="application/json"}
$params = @{    "username"=$env:HOVER_USERNAME;
                "password"=$env:HOVER_PASSWORD}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$loginResult = Invoke-WebRequest -Uri "https://www.hover.com/api/login" -Method POST -Body ($params|ConvertTo-Json) -Headers $Headers -SessionVariable WebSession

#Check the login was successful
if($loginResult.Headers.'Set-Cookie' -notmatch "hoverauth" -or $loginResult.StatusDescription -ne "OK")
{
    Write-Host "There has been a problem"
}
else
{
    #update the record
    $jsonRequest = '{"domain":{"id":"domain-' + $dnsdomain + '","dns_records":[{"id":"'+$dnsID+'"}]},"fields":{"content":"' + $myIP + '"}}'
    $updateResult = Invoke-WebRequest -Uri "https://www.hover.com/api/control_panel/dns" -Method put -Body $jsonRequest -WebSession $WebSession
    Write-Host "Done!"
}