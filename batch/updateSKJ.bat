@echo off

set USERID=user
set DBNAME=database
set HOST=192.168.10.60
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

set TABLE = T_CM90_SKJ_M

for %%i in (CM90_SKJ_FMYMD CM90_SKJ_TOYMD) do (
    psql --echo-errors -U %USERID% -d %DBNAME% -h %HOST% -p %PORT% -c  "UPDATE %TABLE% SET %%i='%yy%%mm%%dd%';" >> %logfile% 2>&1
)
