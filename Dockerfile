FROM rocker/tidyverse

RUN Rscript -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN Rscript -e "remotes::install_version('readr')"
RUN Rscript -e "remotes::install_version('ggplot2')"
RUN Rscript -e "remotes::install_version('tidymodels')"
RUN Rscript -e "remotes::install_version('caret')"
RUN Rscript -e "remotes::install_version('gridExtra')"