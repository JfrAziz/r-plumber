library(plumber)

# load required helpers
source("./helpers/error.R")
source("./helpers/logging.R")
source("./helpers/validator.R")

# load env variables
HOST <- Sys.getenv("HOST", "127.0.0.1")
PORT <- strtoi(Sys.getenv("PORT", 8000))

# App initialization and settings for warning, trailing slash
app <- pr()
options(warn = -1)
options_plumber(trailingSlash = TRUE)

# Plumbber settings
app %>%
  pr_set_error(error_handler) %>%
  pr_hooks(list(preroute = pre_route_logging, postroute = post_route_logging))

r_routes_file_names = list.files(path = './routes' ,full.names=TRUE, recursive=TRUE)
for (file_name in r_routes_file_names) {
  routeName = substring(file_name, 10, nchar(file_name) - 2)
  app %>%
    pr_mount(routeName, pr(file_name) %>% pr_set_error(error_handler))
}

# run plumber
app %>%
  pr_run(host = HOST, port = PORT)