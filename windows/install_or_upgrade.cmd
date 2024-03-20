@echo off
echo:

@rem Git global config
echo y | copy git\.gitconfig %USERPROFILE%\ > nul
if %ERRORLEVEL% neq 0 (
  echo [ERROR]: Failed to upgrade .gitconfig
  call :RESET_ERRORLEVEL
) else (
  echo [INFO]: Installed latest .gitconfig
)
echo:

@rem VS Code extenstions
echo [INFO]: Installing or updating vscode extensions...
echo:
call code --install-extension ms-vscode.cpptools-extension-pack --force > nul
call code --install-extension streetsidesoftware.code-spell-checker --force  > nul
call code --install-extension dbaeumer.vscode-eslint --force > nul
call code --install-extension eamodio.gitlens --force > nul
call code --install-extension oderwat.indent-rainbow --force > nul
call code --install-extension ritwickdey.liveserver --force > nul
call code --install-extension yzhang.markdown-all-in-one --force > nul
call code --install-extension esbenp.prettier-vscode --force > nul
call code --install-extension rangav.vscode-thunder-client --force > nul
call code --install-extension enkia.tokyo-night --force > nul
call code --install-extension vscodevim.vim --force > nul
call code --install-extension vscode-icons-team.vscode-icons --force > nul
call code --install-extension redhat.vscode-xml --force > nul
call :reset_errorlevel

@rem VS Code settings.json
echo y | copy vscode\settings.json %APPDATA%\Code\User\settings.json > nul
if %ERRORLEVEL% neq 0 (
  echo [ERROR]: Failed to install latest VSCode settings.json
  call :RESET_ERRORLEVEL
) else (
  echo [INFO]: Installed latest VSCode settings.json
)
echo:

@rem Bash config
echo y | copy git\.bashrc %USERPROFILE%\ > nul
if %ERRORLEVEL% neq 0 (
  echo [ERROR]: Failed to upgrade .bashrc
  call :RESET_ERRORLEVEL
) else (
  echo [INFO]: Installed latest .bashrc
)
echo:

@rem Setting doskeys if run with admin privilege
net session > nul 2>&1
if %ERRORLEVEL% neq 0 (
  echo [ERROR]: To set the doskey macros registry key this script must be run as an administrator
  echo:
  goto SKIP_DOSKEY_REG_KEY
)
reg query "hklm\software\microsoft\command processor" /v autorun > nul
reg add "hklm\software\microsoft\command processor" /v autorun /t reg_expand_sz /d "doskey /listsize=999 /macrofile=%USERPROFILE%\doskey_macros.txt" /f > nul
echo [INFO]: Set reg key to load doskey doskey_macros
echo:
:SKIP_DOSKEY_REG_KEY
call :RESET_ERRORLEVEL

@rem doskey macros
echo y | copy cmd\doskey_macros.txt %USERPROFILE%\ > nul
if %ERRORLEVEL% neq 0 (
  echo [ERROR]: Failed to upgrade doskey_macros.txt
  call :RESET_ERRORLEVEL
) else (
  echo [INFO]: Installed latest doskey_macros.txt
)
echo:

echo [INFO]: Finished installing latest Windows environment configuration
echo         Following tools must be installed manually if not yet installed:
echo             - vscode: https://code.visualstudio.com/#alt-downloads
echo             - git: https://git-scm.com/download/win
echo             - grep for Windows: https://github.com/BurntSushi/ripgrep
echo             - Meslo nerd font: https://github.com/andreberg/Meslo-Font
echo:

goto :EOF

:RESET_ERRORLEVEL
exit /b 0
