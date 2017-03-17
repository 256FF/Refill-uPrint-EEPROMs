import binascii
import argparse
import sys
parser = argparse.ArgumentParser(description='Convert .bin files to CSV and clipboard')

parser.add_argument("-i", "--inputfile", action="store")
parser.add_argument("-s", "--save", action="store_true")
parser.add_argument("-o", "--outputfile", action="store")

args = parser.parse_args()

with open(args.inputfile, 'rb') as f:
    content = f.read()
string = binascii.hexlify(content)
#print string
length = len (string)
length = length - 2

i = 0
k = 0

while k < length:
    string = string[:(2+i*3)] + "," + string[(2+i*3):]
    i = i + 1
    k = i * 2	

# Add write command for DIAG-Port connection
string = "ew 0 1 0 \"" + string + "\""

# print complete content
print string

if args.save:
    with open(args.outputfile, "w") as text_file:
        text_file.write(string)

# Copy content to clipboard
try:
    from Tkinter import Tk
except ImportError:
    # welcome to Python3
    from tkinter import Tk
    raw_input = input

r = Tk()
r.withdraw()
r.clipboard_clear()
r.clipboard_append(string)
