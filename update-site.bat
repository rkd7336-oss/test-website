@echo off
setlocal
cd /d "%~dp0"
title Update Naturalbox website

echo Checking the website build...
call npm run build
if errorlevel 1 (
  echo.
  echo Build failed. Nothing was uploaded.
  pause
  exit /b 1
)

git add -A
git diff --cached --quiet
if not errorlevel 1 (
  echo.
  echo No changes to upload.
  pause
  exit /b 0
)

git commit -m "Update website"
if errorlevel 1 (
  echo.
  echo Commit failed. Nothing was uploaded.
  pause
  exit /b 1
)

git push origin main
if errorlevel 1 (
  echo.
  echo Upload failed. Check your GitHub login or network.
  pause
  exit /b 1
)

echo.
echo Upload complete. Cloudflare Pages will deploy it automatically.
pause
