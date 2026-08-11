param(
    [string]$Selected
)

$dirList = @(
    "$env:USERPROFILE\.config",
    "$env:USERPROFILE\dotfiles",
    "$env:USERPROFILE\work",
    "$env:USERPROFILE\apps",
    "$env:USERPROFILE\cloud",
    "$env:USERPROFILE\cloud\config",
    "$env:USERPROFILE\cloud\dotfiles",
    "$env:USERPROFILE\cloud\programming\projects",
    "$env:USERPROFILE\cloud\programming\courses"
)

function ConvertTo-UnixPath {
    param([string]$path)
    $path = $path -replace '\\', '/'
    $path = $path -replace '^([A-Za-z]):', { "/$($args[0].Groups[1].Value.ToLower())" }
    return $path
}

function Test-TmuxSession {
    param($session)
    $sessions = & tmux list-sessions 2>$null
    return ($sessions -match "^$session`:")
}

function Switch-TmuxSession {
    param($session)
    if (-not $env:TMUX) {
        & tmux attach-session -t $session
    } else {
        & tmux switch-client -t $session
    }
}

function Invoke-Hydrate {
    param($session, $dirUnix)
    if (Test-Path "$dirUnix\.tmux-sessionizer") {
        & tmux send-keys -t $session "source $dirUnix/.tmux-sessionizer" C-M
    } elseif (Test-Path "$env:USERPROFILE\.tmux-sessionizer") {
        # $homeUnix = ConvertTo-UnixPath $env:USERPROFILE
        $homeUnix = $env:USERPROFILE
        & tmux send-keys -t $session "source $homeUnix/.tmux-sessionizer" C-M
    }
}

if (-not $Selected) {
    $allDirs = foreach ($d in $dirList) {
        if (Test-Path $d) {
            Get-ChildItem -Path $d -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName
        }
    }
    $Selected = $allDirs | fzf
}

if (-not $Selected) { exit 0 }

$selectedName = (Split-Path $Selected -Leaf) -replace '\.', '_'
# $selectedUnix = ConvertTo-UnixPath $Selected
$selectedUnix = $Selected

$tmuxRunning = & tmux list-sessions 2>$null

if (-not $env:TMUX -and -not $tmuxRunning) {
    & tmux new-session -s $selectedName -c $selectedUnix
    Invoke-Hydrate $selectedName $selectedUnix
    exit 0
}

if (-not (Test-TmuxSession $selectedName)) {
    & tmux new-session -ds $selectedName -c $selectedUnix
    Invoke-Hydrate $selectedName $selectedUnix
}

Switch-TmuxSession $selectedName
