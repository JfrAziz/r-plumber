#* Endpoint with custom filter filter enabled 
#* @serializer unboxedJSON
#* @get /
function(req, res) {
  return(list(message = "Custom Filter is disable in this endpoint"))
}

#* Another Endpoint with custom filter filter enabled 
#* @serializer unboxedJSON
#* @get /test
function(req, res) {
  return(list(message = "Custom Filter is enable in this endpoint"))
}
