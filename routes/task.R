#* fast endpoint without promise
#* @serializer unboxedJSON
#* @get /fast-without-promise
function(req, res) {
  return(list(message = "Fast without promise endpoint"))
}

#* fast endpoint with promise
#* @serializer unboxedJSON
#* @get /fast-with-promise
function(req, res) {
  future_promise({
    return(list(message = "Fast with promise endpoint"))
  })
}

#* slow endpoint without promise
#* @serializer unboxedJSON
#* @get /slow-without-promise
function(req, res) {
  Sys.sleep(10)
  return(list(message = "Slow without promise endpoint"))
}

#* slow endpoint with promise
#* @serializer unboxedJSON
#* @get /slow-with-promise
function(req, res) {
  future_promise({
    Sys.sleep(10)
    return(list(message = "Slow with promise endpoint"))
  })
}