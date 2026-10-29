@echo off
title FaceAttend AI — Launcher
echo ========================================================
echo   Launching Face Recognition Attendance System
echo ========================================================
start "FaceAttend Backend" "%~dp0run_backend.bat"
timeout /t 3 /nobreak >nul
start "FaceAttend Frontend" "%~dp0run_frontend.bat"
echo System launching... Check the opened terminal windows.
echo - Backend:  http://127.0.0.1:5000/api/health
echo - Frontend: http://localhost:5173
pause

