library(future)
library(promises)

future::plan(future::multisession(workers = WORKERS))

log_info(paste0("Plumber will use ", WORKERS, " workers"))