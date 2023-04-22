test_that("POST /validation/validate : validation success", {
  # Send API request
  req <- httr::POST(paste0("http://", HOST), port = PORT, path = "/validation/validate",
    encode = "json",
    body = jsonlite::fromJSON('
      {
        "boolean": true,
        "max_number": 40,
        "number_value": 123,
        "in_array": "setosa",
        "formula": "y ~ x1 + x2",
        "number_list": [1, 2, 3, 4],
        "with_null_list": [1, null, 3, "hallo"],
        "data": [
          {
            "columnA": 10,
            "columnB": 20
          },
          {
            "columnA": 30,
            "columnB": 40
          }
        ]
      }
    ')
  )

  # Check response
  expect_equal(req$status_code, 200)
})

test_that("POST /validation/validate : validation failed when required params does not exist", {
  # Send API request
  req <- httr::POST(paste0("http://", HOST), port = PORT, path = "/validation/validate",
    encode = "json",
    body = jsonlite::fromJSON('
      {
        "boolean": true
      }
    ')
  )

  # Check response
  expect_equal(req$status_code, 400)
})