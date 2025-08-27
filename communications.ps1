# ================================
# Quantum + X.AI API Integration
# ================================

param(
    [Parameter(Mandatory = $true)]
    [string]$XAI_API_KEY,

    [string]$UserMessage = "Hello from PowerShell + X.AI!"
)

# Construct request body
$body = @{
    messages = @(
        @{
            role    = "user"
            content = $UserMessage
        }
    )
    model       = "grok-4"
    stream      = $false
    temperature = 0.7
} | ConvertTo-Json -Depth 5

# Prepare headers
$headers = @{
    "Content-Type"  = "application/json"
    "Authorization" = "Bearer $XAI_API_KEY"
}

# Make API request
$response = Invoke-RestMethod -Uri "https://api.x.ai/v1/chat/completions" `
    -Method Post `
    -Headers $headers `
    -Body $body

# Show response
$response.choices.message.content
