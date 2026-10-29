@echo off
title FaceAttend AI — Backend Server
cd /d "%~dp0backend"
echo ========================================================
echo   Starting Face Recognition Backend Server (Flask)
echo ========================================================
".venv\Scripts\python.exe" app.py
pause

