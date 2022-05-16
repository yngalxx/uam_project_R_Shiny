FROM r-base:4.1.2 
COPY . /usr/local/src/uam_project_R_Shiny
WORKDIR /usr/local/src/uam_project_R_Shiny

ENV RENV_VERSION 0.15.4
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

COPY renv.lock renv.lock
RUN R -e 'renv::restore()'

CMD ["R", "-e", "runApp('shiny_dashboard.R')"]