% ******Author��Roger.wu****** %
% ******Date��2020-04-10****** %
@echo off
@setlocal enabledelayedexpansion

set targetDir=%1

% Check 1��empty check of param %
if "%1"=="" goto ErrorNeedParam


% The beginning %
@goto deleteUselessScript


% Process control�� go to the end directly %
@goto end

% Step 1��delete useless scripts %
:deleteUselessScript
if exist %targetDir%\�¶Ȱ汾\ (
	@rd /s /q %targetDir%\�¶Ȱ汾\
)
if exist %targetDir%\ÿ�սű�\���Ի��ű�\ (
	@rd /s /q %targetDir%\ÿ�սű�\���Ի��ű�\
)
@goto listScripts
@goto end

% Step 2��list the scripts %
:listScripts
@echo **************************** The scripts to exexute *****************************
for /r %targetDir% %%i in (*) do (
	@echo %%i
)
@goto confirmExecute
@goto end

% Step 3��execution confirmation  %
:confirmExecute
@set /p input= Are you sure to execute these scripts?(y/n)
if "%input%"=="y" goto doExecute
@goto end

% Step 4��do execute %
:doExecute
for /r %targetDir% %%i in (*) do (
	start "%%~ni%%~xi" cmd /k "echo %%i && call ExecuteSql.bat %%i"
)
@goto end


% Method of exception %
:ErrorNeedParam
@echo Error: Param is needed.Please input target directory after the script.
@goto end


:end