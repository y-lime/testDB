<#
引数：
処理：csvファイルをsqlファイルに変換する。
#>

<#
insert用関数
引数：csvファイルのフルパス
処理：csvファイルからinsertのsqlを構築する。
#>
function csv2insertsql($file)
{
    $table = [System.IO.Path]::GetFileNameWithoutExtension($file)
    $outfile = "..\insertData\" + $table + ".sql"
    $columns = 
    $values = 
    $row_cnt = 0
    foreach($row in Get-Content $file)
    {
        if($row_cnt -eq 0){
            $columns = $row
            Write-Output '\encoding SJIS' > $outfile
        }else{
            $values = $row
            $values = $values -replace ",", "','"
            $values = $values -replace "^", "'"
            $values = $values -replace "$", "'"
            $values = $values -replace "%{empty}", ""
            $values = $values -replace "'%{null}'", "NULL"
            Write-Output "INSERT INTO ${table} (${columns}) VALUES (${values});" >> $outfile
        }
        $row_cnt = $row_cnt + 1
    }
}

<#
delete用関数
引数：csvファイルのフルパス
処理：csvファイルからdeleteのsqlを構築する。
#>
function csv2deletesql($file)
{
    $table = [System.IO.Path]::GetFileNameWithoutExtension($file)
    $outfile = "..\deleteData\" + $table + ".sql"

    Write-Output '\encoding SJIS' > $outfile
    Write-Output "DELETE FROM ${table};" >> $outfile
}

<#
select用関数
引数：csvファイルのフルパス
処理：csvファイルからselectのsqlを構築する。
#>
function csv2selectsql($file)
{
    $table = [System.IO.Path]::GetFileNameWithoutExtension($file)
    $outfile = "..\selectData\" + $table + ".sql"

    Write-Output '\encoding SJIS' > $outfile
    Write-Output "SELECT * FROM ${table};" >> $outfile
}

<#
メインルーチン
#>
$csv_folder = "..\table_csv\"
$insert_folder = "..\insertData\"
$delete_folder = "..\deleteData\"
$select_folder = "..\selectData\"

# csvフォルダが存在しない場合、エラー
if(!(Test-Path $csv_folder))
{
    Write-Output [ERROR]csv folder does not exist. `"$csv_folder`"
    exit
}

# insertDataフォルダが存在しない場合、新規作成
if(!(Test-Path $insert_folder))
{
    New-Item $insert_folder -ItemType Directory
}

# insertDataフォルダが存在しない場合、新規作成
if(!(Test-Path $delete_folder))
{
    New-Item $delete_folder -ItemType Directory
}

# selectDataフォルダが存在しない場合、新規作成
if(!(Test-Path $select_folder))
{
    New-Item $select_folder -ItemType Directory
}

Write-Output "**********  TABLE  **********"

# csvフォルダ直下のcsvファイルに対してsql変換処理を実行
ForEach($file in (Get-ChildItem $csv_folder -Filter *.csv))
{
    csv2insertsql $file.FullName
    csv2deletesql $file.FullName
    csv2selectsql $file.FullName
    Write-Output $file.BaseName
}

Write-Output "*****************************"
