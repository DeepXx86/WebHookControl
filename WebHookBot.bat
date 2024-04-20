@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

echo.
echo.
echo                                   █▄▄ ▄▀█ ▀█▀ █▀▀ █░█ ▄▄ █▀▀ █▀█ █▄░█ ▀█▀ █▀█ █▀█ █░░
echo                                   █▄█ █▀█ ░█░ █▄▄ █▀█ ░░ █▄▄ █▄█ █░▀█ ░█░ █▀▄ █▄█ █▄▄
echo                                         ---------------------------------------
echo                                            *Batch-Control v0.01.3 by Pascal*
echo                                         ---------------------------------------
echo.                                  
echo.                                  
echo                                         ---------------------------------------
echo                                                  *Date 16/12/2023*
echo                                         ---------------------------------------
echo.                                  
echo.
echo.
echo.
echo.                                  

REM Set your Discord webhook URL
set "webhook=your web hook"

:mainLoop
REM Set your custom message
set /p message=Enter your message (if want to exit type "exit" to end code):
echo. 

REM Check if the user wants to exit
if /i "%message%"=="exit" goto :endLoop

REM Construct the message
set message=%message%

REM Create a temporary PowerShell script to send the message
echo $data = @{ content = '"%message%"' } > temp.ps1
echo $jsonData = $data ^| ConvertTo-Json >> temp.ps1
echo Invoke-RestMethod -Uri "%webhook%" -Method Post -Body $jsonData -ContentType "application/json" >> temp.ps1

REM Run the temporary PowerShell script
powershell -ExecutionPolicy Bypass -File temp.ps1

REM Clean up the temporary PowerShell script
del temp.ps1

REM Go back to the beginning of the loop
goto :mainLoop

:endLoop
endlocal
