[CmdletBinding()]
param([int]$Port=8081,[switch]$SkipBuild)
$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
if(!$env:JAVA_HOME -or !(Test-Path (Join-Path $env:JAVA_HOME 'bin/java.exe'))) {
    $jdk=Get-ChildItem (Join-Path $env:USERPROFILE '.jdks') -Directory -ErrorAction SilentlyContinue | Where-Object Name -Match '17' | Select-Object -First 1
    if(!$jdk){throw 'Java 17을 설치하거나 JAVA_HOME을 설정해 주세요.'}
    $env:JAVA_HOME=$jdk.FullName
}
$env:Path="$env:JAVA_HOME\bin;$env:Path"
if(!(Test-Path (Join-Path $root 'backend/src/main/resources/application.yml'))){throw '기본 application.yml에 전용 서버 DB 연결 정보를 먼저 설정해 주세요.'}
Push-Location (Join-Path $root 'frontend')
try {
    if(!$SkipBuild){
        if(!(Test-Path 'node_modules')) { & npm.cmd ci --no-fund --no-audit; if($LASTEXITCODE -ne 0){throw 'npm 설치 실패'} }
        & npm.cmd run build
        if($LASTEXITCODE -ne 0){throw '웹 화면 빌드 실패'}
    }
} finally {Pop-Location}
$privateDir=Join-Path $root 'private'
New-Item -ItemType Directory -Force $privateDir | Out-Null
$bytes=New-Object byte[] 32
[Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
$token=([BitConverter]::ToString($bytes)).Replace('-','').ToLowerInvariant()
$url="http://localhost:$Port/#/setup?token=$token"
$accessFile=Join-Path $privateDir 'study-access.html'
$html='<!doctype html><html lang="ko"><meta charset="utf-8"><meta name="referrer" content="no-referrer"><title>MyTOEIC 개인 계정 설정</title><h1>나의 공부방</h1><p>서버에 Started 로그가 나온 뒤 아래 링크를 누르세요.</p><a href="'+$url+'">계정 만들고 MyTOEIC 시작하기</a><p>이 파일은 Git에 올리거나 다른 사람에게 공유하지 마세요. 이미 계정이 있다면 일반 로그인 화면으로 연결됩니다.</p></html>'
[IO.File]::WriteAllText($accessFile,$html,(New-Object Text.UTF8Encoding($false)))
$previousToken=$env:MYTOEIC_SETUP_TOKEN
$previousProfile=$env:SPRING_PROFILES_ACTIVE
$previousMigration=$env:DB_MIGRATE
$previousBootstrap=$env:BOOTSTRAP_ENABLED
Push-Location (Join-Path $root 'backend')
try {
    $env:MYTOEIC_SETUP_TOKEN=$token
    $env:SPRING_PROFILES_ACTIVE='local'
    $env:DB_MIGRATE='false'
    $env:BOOTSTRAP_ENABLED='false'
    Write-Host "MyTOEIC: http://localhost:$Port"
    Write-Host "최초 계정 설정 링크: $accessFile"
    & .\gradlew.bat --console=plain bootRun "--args=--server.address=127.0.0.1 --server.port=$Port"
    if($LASTEXITCODE -ne 0){throw '앱 실행 실패. 위 오류를 확인해 주세요.'}
} finally {
    Pop-Location
    $env:MYTOEIC_SETUP_TOKEN=$previousToken
    $env:SPRING_PROFILES_ACTIVE=$previousProfile
    $env:DB_MIGRATE=$previousMigration
    $env:BOOTSTRAP_ENABLED=$previousBootstrap
}
