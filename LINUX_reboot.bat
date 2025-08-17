REM ---------------------||Windows to LINUX reboot||---------------------
@echo off
REM need admin permission
net session >nul 2>&1
if %errorlevel% NEQ 0 (
  echo [!] Нужны права администратора. Повторный запуск...
  powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
  exit /b
)
REM see GUID disk where is LINUX
REM write please command " bcdedit /enum  " in PowerShell CLI
set LINUX_GUID={GUID}
REM replace field GUID on self 
REM (Recomended disable Fast Startup: powercfg -h off)

bcdedit /bootsequence %LINUX_GUID% >nul
if %errorlevel% NEQ 0 (
  echo [!] error bcdedit. Check  GUID and permission.
  pause
  exit /b 1
)

shutdown /r /t 0
REM ---------------------||Windows to LINUX reboot||---------------------