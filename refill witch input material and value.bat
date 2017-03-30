:: Batch to create the data to refill the EEPROM of uPrints via DIAG-Port connection
:: DATE: 30.03.2017
:: Version: 3.0
:: Author: 256FF (https://github.com/256FF)

@echo off
set VAR_1=eeprom --machine-type uprint --eeprom-uid
set UID=%1
set SNR=%2
set VAR_3=--serial-number
set MAT=%11
set VOL=%12
set VAR_4=--material-name %MAT% --manufacturing-lot 7567 --manufacturing-date "2017-01-01 01:01:01" --use-date "2017-01-01 01:01:01" --initial-material %VOL% --current-material %VOL% --key-fragment 55aa55c395bf4ebe --version 1 --signature SMARTFILL -o new.bin
set HX_0=%3
set HX_1=%4
set HX_2=%5
set HX_3=%6
set HX_4=%7
set HX_5=%8
set HX_6=%9
set HX_7=%10

:: Input
set /p UID=UID: 
set /p MAT=P430_IVR or ABS_SS: 
set /p VOL=Filling value (40.0): 
set VAR_4=--material-name %MAT% --manufacturing-lot 7567 --manufacturing-date "2017-01-01 01:01:01" --use-date "2017-01-01 01:01:01" --initial-material %VOL% --current-material %VOL% --key-fragment 55aa55c395bf4ebe --version 1 --signature SMARTFILL -o new.bin

:: Option to manually input serial number
:: set /p SNR=New serial number (x.0): 

:: Seriennummer automatisch erzeugen aus Datum und Uhrzeit
:: Create serial number with time and date
:: JJMMTTMMSS - without HH
:: set /a SNR=%date:~8,2%%date:~3,2%%date:~0,2%%time:~0,2%%time:~3,2%%time:~6,2%
set /a SNR=%date:~8,2%%date:~3,2%%date:~0,2%%time:~3,2%%time:~6,2%

:: UID umkehren / swap UID
set HX_0=%UID:~0,2%
set HX_1=%UID:~3,2%
set HX_2=%UID:~6,2%
set HX_3=%UID:~9,2%
set HX_4=%UID:~12,2%
set HX_5=%UID:~15,2%
set HX_6=%UID:~18,2%
set HX_7=%UID:~21,2%
set UID=%HX_7%%HX_6%%HX_5%%HX_4%%HX_3%%HX_2%%HX_1%%HX_0%

:: Ausgabe der eingegebenen Werte
:: Show the values
echo\
echo Used values:
echo SwapUID: %UID%
echo New SNr: %SNR%
echo Material: %MAT%
echo Filling quantity: %VOL%
echo\

:: Erstellen der new.bin mit bevanheu's script
:: Create the new *.bin file with bvanheu's script
stratasys-cli.py %VAR_1% %UID% %VAR_3% %SNR% %VAR_4%

:: Show info of the .bin file
stratasys-cli.py %VAR_1% %UID% -i new.bin

:: Umwandeln der new.bin in CSV + CopyData2Clipboard
:: Convert the new.bin into CSV and copy the data to the clipboard with write-command for the DIAG-Port
set VAR_1=-i new.bin -s -o csv.txt
::cd C:\Temp\refill\
trans_cp.py %VAR_1%

echo\
echo Write command has been copied to the clipboard. Swtich to putty and paste it. 
echo Make sure to choose the right bay! 
echo\
pause
