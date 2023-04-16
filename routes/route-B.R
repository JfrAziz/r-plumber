#* Echo back the input route-a files
#* @param msg The message to echo
#* @get /hello/<id>
function(msg="", id) {
  list(msg = paste0("The message is from route-A files: '", msg,id, "'"))
}