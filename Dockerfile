FROM rocker/rstudio:4.4.2

WORKDIR /home/rstudio
COPY data data/
COPY docs docs/
COPY reports reports/
COPY results results/
COPY scripts scripts/
COPY Makefile .

RUN Rscript -e "install.packages('remotes', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('readr', version='2.1.5', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('dplyr', version='1.1.4', repos='https://cloud.r-project.org/')" 
RUN Rscript -e "remotes::install_version('tidymodels', version='1.3.0', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('docopt', version='0.7.1', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('knitr', version='1.49', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('kknn', version='1.3.1', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('rmarkdown', version='2.29', repos='https://cloud.r-project.org/')"
Run Rscript -e "remotes::install_version('devtools', version='2.4.5', repos='https://cloud.r-project.org/')"
RUN Rscript -e "devtools::install_github('DSCI-310-2025/animalshelterdataanalysis')"

RUN chown -R rstudio .