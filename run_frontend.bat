@echo off
title FaceAttend AI — Frontend Dashboard
cd /d "%~dp0frontend"
echo ========================================================
echo   Starting React + Vite Attendance Dashboard
echo ========================================================
set PATH=C:\Program Files\nodejs;%PATH%
npm run dev
pause

