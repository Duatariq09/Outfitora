@echo off
cd /d "%~dp0"
title Outfitora - online
where node >nul 2>nul || (echo Node.js is not installed. Install the LTS version from https://nodejs.org, then run this file again. ^& pause ^& exit /b 1)
where cloudflared >nul 2>nul
if errorlevel 1 (
  echo Installing cloudflared, the free tool that makes your public link...
  winget install --id Cloudflare.cloudflared -e --accept-source-agreements --accept-package-agreements
  echo.
  echo If it was installed, CLOSE this window and run GO-ONLINE.bat again.
  echo If winget does not exist on your computer, download cloudflared from https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/
  pause
  exit /b 1
)
if not exist .env copy .env.example .env >nul
echo Starting Outfitora in a second window. Keep that window open.
start "Outfitora server" cmd /k node start.js
timeout /t 6 /nobreak >nul
echo.
echo ===================================================================
echo  Your public link will appear below, like https://xxxx.trycloudflare.com
echo  Open it on your phone. Sign up and log in there, like any website.
echo  Keep this window and the server window open while people use it.
echo ===================================================================
cloudflared tunnel --url http://localhost:3000
pause
