library(plumber)

# remove warning from logs
options(warn = -1)

# load required helpers
source("./helpers/env.R")
source("./helpers/error.R")
source("./helpers/logging.R")
source("./helpers/parallel.R")
source("./helpers/validator.R")

# App initialization
app <- pr()

# redirect to slashed endpoint, /hello to /hello/
options_plumber(trailingSlash = TRUE) 

# Plumbber settings
app %>%
  pr_set_error(error_handler) %>%
  pr_hooks(list(preroute = pre_route_logging, postroute = post_route_logging))

# 'file based' routing
r_routes_file_names = list.files(path = './routes' ,full.names=TRUE, recursive=TRUE)
for (file_name in r_routes_file_names) {
  routeName = substring(file_name, 10, nchar(file_name) - 2)
  app %>%
    pr_mount(routeName, pr(file_name) %>% pr_set_error(error_handler))
}

# run plumber
app %>%
  pr_run(host = HOST, port = PORT)