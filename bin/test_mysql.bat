@echo off
cls
@set path=c:\xampp\apache\bin\

ab -n100 -c10 -l localhost/master/wdo.v2/sql8.prg

pause