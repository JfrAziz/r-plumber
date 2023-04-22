source("../helpers/error.R")
source("../helpers/validator.R")

test_that("VALIDATOR : checkRequired function", {
  expect_condition(
    checkRequired(
      list(data = c()), 
      c("params")), 
    class = "api_error"
  )
  
  expect_condition(
    checkRequired(
      list(
        "params1" = "example value"
      ), 
      c("params1", "params2")), 
    class = "api_error"
  )
  
  expect_no_condition(
    checkRequired(
      list(
        "params1" = "example value",
        "params2" = "example value"
      ), 
      c("params1")), 
    class = "api_error"
  )
  
  expect_no_condition(
    checkRequired(
      list(
        "params1" = "example value",
        "params2" = "example value"
      ), 
      c()), 
    class = "api_error"
  )
})


test_that("VALIDATOR : checkData function", {
  expect_condition(checkData(c()), class = "api_error")
  
  expect_condition(checkData(c("column1", "column2")), class = "api_error")
  
  expect_condition(checkData("string instead"), class = "api_error")
  
  expect_no_condition(checkData(iris), class = "api_error")
})


test_that("VALIDATOR : checkArray function", {
  expect_condition(checkArray(c()), class = "api_error")
  
  expect_no_condition(checkArray("string instead"), class = "api_error")
  
  expect_vector(checkArray("string instead"), size = 1)
  
  expect_condition(checkArray(iris), class = "api_error")
  
  expect_no_condition(checkArray(c(1, 2, 4, 5)), class = "api_error")
})


test_that("VALIDATOR : checkVector function", {
  expect_equal(checkVector(c()), c())
  
  expect_equal(checkVector(iris), c())
  
  expect_equal(checkVector(c(NULL)), c())
  
  expect_vector(checkVector(c(NA, 1, 3, 4, NULL)), size = 3)
  
  expect_vector(checkVector(c(2, 1, 3, 4, 5)), size = 5)
})


test_that("VALIDATOR : checkFormula function", {
  expect_condition(checkFormula(c()), class = "api_error")
  
  expect_condition(checkFormula("random string"), class = "api_error")
  
  expect_no_condition(checkFormula("y ~ x1 + x2"), class = "api_error")
  
  expect_s3_class(checkFormula("y ~ x1 + x2"), "formula")
  
  expect_no_condition(checkFormula("y ~ x1 + x2 ~ 123"), class = "api_error")
})


test_that("VALIDATOR : checkNumber function", {
  expect_condition(checkNumber(c()), class = "api_error")
  
  expect_condition(suppressWarnings(checkNumber("random string")), class = "api_error")
  
  expect_equal(checkNumber("123"), 123)
  
  expect_equal(checkNumber(0), 0)
  
  expect_equal(checkNumber(123), 123)
  
  expect_equal(checkNumber("1e5"), 1e5)
})


test_that("VALIDATOR : checkInArray function", {
  expect_condition(checkInArray("Value 1", c("value 1")), class = "api_error")
  
  expect_condition(checkInArray("value 2", c("value 1")), class = "api_error")
  
  expect_equal(checkInArray("value 2", c("value 1", "value 2")), "value 2")
  
  expect_condition(checkInArray("value 3", c("value 1", "value 2")), class = "api_error")
  
  expect_condition(checkInArray(c("value 1", "value 2"), c("value 1", "value 2")), class = "api_error")
})


test_that("VALIDATOR : checkBoolean function", {
  expect_equal(checkBoolean("TRUE"), TRUE)
  
  expect_equal(checkBoolean("TrUe"), TRUE)
  
  expect_equal(checkBoolean("true"), TRUE)
  
  expect_equal(checkBoolean(1), TRUE)
  
  expect_equal(checkBoolean("FALSE"), FALSE)
  
  expect_equal(checkBoolean("FaLsE"), FALSE)
  
  expect_equal(checkBoolean("false"), FALSE)
  
  expect_equal(checkBoolean(0), FALSE)
  
  expect_condition(checkBoolean("random string"), class = "api_error")
})


test_that("VALIDATOR : setMaxNumber function", {
  expect_equal(setMaxNumber(1, 2), 1)
  
  expect_equal(setMaxNumber(2, 2), 2)
  
  expect_equal(setMaxNumber(3, 2), 2)
})