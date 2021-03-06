@echo off
SET ROOT=%~dp0..

if exist %ROOT%\Artifacts rmdir /Q /S %ROOT%\Artifacts

call powershell -NoProfile %ROOT%\Build\UpdateAssemblyInfo.ps1
if %errorlevel% neq 0 exit /b %errorlevel%

call %ROOT%\Build\nuget-restore.bat
if %errorlevel% neq 0 exit /b %errorlevel%

call %ROOT%\Build\build-all-release.bat
if %errorlevel% neq 0 exit /b %errorlevel%

call %ROOT%\Build\run-tests.bat
if %errorlevel% neq 0 exit /b %errorlevel%

call %ROOT%\Build\pack-nuget.bat
if %errorlevel% neq 0 exit /b %errorlevel%

call %ROOT%\Build\zip-artifacts.bat
if %errorlevel% neq 0 exit /b %errorlevel%