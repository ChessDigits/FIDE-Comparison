"
17.03.2021

FIDE Comparison
Using data from:
https://github.com/EthanLebowitz/ChessData/blob/master/FIDEreportedLichess.csv

fn
"

#### load data ####
load_data <- function(local=FALSE)
{
  if(!local) fpath <- "https://raw.githubusercontent.com/ChessDigits/FIDE-Comparison/develop/FIDEreportedLichess.csv"
  if(local) stop("Local file reading not implemented")
  df <- read.csv(fpath)
  return(df)
}