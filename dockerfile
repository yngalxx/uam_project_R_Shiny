ENV RENV_VERSION 0.15.4
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

WORKDIR /uam_project_R_Shiny
COPY renv.lock renv.lock
RUN R -e 'renv::restore()'

COPY data/ data/

EXPOSE 7914

CMD ["R", "-e", "shiny::runApp('/uam_project_R_Shiny', host='127.0.0.1', port=7914)"]