#* Endpoint with custom filter enabled 
#* @serializer unboxedJSON
#* @get /
function(req, res) {
  return(list(message = "Custom Filter is enable in this endpoint"))
}

#* Another Endpoint with custom filter enabled 
#* @serializer unboxedJSON
#* @get /test
function(req, res) {
  return(list(message = "Custom Filter is enable in this endpoint"))
}


#* @plumber
function(pr) {
  pr %>%
    pr_filter("custom-filter", function(req, res) {
      log_info("CUSTOM FILTER CALLED")
      plumber::forward()
    })
}