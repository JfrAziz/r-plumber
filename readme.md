# R Plumber API Templates

## Features

This repository is a boilerplate to setup a new project with R plumber. You can use or customize the code provided in this repository for your own purposes. The features included in this templates are:

| Features                   | Implemented | Description                                                                                                                                                                          |
| -------------------------- | :---------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Logging                    |     ✅      | Better way to log any incoming request to stdout and file with `logger` package                                                                                                      |
| Error Handling             |     ✅      | Proper & simple error handling with custom HTTP Response code                                                                                                                        |
| File Based Routing         |     ✅      | Auto mount route file from `routes` dir with file name based endpoint                                                                                                                |
| Dynamic Filter/Miiddleware |   Not Yet   | Add custom filter / middleware each mounted route from `routes` dir                                                                                                                  |
| Request Validation         |     ✅      | Simple validation mechanism to check incoming request from request body / params, such as required fields, check type (number, boolean, array), check the value in given array, etc. |
| Docker                     |     ✅      | Simplifying apps with docker, for better development, deployment, dependencies management, and scaling                                                                               |
| Multiprocessing            |   Not Yet   | R only run a request at a time, make it multiple processing with `promises` and `future` packages.

## How to use it

To use this templates, you must have Docker installed, I am prefer using docker because it's simple and can run anywhere, just build and run. If you not using docker you can run it manullay from `Rstudio` or any IDE you like by using this command `Rscript app.R` in the project dir, and make sure you have installed all the dependecies / packages before running it.

```bash
docker build -t "r-plumber:latest" .

docker run -d --name "r-plumber" -e "HOST=0.0.0.0" -p 8000:8000 r-plumber:latest 
```

> Note that, if you made changes to your project, you must restart the container or running it again.

### Routing

To create a new route or endpoint, just create a `*.R` file in `routes` dir with `roxygen2` like comment or annotation like this.

```r
# routes/example-route.R

#* Return a message
#* @param msg The message to echo
#* @serializer unboxedJSON
#* @get /
function(msg="") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Return a hello message
#* @serializer unboxedJSON
#* @get /hello
function(msg="") {
  list(msg = 'Hallo from /hello endpoint')
}
```

And this will generate `GET /example-route/` and `GET /example-route/hello` endpoint. Read more about it from the [docs](https://www.rplumber.io/)

### Request Validation

We validate the request using custom function from [`helpers/validator.R`](./helpers/validator.R), you can take a look to the example in this endpoint  [`routes/validation.R`](./routes/validation.R)

## Last...

Happy coding...