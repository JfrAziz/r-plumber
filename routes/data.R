#* Get Iris Dataset
#* @serializer unboxedJSON
#* @get /iris
function(req, res) {
  return(list(data = iris))
}

#* Return the columns of data
#* @serializer unboxedJSON
#* @post /columns
function(res, req) {
  checkRequired(req$body, c("data"))

  reqData <- checkData(req$body$data)
  
  return(list(
    message = "column from data",
    data = colnames(reqData)
  ))
}

#* Filter a data by columns name
#* @serializer unboxedJSON
#* @post /select
function(res, req) {
  checkRequired(req$body, c("data", "columns"))
  
  reqData <- checkData(req$body$data)
  
  columns <- checkArray(req$body$columns, "columns")

  colomnsOfReqData <- colnames(reqData)

  for (i in seq_along(columns)) {
    checkInArray(columns[i], colomnsOfReqData)
  }

  return(list(
    message = "filtered data",
    data = reqData[columns]
  ))
}

#* Merge or join 2 data by a column
#* @serializer unboxedJSON
#* @post /join
function(res, req) {
  checkRequired(req$body, c("data_x", "data_y", "by"))
    
  data_x <- checkData(req$body$data_x)
  
  data_y <- checkData(req$body$data_y)

  byColumn <- req$body$by

  return(list(
    message = "merged data",
    data = merge(x = data_x, y = data_y, by = byColumn)
  ))
}

#* Return summary data from psych package, data contain n, mean, sd, min, max, range, and se
#* @serializer unboxedJSON
#* @post /summary
function(res, req) {
  checkRequired(req$body, c("data"))

  reqData <- checkData(req$body$data)
  
  return(list(
      message = "summary data from psych package",
      data = psych::describe(reqData, fast = TRUE)
  ))
}