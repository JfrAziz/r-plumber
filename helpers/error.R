api_error <- function(message, status) {
    err <- structure(
        list(message = message, status = status),
        class = c("api_error", "error", "condition")
    )
    signalCondition(err)
}

error_handler <- function(req, res, err) {
    if (!inherits(err, "api_error")) {
        log_error("500 {convert_empty(err$message)}") # nolint
        res$status <- 500
        body <- list(
            code = 500,
            message = "Internal server error"
        )
    } else {
        log_error("{err$status} {convert_empty(err$message)}") # nolint
        res$status <- err$status
        body <- list(
            code = err$status,
            message = err$message
        )
    }
    return(body)
}

# Custom error handler for HTTP Response code

# 400 BAD REQUEST
bad_request <- function(message = "Somethings wrong") {
    return(api_error(message = message, status = 400))
}

# 404 NOT FOUND
not_found <- function(message = "Resource Not Found") {
    return(api_error(message = message, status = 404))
}