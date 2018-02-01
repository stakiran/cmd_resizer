@echo off
setlocal ENABLEDELAYEDEXPANSION
set defaultx=72
set defaulty=16
set delta=5

:loop_main
mode con: cols=%defaultx% lines=%defaulty%
:loop_main_without_resize
set /p dummyvar=cols:%defaultx% lines:%defaulty% delta:%delta% <nul
set /p command="(input?) "

if "%command%"=="q" (
	exit /b
)

if "%command%"=="h" (
	call :usage
	goto :loop_main_without_resize
)

if "%command%"=="s" (
	set /a defaulty=%defaulty%-%delta%
	goto :loop_main
)

if "%command%"=="x" (
	set /a defaulty=%defaulty%+%delta%
	goto :loop_main
)

if "%command%"=="z" (
	set /a defaultx=%defaultx%-%delta%
	goto :loop_main
)

if "%command%"=="c" (
	set /a defaultx=%defaultx%+%delta%
	goto :loop_main
)

call :is_numeric %command%
if %ret% neq 0 (
	echo Error!: The command "%command%" is invalid.
	goto :loop_main_without_resize
)

set delta=%command%
goto :loop_main

rem ----------
rem subrootins
rem ----------

:usage
echo [Change the window size]
echo      S
echo    Z X C
echo.
echo [Quit]
echo      Q
echo.
echo [Change the delta]
echo      Numbers
echo.
exit /b

rem ret=0 if %1 is numeric
rem ret=1 if %1 is not numeric
:is_numeric
set "var="&for /f "delims=0123456789" %%i in ("%1") do set var=%%i
if defined var (set ret=1) else (set ret=0)
exit /b
