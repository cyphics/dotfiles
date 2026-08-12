Remove-Item alias:ls -ErrorAction SilentlyContinue
function ls { eza --icons --git $args }
function ll { eza -la --icons --git $args }
function l { eza -l --icons --git $args }
function vim { nvim $args }
function y { yazi }

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key Ctrl+p -Function PreviousHistory
Set-PSReadLineKeyHandler -Key Ctrl+n -Function NextHistory
Set-PSReadLineKeyHandler -Key Ctrl+d -Function ViExit
function tsess { & "$env:USERPROFILE\.tmux-sessionizer.ps1" @args }
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
