"
17.03.2021

FIDE Comparison
Using data from:
https://github.com/EthanLebowitz/ChessData/blob/master/FIDEreportedLichess.csv

pip
"

df <- load_data()
df <- remove_username(df)
tt <- ttsplit(df)
init_h2o()
