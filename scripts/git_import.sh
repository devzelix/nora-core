#!/bin/bash

echo "📥 Importing JSON to n8n..."

docker exec -u node nora_core_app n8n import:credentials --input=/backup/credentials.json
docker exec -u node nora_core_app n8n import:workflow --input=/backup/workflows/

echo "✅ Import ready."