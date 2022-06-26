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

# Shiny app tests
context("Shiny App Tests")

app <- ShinyDriver$new("../../app.R")
testthat::test_that('app operation', {
  expect_identical(app$getTitle(), "China vs. USA Pop.")
  expect_identical(app$getUrl(), "http://0.0.0.0:8080/")
})
app$stop()

