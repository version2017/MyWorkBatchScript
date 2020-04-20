% ******Author：Roger.wu****** %
% ******Date：2020-04-13****** %
% ******DESC：call psftp scripts****** %
@echo off

set ipAddress=192.168.102.182
set username=yxfwsqlcheck
set password=YXFW_2018
set port=1111

if "%1"=="" goto nullParamException
pushd %sftpDataDir%
psftp %ipAddress% -l %username% -pw %password% -P %port% -b "%1"
::psftp 192.168.102.182 -l yxfwsqlcheck -pw YXFW_2018 -P 1111 -b "psftpListCommand.txt"
popd
goto end

:nullParamException
echo Error: null param.

:end