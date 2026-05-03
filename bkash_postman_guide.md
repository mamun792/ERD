# bKash Tokenized Checkout API - Postman Testing Guide

## 🔧 Configuration

```
BKASH_SANDBOX = true  (Production এ false করুন)

Sandbox Base URL: https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout
Production Base URL: https://tokenized.pay.bka.sh/v1.2.0-beta/tokenized/checkout
```

## 📋 Credentials

| Key | Value |
|-----|-------|
| App Key | `4f6o0cjiki2rfm34kfdadl1eqq` |
| App Secret | `2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b` |
| Username | `sandboxTokenizedUser02` |
| Password | `sandboxTokenizedUser02@12345` |

---

## 1️⃣ Token Grant API

### Request

```
Method: POST
URL: https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/token/grant
```

### Headers

| Key | Value |
|-----|-------|
| Content-Type | `application/json` |
| Accept | `application/json` |
| username | `sandboxTokenizedUser02` |
| password | `sandboxTokenizedUser02@12345` |

### Body (raw JSON)

```json
{
    "app_key": "4f6o0cjiki2rfm34kfdadl1eqq",
    "app_secret": "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b"
}
```

### ✅ Success Response (200)

```json
{
    "statusCode": "0000",
    "statusMessage": "Successful",
    "id_token": "eyJraWQiOiJvTVJzNU9ZY0wr...(long token)",
    "token_type": "Bearer",
    "expires_in": 3600,
    "refresh_token": "eyJjdHkiOiJKV1Qi..."
}
```

---

## 2️⃣ Create Payment API

### Request

```
Method: POST
URL: https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/create
```

### Headers

| Key | Value |
|-----|-------|
| Content-Type | `application/json` |
| Accept | `application/json` |
| Authorization | `{id_token from Step 1}` |
| X-APP-Key | `4f6o0cjiki2rfm34kfdadl1eqq` |

### Body (raw JSON)

```json
{
    "mode": "0011",
    "payerReference": "01770618575",
    "callbackURL": "https://example.com/callback",
    "amount": "10",
    "currency": "BDT",
    "intent": "sale",
    "merchantInvoiceNumber": "INV-123456"
}
```

### ✅ Success Response (200)

```json
{
    "paymentID": "TR0011tl3v1Oj1765275163828",
    "bkashURL": "https://sandbox.payment.bkash.com/?paymentId=TR0011...",
    "callbackURL": "https://example.com/callback",
    "successCallbackURL": "https://example.com/callback?paymentID=...&status=success",
    "failureCallbackURL": "https://example.com/callback?paymentID=...&status=failure",
    "cancelledCallbackURL": "https://example.com/callback?paymentID=...&status=cancel",
    "amount": "10",
    "intent": "sale",
    "currency": "BDT",
    "paymentCreateTime": "2025-12-09T16:12:43:828 GMT+0600",
    "transactionStatus": "Initiated",
    "merchantInvoiceNumber": "INV-123456",
    "statusCode": "0000",
    "statusMessage": "Successful"
}
```

---

## 3️⃣ Execute Payment API

### Request

```
Method: POST
URL: https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/execute
```

### Headers

| Key | Value |
|-----|-------|
| Content-Type | `application/json` |
| Accept | `application/json` |
| Authorization | `{id_token}` |
| X-APP-Key | `4f6o0cjiki2rfm34kfdadl1eqq` |

### Body (raw JSON)

```json
{
    "paymentID": "TR0011tl3v1Oj1765275163828"
}
```

---

## 4️⃣ Query Payment API

### Request

```
Method: POST
URL: https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/payment/status
```

### Headers

| Key | Value |
|-----|-------|
| Content-Type | `application/json` |
| Accept | `application/json` |
| Authorization | `{id_token}` |
| X-APP-Key | `4f6o0cjiki2rfm34kfdadl1eqq` |

### Body (raw JSON)

```json
{
    "paymentID": "TR0011tl3v1Oj1765275163828"
}
```

---

## 🔄 Postman Environment Variables (Optional)

Postman-এ Environment তৈরি করে এই variables সেট করুন:

| Variable | Initial Value |
|----------|---------------|
| `base_url` | `https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout` |
| `app_key` | `4f6o0cjiki2rfm34kfdadl1eqq` |
| `app_secret` | `2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b` |
| `username` | `sandboxTokenizedUser02` |
| `password` | `sandboxTokenizedUser02@12345` |
| `id_token` | *(Token Grant থেকে পাওয়া token সেট করুন)* |

### Auto-set Token (Tests Script)

Token Grant request এর **Tests** tab এ এই script যোগ করুন:

```javascript
var jsonData = pm.response.json();
if (jsonData.id_token) {
    pm.environment.set("id_token", jsonData.id_token);
}
```

---

## ⚠️ গুরুত্বপূর্ণ নোট

1. **Token Expiry:** Token ১ ঘণ্টা (3600 সেকেন্ড) পর expire হয়
2. **সঠিক URL:** `checkout.sandbox.bka.sh` ❌ কাজ করে না, `tokenized.sandbox.bka.sh` ✅ ব্যবহার করুন
3. **Mode `0011`:** Tokenized checkout এর জন্য
4. **Production:** Production এ যাওয়ার আগে bKash থেকে production credentials নিন

---

## 📥 cURL Commands (Reference)

### Token Grant
```bash
curl -X POST "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/token/grant" \
  -H "Content-Type: application/json" \
  -H "username: sandboxTokenizedUser02" \
  -H "password: sandboxTokenizedUser02@12345" \
  -d '{"app_key": "4f6o0cjiki2rfm34kfdadl1eqq", "app_secret": "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b"}'
```

### Create Payment
```bash
curl -X POST "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/create" \
  -H "Content-Type: application/json" \
  -H "Authorization: YOUR_ID_TOKEN" \
  -H "X-APP-Key: 4f6o0cjiki2rfm34kfdadl1eqq" \
  -d '{"mode":"0011","payerReference":"01770618575","callbackURL":"https://example.com/callback","amount":"10","currency":"BDT","intent":"sale","merchantInvoiceNumber":"INV-123456"}'
```
