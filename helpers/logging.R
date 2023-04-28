library('logger')
library('tictoc')

# write logs to file
log_dir <- "logs"
if (!fs::dir_exists(log_dir)) fs::dir_create(log_dir)
log_appender(appender_tee(tempfile(paste0("plumber_", Sys.time(), "_"), log_dir, ".log")))

# transoform empty value to -
convert_empty <- function(string = "") {
  if (is.null(string)) return("-")
  if (string == "") return("-")
  return(string)
}

pre_route_logging <- function(req) {
  tictoc::tic(msg = req$PATH_INFO)
}

post_route_logging <- function(req, res) {
  end <- tictoc::toc(quiet = TRUE) # nolint
  
  log_info(sprintf('%s "%s" %s %s %s %s %s', 
    convert_empty(req$REMOTE_ADDR),
    convert_empty(req$HTTP_USER_AGENT),
    convert_empty(req$HTTP_HOST),
    convert_empty(req$REQUEST_METHOD),
    convert_empty(end$msg),
    convert_empty(res$status),
    round(end$toc - end$tic, digits = getOption("digits", 5))
  )) # nolint
}