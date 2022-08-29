@echo off
rem This file was created by pub v2.16.2.
rem Package: webdev
rem Version: 2.7.8
rem Executable: webdev
rem Script: webdev
if exist "C:\Users\Saturn\AppData\Local\Pub\Cache\global_packages\webdev\bin\webdev.dart-2.16.2.snapshot" (
  call dart "C:\Users\Saturn\AppData\Local\Pub\Cache\global_packages\webdev\bin\webdev.dart-2.16.2.snapshot" %*
  rem The VM exits with code 253 if the snapshot version is out-of-date.
  rem If it is, we need to delete it and run "pub global" manually.
  if not errorlevel 253 (
    goto error
  )
  dart pub global run webdev:webdev %*
) else (
  dart pub global run webdev:webdev %*
)
goto eof
:error
exit /b %errorlevel%
:eof

