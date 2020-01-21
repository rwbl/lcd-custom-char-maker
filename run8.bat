@echo off
rem Run Java 8 jar application with all modules
rem Supports runnung javafx applications
rem javaw is used to run the application
rem Path settings:
rem app - name of the app to run. will run the jar app.jar.
rem jdkpath - path of the jdk11 location
rem Change the var or path to run any other jar applicaton
rem 20200119 rwbl

rem define local vars
set app=lcdcustomcharmaker
set jdkpath=c:\prog\jdk8

rem inform
echo Running Java application %app%
echo Loading...

rem run the jar from the Objects subfolder
cd Source\Objects
start "%app%" %jdkpath%\bin\javaw.exe -jar %app%.jar

echo "Done"

exit
