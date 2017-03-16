# Refill-uPrint-EEPROMs
Batch files for creating data to refill uPrint EEPROMs via DIAG-Port and a serial connection
----
You need to download and copy all stuff from https://github.com/bvanheu/stratasys to the same folder as these files.


**flip + generate + clipboard.bat**
----
Run the bat file and insert the UID (b3 5c 1c 0b d0 14 10 0d ) with spaces. You get it when connected to the DIAG-Port via putty. Copy the output of the UID after the command _er 0 1 0 128_.

The batch file swaps the UID and generates a serial number by date and time (JJMMTTHHMM). Then these info is used to create a new.bin file with stratasys-cli.py. 

Afterwards trans_cp.py transforms the HEX data to CSV and adds the write command for the putty connection. This complete string will be copied to clipboard and can be inserted in putty to write the eeprom.

Remember to edit the line 31 in trans_cp.py if you have one or two bays under the printer
* model bay 1: string = "ew 0 0 0 \"" + string + "\""
* model bay 2: string = "ew 0 1 0 \"" + string + "\""

Filling will bei __42 cu in__. If you want other quantities you have to edit line 6 in the batch _flip + generate + clipboard.bat_
* --initial-material __42.0__ --current-material __42.0__

Take the model cassette out after writing the eeprom and insert it again. Filling will bei 100% again.
