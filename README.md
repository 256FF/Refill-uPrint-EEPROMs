# Refill-uPrint-EEPROMs

Batch files for creating data to refill uPrint EEPROMs via DIAG-Port and a serial connection


You need to download and copy all stuff from https://github.com/bvanheu/stratasys to the same folder as these files.

----

## flip + generate + clipboard.bat

Run the bat file and paste the UID (b3 5c 1c 0b d0 14 10 0d ) with spaces. You get it when connected to the DIAG-Port via putty. Just mark and copy the output of the UID after the command _er 0 1 0 128_.

```
er 0 1 0 128
Model carrier ID (8 8-bit values)
000000: b3 5c 1c 0b d0 14 10 0d                           .\......

Model carrier in bay 1: 128 bytes at address 0 (128 8-bit values)
000000: ed 45 85 80 6b 9b a1 1e f3 20 bb 2e 2f 96 74 a9   .E..k.... ../.t.
000016: 67 f2 b9 2a 56 c7 79 f6 90 c2 42 7f cb 09 60 53   g..*V.y...B...`S
000032: f2 05 72 63 08 f0 36 72 ec f2 5d 53 52 e3 6d 74   ..rc..6r..]SR.mt
000048: ec f2 5d 53 52 e3 6d 74 b0 89 5c 51 69 ae 14 c5   ..]SR.mt..\Qi...
000064: 22 60 00 00 00 00 74 25 55 aa 55 83 8b f7 4c be   "`....t%U.U...L.
000080: a8 74 00 00 00 00 00 00 7e 35 04 51 0f 0e 1c 9e   .t......~5.Q....
000096: f4 5c 56 f3 fc a9 f1 d2 53 54 52 41 54 41 53 59   .\V.....STRATASY
000112: 53 ac 99 cb ee 48 b4 9e a3 62 f0 97 a5 2b 84 38   S....H...b...+.8
```

The batch file swaps the UID and generates a serial number by date and time (JJMMTTHHMM). Then these info is used to create a new.bin file with stratasys-cli.py. 

Afterwards trans_cp.py transforms the HEX data to CSV and adds the write command for the putty connection. This complete string will be copied to clipboard and can be inserted in putty to write the eeprom.

```
UID eingeben: b3 5c 1c 0b d0 14 10 0d

Ausgabe zur Kontrolle:
SwapUID=0d1014d00b1c5cb3
SNR=1703171609

ew 0 1 0 "82,57,35,1b,87,b5,bb,85,72,60,fe,77,8c,11,f0,41,3f,bd,1a,d0,bb,12,c5,e
3,66,93,06,62,85,8a,f6,1c,cf,43,2e,77,8a,58,f8,4a,52,c9,4c,9e,1e,d0,fa,4a,52,c9,
4c,9e,1e,d0,fa,4a,e3,50,ca,cd,b0,33,03,65,ab,c7,00,00,00,00,33,99,55,aa,55,c3,95
,bf,4e,be,2e,e5,00,00,00,00,00,00,e3,50,ca,cd,b0,33,03,65,34,36,33,60,00,00,00,0
0,53,4d,41,52,54,46,49,4c,4c"

Die Werte wurden in die Zwischenablage kopiert.

Drücken Sie eine beliebige Taste . . .
```

Remember to edit the line 31 in trans_cp.py if you have one or two bays under the printer
* model bay 1: string = "ew 0 0 0 \"" + string + "\""
* model bay 2: string = "ew 0 1 0 \"" + string + "\""

Filling will bei __42 cu in__. If you want other quantities you have to edit line 6 in the batch _flip + generate + clipboard.bat_
* --initial-material __42.0__ --current-material __42.0__


__Take the model cassette out after writing the eeprom and insert it again. Filling will bei 100% again.__

----

## Credits:

Many thanks to bvanheu for the great creating tool and mayrthom for the python script to convert the .bin files

----

## Todo

- [ ] Translate to english
- [ ] Establish serial connection to the printer
- [ ] Read EEPROM
- [ ] Get and transfer UID
- [ ] Choose Material
- [ ] Choose Bay (for flash command)
- [ ] Choose filling quantity
- [x] Reverse UID
- [x] Autocreate "unique" new serial number
- [x] Transfer variables to stratasys-cli.py to create a new .bin file
- [x] Show info of created file
- [x] Convert HEX date to CSV
- [x] Add write command for flashing EEPROM via DIAG port
- [x] Copy string to clipboard
- [ ] Write EEPROM via DIAG port
- [ ] Restart or Exit
