@ECHO OFF
set str=%1
set matchStr=%2
set ReplaceStrWithSpaceRet=!str:%matchStr%=!
::echo Res:%testBatRet%