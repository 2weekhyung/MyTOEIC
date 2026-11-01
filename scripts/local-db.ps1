[CmdletBinding()]
param(
    [ValidateSet('Check','Migrate','Run')][string]$Action = 'Check',
    [switch]$CheckApp,
    [switch]$Bootstrap,
    [ValidatePattern('^[A-Za-z0-9_.-]{3,80}$')][string]$BootstrapUsername = 'owner'
)
$ErrorActionPreference = 'Stop'
if ($CheckApp -and $Action -ne 'Check') { throw '-CheckApp is only for -Action Check.' }
if ($Bootstrap -and $Action -ne 'Run') { throw '-Bootstrap is only for -Action Run.' }

function Read-PrivatePassword([string]$Prompt) {
    $secret = Read-Host $Prompt -AsSecureString
    $secretBuffer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret)
    try { $value = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($secretBuffer) }
    finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($secretBuffer); $secret.Dispose() }
    if ([string]::IsNullOrEmpty($value)) { throw 'A password is required.' }
    return $value
}

$managedNames = @('DB_URL','DB_USERNAME','DB_PASSWORD','DB_MIGRATION_USERNAME','DB_MIGRATION_PASSWORD','DB_MIGRATE',
    'SPRING_PROFILES_ACTIVE','SPRING_CONFIG_ADDITIONAL_LOCATION','MYTOEIC_DB_CONFIG','SERVER_PORT','COOKIE_SECURE','BOOTSTRAP_ENABLED','BOOTSTRAP_USERNAME','BOOTSTRAP_PASSWORD')
$previousEnvironment = @{}
foreach ($name in $managedNames) { $previousEnvironment[$name] = [Environment]::GetEnvironmentVariable($name,'Process') }
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath (Join-Path $projectRoot 'backend')
try {
    foreach ($name in $managedNames) { [Environment]::SetEnvironmentVariable($name,$null,'Process') }
    $privateConfig = Join-Path $projectRoot 'backend\config\application-local.yml'
    if (-not (Test-Path -LiteralPath $privateConfig)) { throw 'Create backend/config/application-local.yml from the example first.' }
    $env:MYTOEIC_DB_CONFIG = $privateConfig
    $env:DB_MIGRATE = 'false'
    $env:BOOTSTRAP_ENABLED = 'false'
    if ($Action -eq 'Check') {
        $role = if ($CheckApp) { 'app' } else { 'migration' }
        & .\gradlew.bat --console=plain dbCheck "-PdbRole=$role"
    } elseif ($Action -eq 'Migrate') {
        # Explicit action only: caller must first approve the actual server schema/data changes.
        $env:DB_MIGRATE = 'true'
        & .\gradlew.bat --console=plain dbMigrate
    } else {
        $env:SPRING_PROFILES_ACTIVE = 'local'
        $env:SPRING_CONFIG_ADDITIONAL_LOCATION = 'file:' + $privateConfig.Replace('\','/')
        $env:SERVER_PORT = '8081'
        $env:COOKIE_SECURE = 'false'
        if ($Bootstrap) {
            $env:BOOTSTRAP_ENABLED = 'true'
            $env:BOOTSTRAP_USERNAME = $BootstrapUsername
            $env:BOOTSTRAP_PASSWORD = Read-PrivatePassword 'Site admin password (16+ characters, <=72 UTF-8 bytes)'
            if ($env:BOOTSTRAP_PASSWORD.Length -lt 16 -or [Text.Encoding]::UTF8.GetByteCount($env:BOOTSTRAP_PASSWORD) -gt 72) {
                throw 'Site admin password must be at least 16 characters and at most 72 UTF-8 bytes.'
            }
        }
        & .\gradlew.bat --console=plain bootRun
    }
    if ($LASTEXITCODE -ne 0) { throw "Gradle failed with exit code $LASTEXITCODE. Check the error above." }
} finally {
    Pop-Location
    foreach ($name in $managedNames) { [Environment]::SetEnvironmentVariable($name,$previousEnvironment[$name],'Process') }
}
