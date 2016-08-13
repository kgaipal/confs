:: Sets up various shortcuts and environment variables
:: Run as administrator

SET HOME=%USERPROFILE%
SET START_MENU=%HOME%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs

MKDIR "%HOME%/code"
MKDIR "%HOME%/.local/bin"

:: clone github's confs.git and make links to essential scripts from it
:: github's public repo is always read-only without credentials so clone will work without problems!
%COMSPEC% /C "git clone https://github.com/kgaipal/confs.git "%HOME%/code/confs""

:: Note: to make soft links, use MKLINK instead of bash's ln otherwise
:: git-bash will copy target file to the link location instead [bug #???]
MKLINK "%HOME%/.local/bin/grepk" "%HOME%/code/confs/scripts/grepk"
MKLINK "%HOME%/.local/bin/findk" "%HOME%/code/confs/scripts/findk"
MKLINK "%HOME%/.local/bin/util.inc" "%HOME%/code/confs/scripts/util.inc"
MKLINK "%HOME%/.gitconfig" "%HOME%/code/confs/misc/gitconfig"
MKLINK "%HOME%/.bashrc" "%HOME%/code/confs/misc/gitconfig"

:: remove unwanted programs which came with vanilla installation
%COMSPEC% /C "powershell -ExecutionPolicy ByPass -File windows10-remove-default-pacakges.ps1"

:: Registry editing
%COMSPEC% /C caps_lock_to_control.reg
%COMSPEC% /C cmd_env.reg
%COMSPEC% /C remove_personal_one_drive_menu_explorer.reg

:: create shortcut for other scripts for start menu only
:: disabling thi now this since wee want to create a shortcut not symlinks!
::MKLINK "%START_MENU%/vs-cmd" "%HOME%/code/confs/scripts/vs-dev-env.bat"

:: prefer to call a git-bash and setup all commands in that instead


ECHO Done setting up
