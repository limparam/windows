$diskhealth = Get-StoragePool | select -ExpandProperty HealthStatus
$diskstat = Get-StoragePool | Select-Object FriendlyName, OperationalStatus, HealthStatus
$physical = Get-PhysicalDisk
if ($diskhealth -ne "Healthy")
{
$MailArgs = @{
From = 'server.name@domain.com'
To = 'monitoring@domain.com'
Subject = 'Storage Spaces error'
Body = ($diskstat | Out-String)
SmtpServer = 'smtp.domain.com'
Port = 25
}

Send-MailMessage @MailArgs

}


### Create task!
