:: Sets up various shortcuts and environment variables
:: Run as administrator

SET HOME=%USERRPROFILE%
SET START_MENU="%HOME%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs"

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

:: create shortcut for other scripts for start menu only
MKLINK "%START_MENU%/vs-cmd" "%HOME%/code/confs/scripts/vs-dev-env.bat"

:: prefer to call a git-bash and setup all commands in that instead
