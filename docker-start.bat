@echo off
REM EventSphere Docker Quick Start Script for Windows
REM This script starts the EventSphere application using Docker Compose

echo ========================================
echo   EventSphere Docker Deployment
echo ========================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not installed or not in PATH
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

REM Check if Docker Compose is installed
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker Compose is not installed or not in PATH
    pause
    exit /b 1
)

echo Docker is installed and ready!
echo.

REM Check if .env file exists, if not create from example
if not exist .env (
    echo Creating .env file from .env.example...
    copy .env.example .env >nul
    echo .env file created with default values
    echo.
)

echo Starting EventSphere containers...
echo This may take a few minutes on first run...
echo.

REM Start Docker Compose
docker-compose up --build

REM If user stops with Ctrl+C, clean up
echo.
echo ========================================
echo   EventSphere Stopped
echo ========================================
echo.
echo To start again, run: docker-start.bat
echo To stop and remove containers: docker-compose down
echo.
pause
