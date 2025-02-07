# Posh-Git Config
Import-Module '/home/dino/.local/share/powershell/Modules/posh-git/1.1.0/posh-git.psd1'
$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "dd-MM-yyyy HH:mm") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta

# Change directory into repositories
function Set-LocationRepos {
  Set-Location -Path "$HOME/Documents/Repos"
}
Set-Alias -Name repos -Value Set-LocationRepos

# Open notes in neovim
function Start-Notes {
  nvim "$HOME/Documents/notes.md"
}
Set-Alias -Name notes -Value Start-Notes

# Create a new file
Set-Alias -Name touch -Value New-Item

