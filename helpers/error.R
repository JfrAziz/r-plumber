api_error <- function(message, status) {
    err <- structure(
        list(message = message, status = status),
        class = c("api_error", "error", "condition")
    )
    signalCondition(err)
}

error_handler <- function(req, res, err) {
    if (!inherits(err, "api_error")) {
        # log_error("{500} {convert_empty(err$message)}") # nolint
        print(err$message)
        res$status <- 500
        body <- list(message = "Internal server error")
    } else {
        # log_error("{err$status} {convert_empty(err$message)}") # nolint
        print(err$message)
        res$status <- err$status
        body <- list(message = err$message)
    }
    return(body)
}