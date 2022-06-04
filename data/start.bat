:: Start script generated by ServerPackCreator.
:: This script checks for the Minecraft and Forge JAR-files, and if they are not found, they are downloaded and installed.
:: If everything is in order, the server is started.
@ECHO off
SetLocal EnableDelayedExpansion

SET JAVA="java"
SET MINECRAFT="1.18.2"
SET FORGE="40.1.25"
SET ARGS="-Xmx5G"
SET OTHERARGS="-Dlog4j2.formatMsgNoLookups=true"

SET AGREE="I agree"

IF NOT EXIST libraries/net/minecraftforge/forge/%MINECRAFT%-%FORGE%/forge-%MINECRAFT%-%FORGE%-server.jar (

  ECHO Forge Server JAR-file not found. Downloading installer...
  powershell -Command "(New-Object Net.WebClient).DownloadFile('https://files.minecraftforge.net/maven/net/minecraftforge/forge/%MINECRAFT%-%FORGE%/forge-%MINECRAFT%-%FORGE%-installer.jar', 'forge-installer.jar')"

  IF EXIST forge-installer.jar (

    ECHO Installer downloaded. Installing...
    java -jar forge-installer.jar --installServer

    IF EXIST libraries/net/minecraftforge/forge/%MINECRAFT%-%FORGE%/forge-%MINECRAFT%-%FORGE%-server.jar (
      DEL forge-installer.jar
      ECHO Installation complete. forge-installer.jar deleted.
    )

  ) ELSE (
    ECHO forge-installer.jar not found. Maybe the Forges servers are having trouble.
    ECHO Please try again in a couple of minutes.
  )
) ELSE (
  ECHO Forge server present. Moving on...
)

IF NOT EXIST libraries/net/minecraft/server/%MINECRAFT%/server-%MINECRAFT%.jar (
  ECHO Minecraft Server JAR-file not found. Downloading...
  powershell -Command "(New-Object Net.WebClient).DownloadFile('Optional[https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar]', 'libraries/net/minecraft/server/%MINECRAFT%/server-%MINECRAFT%.jar')"
) ELSE (
  ECHO Minecraft server present. Moving on...
)

IF EXIST run.bat (
  DEL run.bat
  ECHO Deleted run.bat as we already have start.bat
)
IF EXIST run.sh (
  DEL run.sh
  ECHO Deleted run.sh as we already have start.sh
)

IF NOT EXIST eula.txt (
  ECHO Mojang's EULA has not yet been accepted. In order to run a Minecraft server, you must accept Mojang's EULA.
  ECHO Mojang's EULA is available to read at https://account.mojang.com/documents/minecraft_eula
  ECHO If you agree to Mojang's EULA then type "I agree"
  set /P "Response="
  IF "%Response%" == "%AGREE%" (
    ECHO User agreed to Mojang's EULA.
    ECHO #By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://account.mojang.com/documents/minecraft_eula^).> eula.txt
    ECHO eula=true>> eula.txt
  ) else (
    ECHO User did not agree to Mojang's EULA. 
  )
) ELSE (
  ECHO eula.txt present. Moving on...
)

ECHO Starting server...
ECHO Minecraft version: %MINECRAFT%
ECHO Forge version: %FORGE%
ECHO Java version:
%JAVA% --version
ECHO Java args in user_jvm_args.txt: %ARGS%

REM Forge requires a configured set of both JVM and program arguments.
REM Add custom JVM arguments to the user_jvm_args.txt
REM Add custom program arguments {such as nogui} to this file in the next line before the %* or
REM  pass them to this script directly
ECHO If you receive the error message "Error: Could not find or load main class @user_jvm_args.txt" you may be using the wrong Java-version for this modded Minecraft server. Contact the modpack-developer or, if you made the server pack yourself, do a quick google-search for the used Minecraft version to find out which Java-version is required in order to run this server.

%JAVA% "%OTHERARGS%" @user_jvm_args.txt @libraries/net/minecraftforge/forge/%MINECRAFT%-%FORGE%/win_args.txt nogui %*

PAUSE