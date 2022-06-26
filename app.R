#!/usr/bin/env Rscript

source("ui.R")
source("server.R")

app <- shinyApp(
  ui = ui,
  server = server
)

runApp(
  app,
  host = '0.0.0.0',
  port = 8080
)

