@ECHO OFF

rem
rem Kshitij Gaipal
rem kgaipal@gmail.com
rem
rem Sets the custom prompt for cmd.exe and then exec's Visual Studio dev environment for
rem current shell.

CHDIR "%HOME%/code/"
set PROMPT=[$P]$_$$
%comspec% /k "C:/"Program Files (x86)"/"Microsoft Visual Studio 14.0"/Common7/Tools/VsDevCmd.bat"
