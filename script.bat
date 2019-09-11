@echo off
CALL admin.bat
SETLOCAL
IF /I "%1"=="" (
    CALL:HELP_MESSAGE
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-?" (
    CALL:HELP_MESSAGE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--help" (
    CALL:HELP_MESSAGE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-ch" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:INSTALL_CHOCO
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--install-chocolatey" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:INSTALL_CHOCO
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-vs" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Visual studio code."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_CODE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--install-code" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Visual studio code."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_CODE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-git" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Git."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_GIT
    IF /I "%2"=="--configure-proxy" (
        CALL:PROXY_GIT
    ) 
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--install-git" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Git."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_GIT
    IF /I "%2"=="--configure-proxy" (
        CALL:PROXY_GIT
    ) 
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--unset-proxy" (
    IF EXIST "C:\Program Files\Git\cmd" (
        CALL:UNSET_GIT
    ) ELSE (
        ECHO.
        CALL:ECHORED "Git no esta instalado en el equipo"
        EXIT /B 0
    )
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-c1" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Visual Studio Code."
    CALL:ECHOYELLOW "Git."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_CODE
    CALL:INSTALL_GIT
    CALL:PROXY_GIT
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--configuration-1" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Visual Studio Code."
    CALL:ECHOYELLOW "Git."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_CODE
    CALL:INSTALL_GIT
    CALL:PROXY_GIT
    EXIT /B %ERRORLEVEL%
)
:HELP_MESSAGE
    ECHO.
    ECHO -?, --help
    ECHO    Imprime el menu de ayuda.
    ECHO.
    ECHO -ch, --install-chocolatey
    ECHO    Instala chocolatey.
    ECHO.
    ECHO -vs, --install-code
    ECHO    Instala visual studio code.
    ECHO.
    ECHO -git, --install-git
    ECHO    Instala git.
    ECHO.
    ECHO    --configure-proxy 
    ECHO    Configura git con el proxy de la uptc.
    ECHO.
    ECHO --unset-proxy 
    ECHO    Quita el proxy de git.
    ECHO.
    CALL:ECHOBLUE "'-c1, --configuration-1'"
    ECHO.
    ECHO Instala los siguientes programas:
    ECHO.
    CALL:ECHOMAGENTA "Chocolatey."
    CALL:ECHOMAGENTA "Visual Studio Code."
    CALL:ECHOMAGENTA "Git."
    ECHO.
    ECHO Con las siguientes configuraciones:
    ECHO.
    CALL:ECHOYELLOW "Proxy de git:"
    ECHO    Ip: 192.168.3.5
    ECHO    Puerto: 8080
EXIT /B 0
:INSTALL_CHOCO
    IF EXIST "C:\ProgramData\chocolatey" (
        ECHO.
        CALL:ECHOMAGENTA "Chocolatey ya se encuentra instalado."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Instalando Chocolatey."
        ECHO.
        @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
        ECHO.
        CALL:ECHOGREEN "Chocolatey se ha instalado satisfactoriamente."
    )
EXIT /B 0
:INSTALL_CODE
    IF EXIST "C:\Program Files\Microsoft VS Code" (
        ECHO.
        CALL:ECHOMAGENTA "Visual studio code ya se encuentra instalado."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Instalando visual studio code."
        ECHO.
        choco install vscode -y
        ECHO.
        CALL:ECHOGREEN "Visual studio code se ha instalado satisfactoriamente."
    )
EXIT /B 0
:INSTALL_GIT
    IF EXIST "C:\Program Files\Git\cmd" (
        ECHO.
        CALL:ECHOMAGENTA "Git ya se encuentra instalado."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Instalando git."
        ECHO.
        choco install git -y
        ECHO.
        CALL:ECHOGREEN "Git se ha instalado satisfactoriamente."
    )
EXIT /B 0
:PROXY_GIT:
    ECHO.
    CALL:ECHOBLUE "Se configurara el proxy de git con la siguiente configuracion: "
    ECHO.
    ECHO Ip: 192.168.3.5
    ECHO Puerto: 8080
    ECHO.
    git config --global http.proxy 192.168.3.5:8080
    CALL:ECHOGREEN "El proxy se ha configurado satisfactoriamente"
EXIT /B 0
:UNSET_GIT:
    ECHO.
    git config --global --unset http.proxy
    CALL:ECHOBLUE "Proxy retirado"
EXIT /B 0
:ECHORED
    %Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Red %1
GOTO:EOF
:ECHOGREEN
    %Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Green %1
GOTO:EOF
:ECHOYELLOW
    %Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Yellow %1
GOTO:EOF
:ECHOBLUE
    %Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Blue %1
GOTO:EOF
:ECHOMAGENTA
    %Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Magenta %1
GOTO:EOF