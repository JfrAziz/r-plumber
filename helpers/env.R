# load env variables
HOST <- Sys.getenv("HOST", "127.0.0.1")

PORT <- strtoi(Sys.getenv("PORT", 8000))

WORKERS <- strtoi(Sys.getenv("WORKERS", 3))