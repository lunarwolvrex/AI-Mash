@echo off
REM ============================================================
REM universal-modder CLI launcher for Windows
REM Runs: um <group> <command> [args...]
REM ============================================================

set "REPO_DIR=%~dp0"
REM Strip trailing backslash: "...modder\" would escape the closing quote
REM when passed as "%REPO_DIR%" to uv/python and mangle every argument after it
if "%REPO_DIR:~-1%"=="\" set "REPO_DIR=%REPO_DIR:~0,-1%"
cd /d "%REPO_DIR%"

REM Check for uv first (preferred - handles dependencies automatically)
where uv >nul 2>&1
if %errorlevel% equ 0 (
    uv run --quiet --project "%REPO_DIR%" python -m um %*
    exit /b %errorlevel%
)

REM Fallback to system python
where python >nul 2>&1
if %errorlevel% equ 0 (
    set "PYTHONPATH=%REPO_DIR%;%PYTHONPATH%"
    python -m um %*
    exit /b %errorlevel%
)

where python3 >nul 2>&1
if %errorlevel% equ 0 (
    set "PYTHONPATH=%REPO_DIR%;%PYTHONPATH%"
    python3 -m um %*
    exit /b %errorlevel%
)

echo Error: Neither 'uv' nor 'python' found in PATH.
echo Install uv (recommended): https://github.com/astral-sh/uv
echo Or install Python 3.10+: https://python.org
exit /b 1