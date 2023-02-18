cd PrismUpdater
curl -s -o curl.txt https://api.github.com/repos/PrismLauncher/PrismLauncher/releases/latest
findstr /r \/PrismLauncher-Windows-MSVC-Portable.....zip curl.txt > output.txt
findercutter.py
set /p VV=<urlonly.txt
certutil.exe -urlcache -split -f %VV%
ren PrismLauncher*.zip PrismLauncher.zip
7z e PrismLauncher.zip -aoa -oC:\Users\sorei\OneDrive\Gaming\Minecraft\PrismLauncher
del PrismLauncher.zip