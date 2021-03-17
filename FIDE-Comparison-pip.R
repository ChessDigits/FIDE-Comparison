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
tt_h2o <- ship_train_and_test_to_h2o(tt)
automl <- get_automl_model(config, tt_h2o)
tt <- add_predictions_from_automl(automl, tt, tt_h2o, add_confidence_level = F)
