# LCD-Custom-Char-Maker
Create Custom Characters for LCD displays connected to Arduino, Raspberry Pi, Tinkerforge or other

* Created with [B4J v8.00](https://www.b4x.com/b4j.html) - development tool for cross platform desktop, server and IoT solutions.
* Requires Java JDK 8 to run. Ensure to comply to the [Oracle JDK Licence agreement](https://www.oracle.com/downloads/licenses/oracle-javase-license.html).
* Developed for personal & development use only.

![lcdcustomcharmaker](https://user-images.githubusercontent.com/47274144/72811224-7de5e700-3c5f-11ea-81ab-df8d4fbfeb9f.png)

## Functionality
* Create custom LCD character with 5 pixel horizontal (cols), 8 pixel vertical (rows).
* Each row is represented by a byte with 5 bits.
* Create DEC, HEX and BIN arrays.
* Save / open the character to / from a textfile located in the application folder.
* Import 8 bytes array string in format 0xNN,0xNN... where NN is HEX value.
* Convert LCD character table high & low bits to DEC & HEX values.
* Various language specific examples
* Some example chars in the project source/objects folder.

## Files
* lcdcustomcharmaker.zip contains the application, sample characters and examples.

## Install
From the source/Objects folder, run the Java jar **lcdcustomcharmaker.jar**
```
java -jar lcdcustomcharmaker.jar
```

**Notes:**
* The full B4J source code is included (folder source).
* An example batch file "run8.bat" to run under Windows is included. Ensure to set the path to the JDK8 folder.
* There is also a "run11.bat" for running with openJDK11 - might require to recompile first with B4J using openJDK11.

## Example Coding Custom Character Battery

This example covers various development tools B4R, B4J and dedicated Tinkerforge 20x4 bricklet with C, Java, JavaScript, MQTT & Python.

Example output for the custom character Battery (empty):

```
' B4X HEX array
Dim battery(8) As Byte
battery = Array As Byte (0x0E, 0x1B, 0x11, 0x11, 0x11, 0x11, 0x11, 0x1F)

// C byte array
Byte battery[8] = {B01110, B11011, B10001, B10001, B10001, B10001, B10001, B11111};
// C int8_t array
int8_t battery[8] = {14, 27, 17, 17, 17, 17, 17, 31};

# Python int array
battery = [14, 27, 17, 17, 17, 17, 17, 31]

// Java short array
short[] battery = new short[]{14, 27, 17, 17, 17, 17, 17, 31}

// JavaScript int array
battery = [14, 27, 17, 17, 17, 17, 17, 31]

# JSON Tinkerforge MQTT2 index 0 and int array
{"index":0, "character":[14, 27, 17, 17, 17, 17, 17, 31]}
```

### Tinkerforge
The LCD 20x4 Bricklet supports up to 8 custom characters 0-7 which are mapped to \u0008-\u000F (\u takes hex numbers).
Tested defining and writing custom characters with an LCD 20x4 v1.2 Bricklet having UID=BHN.
Some API snippet exmples.

#### C
```
// Create device object
LCD20x4 lcd;

// Clear display & turn backlight on
lcd_20x4_clear_display(&lcd);
lcd_20x4_backlight_on(&lcd);

// Custom Char battery assigned to index 0 (from max 7)
int8_t battery[8] = {14,27,17,17,17,17,17,31};
lcd_20x4_set_custom_character(&lcd,0, battery);
// Write text and the custom character
lcd_20x4_write_line(&lcd, 0, 0, "Battery: \x08"); 
```

#### Java
```
BrickletLCD20x4 lcd = new BrickletLCD20x4(UID, ipcon); // Create device object

// Clear & turn backlight on
lcd.clearDisplay();
lcd.backlightOn();

// Custom Char battery assigned to index 0 (from max 7)
short[] battery = new short[]{14,27,17,17,17,17,17,31};
lcd.setCustomCharacter((short)0, battery);
// Display the custom char with some text
lcd.writeLine((short)0, (short)0, "Battery: " + "\u0008");
//lcd.writeLine((short)0, (short)0, "Battery: " + (char)0x08); 
```

#### JavaScript
```
var lcd = new Tinkerforge.BrickletLCD20x4(UID, ipcon); // Create device object

// Clear & turn backlight on
lcd.clearDisplay();
lcd.backlightOn();

// Custom Char battery assigned to index 0 (from max 7)
battery = [14,27,17,17,17,17,17,31]
lcd.setCustomCharacter(0, battery)
// Display the custom char with some text
lcd.writeLine(0, 0, "Battery: " + "\x08")        
```

#### MQTT V2
*Test 1:* Turn the display backlight on, clear the display and display text string "Hello World".
```
mosquitto_pub -t tinkerforge/request/lcd_20x4_bricklet/BHN/backlight_on -m ''
mosquitto_pub -t tinkerforge/request/lcd_20x4_bricklet/BHN/clear_display -m ''
mosquitto_pub -t tinkerforge/request/lcd_20x4_bricklet/BHN/write_line -m '{"line": 0, "position": 0, "text": "Hello World"}'
```

*Test 2:* Define & custom character Battery.

The JSON definition for the custom character battery set to index 0 (the first custom character at position 0x08 = \u0008):
```
{"index":0, "character":[14, 27, 17, 17, 17, 17, 17, 31]}
```
Set custom character 0:
```
mosquitto_pub -t tinkerforge/request/lcd_20x4_bricklet/BHN/set_custom_character -m '{"index":0, "character":[14, 27, 17, 17, 17, 17, 17, 31]}'
```

Write it to the display with some text: 
```
mosquitto_pub -t tinkerforge/request/lcd_20x4_bricklet/BHN/write_line -m '{"line": 0, "position": 0, "text": "Battery: \u0008"}'
```

#### Python
```
lcd = BrickletLCD20x4(UID, ipcon) # Create device object

# Clear & Turn backlight on
lcd.clear_display()
lcd.backlight_on()

# Custom Char battery assigned to index 0 (from max 7)
battery = [14,27,17,17,17,17,17,31]
lcd.set_custom_character(0, battery)
# Display the custom char with some text
lcd.write_line(0, 0, "Battery: " + "\x08")
```

### B4R 

#### B4R Binary Definition
```
Byte battery[8] = {B01110,B11011,B10001,B10001,B10001,B10001,B10001,B11111};                            
```
#### B4R Example
InlineC Code is required to display the special characters.
This example can be used by copy and paste in projects.
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
Byte arrowup[8] = {B00000,B00100,B01110,B11111,B00100,B00100,B00100,B00000};
Byte arrowdown[8] = {B00000,B00100,B00100,B00100,B11111,B01110,B00100,B00000};
Byte arroweq[8] = {B00000,B00000,B11111,B00000,B11111,B00000,B00000,B00000};
```

```
//Create the special chars:0=arrow up, 1=arrow down, 2=arrow equal
//RunNative("createChar", Null)
void createChar(B4R::Object* o) {
   b4r_main::_lcd->lc->createChar(0, arrowup);
   b4r_main::_lcd->lc->createChar(1, arrowdown);
   b4r_main::_lcd->lc->createChar(2, arroweq);
}

//Write a special character to the display: 0=arrow up, 1=arrow down, 2=arrow equal
//lcd.SetCursor(0,1)
//RunNative("writeChar", 0)
void writeChar(B4R::Object* o) {
   b4r_main::_lcd->lc->write((Byte)o->toULong());
}
#end if                                                          
```

#### Hint
To write a character from the character table of the LCD Display driver.
The Degree Character ° is located at position upper 4 bits 1101 and lower 4 bits 1111.
The 8 bits 1101 1111 are HEX DF and DEC 223.
To write the character to the LCD use lcd.Write(Array As Byte(223)).

### LCD Character Table
Convert Upper 4 & Lower 4 bits to HEX and Unicode
Example Cent Character: Upper 4 bits = 1110, Lower 4 bits = 1111
Converted:
11101111 = EF , 0xEF , \u00EF, 239

Use the LCD display datasheet accordingly.

## Licence
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with the samples.  If not, see [GNU Licenses](http://www.gnu.org/licenses/).
