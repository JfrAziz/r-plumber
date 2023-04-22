# check all attributes are exist in data object
# send bad_request error if one of the attributes is 
# not exist
checkRequired <- function(data, attributes = c()) {
    lapply(attributes, function(attribute) {
        if (!exists(attribute, data)) bad_request(paste0(attribute, " is required"))
    })
}

# check the value is a data (array of object in js)
# and the length is not 0 or empty. the function alse
# return the data.
checkData <- function(data, attributeName = "data") {
    if (!is.list(data) || length(data) == 0) bad_request(paste0(attributeName, " must be an array and not empty"))
    return(data)
}

# check the value is array, e.g [1,2,3,4,5], not [] and 
# will return the array, throw error otherwise. 
checkArray <- function(data, attributeName = "data") {
    if (!is.vector(data) || length(data) == 0) bad_request(paste0(attributeName, " must be an array and not empty"))
    return(data)
}

# check the value is array, and give empty array 
# if the value is not a array, invalid, or NULL
checkVector <- function(data = c()) {
  if (!is.vector(data) || is.list(data)) return(c())

  data <- data[!is.na(data)]

  if (length(data) == 1 && !nzchar(data[1])) return(c())

  return(data[nzchar(data)])
}

# check the value is string and is in formula format
# e.g y~x1+x2 etc, and return it as a R formula. throw error otherwise
checkFormula <- function(formula, attributeName = "formula") {
    tryCatch({
        parsedValue <- as.formula(formula)
        
        if (!inherits(parsedValue, "formula")) stop("not valid formula")

        if (length(parsedValue) == 0) stop("not valid formula")
        
        return(parsedValue)
    },
    error = function(error) bad_request(paste0(attributeName, " is not valid, example: y~x1+x2..."))
    )
}

# check the value is a number or numeric, give back the value.
# throw error if the value is not a number
checkNumber <- function(value, attributeName = "number") {
    if (length(value) == 0) bad_request(paste0(attributeName, " is not number"))

    parsedValue <- as.numeric(value)

    if (!is.numeric(parsedValue) || is.na(parsedValue)) bad_request(paste0(attributeName, " is not number"))
    
    return(parsedValue)
}

# check if the value exist in the given array.
# example is 3 exist in [3,4,5,6]?
checkInArray <- function(value, array) {
    if (length(value) != 1) bad_request(paste0(value, " is not single value"))

    if (!(value %in% array)) bad_request(paste0(value, " is not in: ", paste0(array, collapse = ", ")))
    return(value)
}

# check the value is in boolean, e.g FALSE, false, 
# TRUE, true, 0, 1, etc. return back the boolean value
checkBoolean <- function(value) {
    if (!(tolower(value) %in% c("true", "false", 1, 0))) bad_request(paste0(value, " is not valid boolean"))
    return(tolower(value) == "true" || tolower(value) == 1)
}


# set the maximum number of the given value.
# setMaxNumber(4, 3) -> 3
setMaxNumber <- function(value, max){
    if(value < max) return(value)
    return(max)
}