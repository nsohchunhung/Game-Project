#!/bin/bash
# ============================================
# Import Grafana Dashboard Automatically
# ============================================
# Purpose: Automatically import Grafana dashboard from JSON file
# Usage: ./scripts/import-grafana-dashboard.sh

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
DASHBOARD_FILE="${1:-k8s/grafana-dashboard-humor-game.json}"
GRAFANA_NAMESPACE="${GRAFANA_NAMESPACE:-monitoring}"
GRAFANA_SERVICE="${GRAFANA_SERVICE:-prometheus-grafana}"
GRAFANA_PORT="${GRAFANA_PORT:-3000}"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Importing Grafana Dashboard${NC}"
echo -e "${GREEN}========================================${NC}"

# Check if dashboard file exists
if [ ! -f "${DASHBOARD_FILE}" ]; then
  echo -e "${RED}Error: Dashboard file not found: ${DASHBOARD_FILE}${NC}"
  exit 1
fi

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
  echo -e "${RED}Error: kubectl not found${NC}"
  exit 1
fi

# Check if Grafana pod is running
echo -e "${YELLOW}Checking Grafana availability...${NC}"
if ! kubectl get pods -n ${GRAFANA_NAMESPACE} -l app.kubernetes.io/name=grafana | grep -q Running; then
  echo -e "${RED}Error: Grafana pod not running in namespace ${GRAFANA_NAMESPACE}${NC}"
  echo -e "${YELLOW}Starting port-forward in background...${NC}"
  kubectl port-forward -n ${GRAFANA_NAMESPACE} svc/${GRAFANA_SERVICE} ${GRAFANA_PORT}:80 &
  PORT_FORWARD_PID=$!
  sleep 5
else
  PORT_FORWARD_PID=""
fi

# Get Grafana admin credentials
echo -e "${YELLOW}Getting Grafana admin credentials...${NC}"
GRAFANA_USER="${GRAFANA_USER:-admin}"
GRAFANA_PASS=$(kubectl get secret -n ${GRAFANA_NAMESPACE} prometheus-grafana -o jsonpath="{.data.admin-password}" 2>/dev/null | base64 -d || echo "admin")

# Get auth token
echo -e "${YELLOW}Authenticating with Grafana...${NC}"
AUTH_RESPONSE=$(curl -s -X POST http://localhost:${GRAFANA_PORT}/api/auth/keys \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"terraform-import\",\"role\":\"Admin\",\"secondsToLive\":3600}" \
  -u "${GRAFANA_USER}:${GRAFANA_PASS}")

API_KEY=$(echo $AUTH_RESPONSE | jq -r '.key // empty')

if [ -z "$API_KEY" ] || [ "$API_KEY" = "null" ]; then
  echo -e "${YELLOW}API key creation failed, trying direct import...${NC}"
  API_KEY=""
else
  echo -e "${GREEN}✓ API key created${NC}"
fi

# Prepare dashboard JSON
echo -e "${YELLOW}Preparing dashboard JSON...${NC}"
DASHBOARD_JSON=$(cat ${DASHBOARD_FILE} | jq '.dashboard' | jq '. + {
  "overwrite": true,
  "inputs": [],
  "folderId": null
}')

# Import dashboard
echo -e "${YELLOW}Importing dashboard to Grafana...${NC}"

if [ -n "$API_KEY" ]; then
  IMPORT_RESPONSE=$(curl -s -X POST "http://localhost:${GRAFANA_PORT}/api/dashboards/db" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${API_KEY}" \
    -d "${DASHBOARD_JSON}")
else
  IMPORT_RESPONSE=$(curl -s -X POST "http://localhost:${GRAFANA_PORT}/api/dashboards/db" \
    -H "Content-Type: application/json" \
    -u "${GRAFANA_USER}:${GRAFANA_PASS}" \
    -d "${DASHBOARD_JSON}")
fi

# Check response
if echo "$IMPORT_RESPONSE" | jq -e '.uid' > /dev/null 2>&1; then
  DASHBOARD_UID=$(echo "$IMPORT_RESPONSE" | jq -r '.uid')
  DASHBOARD_URL="http://localhost:${GRAFANA_PORT}/d/${DASHBOARD_UID}"
  echo -e "${GREEN}✓ Dashboard imported successfully!${NC}"
  echo -e "${GREEN}Dashboard URL: ${DASHBOARD_URL}${NC}"
else
  echo -e "${RED}Error importing dashboard:${NC}"
  echo "$IMPORT_RESPONSE" | jq '.'
  exit 1
fi

# Cleanup API key if created
if [ -n "$API_KEY" ]; then
  KEY_ID=$(echo $AUTH_RESPONSE | jq -r '.id // empty')
  if [ -n "$KEY_ID" ] && [ "$KEY_ID" != "null" ]; then
    curl -s -X DELETE "http://localhost:${GRAFANA_PORT}/api/auth/keys/${KEY_ID}" \
      -H "Authorization: Bearer ${API_KEY}" > /dev/null
  fi
fi

# Cleanup port-forward if we started it
if [ -n "$PORT_FORWARD_PID" ]; then
  kill $PORT_FORWARD_PID 2>/dev/null || true
fi

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Dashboard Import Complete!${NC}"
echo -e "${GREEN}========================================${NC}"

