% ******Author：Roger.wu****** %
% ******Date：2020-04-19****** %
% ******Note：list modified files by svn ****** %

@echo off
@setlocal enabledelayedexpansion
chcp 65001

set workMainDir=D:\Workspace\project2020\CRM2.0\Sources\ModularCI
set svnModifedFilesLog=D:\Workspace\project2020\CRM2.0WorkSpace2\svnModifedFiles.log
set EXE_NotePad=D:\Apps\Daily\Notepad++\notepad++.exe

echo Getting info from svn. Please wait a moment...
echo 已变动的文件： > %svnModifedFilesLog%

if "%1"=="all" goto listAllFiles

:listFilesExceptIml
for /F "tokens=1,2 delims= " %%i in ('svn status %workMainDir%') do (
	rem if %%j contains ".iml"
	call ReplaceStrWithSpace.bat %%j .iml
	rem if "!ReplaceStrWithSpaceRet!"=="%%j" echo %%i %%j
	if "!ReplaceStrWithSpaceRet!"=="%%j" echo %%i %%j >> %svnModifedFilesLog%
)
%EXE_NotePad% %svnModifedFilesLog%
goto end

:listAllFiles
for /F "tokens=1,2 delims= " %%i in ('svn status %workMainDir%') do (
	echo %%i %%j >> %svnModifedFilesLog%
)
%EXE_NotePad% %svnModifedFilesLog%
goto end

:end
chcp 936
endlocal