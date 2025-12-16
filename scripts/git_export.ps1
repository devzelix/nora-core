Write-Host "🚀 Exporting n8n to JSON..." -ForegroundColor Cyan

$backupPath = Join-Path ".." "git_backup"
if (!(Test-Path -Path $backupPath)) { New-Item -ItemType Directory -Path $backupPath | Out-Null }

docker exec -u node nora_core_app n8n export:workflow --all --separate --output=/backup/workflows/
docker exec -u node nora_core_app n8n export:credentials --all --encrypted --output=/backup/credentials.json

Write-Host "✅ Ready export in git_backup" -ForegroundColor Green