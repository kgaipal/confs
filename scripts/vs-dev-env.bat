::
:: Kshitij Gaipal
:: kgaipal@gmail.com
::
:: Exec's Visual Studio dev environment for current shell.

CALL env.cmd
CHDIR "%HOME%/code/"
%comspec% /k "C:/"Program Files (x86)"/"Microsoft Visual Studio 14.0"/Common7/Tools/VsDevCmd.bat"
