@echo off
REM EventSphere Docker Build & Push Script for Windows
REM Replace 'your-dockerhub-username' with your actual Docker Hub username

echo ========================================
echo   EventSphere Docker Build and Push
echo ========================================
echo.

REM Set your Docker Hub username here
set DOCKER_USERNAME=your-dockerhub-username

REM Check if username is set
if "%DOCKER_USERNAME%"=="your-dockerhub-username" (
    echo ERROR: Please edit this file and set your Docker Hub username!
    echo Open build-and-push.bat and change 'your-dockerhub-username' to your actual username
    pause
    exit /b 1
)

echo Docker Hub Username: %DOCKER_USERNAME%
echo.

REM Login to Docker Hub
echo Step 1: Logging in to Docker Hub...
echo Please enter your Docker Hub credentials:
docker login
if errorlevel 1 (
    echo ERROR: Docker login failed!
    pause
    exit /b 1
)
echo.

REM Build application image
echo Step 2: Building application image...
echo This may take 3-5 minutes...
docker build -t %DOCKER_USERNAME%/eventsphere-app:latest .
if errorlevel 1 (
    echo ERROR: Application build failed!
    pause
    exit /b 1
)
echo Application image built successfully!
echo.

REM Build MySQL image
echo Step 3: Building MySQL image...
docker build -f Dockerfile.mysql -t %DOCKER_USERNAME%/eventsphere-mysql:latest .
if errorlevel 1 (
    echo ERROR: MySQL build failed!
    pause
    exit /b 1
)
echo MySQL image built successfully!
echo.

REM Push application image
echo Step 4: Pushing application image to Docker Hub...
docker push %DOCKER_USERNAME%/eventsphere-app:latest
if errorlevel 1 (
    echo ERROR: Failed to push application image!
    pause
    exit /b 1
)
echo Application image pushed successfully!
echo.

REM Push MySQL image
echo Step 5: Pushing MySQL image to Docker Hub...
docker push %DOCKER_USERNAME%/eventsphere-mysql:latest
if errorlevel 1 (
    echo ERROR: Failed to push MySQL image!
    pause
    exit /b 1
)
echo MySQL image pushed successfully!
echo.

echo ========================================
echo   SUCCESS!
echo ========================================
echo.
echo Your images are now on Docker Hub:
echo   - %DOCKER_USERNAME%/eventsphere-app:latest
echo   - %DOCKER_USERNAME%/eventsphere-mysql:latest
echo.
echo You can now deploy them anywhere!
echo.
echo Next steps:
echo 1. Go to https://hub.docker.com
echo 2. View your repositories
echo 3. Deploy to Railway, Render, or any cloud platform
echo.
pause
