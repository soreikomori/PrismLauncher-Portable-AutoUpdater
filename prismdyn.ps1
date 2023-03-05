$repoOwner = "PrismLauncher"
$repoName = "PrismLauncher"
$releaseName = "latest"
$assetPattern = "/PrismLauncher-Windows-MSVC-Portable.*\.zip"
$zipFileName = "PrismLauncher.zip"
$downloadUrl = ""

# check parameters for if they are provided
if ($args.Count -eq 1) {
    $destinationPath = $args[0]
}
else {
    # ask for path
    Write-Host "Please enter the destination path for the extracted files:"
    $destinationPath = Read-Host
}

# Fetch latest version thru github
$uri = "https://api.github.com/repos/$repoOwner/$repoName/releases/$releaseName"
$latestRelease = Invoke-RestMethod -Uri $uri

# Look for the download url
foreach ($asset in $latestRelease.assets) {
    if ($asset.browser_download_url -match $assetPattern) {
        $downloadUrl = $asset.browser_download_url
        break
    }
}

# Download the url and extract the zip
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFileName

try {
    Expand-Archive -Path $zipFileName -DestinationPath $destinationPath -Force -ErrorAction Stop
}
catch {
    Write-Error "Error: Failed to extract files to $destinationPath. Please check that the path is valid and try again."
    exit 1
}

# delete the zip
Remove-Item -Path $zipFileName -Force
