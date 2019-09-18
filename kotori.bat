@ECHO OFF
SETLOCAL
SET VERSION=0.12.2
NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 (
    IF NOT EXIST %~d0%~p0.installed (
        FSUTIL FILE CREATENEW .installed 1 > NUL
    )
    SET VER_=
    IF /I "%1"=="-v" SET VER_=TRUE
    IF /I "%1"=="--version" SET VER_=TRUE
    IF NOT DEFINED VER_ (
        CALL:LOGO
    )
    CALL:COMANDS %1 %2 %3
) ELSE (
    SET ENTRY_=
    SET VER_=
    IF /I "%1"=="-v" (
        SET ENTRY_=TRUE
        SET VER_=TRUE
    )
    IF /I "%1"=="--version" (
        SET ENTRY_=TRUE
        SET VER_=TRUE
    )
    IF /I "%1"=="-?" SET ENTRY_=TRUE
    IF /I "%1"=="--help" SET ENTRY_=TRUE
    IF DEFINED ENTRY_ (
        IF NOT DEFINED VER_ (
            CALL:LOGO
        )
        CALL:COMANDS %1
    ) ELSE (
        CALL:LOGO
        CALL:ECHOYELLOW "Este programa se debe ejecutar en un entorno elevado de administrador."
    )
)
EXIT /B 0
:LOGO
    ECHO.
    ECHO [48;5;48m                                                                      [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m                                                                  [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m   ,ggg,        gg                                                [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m  dP""Y8b       dP              I8                                [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m  Yb, `88      d8'              I8                                [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m   `"  88    ,dP'            88888888                       gg    [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m       88aaad8"                 I8                          ""    [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m       88""""Yb,      ,ggggg,   I8     ,ggggg,   ,gggggg,   gg    [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m       88     "8b    dP"  "Y8gggI8    dP"  "Y8gggdP""""8I   88    [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m       88      `8i  i8'    ,8I ,I8,  i8'    ,8I ,8'    8I   88    [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m       88       Yb,,d8,   ,d8',d88b,,d8,   ,d8',dP     Y8,_,88,_  [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m       88        Y8P"Y8888P"  8P""Y8P"Y8888P"  8P      `Y88P""Y8  [48;5;48m  [0m
    ECHO [48;5;48m  [38;5;118;48;5;239m                                                                  [48;5;48m  [0m
    ECHO [48;5;48m                                                                      [0m
    CALL:ECHOGREEN "%VERSION%v."
    ECHO.
    ECHO [36;1mCreado por @CristianFonseca03.[0m
    ECHO [32m-^> [36mgithub.com/CristianFonseca03/Kotori[0m
    ECHO.
GOTO:EOF
:COMANDS
    REM TODO: ARREGLAR ERROR
    IF /I "%1"=="" (
        CALL:HELP_MESSAGE
    )
    IF /I "%1"=="-?" (
        CALL:HELP_MESSAGE
    )
    IF /I "%1"=="--help" (
        CALL:HELP_MESSAGE
    )
    IF /I "%1"=="-v" (
        CALL:ECHOGREEN "Kotori %VERSION%v"
    )
    IF /I "%1"=="--version" (
        CALL:ECHOGREEN "%VERSION%"
    )
    IF /I "%1"=="-ch" (
        SET INSTALLED =
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "CHOCOLATEY" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Chocolatey ya se encuentra instalado."
            ECHO.
        ) ELSE (
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Chocolatey."
            ECHO.
            GOTO:INSTALL_CHOCO
        )
    )
    IF /I "%1"=="--install-chocolatey" (
        SET INSTALLED =
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "CHOCOLATEY" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Chocolatey ya se encuentra instalado."
            ECHO.
        ) ELSE (
            ECHO.
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Chocolatey."
            ECHO.
            GOTO:INSTALL_CHOCO
        )
    )
    IF /I "%1"=="-vs" (
        SET INSTALLED =
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "VSCODE" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Visual Studio Code ya se encuentra instalado."
            ECHO.
        ) ELSE (
            ECHO.
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Visual Studio Code."
            ECHO.
            GOTO:INSTALL_CODE
        )Ñ
        IF /I "%2"=="-beautify" (
            IF /I "%3"=="-p" (
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Beautify."
                ECHO.
                CALL:INSTALL_BEAUTIFY_P
            )
            IF /I "%3"=="" (
                ECHO.
                CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar la extencion','"
                CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como tercer parametro."
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Beautify."
                ECHO.
                CALL:INSTALL_BEAUTIFY
            )
        ) 
        IF /I "%2"=="-material-theme" (
            CALL:ECHOYELLOW "Se instalaran las siguientes extensiones:"
            ECHO.
            CALL:ECHOMAGENTA "Material Theme"
            ECHO.
            CALL:ECHOYELLOW "Instalando Material Theme..."
            CALL:INSTALL_MATERIAL_THEME %3
            ECHO.
            CALL:ECHOYELLOW "ALERTA: Si no se instalan las extensiones, revisa si estas bajo un proxy e intenta con la bandera -p. /? para ver el menu de ayuda"
        )
        IF /I "%2"=="-material-icon" (
            IF /I "%3"=="-p" (
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Material Icon Theme"
                ECHO.
                CALL:INSTALL_MATERIAL_ICON_P
            )
            IF /I "%3"=="" (
                ECHO.
                CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar la extencion','"
                CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como tercer parametro."
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Material Icon Theme"
                ECHO.
                CALL:INSTALL_MATERIAL_ICON
            )
        )
        IF /I "%2"=="-live-server" (
            IF /I "%3"=="-p" (
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Live Server"
                ECHO.
                CALL:INSTALL_LIVE_SERVER_P
            )
            IF /I "%3"=="" (
                ECHO.
                CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar la extencion','"
                CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como tercer parametro."
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Live Server"
                ECHO.
                CALL:INSTALL_LIVE_SERVER
            )
        )
    )
    IF /I "%1"=="--install-code" (
        SET INSTALLED =
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "VSCODE" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Visual Studio Code ya se encuentra instalado."
            ECHO.
        ) ELSE (
            ECHO.
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Visual Studio Code."
            ECHO.
            GOTO:INSTALL_CODE
        )
        IF /I "%2"=="-beautify" (
            IF /I "%3"=="-p" (
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Beautify."
                ECHO.
                CALL:INSTALL_BEAUTIFY_P
            )
            IF /I "%3"=="" (
                ECHO.
                CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar la extencion','"
                CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como tercer parametro."
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Beautify."
                ECHO.
                CALL:INSTALL_BEAUTIFY
            )
        )
        IF /I "%2"=="-material-theme" (
            IF /I "%3"=="-p" (
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Material Theme"
                ECHO.
                CALL:INSTALL_MATERIAL_THEME_P
            )
            IF /I "%3"=="" (
                ECHO.
                CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar la extencion','"
                CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como tercer parametro."
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Material Theme"
                ECHO.
                CALL:INSTALL_MATERIAL_THEME
            )
        )
        IF /I "%2"=="-material-icon" (
            IF /I "%3"=="-p" (
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Material Icon Theme"
                ECHO.
                CALL:INSTALL_MATERIAL_ICON_P
            )
            IF /I "%3"=="" (
                ECHO.
                CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar la extencion','"
                CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como tercer parametro."
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Material Icon Theme"
                ECHO.
                CALL:INSTALL_MATERIAL_ICON
            )
        )
        IF /I "%2"=="-live-server" (
            IF /I "%3"=="-p" (
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Live Server"
                ECHO.
                CALL:INSTALL_LIVE_SERVER_P
            )
            IF /I "%3"=="" (
                ECHO.
                CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar la extencion','"
                CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como tercer parametro."
                ECHO.
                ECHO Se instalaran las siguientes extensiones:
                ECHO.
                CALL:ECHOYELLOW "Live Server"
                ECHO.
                CALL:INSTALL_LIVE_SERVER
            )
        ) 
    )
    IF /I "%1"=="-git" (
        SET INSTALLED = 
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "GIT" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Git ya se encuentra instalado."
            ECHO.
        ) ELSE (
            ECHO.
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Git."
            ECHO.
            GOTO:INSTALL_GIT
        )
        IF /I "%2"=="--configure-proxy" (
            CALL:PROXY_GIT
        )
        IF /I "%2"=="-p" (
            CALL:PROXY_GIT
        )
        IF /I "%2"=="--set-credentials" (
            CALL:GIT_CREDENTIALS
        )
        IF /I "%2"=="-c" (
            CALL:GIT_CREDENTIALS
        )
    )
    IF /I "%1"=="--install-git" (
        SET INSTALLED =
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "GIT" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Git ya se encuentra instalado."
            ECHO.
        ) ELSE (
            ECHO.
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Git."
            ECHO.
            GOTO:INSTALL_GIT
        )
        IF /I "%2"=="--configure-proxy" (
            CALL:PROXY_GIT
        )
        IF /I "%2"=="--set-credentials" (
            CALL:GIT_CREDENTIALS
        )
    )
    IF /I "%1"=="-up" (
        IF EXIST "C:\Program Files\Git\cmd" (
            CALL:UNSET_GIT_PROXY
        ) ELSE (
            ECHO.
            CALL:ECHORED "Git no esta instalado en el equipo"
            EXIT /B 0
        )
    )
    IF /I "%1"=="--unset-proxy" (
        IF EXIST "C:\Program Files\Git\cmd" (
            CALL:UNSET_GIT_PROXY
        ) ELSE (
            ECHO.
            CALL:ECHORED "Git no esta instalado en el equipo"
            EXIT /B 0
        )
    )
    IF /I "%1"=="-ter" (
        SET INSTALLED =
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "TERMINUS" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Terminus ya se encuentra instalado."
            ECHO.
        ) ELSE (
            ECHO.
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Terminus."
            ECHO.
            GOTO:INSTALL_TERMINUS
        )
    )
    IF /I "%1"=="--install-terminus" (
        SET INSTALLED =
        IF EXIST %~d0%~p0\.installed (
            FOR /F "delims=;" %%A IN (%~d0%~p0\.installed) DO (
                IF "%%A" == "TERMINUS" SET INSTALLED=TRUE
            )
        )
        IF DEFINED INSTALLED (
            CALL:ECHOYELLOW "Terminus ya se encuentra instalado."
            ECHO.
        ) ELSE (
            ECHO.
            CALL:ECHOBLUE "Se instalaran los siguientes programas: "
            ECHO.
            CALL:ECHOMAGENTA "Terminus."
            ECHO.
            GOTO:INSTALL_TERMINUS
        )
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
        CALL:GIT_CREDENTIALS
        ECHO.
        ECHO Se instalaran las siguientes extensiones:
        ECHO.
        CALL:ECHOYELLOW "Beautify"
        CALL:ECHOYELLOW "Material Theme"
        CALL:ECHOYELLOW "Material Icon Theme"
        CALL:ECHOYELLOW "Live Server"
        ECHO.
        IF /I "%2"=="-p" (
            CALL:INSTALL_BEAUTIFY_P
            ECHO.
            CALL:INSTALL_MATERIAL_THEME_P
            ECHO.
            CALL:INSTALL_MATERIAL_ICON_P
            ECHO.
            CALL:INSTALL_LIVE_SERVER_P
            CALL:PROXY_GIT
        )
        IF /I "%2"=="" (
            CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar las extenciones','"
            CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como segundo parametro."
            ECHO.
            CALL:INSTALL_BEAUTIFY
            ECHO.
            CALL:INSTALL_MATERIAL_THEME
            ECHO.
            CALL:INSTALL_MATERIAL_ICON
            ECHO.
            CALL:INSTALL_LIVE_SERVER
            ECHO.
        )
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
        CALL:GIT_CREDENTIALS
        ECHO.
        ECHO Se instalaran las siguientes extensiones:
        ECHO.
        CALL:ECHOYELLOW "Beautify"
        CALL:ECHOYELLOW "Material Theme"
        CALL:ECHOYELLOW "Material Icon Theme"
        CALL:ECHOYELLOW "Live Server"
        ECHO.
        IF /I "%2"=="-p" (
            CALL:INSTALL_BEAUTIFY_P
            ECHO.
            CALL:INSTALL_MATERIAL_THEME_P
            ECHO.
            CALL:INSTALL_MATERIAL_ICON_P
            ECHO.
            CALL:INSTALL_LIVE_SERVER_P
            CALL:PROXY_GIT
        )
        IF /I "%2"=="" (
            CALL:ECHOYELLOW "ADVERTENCIA: Si se generan errores al instalar las extenciones','"
            CALL:ECHOYELLOW "se recomienda utilizarla bandera -p como segundo parametro."
            ECHO.
            CALL:INSTALL_BEAUTIFY
            ECHO.
            CALL:INSTALL_MATERIAL_THEME
            ECHO.
            CALL:INSTALL_MATERIAL_ICON
            ECHO.
            CALL:INSTALL_LIVE_SERVER
            ECHO.
        )
    )
EXIT /B 0
:HELP_MESSAGE
    ECHO -?, --help
    ECHO    Imprime el menu de ayuda.
    ECHO.
    ECHO -v, --version
    ECHO    Muestra la version de kotori actualmente instalada.
    ECHO.
    ECHO -ch, --install-chocolatey
    ECHO    Instala chocolatey.
    ECHO.
    ECHO -vs, --install-code
    ECHO    Instala Visual Studio Code.
    ECHO.
    CALL:ECHOYELLOW "   La bandera -p como tercer parametro, instalara las extenciones"
    CALL:ECHOYELLOW "   con los archivos vsix guardados en la carpeta 'vs-extensions'."
    ECHO.
    ECHO    -beautify
    ECHO    Instala Visual Studio Code con la extension 'Beautify'.
    ECHO.
    ECHO    -material-theme
    ECHO    Instala Visual Studio Code con la extension 'Material Theme'.
    ECHO.
    ECHO    -material-icon
    ECHO    Instala Visual Studio Code con la extension 'Material Icon Theme'.
    ECHO.
    ECHO    -live-server
    ECHO    Instala Visual Studio Code con la extension 'Live Server'.
    ECHO.
    ECHO -ter, --install-terminus
    ECHO    Instala terminus.
    ECHO.
    ECHO -git, --install-git
    ECHO    Instala git.
    ECHO.
    ECHO    -p, --configure-proxy
    ECHO    Configura el proxy de git con la siguiente informacion.
    ECHO.
    ECHO    git.proxy: 192.168.3.5:8080
    ECHO.
    ECHO    -c, --set-credentials
    ECHO    Configura las credenciales de git con la siguiente informacion:
    ECHO.
    ECHO    git.user.name: 'Cristian Fonseca'
    ECHO    git.user.email: 'cristian.lfs@gmail.com'
    ECHO.
    ECHO -up, --unset-proxy 
    ECHO    Quita el proxy de git.
    ECHO.
    CALL:ECHOBLUE "CONFIGURACIONES:"
    ECHO.
    CALL:ECHOYELLOW "La bandera -p como segundo parametro, instalara las extenciones"
    CALL:ECHOYELLOW "con los archivos vsix guardados en la carpeta 'vs-extensions' y configurara"
    CALL:ECHOYELLOW "git con los siguientes parametros adicionales: "
    ECHO.
    ECHO git.proxy: 192.168.3.5:8080
    ECHO.
    ECHO -c1, --configuration-1
    ECHO.
    CALL:ECHOYELLOW "   Instala los siguientes programas:"
    ECHO.
    ECHO    Chocolatey.
    ECHO    Visual Studio Code.
    ECHO    Git.
    ECHO.
    CALL:ECHOYELLOW "   Con la siguiente configuracion:"
    ECHO.
    ECHO    git.user.name: 'Cristian Fonseca'
    ECHO    git.user.email: 'cristian.lfs@gmail.com'
    ECHO.
    CALL:ECHOYELLOW "   Con las siguientes extenciones de Visual Studio Code:"
    ECHO.
    ECHO    Beautify.
    ECHO    Material theme.
    ECHO    Material icon theme.
    ECHO    LiveServer.
EXIT /B 0
:INSTALL_CHOCO
    CALL:ECHOYELLOW "Instalando Chocolatey..."
    call %~d0%~p0installers\install_choco.bat
    IF not %ERRORLEVEL% == 0 (
        ECHO.
        CALL:ECHORED "Error inesperado durante la instalacion."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Chocolatey instalado satisafactoriamente."
        ECHO CHOCOLATEY; >> %~d0%~p0.installed
    )
GOTO:EOF
:INSTALL_CODE
    CALL:ECHOYELLOW "Instalando Visual Studio Code..."
    CALL choco install vscode -y >nul
    IF not %ERRORLEVEL% == 0 (
        ECHO.
        CALL:ECHORED "Error inesperado durante la instalacion."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Visual Studio Code instalado satisafactoriamente."
        ECHO VSCODE; >> %~d0%~p0.installed
    )
GOTO:EOF
:INSTALL_GIT
    CALL:ECHOYELLOW "Instalando Git..."
    CALL choco install git -y >nul
    IF not %ERRORLEVEL% == 0 (
        ECHO.
        CALL:ECHORED "Error inesperado durante la instalacion."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Git instalado satisafactoriamente."
        ECHO GIT; >> %~d0%~p0.installed
    )
GOTO:EOF
:INSTALL_TERMINUS
    CALL:ECHOYELLOW "Instalando Terminus..."
    CALL choco install terminus -y >nul
    IF not %ERRORLEVEL% == 0 (
        ECHO.
        CALL:ECHORED "Error inesperado durante la instalacion."
    ) ELSE (
        ECHO.
        CALL:ECHOGREEN "Terminus instalado satisafactoriamente."
        ECHO TERMINUS; >> %~d0%~p0.installed
    )
GOTO:EOF
:PROXY_GIT
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
    git config --global --unset http.proxy
    IF %ERRORLEVEL% EQU 5 (
            CALL:ECHOYELLOW "No se encontro proxy registrado"
    ) ELSE (
        IF %ERRORLEVEL% NEQ 0 (
            CALL:ECHORED "Error al retirar el proxy de Git."
            ECHO.
            CALL:ECHOYELLOW "RECOMENDACION: Cierra el terminal y ejecuta el comando de nuevo"
        ) ELSE (
            CALL:ECHOGREEN "Proxy retirado"
        )
    )
EXIT /B 0
::VsCode extensions
:INSTALL_BEAUTIFY
    IF /I "%1"=="-p" (
        code --install-extension vs-extensions/HookyQR.beautify-1.5.0.vsix > nul
    ) ELSE (
        code --install-extension hookyqr.beautify > nul
    )
EXIT /B 0
:INSTALL_MATERIAL_THEME
    IF /I "%1"=="-p" (
        code --install-extension vs-extensions/Equinusocio.vsc-material-theme-30.0.0.vsix > nul
    ) ELSE (
        code --install-extension equinusocio.vsc-material-theme > nul
    )
GOTO:EOF
:INSTALL_MATERIAL_ICON
    IF /I "%1"=="-p" (
        code --install-extension vs-extensions/PKief.material-icon-theme-3.9.0.vsix > nul
    ) ELSE (
        code --install-extension pkief.material-icon-theme > nul
    )
EXIT /B 0
:INSTALL_LIVE_SERVER
    IF /I "%1"=="-p" (
        code --install-extension vs-extensions/ritwickdey.LiveServer-5.6.1.vsix > nul
    ) ELSE (
        code --install-extension ritwickdey.liveserver > nul
    )
EXIT /B 0
:ECHORED
    ECHO [31;1m%~1[0m
GOTO:EOF
:ECHOGREEN
    ECHO [32;1m%~1[0m
GOTO:EOF
:ECHOYELLOW
    ECHO [33;1m%~1[0m
GOTO:EOF
:ECHOBLUE
    ECHO [34;1m%~1[0m
GOTO:EOF
:ECHOMAGENTA
    ECHO [35;1m%~1[0m
GOTO:EOF