$repoOwner = "PrismLauncher"
$repoName = "PrismLauncher"
$releaseName = "latest"
$assetPattern = "/PrismLauncher-Windows-MSVC-Portable.*\.zip"
$destinationPath = "C:\Users\rktfier\Desktop\PrismLauncher" #change this to your path
$zipFileName = "PrismLauncher.zip"
$downloadUrl = ""

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
Expand-Archive -Path $zipFileName -DestinationPath $destinationPath -Force

# delete the zip
Remove-Item -Path $zipFileName -Force
