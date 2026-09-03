# Carrega as bibliotecas visuais do Windows
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# ----------------------------------------------------------------------
# 1. Lista de Aplicativos (Winget)
# ----------------------------------------------------------------------
$Apps = @(
    # --- CATEGORIA: IMPORTANTE ---
    @{ Nome = "Visual C++ All-in-One"; Id = "abbodi1406.vcredist"; Cat = "IMPORTANTE" },
    @{ Nome = "DirectX Web Setup";     Id = "Microsoft.DirectX";    Cat = "IMPORTANTE" },
    @{ Nome = ".NET Desktop Runtime"; Id = "Microsoft.DotNet.DesktopRuntime.8"; Cat = "IMPORTANTE" },

    # --- CATEGORIA: PROGRAMAS ---
    @{ Nome = "WinRAR";               Id = "RARLab.WinRAR";        Cat = "PROGRAMAS" },
    @{ Nome = "7-Zip";                Id = "7zip.7zip";            Cat = "PROGRAMAS" },
    @{ Nome = "Discord";              Id = "Discord.Discord";      Cat = "PROGRAMAS" },
    @{ Nome = "Steam";                Id = "Valve.Steam";          Cat = "PROGRAMAS" },
    @{ Nome = "Google Chrome";        Id = "Google.Chrome";        Cat = "PROGRAMAS" },
    @{ Nome = "VLC Media Player";     Id = "VideoLAN.VLC";         Cat = "PROGRAMAS" },
    @{ Nome = "Spotify";              Id = "Spotify.Spotify";      Cat = "PROGRAMAS" }
)

# ----------------------------------------------------------------------
# 2. Construção da Interface Gráfica (GUI)
# ----------------------------------------------------------------------
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Painel de Instalação Rápida"
$Form.Size = New-Object System.Drawing.Size(460, 610)
$Form.StartPosition = 'CenterScreen'
$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1E1E1E")
$Form.ForeColor = [System.Drawing.Color]::White
$Form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$Form.FormBorderStyle = 'FixedDialog'
$Form.MaximizeBox = $false

# Título
$LabelTitulo = New-Object System.Windows.Forms.Label
$LabelTitulo.Text = "Selecione os programas que deseja instalar:"
$LabelTitulo.Location = New-Object System.Drawing.Point(20, 15)
$LabelTitulo.AutoSize = $true
$Form.Controls.Add($LabelTitulo)

# --- GRUPO: DRIVERS DE VÍDEO (RADIO BUTTONS) ---
$GBGpu = New-Object System.Windows.Forms.GroupBox
$GBGpu.Text = "DRIVER DE VÍDEO (GPU)"
$GBGpu.Location = New-Object System.Drawing.Point(20, 45)
$GBGpu.Size = New-Object System.Drawing.Size(400, 75)
$GBGpu.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#00FF7F")
$Form.Controls.Add($GBGpu)

# Opção: Nenhum (Padrão)
$RBDriverNenhum = New-Object System.Windows.Forms.RadioButton
$RBDriverNenhum.Text = "Nenhum"
$RBDriverNenhum.Location = New-Object System.Drawing.Point(15, 30)
$RBDriverNenhum.AutoSize = $true
$RBDriverNenhum.Checked = $true
$RBDriverNenhum.ForeColor = [System.Drawing.Color]::Gray
$GBGpu.Controls.Add($RBDriverNenhum)

# Opção: NVIDIA App
$RBDriverNvidia = New-Object System.Windows.Forms.RadioButton
$RBDriverNvidia.Text = "NVIDIA App"
$RBDriverNvidia.Location = New-Object System.Drawing.Point(110, 30)
$RBDriverNvidia.AutoSize = $true
$RBDriverNvidia.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#76B900")
$GBGpu.Controls.Add($RBDriverNvidia)

# Opção: AMD Software
$RBDriverAmd = New-Object System.Windows.Forms.RadioButton
$RBDriverAmd.Text = "AMD Software"
$RBDriverAmd.Location = New-Object System.Drawing.Point(240, 30)
$RBDriverAmd.AutoSize = $true
$RBDriverAmd.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FF4500")
$GBGpu.Controls.Add($RBDriverAmd)

# --- GRUPO: IMPORTANTE ---
$GBImp = New-Object System.Windows.Forms.GroupBox
$GBImp.Text = "[ ! ] IMPORTANTE"
$GBImp.Location = New-Object System.Drawing.Point(20, 130)
$GBImp.Size = New-Object System.Drawing.Size(400, 110)
$GBImp.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFD700")
$Form.Controls.Add($GBImp)

# --- GRUPO: PROGRAMAS ---
$GBProg = New-Object System.Windows.Forms.GroupBox
$GBProg.Text = "PROGRAMAS ESSENCIAIS"
$GBProg.Location = New-Object System.Drawing.Point(20, 250)
$GBProg.Size = New-Object System.Drawing.Size(400, 210)
$GBProg.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#00CED1")
$Form.Controls.Add($GBProg)

# Gerador Dinâmico de Checkboxes
$CheckBoxes = @()
$yImp = 30; $xProg = 20; $yProg = 30

foreach ($App in $Apps) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $App.Nome
    $cb.AutoSize = $true
    $cb.ForeColor = [System.Drawing.Color]::White
    $cb.Tag = $App

    if ($App.Cat -eq "IMPORTANTE") {
        $cb.Location = New-Object System.Drawing.Point(20, $yImp)
        $GBImp.Controls.Add($cb)
        $yImp += 25
    } else {
        $cb.Location = New-Object System.Drawing.Point($xProg, $yProg)
        $GBProg.Controls.Add($cb)
        $yProg += 25
        if ($yProg -gt 160) {
            $yProg = 30
            $xProg += 180
        }
    }
    $CheckBoxes += $cb
}

# Botão: Selecionar Todos
$BtnTodos = New-Object System.Windows.Forms.Button
$BtnTodos.Text = "Marcar Todos"
$BtnTodos.Location = New-Object System.Drawing.Point(20, 485)
$BtnTodos.Size = New-Object System.Drawing.Size(120, 35)
$BtnTodos.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#333333")
$BtnTodos.FlatStyle = 'Flat'
$BtnTodos.Add_Click({
    foreach ($cb in $CheckBoxes) { $cb.Checked = $true }
})
$Form.Controls.Add($BtnTodos)

# Botão: Instalar
$BtnInstalar = New-Object System.Windows.Forms.Button
$BtnInstalar.Text = "Instalar Selecionados"
$BtnInstalar.Location = New-Object System.Drawing.Point(150, 485)
$BtnInstalar.Size = New-Object System.Drawing.Size(270, 35)
$BtnInstalar.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#0078D7")
$BtnInstalar.FlatStyle = 'Flat'
$BtnInstalar.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$BtnInstalar.Add_Click({
    $Form.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $Form.Close()
})
$Form.Controls.Add($BtnInstalar)

# Exibe a interface
$Form.Topmost = $true
$Result = $Form.ShowDialog()

# ----------------------------------------------------------------------
# 3. Processamento das Instalações (Após fechar a janela)
# ----------------------------------------------------------------------
if ($Result -eq [System.Windows.Forms.DialogResult]::OK) {
    Clear-Host
    Write-Host "==================================================================" -ForegroundColor Cyan
    Write-Host "                INICIANDO INSTALAÇÕES SELECIONADAS                " -ForegroundColor White
    Write-Host "==================================================================`n" -ForegroundColor Cyan
    
    # 1. Verifica qual Driver de Vídeo foi selecionado
    $GpuParaInstalar = $null
    
    if ($RBDriverNvidia.Checked) {
        $GpuParaInstalar = @{
            Nome       = "NVIDIA App"
            Url        = "https://us.download.nvidia.com/nvapp/client/11.0.9.251/NVIDIA_app_v11.0.9.251.exe"
            Argumentos = "/s"
        }
    } elseif ($RBDriverAmd.Checked) {
        $GpuParaInstalar = @{
            Nome       = "AMD Software Adrenalin"
            Url        = "https://drivers.amd.com/drivers/installer/24.10/beta/amd-software-adrenalin-edition-auto-detect-install.exe"
            Argumentos = ""
        }
    }

    # Executa o download/instalação do driver de vídeo caso tenha sido selecionado
    if ($GpuParaInstalar) {
        Write-Host "• Processando: $($GpuParaInstalar.Nome)... " -NoNewline -ForegroundColor White
        try {
            Write-Host " Baixando instalador..." -ForegroundColor Cyan
            $tempFile = Join-Path $env:TEMP "setup_gpu.exe"
            
            $ProgressPreference = 'SilentlyContinue'
            $userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            
            Invoke-WebRequest -Uri $GpuParaInstalar.Url -OutFile $tempFile -UserAgent $userAgent -UseBasicParsing -ErrorAction Stop
            $ProgressPreference = 'Continue'
            
            Write-Host "  Instalando..." -ForegroundColor Cyan
            $proc = if ($GpuParaInstalar.Argumentos) {
                Start-Process -FilePath $tempFile -ArgumentList $GpuParaInstalar.Argumentos -Wait -PassThru
            } else {
                Start-Process -FilePath $tempFile -Wait -PassThru
            }
            
            if ($proc.ExitCode -eq 0 -or $proc.ExitCode -eq 3010) {
                Write-Host " [OK] Driver/App de GPU Instalado com sucesso! `n" -ForegroundColor White -BackgroundColor DarkGreen
            } else {
                Write-Host " [ERRO] Código de retorno: $($proc.ExitCode) `n" -ForegroundColor White -BackgroundColor DarkRed
            }
        } catch {
            Write-Host " [ERRO] Falha no download do driver: $($_.Exception.Message) `n" -ForegroundColor White -BackgroundColor DarkRed
        } finally {
            if (Test-Path $tempFile) { Remove-Item $tempFile -Force -ErrorAction SilentlyContinue }
        }
    }

    # 2. Processa os programas selecionados nas checkboxes
    foreach ($cb in $CheckBoxes) {
        if ($cb.Checked) {
            $App = $cb.Tag
            Write-Host "• Processando: $($App.Nome)... " -NoNewline -ForegroundColor White
            
            # Checa se já está instalado via winget
            $jaInstalado = winget list -e --id $App.Id --source winget 2>&1
            if ($LASTEXITCODE -eq 0 -and $jaInstalado -notmatch "Nenhum pacote encontrado|No package found") {
                Write-Host " Já instalado no PC `n" -ForegroundColor Black -BackgroundColor Yellow
                continue
            }
            
            Write-Host " Instalando via Winget..." -ForegroundColor Cyan
            try {
                winget install -e --id $App.Id --silent --accept-package-agreements --accept-source-agreements --source winget 2>&1 | Out-Null
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host " [OK] Instalado com sucesso! `n" -ForegroundColor White -BackgroundColor DarkGreen
                } else {
                    Write-Host " [ERRO] Código Winget: $LASTEXITCODE `n" -ForegroundColor White -BackgroundColor DarkRed
                }
            } catch {
                Write-Host " [ERRO] Falha crítica ao instalar `n" -ForegroundColor White -BackgroundColor DarkRed
            }
        }
    }
    Write-Host "Processo concluído!" -ForegroundColor Green
} else {
    Clear-Host
    Write-Host "Operação cancelada. Nenhuma alteração foi feita." -ForegroundColor Gray
}