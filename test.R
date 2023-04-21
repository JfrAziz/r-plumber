library(testthat)

options(warn = -1)

# Setup by starting APIs
HOST <- Sys.getenv("HOST", "0.0.0.0")

PORT <- strtoi(Sys.getenv("PORT", 8000))

WAIT_TIME <- strtoi(Sys.getenv('WAIT_TIME', 5)) # second

# wait until the API is running
Sys.sleep(WAIT_TIME)

test_dir('test', reporter = MultiReporter$new(c(
  LocationReporter$new(), 
  CheckReporter$new()
)))