@echo off

echo.
echo Welcome to Rococopy Me!
echo https://github.com/skipscode/robocopyme
echo MIT License
echo.

:main
	setlocal enabledelayedexpansion
	call :get-ini config.ini Destination uuid uuid
	call :get-ini config.ini Destination folder dest_folder
	call :get-ini config.ini Option options options
	call :get-ini config.ini Option log log
	set "volume=\Volume{%uuid%}"
	set "drive_letter="
	set "log_option="
	set dt=%date:/=-%
	if not defined dest_folder (set "folder=") else (set "folder=%dest_folder%\")
	if /i "%log%" == "true" (set "log_option=/LOG+:log-%dt%.txt") else (set "log_option=")
	call :get-drive_letter
	echo Drive letter set to %drive_letter%

	echo.
	echo Starting backup
	echo.
	
	set "var=config.ini"
	set "Source="

	for /F "tokens=*" %%a in (%var%) do (
		if defined flag (
			echo %%a|find "[" >null && set "flag=" || (
			set wfolder=%%a
			echo.
			echo Copying %%a to "%drive_letter%\%folder%!wfolder:~0,1!\!wfolder:~3!" with these options %options% %log_option%
			rem echo robocopy %%a "%drive_letter%\%folder%!wfolder:~0,1!\!wfolder:~3!" %options% %log_option%
			robocopy %%a "%drive_letter%\%folder%!wfolder:~0,1!\!wfolder:~3!" %options% %log_option%
			rem /MIR /XJD /R:0 /W:0 /V /eta /ndl /nfl /LOG+:log-%dt%.txt /L
		)
		) else (
			if "%%a" == "[Source]" set flag=1
		)
	)
	goto :eof

:get-ini <filename> <section> <key> <result>
  set %~4=
  setlocal
  set insection=
  for /f "usebackq eol=; tokens=*" %%a in ("%~1") do (
    set line=%%a
    if defined insection (
      for /f "tokens=1,* delims==" %%b in ("!line!") do (
        if /i "%%b"=="%3" (
          endlocal
          set %~4=%%c
          goto :eof
        )
      )
    )
    if "!line:~0,1!"=="[" (
      for /f "delims=[]" %%b in ("!line!") do (
        if /i "%%b"=="%2" (
          set insection=1
        ) else (
          endlocal
          if defined insection goto :eof
        )
      )
    )
  )
  endlocal
  
:get-drive_letter
  	echo Seeking driver letter from \Volume{%uuid%}
	for %%D in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
	mountvol %%D: /L | findstr "%volume%" >nul
	if not errorlevel 1 set "drive_letter=%%D:"
	)