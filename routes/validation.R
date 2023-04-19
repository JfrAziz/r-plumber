#* Test Post Param With Validation
#* @serializer unboxedJSON
#* @post /validate
function(req, res) {
  # check all the parameters exist in
  # request body
  checkRequired(req$body, c(
    "boolean",
    "max_number",
    "number_value",
    "in_array",
    "formula",
    "number_list",
    "with_null_list",
    "data"
  ))

  # now validate all the params one by one.

  # check the boolean params is truly a boolean
  # TRUE, TrUe, false, 0, 1 is acceptable
  boolVar <- checkBoolean(req$body$boolean)

  # check numeric value and maximum value.
  # before set the maximum value, we need to 
  # validate if the params is a number
  numberVar <- checkNumber(req$body$number_value, "number_value")
  maxNumberVar <- setMaxNumber(checkNumber(req$body$max_number, "max_number"), 50)

  # the value must exist in the given array
  inArrayVar <- checkInArray(req$body$in_array, c('setosa', 'versicolor', 'virginica'))

  # the value must be a R formula format
  formulaVar <- checkFormula(req$body$formula, "Formula")

  # check the value is an array
  numberListVar <- checkArray(req$body$number_list, "number_list")

  # sanitize the value to an array and remove the 
  # NULL value.
  withNullListVar <- checkVector(req$body$with_null_list)
  
  # check the values is a data, which is a array of object in
  # json. 
  dataVar <- checkData(req$body$data, "data")

  # now you can use all the request params safely
  # for your need. in this example, I just return it back

  return(list(
    boolean = boolVar,
    max_number = maxNumberVar,
    number_value = numberVar,
    in_array = inArrayVar,
    formula = deparse1(formulaVar),
    number_list = numberListVar,
    with_null_list = withNullListVar,
    data = dataVar
  ))
}