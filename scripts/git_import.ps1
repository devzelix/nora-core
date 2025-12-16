Write-Host "📥 Importing JSON to n8n..." -ForegroundColor Cyan

docker exec -u node nora_core_app n8n import:credentials --input=/backup/credentials.json
docker exec -u node nora_core_app n8n import:workflow --input=/backup/workflows/

Write-Host "✅ Import ready." -ForegroundColor Green