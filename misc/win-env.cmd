rem
rem Customization for cmd.exe for colors, fonts, aliases :
rem http://stackoverflow.com/questions/20530996/aliases-in-windows-command-prompt
rem Run as:
rem       cmd.exe /K win-env.cmd
rem       CALL win-env.cmd


ECHO OFF
title "Git Status"
doskey gits=git status $*

title "Go one level up in DIR"
doskey b=CD .. $*
