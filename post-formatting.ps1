winget install --id Discord.Discord --silent --accept-package-agreements --accept-source-agreements
winget install --id Brave.Brave --silent --accept-package-agreements --accept-source-agreements
winget install --id AnyDesk.AnyDesk --silent --accept-package-agreements --accept-source-agreements
winget install --id abbodi1406.vcredist --accept-package-agreements --accept-source-agreements
winget install --id Microsoft.DirectX --silent --accept-package-agreements --accept-source-agreements
winget install --id RARLab.WinRAR --silent --accept-package-agreements --accept-source-agreements
winget install --id CodecGuide.K-LiteCodecPack.Full --silent --accept-package-agreements --accept-source-agreements
winget install --id CPUID.HWMonitor --silent --accept-package-agreements --accept-source-agreements
winget install --id Valve.Steam --silent --accept-package-agreements --accept-source-agreements
winget install --id qBittorrent.qBittorrent --silent --accept-package-agreements --accept-source-agreements
winget install --id SoftDeluxe.FreeDownloadManager --silent --accept-package-agreements --accept-source-agreements
winget install --id Wagnardsoft.DisplayDriverUninstaller --silent --accept-package-agreements --accept-source-agreements
winget install --id Klocman.BulkCrapUninstaller --silent --accept-package-agreements --accept-source-agreements
winget install --id Spotify.Spotify --silent --accept-package-agreements --accept-source-agreements
(New-Object System.Net.WebClient).DownloadFile("https://us.download.nvidia.com/nvapp/client/11.0.9.251/NVIDIA_app_v11.0.9.251.exe", "$env:TEMP\nvidia_app.exe"); Start-Process "$env:TEMP\nvidia_app.exe" -ArgumentList "/s" -Wait; Remove-Item "$env:TEMP\nvidia_app.exe" -Force
