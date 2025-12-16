#!/bin/bash

echo "🚀 Exporting n8n to JSON..."

mkdir -p ../git_backup

docker exec -u node nora_core_app n8n export:workflow --all --separate --output=/backup/workflows/

docker exec -u node nora_core_app n8n export:credentials --all --encrypted --output=/backup/credentials.json

echo "✅ Ready export in git_backup"