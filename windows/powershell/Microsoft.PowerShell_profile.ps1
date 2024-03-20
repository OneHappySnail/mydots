$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$global:isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)


function prompt {
  $IS_GIT_REPO = git rev-parse --is-inside-work-tree

  # Windows logo
  Write-Host "`u{f17a} | " -NoNewLine
  
  # Print current location
  $LOCATION = "$(Get-Location)"
  $USER_PROFILE = $env:USERPROFILE
  $FINAL_LOCATION = $LOCATION.Replace($USER_PROFILE, "~")

  if ($IS_GIT_REPO -eq "true") {
    $LOCAL_BRANCH = git rev-parse --abbrev-ref HEAD
    $AHEAD = [int]$(git rev-list origin/$LOCAL_BRANCH..$LOCAL_BRANCH --count)
    $BEHIND = [int]$(git rev-list $LOCAL_BRANCH..origin/$LOCAL_BRANCH --count)

    Write-Host "`u{f07c} $FINAL_LOCATION" -NoNewLine -ForegroundColor DarkCyan
    Write-Host " |" -NoNewLine
    Write-Host " `u{f126} on $LOCAL_BRANCH" -NoNewLine -ForegroundColor Green

    # Show indicator if local branch is ahead of origin
    if ($AHEAD -gt 0) {
      Write-Host " `u{2191}$AHEAD" -NoNewLine -ForegroundColor Green
    }

    # Show indicator if local branch is behind of origin
    if ($BEHIND -gt 0) {
      Write-Host " `u{2193}$BEHIND" -NoNewLine -ForegroundColor Red
    }
  } else {
    Write-Host "`u{f07c} $FINAL_LOCATION" -NoNewLine -ForegroundColor DarkCyan
    Write-Host " |" -NoNewLine
  }

  # Unix like indicator for elevated privileges
  $privilegeIdentifiert = "$"
  if ($global:isAdmin) {
    $privilegeIdentifiert = "#"
  }
  Write-Host " $privilegeIdentifiert" -NoNewLine
  return " "
}

# Unix like "sudo" command.
# Run command with admin privileges or launch a new pwsh with admin privileges.
function runAsAdmin {
  if ($args.Count -gt 0) {
    $argList = "& '" + $args + "'"
    Start-Process "$pshome\pwsh.exe" -Verb runAs -ArgumentList $argList
  } else {
    Start-Process "$pshome\pwsh.exe" -Verb runAs
  }
}
Set-Alias -Name sudo -Value runAsAdmin

# Use ripgrep as grep.
# Windows does not have grep anyways.
Set-Alias -Name grep -Value rg

# Shorthand git
Set-Alias -Name g -Value git

# Remove variables
Remove-Variable currentPrincipal

