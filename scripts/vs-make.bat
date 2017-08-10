::
:: Kshitij Gaipal
::
:: Exec's msbuild from current shell.

@CALL "C:/Program Files (x86)/Microsoft Visual Studio 14.0/Common7/Tools/VsDevCmd.bat"
CALL "msbuild" "/v:minimal" %*
