# Step 1 -- Create a backup folder
$backupFolder = "DevOpsWorkshop_" + (Get-Date).ToString("dd-MM-yyyy-HH-mm-ss")
New-Item -ItemType Directory -Path C:\inetpub\wwwroot\Backup -Name $backupFolder

$backupFolderPath = "C:\inetpub\wwwroot\Backup\" + $backupFolder

# Step 2 -- Copy existing files to backup
$DevOpsWorkshopFolderPath = "C:\inetpub\wwwroot\DevOpsWorkshop\"
Copy-Item -Path $DevOpsWorkshopFolderPath -Destination $backupFolderPath -Force -Recurse

# Step 3 -- Delete all files in the UI folder (cleanup)
function DeleteIfExistsAndCreateEmptyFolder($dir) {
    if (Test-Path $dir) {
        Get-ChildItem -Path $dir -Force -Recurse | Remove-Item -Force -Recurse
    }
}
DeleteIfExistsAndCreateEmptyFolder($DevOpsWorkshopFolderPath)

# Step 4 -- Copy new files from deployment
$dllPath = "C:\inetpub\wwwroot\DevOpsWorkshop\*"
Copy-Item $dllPath $DevOpsWorkshopFolderPath -Force -Recurse
