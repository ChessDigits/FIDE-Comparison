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


#### data prep ####
remove_username <- function(df)
{
  if(any(duplicated(df$username))) stop("Duplicated usernames found.")
  df <- df[!colnames(df) %in% "username"]
  
  # out
  print("Removed column 'username'")
  return(df)
}