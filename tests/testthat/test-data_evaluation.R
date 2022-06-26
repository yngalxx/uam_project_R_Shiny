library(usethis)
library(devtools)

source("app.R")


testthat::test_that("check nulls", {
  testthat::expect_equal(check_null(c(3, 7, 1, 5, 2, 8)), 0)
})

file_path <- "data/China/china_population.csv"
df_test <- read.csv(file_path)
testthat::test_that("read data", {
  testthat::expect_identical(read_data(file_path), df_test)
})

file_path2 <- "data/USA/population_usa.csv"
df_test2 <- read.csv(file_path2)
merge_test <- merge(
  x = df_test,
  y = df_test2,
  by = "Year",
  all = TRUE,
  suffixes = c(".USA", ".China")
)
testthat::test_that("merge dataframes", {
  testthat::expect_identical(merge_dfs(
    df_test, df_test2, "Year",
    c(".USA", ".China")
  ), merge_test)
})
