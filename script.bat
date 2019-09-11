@echo off

:: Pedir permisos de administrador
    REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
        >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
    ) ELSE (
        >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
    )
    REM --> If error flag set, we do not have admin.
    if '%errorlevel%' NEQ '0' (
        echo Requesting administrative privileges...
        goto UACPrompt
    ) else ( goto gotAdmin )
    :UACPrompt
        echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
        set params= %*
        echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
        "%temp%\getadmin.vbs"
        del "%temp%\getadmin.vbs"
        exit /B
    :gotAdmin
        pushd "%CD%"
        CD /D "%~dp0"
        
SETLOCAL
IF /I "%1"=="" (
    CALL:HELP_MESSAGE
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-?" (
    CALL:HELP_MESSAGE
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--help" (
    CALL:HELP_MESSAGE
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-ch" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:INSTALL_CHOCO
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--install-chocolatey" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:INSTALL_CHOCO
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-vs" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Visual Studio Code."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_CODE
    IF /I "%2"=="-beautify" (
        ECHO.
        ECHO Se instalaran las siguientes extensiones:
        CALL:INSTALL_BEAUTIFY
    ) 
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--install-code" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Visual Studio Code."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_CODE
    IF /I "%2"=="-beautify" (
        ECHO.
        ECHO Se instalaran las siguientes extensiones:
        CALL:INSTALL_BEAUTIFY
    )
    PAUSE
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
    IF /I "%2"=="--set-credentials" (
        CALL:GIT_CREDENTIALS
    ) 
    PAUSE
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
    IF /I "%2"=="--set-credentials" (
        CALL:GIT_CREDENTIALS
    ) 
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="-ter" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Terminus."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_TERMINUS
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--install-terminus" (
    ECHO.
    CALL:ECHOBLUE "Se instalaran los siguientes programas: "
    ECHO.
    CALL:ECHOYELLOW "Chocolatey."
    CALL:ECHOYELLOW "Terminus."
    CALL:INSTALL_CHOCO
    CALL:INSTALL_TERMINUS
    PAUSE
    EXIT /B %ERRORLEVEL%
)
IF /I "%1"=="--unset-proxy" (
    IF EXIST "C:\Program Files\Git\cmd" (
        CALL:UNSET_GIT_PROXY
    ) ELSE (
        ECHO.
        CALL:ECHORED "Git no esta instalado en el equipo"
        EXIT /B 0
    )
    PAUSE
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
    CALL:GIT_CREDENTIALS
    PAUSE
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
    CALL:GIT_CREDENTIALS
    PAUSE
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
    ECHO    Instala Visual Studio Code.
    ECHO.
    ECHO    -beautify
    ECHO    Instala Visual Studio Code con la extension 'Beautify'.
    ECHO.
    ECHO -ter, --install-terminus
    ECHO    Instala terminus.
    ECHO.
    ECHO -git, --install-git
    ECHO    Instala git.
    ECHO.
    ECHO    --configure-proxy 
    ECHO    Configura el proxy de git con la siguiente informacion.
    ECHO.
    ECHO    git.proxy: 192.168.3.5:8080
    ECHO.
    ECHO    --set-credentials
    ECHO    Configura las credenciales de git con la siguiente informacion:
    ECHO.
    ECHO    git.user.name: 'Cristian Fonseca'
    ECHO    git.user.email: 'cristian.lfs@gmail.com'
    ECHO.
    ECHO --unset-proxy 
    ECHO    Quita el proxy de git.
    ECHO.
    CALL:ECHOBLUE "CONFIGURACIONES:"
    ECHO.
    ECHO -c1, --configuration-1
    ECHO.
    ECHO Instala los siguientes programas:
    ECHO.
    CALL:ECHOMAGENTA "Chocolatey."
    CALL:ECHOMAGENTA "Visual Studio Code."
    CALL:ECHOMAGENTA "Git."
    ECHO.
    CALL:ECHOYELLOW "Con la siguiente configuracion:"
    ECHO.
    ECHO git.proxy: 192.168.3.5:8080
    ECHO git.user.name: 'Cristian Fonseca'
    ECHO git.user.email: 'cristian.lfs@gmail.com'
    ECHO.
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
        IF %ERRORLEVEL% NEQ 0 (
            CALL:ECHORED "Error al instalar chocolatey."
        ) ELSE (
            CALL:ECHOGREEN "Chocolatey se ha instalado satisfactoriamente."
        )
    )
EXIT /B 0
:INSTALL_CODE
    IF EXIST "C:\Program Files\Microsoft VS Code" (
        ECHO.
        CALL:ECHOMAGENTA "Visual Studio Code ya se encuentra instalado."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Instalando Visual Studio Code."
        ECHO.
        choco install vscode -y
        ECHO.
        IF %ERRORLEVEL% NEQ 0 (
            CALL:ECHORED "Error al instalar Visual Studio Code."
        ) ELSE (
            CALL:ECHOGREEN "Visual Studio Code se ha instalado satisfactoriamente."
        )
    )
EXIT /B 0
:INSTALL_TERMINUS
    IF EXIST "%LOCALAPPDATA%\Programs\Terminus" (
        ECHO.
        CALL:ECHOMAGENTA "Terminus ya se encuentra instalado."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Instalando Terminus."
        ECHO.
        choco install terminus -y
        ECHO.
        IF %ERRORLEVEL% NEQ 0 (
            CALL:ECHORED "Error al instalar Terminus."
        ) ELSE (
            CALL:ECHOGREEN "Terminus se ha instalado satisfactoriamente."
        )
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
        IF %ERRORLEVEL% NEQ 0 (
            CALL:ECHORED "Error al instalar Git."
        ) ELSE (
            CALL:ECHOGREEN "Git se ha instalado satisfactoriamente."
        )
    )
EXIT /B 0
:PROXY_GIT
    ECHO.
    CALL:ECHOBLUE "Se configurara el proxy de git con la siguiente configuracion: "
    ECHO.
    ECHO git.proxy: 192.168.3.5:8080
    ECHO.
    git config --global http.proxy 192.168.3.5:8080
    IF %ERRORLEVEL% NEQ 0 (
        CALL:ECHORED "Error al configurar el proxy de Git."
        ECHO.
        CALL:ECHOYELLOW "RECOMENDACION: Cierra el terminal y ejecuta el comando de nuevo"
    ) ELSE (
        CALL:ECHOGREEN "El proxy se ha configurado satisfactoriamente"
    )
EXIT /B 0
:GIT_CREDENTIALS
    ECHO.
    CALL:ECHOBLUE "Se configurara las credenciales de git con la siguiente configuracion: "
    ECHO.
    ECHO git.user.name: 'Cristian Fonseca'
    ECHO git.user.email: 'cristian.lfs@gmail.com'
    ECHO.
    git config --global user.name "Cristian Fonseca"
    IF %ERRORLEVEL% NEQ 0 (
        CALL:ECHORED "Error al configurar las credenciales de Git."
        ECHO.
        CALL:ECHOYELLOW "RECOMENDACION: Cierra el terminal y ejecuta el comando de nuevo"
        EXIT /B 0
    ) ELSE (
        git config --global user.email "cristian.lfs@gmail.com"
        CALL:ECHOGREEN "Las credenciales de git se han configurado satisfactoriamente"
    )
EXIT /B 0
:UNSET_GIT_PROXY
    ECHO.
    git config --global --unset http.proxy
    IF %ERRORLEVEL% NEQ 0 (
        CALL:ECHORED "Error al retirar el proxy de Git."
        ECHO.
        CALL:ECHOYELLOW "RECOMENDACION: Cierra el terminal y ejecuta el comando de nuevo"
    ) ELSE (
        CALL:ECHOGREEN "Proxy retirado""
    )
EXIT /B 0
:INSTALL_BEAUTIFY
    ECHO.
    CALL:ECHOYELLOW "Beautify"
    ECHO.
    CALL code --install-extension vs-extensions/HookyQR.beautify-1.5.0.vsix
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