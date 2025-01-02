# Backup script for Hydroponic Plants Index
$date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$buildDir = "..\build"
$backupName = "hydroponic_backup_$date"

# Build the web app
Write-Host "Building web app..."
flutter build web --release --web-renderer canvaskit

# Create backup directory
$backupDir = Join-Path $buildDir $backupName
New-Item -ItemType Directory -Path $backupDir -Force

# Copy web files
Write-Host "Copying files..."
Copy-Item -Path "$buildDir\web\*" -Destination $backupDir -Recurse
Copy-Item -Path "..\web\landing_page.html" -Destination $backupDir
Copy-Item -Path "..\web\redirect.html" -Destination $backupDir
Copy-Item -Path "..\web\versions.html" -Destination $backupDir

# Create ZIP archive
Write-Host "Creating ZIP archive..."
Compress-Archive -Path "$backupDir\*" -DestinationPath "$buildDir\$backupName.zip" -Force

# Cleanup temporary directory
Remove-Item -Path $backupDir -Recurse -Force

Write-Host "Backup completed: $buildDir\$backupName.zip"
Write-Host "Please upload the backup file to Google Drive manually for security reasons."
