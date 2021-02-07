# 概要

# 使い方
## テーブル初期化
1. testDBフォルダを任意のディレクトリにダウンロードする。
2. xlsxファイルを作成または編集する。
3. run.batをダブルクリックして実行する。

## データ取得 (ダンプ)
1. testDBフォルダを任意のディレクトリにダウンロードする。
2. selectData.batをダブルクリックして実行する。


# 構成
## バッチファイル
|ファイル名|説明|
|--|--|
|xlsx2csv.ps1|table_xlsxフォルダに格納されたxlsxファイルをcsvファイルに変換してtable_csvフォルダに格納。|
|csv2sql.ps1|csvフォルダに格納されたcsvファイルを元にsqlファイルを作成し、insertData, deleteData, selectDataに格納。|
|insertData.bat|insertDataフォルダに格納されたsqlファイルを実行し、DBの初期化を実行する。_localはローカルホストのDBに対して実行。|
|deleteData.bat|deleteDataフォルダに格納されたsqlファイルを実行し、DBのデータ削除を実行する。_localはローカルホストのDBに対して実行。|
|selectData.bat|selectDataフォルダに格納されたsqlファイルを実行し、DBのデータ取得を実行し、dumpフォルダにテーブルごとのcsvファイルとして格納。|
|updateSKJ.bat|T_CM90_SKJテーブルの日付カラムを実行日の日付に更新。|
|run.bat|table_xlsxフォルダに格納されたxlsxファイルを元に、DBの初期化を実行。既存データの全削除、初期化データの全挿入、日付データの更新をlocalhostのDBに対して実行。|

## ディレクトリ構成
|ディレクトリ|説明|
|--|--|
|batch|バッチファイルを格納。|
|table_csv|テーブル初期化情報のxlsxファイルを格納。バッチにより生成。|
|table_xlsx|テーブル初期化情報のxlsxファイルを格納。ユーザの編集領域。|
|(insert)Data| SQLファイルを格納。|
|dump|selectData.batにより取得したテーブル情報。|
|log|insertData.bat実行時のログファイル。|

## 格納ファイル
- testDB
    - batch
        - xlsx2csv.ps1
        - csv2sql.ps1
        - insertData.bat
        - deleteData.bat
        - selectData.bat
        - run.bat
    - table_csv
        - table1.csv
        - table2.csv
    - table_xlsx
        - table1.xlsx
        - table2.xlsx
    - insertData
        - table1.sql
        - table2.sql
    - deleteData
         - table1.sql
         - table2.sql
    - selectData
        - table1.sql
        - table2.sql
    - dump
        - table1.csv
        - table2.csv
    - log
        - log_yyyyMMddHHmmss.txt

# 注意点
## テーブル初期化ファイルに関して
- 新たなテーブルにデータを追加するときは、xlsxファイルを新規作成してtable_xlsxフォルダに格納し、run.batを実行する。
- ファイル名は"テーブル名.xlsx"とする。ファイル名を使用してSQLを構築するため、厳密に一致している必要がある。
- データの自動編集を防止するために、xlsxファイルのデータ形式は文字列とする。

## テーブル初期化ファイルのデータに関して
- 空文字は%{empty}と記述する。
- NULL値は%{null}と記述する。


## テーブル初期化処理実行時に関して
- 該当するログファイルを確認し、エラーがないことを確認する。
