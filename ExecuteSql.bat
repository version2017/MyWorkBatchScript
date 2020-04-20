% ******Author：Roger.wu****** %
% ******Date：2020-04-10****** %
% ******Note：execute script and maintain the execute history record ****** %

@echo off
@setlocal enabledelayedexpansion

set logDir=D:\PsftpDownload\
set username=standdb
set password=standdb

if "%1"=="" goto end
echo [%time:~0,8%] %1 >> %logDir%sqlExecute%date:~0,4%%date:~5,2%%date:~8,2%.log
sqlplus %username%/%password%@orcl @%1

:end