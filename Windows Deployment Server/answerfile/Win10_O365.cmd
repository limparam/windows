color C0

echo off
rem timeout 5 /nobreak
echo ==============================================================================
echo Windows 10 Pro installation is complete. Application installation in progress.
echo ==============================================================================
echo Connecting to WDSsrvVM network share folder
net use x: \\fineshare\silent$\soft

echo Disable pc sleep
c:\windows\system32\powercfg.exe -change -standby-timeout-ac 0
c:\windows\system32\powercfg.exe -change -hibernate-timeout-ac 0
echo Done.

echo Installing Office365...
start /wait x:\Office365x64\setup.exe /configure x:\Office365x64\RU.xml
echo Done.

color E0

echo Installing 7-zip...
start /wait msiexec /i x:\7z1900-x64.msi /qb
echo Done.

echo Enable NET framework 3.5...
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:x:\Windows_10_Pro_sxs
echo Done.

echo Enable ICMP
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
echo Done.

echo Installing ESET Agent
start /wait msiexec /i x:\ESET\Agent_x64.msi /quiet /norestart
echo Done.

echo Installing ESET Endpoint Antivirus
start /wait msiexec /i x:\ESET\eea_nt64_enu.msi /quiet /norestart
echo Done.

echo Installing LAPS
start /wait msiexec /i x:\LAPS.x64.msi /quiet /norestart
echo Done.

echo Disconnect network folder
net use x: /delete


color A0

echo ===================================================
echo Now you can finish setup computer, add to domain...
echo NOTE: If you from testing group employee,
echo change local administrator password.
echo Autologin work at first logon only!
wmic baseboard get product > c:\windows\model.txt
for /f "usebackq  delims=" %%i in (`find /n /v "" c:\windows\model.txt ^| find "[2]"`) do (
    set value=%%i
)
echo Computer motherboard model: %value:~3%

reg add hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\ /v Model /t REG_SZ /d "%value:~3%" /f

echo activated Windows
slmgr /ipk WWWWW-WWWWW-WWWWW-WWWWW-WWWWW
echo ===================================================
pause
