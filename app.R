library(plumber)

# load required helpers
source("./helpers/error.R")
source("./helpers/logging.R")

# App initialization and settings for warning, trailing slash
app <- pr()
options(warn = -1)
options_plumber(trailingSlash = TRUE)

# Plumbber settings
app %>%
  pr_set_error(error_handler) %>%
  pr_hooks(list(preroute = pre_route_logging, postroute = post_route_logging))

# Simple Routes
app %>%
  pr_get("/", function(req, res){
    log_warn("CUSTOM WARNING...")
    return(list(message = "Welcome R Services"))
  }, serializer = plumber::serializer_unboxed_json()) %>%
  pr_get("/error", function(req, res){
    log_error("CUSTOM ERROR LOG...")
    api_error("ERROR MESSAGE FROM HELPERS", 400)
  }, serializer = plumber::serializer_unboxed_json()) %>%
  pr_get("/default-error", function(req, res){
    stop("DEFAULT ERROR")
  }, serializer = plumber::serializer_unboxed_json())

# run plumber
app %>%
  pr_run(host = '0.0.0.0' ,port = 8000)