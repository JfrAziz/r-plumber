test_that("GET /health-check : API is running", {
  # Send API request
  req <- httr::GET(paste0("http://", HOST), port = PORT, path = "/health-check")

  # Check response
  expect_equal(req$status_code, 200)

  expect_equal(jsonlite::fromJSON(httr::content(req, 'text', "UTF-8"))$message, "R Service is running...")
})

test_that("GET /no-route : return 404", {
  # Send API request
  req <- httr::GET(paste0("http://", HOST), port = PORT, path = "/no-route")

  # Check response
  expect_equal(req$status_code, 404)

  expect_equal(jsonlite::fromJSON(httr::content(req, 'text', "UTF-8"))$error, "404 - Resource Not Found")

  # another method to check the response
  expect_equal(
    jsonlite::toJSON(httr::content(req, encoding = "UTF-8", as = "parsed"), auto_unbox = TRUE),
    jsonlite::toJSON(list(error = "404 - Resource Not Found"), auto_unbox = TRUE)
  )
})
