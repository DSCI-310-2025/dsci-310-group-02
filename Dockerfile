FROM rocker/rstudio:4.4.2

WORKDIR /home/rstudio
COPY R R/
COPY data data/
COPY docs docs/
COPY reports reports/
COPY results results/
COPY scripts scripts/
COPY tests tests/
COPY Makefile .

RUN Rscript -e "install.packages('remotes', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('readr', version='2.1.5', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('dplyr', version='1.1.4', repos='https://cloud.r-project.org/')" 
RUN Rscript -e "remotes::install_version('tidymodels', version='1.3.0', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('docopt', version='0.7.1', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('knitr', version='1.49', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('kknn', version='1.3.1', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('rmarkdown', version='2.29', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('pointblank', version='0.12.2', repos='https://cloud.r-project.org/')"

RUN chown -R rstudio .