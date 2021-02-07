@echo off

echo Start to convert XLSX to CSV.
powershell -ExecutionPolicy RemoteSigned .\xlsx2csv.ps1
echo Finish converting XLSX to CSV.
echo;

echo Start to convert CSV to SQL.
powershell -ExecutionPolicy RemoteSigned .\csv2sql.ps1
echo Finish converting CSV to SQL.
echo;

echo Start to execute SQL INSERT.
call .\deleteData.bat
call .\insertData.bat
echo Finish executing SQL INSERT.
echo;

pause