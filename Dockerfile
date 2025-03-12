FROM jupyter/datascience-notebook:latest

WORKDIR /home/jovyan/work

COPY animal_shelter_adoptability_analysis.ipynb .

RUN Rscript -e "install.packages('remotes', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('kknn', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('readr', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('ggplot2', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('tidymodels', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('caret', repos='https://cloud.r-project.org/')"
RUN Rscript -e "remotes::install_version('gridExtra', repos='https://cloud.r-project.org/')"

CMD ["start-notebook.sh", "--NotebookApp.token=''","--NotebookApp.ip='0.0.0.0'"]