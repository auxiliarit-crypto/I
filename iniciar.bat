@echo off
cd /d "%~dp0"
echo Levantando PostgreSQL y Redis (Docker)...
docker compose up -d --wait
if errorlevel 1 (
  echo.
  echo ERROR: Docker Desktop no esta abierto o fallo el arranque.
  pause
  exit /b 1
)
if not exist backend\node_modules (
  echo Instalando backend...
  pushd backend
  call npm install
  popd
)
if not exist frontend\node_modules (
  echo Instalando frontend...
  pushd frontend
  call npm install
  popd
)
start "Index ITSM - Backend" cmd /k "cd /d %~dp0backend && npm run dev"
start "Index ITSM - Frontend" cmd /k "cd /d %~dp0frontend && npm run dev"
timeout /t 10 >nul
start http://localhost:3000
echo.
echo Listo. Se abrieron dos ventanas (backend y frontend). Ciérralas para detener.
pause
