# Shiny app tests
context("Shiny App Tests")

app <- ShinyDriver$new("app.R")
testthat::test_that('app operation', {
  expect_identical(app$getTitle(), "China vs. USA Pop.")
  expect_identical(app$getUrl(), "http://0.0.0.0:8080/")
})
app$stop()

