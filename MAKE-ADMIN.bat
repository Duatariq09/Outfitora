@echo off
cd /d "%~dp0"
where node >nul 2>nul || (echo Node.js is not installed. Install the LTS version from https://nodejs.org first. ^& pause ^& exit /b 1)
node --no-warnings make-admin.js
pause
