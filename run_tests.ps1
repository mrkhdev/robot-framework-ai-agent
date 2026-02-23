# Run Robot Framework tests
Write-Host "Running Robot Framework AI Agent tests..." -ForegroundColor Cyan

# Activate virtual environment if it exists
if (Test-Path ".\venv\Scripts\Activate.ps1") {
    . .\venv\Scripts\Activate.ps1
}

# Run tests
robot --outputdir results tests/

# Show result
if ($LASTEXITCODE -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host "Some tests failed. Check results/report.html for details." -ForegroundColor Red
}
