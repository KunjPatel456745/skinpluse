# Set Secrets for Supabase Edge Functions
# Make sure you have linked your project using 'supabase link' first.

Write-Host "Setting up secrets for Skinpulse AI..." -ForegroundColor Cyan

$geminiKey = Read-Host "Enter your GEMINI_API_KEY"
$serviceRoleKey = Read-Host "Enter your SUPABASE_SERVICE_ROLE_KEY"
$fcmServerKey = Read-Host "Enter your FCM_SERVER_KEY"
$fcmProjectId = Read-Host "Enter your FCM_PROJECT_ID"
$affiliateTag = Read-Host "Enter your AMAZON_AFFILIATE_TAG (e.g. skinpulse-21)"
$cronSecret = Read-Host "Enter a random CRON_SECRET string"

if ([string]::IsNullOrEmpty($geminiKey) -or [string]::IsNullOrEmpty($serviceRoleKey)) {
    Write-Error "Keys cannot be empty!"
    exit 1
}

Write-Host "Running Supabase CLI commands..." -ForegroundColor Yellow

supabase secrets set "GEMINI_API_KEY=$geminiKey"
supabase secrets set "GEMINI_SCAN_MODEL=gemini-2.5-flash"
supabase secrets set "GEMINI_CHAT_MODEL=gemini-3.1-flash-lite"
supabase secrets set "GEMINI_PRODUCT_MODEL=gemini-2.5-flash"
supabase secrets set "GEMINI_TIP_MODEL=gemini-3.1-flash-lite"
supabase secrets set "GEMINI_ALERT_MODEL=gemini-3.1-flash-lite"
supabase secrets set "SUPABASE_SERVICE_ROLE_KEY=$serviceRoleKey"
supabase secrets set "FCM_SERVER_KEY=$fcmServerKey"
supabase secrets set "FCM_PROJECT_ID=$fcmProjectId"
supabase secrets set "AMAZON_AFFILIATE_TAG=$affiliateTag"
supabase secrets set "CRON_SECRET=$cronSecret"

Write-Host "All 11 secrets set successfully!" -ForegroundColor Green
