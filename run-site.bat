@echo off
setlocal
cd /d "%~dp0"
title Naturalbox website

where node >nul 2>nul
if errorlevel 1 (
  echo Node.js is not installed.
  echo Install the LTS version from https://nodejs.org
  pause
  exit /b 1
)

if not exist "node_modules\astro" (
  echo Installing dependencies...
  call npm install
  if errorlevel 1 (
    echo npm install failed.
    pause
    exit /b 1
  )
)

set "PORT=4321"
:find_port
netstat -ano | findstr /R /C:":%PORT% .*LISTENING" >nul
if not errorlevel 1 (
  set /a PORT+=1
  goto find_port
)

echo Starting the website at http://localhost:%PORT%/
start "Naturalbox Astro" cmd /k "cd /d ^"%~dp0^" ^&^& npm run dev -- --host 127.0.0.1 --port %PORT%"
timeout /t 4 /nobreak >nul
start "" "http://localhost:%PORT%/"
exit /b 0
