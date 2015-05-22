@echo off

set PORT=11111

set WEBCONFIGDIR="D:\git\homemarket\HomeMarket"

cd /d %Programfiles%\IIS Express

start iisexpress /path:%HOMEDRIVE%\Windows\Microsoft.NET\Framework\v4.0.30319\ASP.NETWebAdminFiles /vpath:/ASP.NETWebAdminFiles /port:%PORT% /clr:4.0 /ntlm

start "" "http://localhost:%PORT%/asp.netwebadminfiles/default.aspx?applicationPhysicalPath=%WEBCONFIGDIR%&applicationUrl=/"

pause