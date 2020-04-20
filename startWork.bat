% ******Author：Roger.wu****** %
% ******Date：2020-04-10****** %
@echo off
@setlocal enabledelayedexpansion

::goto end

C:
cd C:\Program Files (x86)\DingDing
start "" /max DingtalkLauncher.exe
cd C:\Program Files (x86)\Google\Chrome\Application\
start "" /max chrome.exe

D:
cd D:\Apps\DevelopTool\JetBrains\IntelliJ IDEA 2018.2.2\bin
start "" /max idea64.exe
start "" /max "D:\Apps\DevelopTool\PLSQL DeveloperX86\plsqldev.exe"
cd D:\Apps\Daily\Youdao\YoudaoNote
start "" /max YoudaoNote.exe
cd D:\Apps\Daily\Notepad++\
start "" /max notepad++.exe
cd D:\Apps\Daily
start "" /max Outlook_2016

set mainWorkSpace=D:\Workspace\project2020\CRM2.0\Sources\ModularCI
explorer %mainWorkSpace%
cd %mainWorkSpace%
echo %mainWorkSpace%
start "" cmder
set /p input= Do you want to update the code in the path above from svn?(y/n)
if not "%input%"=="y" goto end
start cmd /k "cd %mainWorkSpace% && svn update && pause"
set /p input2= Do you want to integrate the scripts from ftp?(y/n)
if not "%input2%"=="y" goto end
call GetScriptZipFromFtp.bat

:end
endlocal
pause