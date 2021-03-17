"
17.03.2021

FIDE Comparison
Using data from:
https://github.com/EthanLebowitz/ChessData/blob/master/FIDEreportedLichess.csv

fn
"

#### imports ####
library(h2o)


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


#### train test ####
ttsplit <- function(df, prop_train=.7)
{
  df_split <- list()
  ix <- sample(nrow(df), round(nrow(df)*prop_train), replace=F)
  df_split$train <- df[ix,]
  df_split$test <- df[-ix,]
  print(paste0("Split df into list with: train, test (proportion train = ", prop_train, ")"))
  return(df_split)
}


#### h2o ####
init_h2o <- function(nthreads=c("minus1", "half", "all"))
{
  "
  input: nthreads
  init h2o cluster (no output)
  "
  # get input
  nthreads <- match.arg(nthreads)
  
  # thread options
  nthreads_values <- list(half=parallel::detectCores() / 2, all=-1)
  nthreads_values <- c(nthreads_values, list(minus1=nthreads_values$half*2-1))
  
  # shutdown
  try({
    print("Shutting down any previous h2o clusters")
    h2o.shutdown(F)
    Sys.sleep(2)
  }, silent=TRUE)
  
  # init
  nthreads <- nthreads_values[[nthreads]]
  h2o.init(nthreads=nthreads, max_mem_size = paste0(floor(.7*16), "g"))
  
}