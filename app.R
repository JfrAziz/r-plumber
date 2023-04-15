library(plumber)

# load required helpers
source("./helpers/logging.R")

# App initialization and settings for warning, trailing slash
app <- pr()
options(warn = -1)
options_plumber(trailingSlash = TRUE)

# Plumbber settings
app %>%
  pr_hooks(list(preroute = pre_route_logging, postroute = post_route_logging))

# Simple Routes
app %>%
  pr_get("/", function(req, res){
    log_warn("CUSTOM WARNING...")
    return(list(message = "Welcome R Services"))
  }, serializer = plumber::serializer_unboxed_json())

# run plumber
app %>%
  pr_run(port = 8000)