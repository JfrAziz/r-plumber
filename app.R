library(plumber)

# App initialization and settings for warning, trailing slash
app <- pr()
options(warn = -1)
options_plumber(trailingSlash = TRUE)

# Simple Routes
app %>%
  pr_get("/", function(req, res){
    return(list(message = "Welcome R Services"))
  }, serializer = plumber::serializer_unboxed_json())

# run plumber
app %>%
  pr_run(port = 8000)