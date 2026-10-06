$SourceFolder = "Put here the path for new images folder" # For example: "D:\Games\Backgrounds"
$SongsFolder  = "Put here the path for osu! maps folder" # For example: "D:\Games\osu!\Songs"

if (-not (Test-Path -LiteralPath $SourceFolder)) {
    Write-Error "Source folder not found: $SourceFolder"
    exit 1
}
if (-not (Test-Path -LiteralPath $SongsFolder)) {
    Write-Error "Songs folder not found: $SongsFolder"
    exit 1
}

$sourceImages = @(Get-ChildItem -LiteralPath $SourceFolder -File |
    Where-Object { $_.Extension -match '^\.(jpe?g|png)$' })

if ($sourceImages.Count -eq 0) {
    Write-Error "No .jpg/.jpeg/.png in $SourceFolder"
    exit 1
}

Write-Host "Source images: $($sourceImages.Count)" -ForegroundColor Cyan

$rand = [System.Random]::new()
$mapFolders = @(Get-ChildItem -LiteralPath $SongsFolder -Directory)
Write-Host "Map folders: $($mapFolders.Count)" -ForegroundColor Cyan
Write-Host ""

$replacedMaps = 0
$replacedFiles = 0
$skipped  = 0
$errored  = 0

foreach ($folder in $mapFolders) {
    $mapPath = $folder.FullName

    # Collect ALL images in the map folder
    $mapImages = @(Get-ChildItem -LiteralPath $mapPath -File |
                   Where-Object { $_.Extension -match '^\.(jpe?g|png)$' })

    if ($mapImages.Count -eq 0) { $skipped++; continue }

    # Pick ONE random source image for this map folder
    $src = $sourceImages[$rand.Next($sourceImages.Count)]

    $okInThisMap = 0
    foreach ($img in $mapImages) {
        try {
            Copy-Item -LiteralPath $src.FullName -Destination $img.FullName -Force
            $okInThisMap++
            $replacedFiles++
        } catch {
            $errored++
            Write-Host "[ERR] $($img.FullName) : $_" -ForegroundColor Red
        }
    }

    if ($okInThisMap -gt 0) {
        $replacedMaps++
        Write-Host "[OK]  ($okInThisMap file(s)) $mapPath" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Done. Maps touched: $replacedMaps | Files replaced: $replacedFiles | Skipped folders: $skipped | Errors: $errored" -ForegroundColor Yellow