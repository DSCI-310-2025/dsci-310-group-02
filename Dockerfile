FROM jupyter/datascience-notebook:2025-02-12

WORKDIR /home/jovyan/work

COPY animal_shelter_adoptability_analysis.ipynb .

# Install R packages with pinned versions in a single RUN command
RUN Rscript -e "install.packages('remotes', repos='https://cloud.r-project.org/'); \
    remotes::install_version('kknn', version='1.3.1', repos='https://cloud.r-project.org/'); \
    remotes::install_version('readr', version='2.1.4', repos='https://cloud.r-project.org/'); \
    remotes::install_version('ggplot2', version='3.4.0', repos='https://cloud.r-project.org/'); \
    remotes::install_version('tidymodels', version='1.0.0', repos='https://cloud.r-project.org/'); \
    remotes::install_version('caret', version='6.0-94', repos='https://cloud.r-project.org/'); \
    remotes::install_version('gridExtra', version='2.3', repos='https://cloud.r-project.org/')" 

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.ip='0.0.0.0'"]
