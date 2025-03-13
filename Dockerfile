FROM rocker/rstudio:4.4.2

WORKDIR /home/rstudio
COPY analysis/animal_shelter_adoptability_analysis.qmd analysis/
COPY code code/
COPY data data/
COPY results results/
COPY docs docs/
COPY Makefile .

RUN Rscript -e "install.packages('remotes', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('tidyverse', version='1.3.0', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('docopt', version='0.7.1', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('tidymodels', version='1.0.0', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('knitr', version='1.49', repos='https://cloud.r-project.org/')"