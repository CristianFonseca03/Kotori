@ECHO OFF
SETLOCAL
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"  > nul
SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"  > nul
EXIT /B %ERRORLEVEL%