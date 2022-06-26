#!/usr/bin/env Rscript

library(dplyr)

source("helpers.R")

china_pop <- read_data("data/China/china_population.csv")
usa_pop <- read_data("data/USA/population_usa.csv")

# check nulls
check_null(china_pop)
check_null(usa_pop)

usa_china_pop <-
  merge_dfs(usa_pop, china_pop, "Year", c(".USA", ".China"))

# check nulls
check_null(usa_china_pop)
