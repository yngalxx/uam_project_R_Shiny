library(usethis)
library(devtools)
library(shinytest)

source("../../data_processing.R")

# Data tests
context('testing data integrity')

testthat::test_that('data type', {
  expect_is(china_pop,'data.frame')
  expect_is(usa_pop,'data.frame')
  expect_is(usa_china_pop,'data.frame')
})

testthat::test_that('missing values', {
  expect_identical(china_pop, na.omit(china_pop))
  expect_identical(usa_pop, na.omit(usa_pop))
  expect_identical(usa_china_pop, na.omit(usa_china_pop))
})

testthat::test_that('data dimensions', {
  expect_equal(ncol(china_pop), 13)
  expect_equal(nrow(china_pop), 18)
  expect_equal(ncol(usa_pop), 13)
  expect_equal(nrow(usa_pop), 18)
  expect_equal(ncol(usa_china_pop), 25)
  expect_equal(nrow(usa_china_pop), 18)
})

# Shiny app test
context("Test Shiny app")

app <- ShinyDriver$new("../../app.R")
app$stop()
