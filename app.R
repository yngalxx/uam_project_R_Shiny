#!/usr/bin/env Rscript

source("ui.R")
source("server.R")

options(shiny.host = "0.0.0.0")
options(shiny.port = 8080)

shinyApp(ui = ui, server = server)
