#!/bin/bash

# bKash Sandbox Configuration
BKASH_SANDBOX=true
BKASH_APP_KEY="4f6o0cjiki2rfm34kfdadl1eqq"
BKASH_APP_SECRET="2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b"
BKASH_USERNAME="sandboxTokenizedUser02"
BKASH_PASSWORD="sandboxTokenizedUser02@12345"

# API Base URL
BASE_URL="https://checkout.sandbox.bka.sh/v1.2.0-beta/checkout"

echo "=========================================="
echo "Testing bKash Sandbox API"
echo "=========================================="
echo ""

# Step 1: Get Token
echo "Step 1: Getting Token..."
echo "-----------------------------------------"

TOKEN_RESPONSE=$(curl -s -X POST "${BASE_URL}/token/grant" \
  -H "Content-Type: application/json" \
  -H "username: ${BKASH_USERNAME}" \
  -H "password: ${BKASH_PASSWORD}" \
  -d "{
    \"app_key\": \"${BKASH_APP_KEY}\",
    \"app_secret\": \"${BKASH_APP_SECRET}\"
  }")

echo "Token Response:"
echo "$TOKEN_RESPONSE" | jq . 2>/dev/null || echo "$TOKEN_RESPONSE"
echo ""

# Extract token
ID_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.id_token' 2>/dev/null)

if [ "$ID_TOKEN" != "null" ] && [ -n "$ID_TOKEN" ]; then
  echo "✓ Token obtained successfully!"
  echo "Token: ${ID_TOKEN:0:50}..."
  echo ""
  
  # Step 2: Create Payment
  echo "Step 2: Creating Payment..."
  echo "-----------------------------------------"
  
  PAYMENT_RESPONSE=$(curl -s -X POST "${BASE_URL}/payment/create" \
    -H "Content-Type: application/json" \
    -H "Authorization: ${ID_TOKEN}" \
    -H "X-APP-Key: ${BKASH_APP_KEY}" \
    -d "{
      \"mode\": \"0011\",
      \"payerReference\": \"01770618575\",
      \"callbackURL\": \"https://example.com/callback\",
      \"amount\": \"10\",
      \"currency\": \"BDT\",
      \"intent\": \"sale\",
      \"merchantInvoiceNumber\": \"INV-$(date +%s)\"
    }")
  
  echo "Payment Create Response:"
  echo "$PAYMENT_RESPONSE" | jq . 2>/dev/null || echo "$PAYMENT_RESPONSE"
  
else
  echo "✗ Failed to obtain token"
  echo "Please check your credentials"
fi

echo ""
echo "=========================================="
echo "Test Complete"
echo "=========================================="
