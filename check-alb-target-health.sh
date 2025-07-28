#!/bin/bash

echo "===== Checking Node.js App Health on Port 4000 ====="

# 1. Check if port 4000 is listening
echo -e "\n[1] Checking if port 4000 is open..."
if ss -tuln | grep -q ':4000'; then
  echo "✅ Port 4000 is open and listening."
else
  echo "❌ Port 4000 is not open!"
fi

# 2. Check response on `/`
echo -e "\n[2] Checking response on path '/' ..."
status_code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/)
if [[ "$status_code" == "200" ]]; then
  echo "✅ '/' returned 200 OK"
else
  echo "❌ '/' returned HTTP $status_code"
fi

# 3. Check response on `/health`
echo -e "\n[3] Checking response on path '/health' ..."
health_code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/health)
if [[ "$health_code" == "200" ]]; then
  echo "✅ '/health' returned 200 OK"
else
  echo "⚠️ '/health' returned HTTP $health_code (maybe not implemented)"
fi

# 4. Check Docker container status
echo -e "\n[4] Checking Docker containers..."
docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"

# 5. Check if Docker port is mapped to 4000
echo -e "\n[5] Verifying if Docker exposes port 4000..."
if docker ps | grep -q '0.0.0.0:4000->4000'; then
  echo "✅ Docker is exposing port 4000"
else
  echo "❌ Docker is not exposing port 4000"
fi

echo -e "\n🧪 Health Check Summary Complete"
