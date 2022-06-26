#!/usr/bin/env Rscript

library(dplyr)

# read data
#
# @param path
#
# @return dataframe
read_data <- function(path) {
  df <- read.csv(path)
  return(df)
}

# check if there is any null
#
# @param x
#
# @return int
check_null <- function(x) {
  sum(is.null(x))
}

# merge dataframes
#
# @params df1, df2, key, suffixes
#
# @return dataframe
merge_dfs <- function(df1, df2, key, suffixes) {
  merged_dfs <- merge(
    x = df1,
    y = df2,
    by = key,
    all = TRUE,
    suffixes = suffixes
  )
  return(merged_dfs)
}
