#!/usr/bin/env Rscript

library(dplyr)

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

