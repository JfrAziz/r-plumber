ARG R_VERSION=latest
FROM rocker/r-ver:${R_VERSION}

# install dependency
RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev \
  curl \
  libsodium-dev \
  libxml2-dev \
  && rm -rf /var/lib/apt/lists/*

# install R packages
RUN install2.r --error --skipinstalled --ncpus -1 \
  remotes \
  && rm -rf /tmp/downloaded_packages

# install r-plumber
ARG PLUMBER_REF=main
RUN Rscript -e "remotes::install_github('rstudio/plumber@${PLUMBER_REF}')"

RUN Rscript -e "install.packages(c('logger','tictoc', 'fs'))"

# setup workspace
COPY . /app

WORKDIR /app

ENTRYPOINT ["Rscript"]

CMD ["app.R"]

EXPOSE 8000