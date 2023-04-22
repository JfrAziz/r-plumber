test_that("POST /data/summary : test summary data with empty data", {
  # Send API request
  req <- httr::POST(paste0("http://", HOST), port = PORT, path = "/data/summary",
    body = jsonlite::toJSON(list(
      data = c()
    ))
  )

  # Check response
  expect_equal(req$status_code, 400)

  expect_equal(jsonlite::fromJSON(httr::content(req, 'text', "UTF-8"))$message, "data must be an array and not empty")
})