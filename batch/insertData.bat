@echo off

set USERID=user
set DBNAME=database
set HOST=localhost
set PORT=5432
set PGPASSWORD=user

set yyyy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set time2=%time: =0%
set hh=%time2:~0,2%
set mn=%time2:~3,2%
set ss=%time2:~6,2%
set logfolder=..\log\
set logfile=%logfolder%log_%yyyy%%mm%%dd%%hh%%mn%%ss%.txt

if not exist %logfolder% (
    mkdir %logfolder%
)


set input_dir=..\insertData
pushd %input_dir%
echo Executing insert data from table SQL ...
echo;

for %%i in (*.sql) do (
    psql --echo-errors -U %USERID% -d %DBNAME% -h %HOST% -p %PORT% -f %%i >> %logfile% 2>&1

)

popd