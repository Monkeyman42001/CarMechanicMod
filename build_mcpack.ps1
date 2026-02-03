param(
  [string]$BehaviorPack = "mechanic_life_bp",
  [string]$ResourcePack = "mechanic_life_rp"
)

$ErrorActionPreference = "Stop"

function New-Mcpack {
  param(
    [Parameter(Mandatory = $true)][string]$SourceDir
  )

  if (-not (Test-Path -Path $SourceDir -PathType Container)) {
    throw "Source folder not found: $SourceDir"
  }

  $baseName = Split-Path -Path $SourceDir -Leaf
  $zipPath = Join-Path -Path (Get-Location) -ChildPath ($baseName + ".zip")
  $mcpackPath = Join-Path -Path (Get-Location) -ChildPath ($baseName + ".mcpack")

  if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
  if (Test-Path $mcpackPath) { Remove-Item -Force $mcpackPath }

  Compress-Archive -Path (Join-Path $SourceDir "*") -DestinationPath $zipPath
  Rename-Item -Path $zipPath -NewName ($baseName + ".mcpack")

  Write-Host "Created $mcpackPath"
}

New-Mcpack -SourceDir $BehaviorPack
New-Mcpack -SourceDir $ResourcePack
