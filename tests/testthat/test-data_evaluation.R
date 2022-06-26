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

china_pop <- read.csv("../../data/China/china_population.csv")
usa_pop <- read.csv("../../data/USA/population_usa.csv")
china_forecast <- read.csv("../../data/China/china_population_forecast.csv")
usa_forecast <- read.csv("../../data/USA/population_usa_forecast.csv")

usa_china_pop <-
  merge_dfs(usa_pop, china_pop, "Year", c(".USA", ".China"))

usa_china_for <-
  merge_dfs(usa_forecast, china_forecast, "Year", c(".USA", ".China"))

# Data tests
context('Data Integrity Tests')

testthat::test_that('data type', {
  expect_is(china_pop,'data.frame')
  expect_is(usa_pop,'data.frame')
  expect_is(usa_china_pop,'data.frame')
  expect_is(china_forecast,'data.frame')
  expect_is(usa_forecast,'data.frame')
  expect_is(usa_china_for,'data.frame')
})

testthat::test_that('data dimensions', {
  expect_equal(ncol(china_pop), 13)
  expect_equal(nrow(china_pop), 18)
  expect_equal(ncol(usa_pop), 13)
  expect_equal(nrow(usa_pop), 18)
  expect_equal(ncol(usa_china_pop), 25)
  expect_equal(nrow(usa_china_pop), 18)
  expect_equal(ncol(china_forecast), 13)
  expect_equal(nrow(china_forecast), 7)
  expect_equal(ncol(usa_forecast), 13)
  expect_equal(nrow(usa_forecast), 7)
  expect_equal(ncol(usa_china_for), 25)
  expect_equal(nrow(usa_china_for), 7)
})

testthat::test_that('missing values', {
  expect_identical(china_pop, na.omit(china_pop))
  expect_identical(usa_pop, na.omit(usa_pop))
  expect_identical(usa_china_pop, na.omit(usa_china_pop))
  expect_identical(china_forecast, na.omit(china_forecast))
  expect_identical(usa_forecast, na.omit(usa_forecast))
  expect_identical(usa_china_for, na.omit(usa_china_for))
})

for (i in c(china_pop, usa_pop, usa_china_pop, china_forecast, usa_forecast, usa_china_for)){
  for (ii in colnames(i)){
    testthat::test_that('column data types', {
      checkArgClassValue(i[[ii]], expected.class = c('integer', 'numeric'))
    })
  }
}
