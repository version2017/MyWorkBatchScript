% ******Author：Roger.wu****** %
% ******Date：2020-04-13****** %
% ******DESC：download sftp files****** %
@echo off
@setlocal enabledelayedexpansion

set isDebug=0
set targetFtpPath=/01-CRM_每日集成脚本
set sftpDataDir=D:\PsftpDownload\
set listCommand=psftpListCommand.txt
set downloadCommand=psftpDownloadCommand.txt
set targetFileList=targetFileList.txt
set fileListLog=ftpFileList.log
set fileDownloadLog=ftpFileDownloadLog.log

set listCommandPath=%sftpDataDir%%listCommand%
set downloadCommandPath=%sftpDataDir%%downloadCommand%
set targetFileListPath=%sftpDataDir%%targetFileList%
set fileListLogPath=%sftpDataDir%%fileListLog%
set fileDownloadLogPath=%sftpDataDir%%fileDownloadLog%

:inputDays
echo ********Input "exit" if you want to exit the script
set /p daysAgo= How many days of zip file do you want to download?(days number)
if "%daysAgo%"=="exit" goto end
if "%daysAgo%"=="" goto ErrorInputNull
echo %daysAgo%|findstr "^[0-9][0-9]*$"&&goto listFtpFile || goto ErrorInputString
goto inputDays
goto end

:listFtpFile
echo cd %targetFtpPath% > %listCommandPath%
echo dir >> %listCommandPath%
call callPsftpScripts.bat "%listCommandPath%" > %fileListLogPath%
if not "%isDebug%"=="1" del %listCommandPath%
goto listFileToDownload
goto end

:listFileToDownload
echo ********Listing files to download.It may take few minutes.Please wait a moment...
echo. > %targetFileListPath%
echo cd %targetFtpPath% > %downloadCommandPath%
goto listFileByDays
goto end

:listFileByDays
>"%temp%\MyDate.vbs" echo LastDate=date()-%daysAgo%
>>"%temp%\MyDate.vbs" echo FmtDate=right(year(LastDate),4) ^& right("0" ^& month(LastDate),2) ^& right("0" ^& day(LastDate),2)
>>"%temp%\MyDate.vbs" echo wscript.echo FmtDate
for /f %%a in ('cscript /nologo "%temp%\MyDate.vbs"') do (set DstDate=%%a)
set DstDate=%DstDate:~0,4%%DstDate:~4,2%%DstDate:~6,2%
if "%isDebug%"=="1" echo DstDate=%DstDate%

for /F "tokens=9 delims= " %%i in (%fileListLogPath%) do (
	call ReplaceStrWithSpace.bat %%i %DstDate%
	if not "!ReplaceStrWithSpaceRet!"=="%%i" (
		echo %%i
		echo %%i >> %targetFileListPath%
		echo get %%i >> %downloadCommandPath%
	)
	
)
if %daysAgo% gtr 1 (
	set /a daysAgo=%daysAgo%-1
	goto listFileByDays
)
goto confirmDownload
goto end

:confirmDownload
set /p whetherDownload= Do you want to download these files?(y/n)
if not "%whetherDownload%"=="y" goto end
call callPsftpScripts.bat "%downloadCommandPath%" > %fileDownloadLogPath%
goto confirmUnzip
goto end

:confirmUnzip
set /p whetherUnzip= Do you want to unzip these files and execute?(y/n)
if not "%whetherUnzip%"=="y" goto end
for /F %%i in (%targetFileListPath%) do (
	echo %%i|findstr "%DstDate%" >nul
	if "!errorlevel!"=="0" call IntegrateZip.bat %sftpDataDir%%%i
)
goto end

:ErrorInputNull
echo Error: The param of number of days is necessary.
echo.
goto inputDays
goto end

:ErrorInputString
echo Error: Please input number.
echo.
goto inputDays
goto end

:end
endlocal

