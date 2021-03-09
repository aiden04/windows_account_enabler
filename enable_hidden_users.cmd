@echo off
Title Warning!
cls
goto Elevation

:Elevation
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd C:\Windows\system32
goto start

:start
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo ---------------------------------------------------------Warning--------------------------------------------------------
echo.
echo.
echo.
echo  - Warning, this batch file will edit your computer files. I am not liable
echo  - for any corruption that happens, if you understand then please enter 
echo  - "Agree", if not, please enter "Disagree".
echo.
set/p answer=Enter yes or no here: 
if %answer%==Agree goto Choice
if %answer%==Disagree goto Disagree
if %answer%==agree goto Choice
if %answer%==disagree goto Disagree
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause>nul|set /p=  - Incorrect Input, Please press any key to go back...
goto Start

:Choice
title Enable or Disable Windows Users
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo --------------------------------------------------Enable or Disable-----------------------------------------------------
echo.
echo.
echo.
echo.
echo  - Would you like to Disable or Enable a Hidden Windows Account.
echo. 
set/p PATH=Enter "Disable", or "Enable" here: 
if %PATH%==enable goto Enable
if %PATH%==Enable goto Enable
if %PATH%==disable goto Disable 
if %PATH%==Disable goto Disable
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause>nul|set /p=  - Incorrect Input, Please press any key to go back...
goto Choice

:Enable
Title Enable
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo ----------------------------------------------------------User----------------------------------------------------------
echo.
echo  - A list of users will be listed.
echo.
net user
echo.
echo  - please select from the list of users.
echo.
set/p variable= Enter Username Here: 
net user %variable% /Active:yes
goto Completed

:Completed
title Completed Enabling
cls
echo.
echo ------------------------------------------------------Completed--------------------------------------------------------
echo.
net user %variable%
echo.
echo.
echo.
echo.
echo  - Look for where it says "Account Active", it should now say "Yes".
echo  - If it does not, the opperation did not complete succsefully
echo  - Please make sure you have entered the username correctly.
echo.
echo.
echo.
echo.
echo  - If you would like to restart please enter "Restart", if not please enter "Exit"
echo  - If you would like to change the account password, please enter "Password".
echo.
set/p EXIT_KEY=Please enter here: 
echo.
if %EXIT_KEY%==Restart goto Enable
if %EXIT_KEY%==Exit goto Exit 
if %EXIT_KEY%==restart goto Enable
if %EXIT_KEY%==exit goto Exit
if %EXIT_KEY%==Password goto Password
if %EXIT_KEY%==password goto Password
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause>nul|set /p=  - Incorrect Input, Please press any key to go back...
goto Completed

:Disable
Title Disabling
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo ----------------------------------------------------------User----------------------------------------------------------
echo.
echo  - A list of users will be listed.
echo.
net user
echo.
echo  - please select from the list of users.
echo.
set/p variable= Enter Username Here: 
net user %variable% /Active:no
goto Completed_Disable

:Completed_Disable
Title Completed Disable
cls
echo.
echo -------------------------------------------------------Completed--------------------------------------------------------
echo.
net user %variable%
echo.
echo.
echo.
echo.
echo  - Look for where it says "Account Active", it should now say "No".
echo  - If it does not, the opperation did not complete succsefully
echo  - Please make sure you have entered the username correctly.
echo.
echo.
echo.
echo.
echo  - If you would like to restart please enter "Restart", if not please enter "Exit"
echo.
set/p EXIT_KEY=Please enter here: 
echo.
if %EXIT_KEY%==Restart goto Disable
if %EXIT_KEY%==Exit goto Exit 
if %EXIT_KEY%==restart goto Disable
if %EXIT_KEY%==exit goto Exit
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause>nul|set /p=  - Incorrect Input, Please press any key to go back...
goto Completed_Disable

:Password
Title Password Changing In Progress
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo ---------------------------------------------------Password Changer-----------------------------------------------------
echo.
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set color_white=%ESC%[37m
set color_black=%ESC%[30m
set/p password= Please enter the password you want here: %color_black%
echo %color_white%
net user %variable% %password%
echo.
goto Password_Complete
pause

:Password_Complete
echo.
echo.
echo.
echo.
echo.
echo  - The text "The command completed successfully." should have appeared.
echo  - If not, Please enter Restart
echo  - If it has completed successfully, please enter "Exit".
echo  - If you would like to see your password please enter "Show".
echo. 
set/p leave_code= Please enter response here: 
if %leave_code%==restart goto Enable
if %leave_code%==Restart goto Enable
if %leave_code%==exit goto EXIT
if %leave_code%==Exit goto EXIT
if %leave_code%==Show goto show_passowrd
if %leave_code%==show goto show_password
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause>nul|set /p=  - Incorrect Input, Please press any key to go back...
cls
goto Password_Complete

:show_password
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo -----------------------------------------------------Show Password-------------------------------------------------------
echo.
echo.
echo.
echo.
echo  - DO NOT SHARE THIS PASSWORD WITH ANYONE!!!
echo.
echo  - The password for %variable% is "%password%".
echo.
pause>nul|set /p=  - Press any key to continue when you have finished...
goto EXIT

:Disagree
title Disagree
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo --------------------------------------------------------Diagree----------------------------------------------------------
echo.
echo  - You have Disagreed, you cannot continue.
echo.
pause>nul|set /p= Please press any key to continue to exit screen...
goto Exit

:EXIT
title Exit
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo ----------------------------------------------------------Exit-----------------------------------------------------------
echo.
echo Command Script has successfully completed on account "%username%" at %time% on %date%.
echo.
pause>nul|set /p= Press any key to exit...
