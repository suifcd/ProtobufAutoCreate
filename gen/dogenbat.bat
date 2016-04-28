@echo off

cd ..\CSharpFile

set csFilePath=%cd%

echo cd ..\protogen 

cd ..\protoFile
for %%i in (*.proto) do echo protogen -i:%%~fi -o:%csFilePath%\%%~ni.cs ^
