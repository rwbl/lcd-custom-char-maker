# lcdcharmaker
Open source application to create custom LCD characters for LCD displays connected to Arduino or Raspberry Pi.

The application is written in B4J (requires v5.80 or higher).

[B4J](https://www.b4x.com/b4j.html) development tool for cross platform desktop, server and IoT solutions by [Anywhere Software](https://www.b4x.com). 

The application have been mainly used for B4R programms.
[B4R](https://www.b4x.com/b4r.html) development tool, by [Anywhere Software](https://www.b4x.com), to build native Arduino & ESP8266 programs. 


__Application Version:__ v1.65 (Build 20170227)

## Files
* lcdcharmaker.zip contains the application and sample characters.

## Usage
* Unpack lcdcharmaker.zip in a folder of choice.
* Run from the objects folder, the file lcdcharmaker.jar. This is a Java application and requires Java to be installed.

## Functionality
* Create custom LCD character with 5 pixel horizontal (cols), 8 pixel vertical (rows).
* Each row is represented by a byte with 5 bits.
* Save / open the character to / from a textfile located in the application folder.
* Import 8 bytes array string in format 0xNN,0xNN... where NN is HEX value.
* Create B4R Inline C code (binary string) with copy to clipboard option.
* Create B4J code (hex string) with copy to clipboard option.
* Added example chars in the project objects folder.
* Tool supports LCD display connected to Raspberry Pi - using HEX strings (B4J).

## Example Custom Character Batterie
#Binary Definition for use in B4R
``` 
Byte batterie[8] = {
B01110,
B11011,
B10001,
B10001,                                              
B10001,
B10001,
B10001,
B11111
};                            
``` 

__HEX Definition for use in B4J:__
``` 
Dim batterie(8) As Byte = Array As Byte (0x0E,0x1B,0x11,0x11,0x11,0x11,0x11,0x1F)
``` 

## B4R Example
InlineC Code is required to display the special characters.
#Example (can be used to be copy and paste in projects)
``` 
'Inline C to define the special characters
'Usage:
'  Private CharArrowUp As Byte = 0
'  Private CharArrowDown As Byte = 1
'  Private CharArrowEq As Byte = 2
'  RunNative("createChar", Null)
'  lcd.SetCursor(0,0)
'  RunNative("writeChar", CharArrowUp)                
'  lcd.SetCursor(5,0)
'  RunNative("writeChar", CharArrowDown)
'  lcd.SetCursor(10,0)
'  RunNative("writeChar", CharArrowEq)
#if C                                                               
Byte arrowup[8] = {                                
  B00000,
  B00100,
  B01110,
  B11111,
  B00100,
  B00100,
  B00100,
  B00000                          
};

Byte arrowdown[8] = {
  B00000,
  B00100,
  B00100,
  B00100,
  B11111,
  B01110,
  B00100,
  B00000
};

Byte arroweq[8] = {
  B00000,
  B00000,
  B11111,
  B00000,
  B11111,
  B00000,
  B00000,
  B00000
};

//Create the special chars:0=arrow up, 1=arrow down, 2=arrow equal
//Use:
//RunNative("createChar", Null)
void createChar(B4R::Object* o) {
   b4r_main::_lcd->lc->createChar(0, arrowup);
   b4r_main::_lcd->lc->createChar(1, arrowdown);
   b4r_main::_lcd->lc->createChar(2, arroweq);
}

//Write a special character to the display: 0=arrow up, 1=arrow down, 2=arrow equal
//Use:
//lcd.SetCursor(0,1)
//RunNative("writeChar", 0)
void writeChar(B4R::Object* o) {
   b4r_main::_lcd->lc->write((Byte)o->toULong());
}
#end if                                                          
``` 

## Hint
To write a character from the character table of the LCD Display driver:
The LCD1602 uses the HD44780 Dot Matrix Liquid Crystal Display Controller/Driver.
The [datasheet](http://www.sparkfun.com/datasheets/LCD/HD44780.pdf) contains the character tables.

Example Degree Character (Reference page 17 of the data sheet):
* The Degree Character __°__ is located at position upper 4 bits 1101 and lower 4 bits 1111.
* The 8 bits 1101 1111 are HEX DF and DEC 223.
* To write the character to the LCD use lcd.Write(Array As Byte(223)).

## B4J
Example snippet.
``` 
Public Sub Char_Batterie( ascii As Int)  'ignore
  Dim chars(8) As Byte = Array As Byte (0x0e, 0x1b, 0x11, 0x11, 0x11, 0x11, 0x11, 0x1f)
  'Call the special routine to define the character
End Sub

Dim b as byte = 0
lcd.Char_Batterie(b)
lcd.PrintAt(2,1, Chr(b))
``` 

## Author
Robert W.B. Linn

## Licence
Copyright (C) 2017  Robert W.B. Linn
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with the samples.  If not, see [GNU Licenses](http://www.gnu.org/licenses/).
