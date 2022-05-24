library(usethis)
library(devtools)

source('helper.R')

testthat::test_that('testing server', {
  testthat::expect_equal(check_null(c(3, 7, 1, 5, 2, 8)), 0)
})
