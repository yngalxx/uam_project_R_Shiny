#!/usr/bin/env Rscript

library(dplyr)

source("helpers.R")

china_pop <- read.csv("data/China/china_population.csv")
usa_pop <- read.csv("data/USA/population_usa.csv")

usa_china_pop <-
  merge_dfs(usa_pop, china_pop, "Year", c(".USA", ".China"))

