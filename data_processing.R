#!/usr/bin/env Rscript

library(dplyr)

source("helpers.R")

china_pop <- read.csv("data/China/china_population.csv")
usa_pop <- read.csv("data/USA/population_usa.csv")
china_forecast <- read.csv("data/China/china_population_forecast.csv")
usa_forecast <- read.csv("data/USA/population_usa_forecast.csv")

usa_china_pop <-
  merge_dfs(usa_pop, china_pop, "Year", c(".USA", ".China"))

usa_china_for <-
  merge_dfs(usa_forecast, china_forecast, "Year", c(".USA", ".China"))
