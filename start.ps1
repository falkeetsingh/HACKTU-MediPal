# FitCred Quick Start Script
# Starts MongoDB, seeds data, and launches both backend and frontend

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "FitCred - Quick Start" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if setup was run
if (-not (Test-Path "backend\node_modules") -or -not (Test-Path "frontend\node_modules")) {
    Write-Host "⚠ Dependencies not installed. Running setup..." -ForegroundColor Yellow
    .\setup.ps1
    if ($LASTEXITCODE -ne 0) {
        exit 1
    }
}

Write-Host "Starting MongoDB..." -ForegroundColor Yellow
Start-Process -FilePath "mongod" -WindowStyle Minimized
Start-Sleep -Seconds 3

Write-Host "Seeding database with demo data..." -ForegroundColor Yellow
Set-Location backend
node seed.js
Set-Location ..

Write-Host ""
Write-Host "Starting backend server..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd backend; npm run dev" -WindowStyle Normal

Start-Sleep -Seconds 2

Write-Host "Starting frontend..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; npm run dev" -WindowStyle Normal

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "FitCred is starting!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backend: http://localhost:5000" -ForegroundColor White
Write-Host "Frontend: http://localhost:5173" -ForegroundColor White
Write-Host ""
Write-Host "Demo credentials:" -ForegroundColor Yellow
Write-Host "  Doctor: doctor@fitcred.com / password123" -ForegroundColor White
Write-Host "  Patient: patient@fitcred.com / password123" -ForegroundColor White
Write-Host ""
Write-Host "Press any key to exit this window..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
