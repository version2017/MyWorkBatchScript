% ******Author：Roger.wu****** %
% ******Date：2020-04-10****** %
% ******Note：make sure the unzip command is in your path ****** %
@echo off
@setlocal enabledelayedexpansion

set targetFile=%1
set targetDir=%targetFile:~0,-4%

% Check 1：empty check of param %
if "%1"=="" goto ErrorNeedParam

% Check 2：the suffix of file %
if not "%targetFile:~-4%"==".zip" goto ErrorWrongSuffix

% Check 3：is target file already unzipped  %
if exist %targetDir% goto ErrorRepeatUnzipp


% The beginning %
@goto unzipFile
::@goto doExecute

% Process control： go to the end directly %
@goto end


% Step 1：unzip target file %
:unzipFile
unzip %targetFile% -d %targetDir%
@goto deleteUselessScript
@goto end

% Step 2：delete useless scripts %
:deleteUselessScript
if exist %targetDir%\月度版本\ (
	@rd /s /q %targetDir%\月度版本\
)
if exist %targetDir%\每日脚本\个性化脚本\ (
	@rd /s /q %targetDir%\每日脚本\个性化脚本\
)
@goto listScripts
@goto end

% Step 3：list the scripts %
:listScripts
@echo **************************** The scripts to exexute *****************************
for /r %targetDir% %%i in (*) do (
	@echo %%i
)
@goto confirmExecute
@goto end

% Step 4：execution confirmation  %
:confirmExecute
@set /p input= Are you sure to execute these scripts?(y/n)
if "%input%"=="y" goto doExecute
@goto end

% Step 5：do execute %
:doExecute
for /r %targetDir% %%i in (*) do (
	start "%%~ni%%~xi" cmd /k "echo %%i && call ExecuteSql.bat %%i"
)
@goto end


% Method of exception %
:ErrorWrongSuffix
@echo Error: Wrong suffix.Only zip file.
@goto end
:ErrorNeedParam
@echo Error: Param is needed.Please input target file after the script.
@goto end
:ErrorRepeatUnzipp
@echo Error: Target file is already unzipped.
@goto end


:end