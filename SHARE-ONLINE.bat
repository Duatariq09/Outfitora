@echo off
cd /d "%~dp0"
where cloudflared >nul 2>nul || (echo cloudflared is not installed. Install it with:  winget install --id Cloudflare.cloudflared  ^& echo Then close this window and run this file again. ^& pause ^& exit /b 1)
echo Make sure Outfitora is running in another window (START-WINDOWS.bat).
echo Your public link will appear below. It looks like https://something.trycloudflare.com
echo Close this window to stop sharing.
cloudflared tunnel --url http://localhost:3000
pause
