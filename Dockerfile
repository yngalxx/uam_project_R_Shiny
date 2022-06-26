FROM rocker/shiny:4.1.2 

COPY . /usr/local/bin/uam_project_R_Shiny
WORKDIR /usr/local/bin/uam_project_R_Shiny

ENV RENV_VERSION 0.15.4
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

RUN R -e 'renv::restore()'

EXPOSE 8080

CMD ["R", "-e", "shiny::runApp('app.R', host = '0.0.0.0', port = 8080)"]