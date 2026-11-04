param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Prompt,
    [string]$Model = "yuri-qwen"
)

$raw = & ollama run $Model $Prompt 2>$null | Out-String

$norm = $raw
$norm = $norm -replace '“([^”]*)”', '「$1」'
$norm = $norm -replace '“', '「'
$norm = $norm -replace '”', '」'
$norm = $norm -replace '"([^"]*)"', '「$1」'
$norm = $norm -replace '^\s+|\s+$', ''

$norm
