<#
引数：
処理：xlsxファイルをcsvファイルに変換する。
#>

$xlsx_folder = "..\table_xlsx"
$csv_folder = "..\table_csv"

# Excelのハンドル取得
$excel = New-Object -ComObject Excel.Application

# 上書きの際に確認しない
$excel.DisplayAlerts=$FALSE


# xlsxフォルダが存在しない場合、終了
if(!(Test-Path $xlsx_folder))
{
    Write-Output [ERROR]フォルダが存在しません。`"$xlsx_folder`"
    exit
}

# csvフォルダが存在しない場合、新規作成
if(!(Test-Path $csv_folder))
{
    New-Item $csv_folder -ItemType Directory
}

# xlsxフォルダ直下のxlsxファイルに対してcsv変換処理を実行
ForEach($file in (Get-ChildItem $xlsx_folder -Filter *.xlsx))
{
    # ブックを開く
    $Workbook = $excel.Workbooks.Open($file.Fullname)
    # ファイル名を修正
    $newName = ($file.Fullname).Replace($file.Extension,".csv").Replace("_xlsx","_csv")
    # csvとして保存する
    $Workbook.SaveAs($newName,6)
    # ブックを閉じる
    $Workbook.Close($false)
}

#excelをクローズ
$excel.quit()
