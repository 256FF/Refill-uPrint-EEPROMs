@echo off
set VAR_1=eeprom --machine-type uprint --eeprom-uid
set UID=%1
set SNR=%2
set VAR_3=--serial-number
set VAR_4=--material-name P430_IVR --manufacturing-lot 7567 --manufacturing-date "2017-01-01 01:01:01" --use-date "2017-01-01 01:01:01" --initial-material 42.0 --current-material 42.0 --key-fragment 55aa55c395bf4ebe --version 1 --signature SMARTFILL -o new.bin

:Eingabe der Werte
set /p UID=UID eingeben:
set /p SNR=Seriennummer eingeben:

:Ausgabe der eingegebenen Werte
echo Ausgabe zur Kontrolle:
echo UID=%UID%
echo SNR=%SNR%

:Wechsel in das Verzeichnis und erstellen der new.bin
cd C:\Temp\refill\
stratasys-cli.py %VAR_1% %UID% %VAR_3% %SNR% %VAR_4%

:Umwandeln der new.bin in CSV + CopyData2Clipboard
set VAR_1=-i new.bin -s -o csv.txt
cd C:\Temp\refill\
trans_cp.py %VAR_1%

pause



