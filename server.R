#!/usr/bin/env Rscript

library(dplyr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(usethis)

source("data_processing.R")

server <- function(input, output) {
  # plot of China population
  output$plot_pop_china <- renderPlot({
    ggplot(china_pop, aes(x = Year, y = Population / 1000000)) +
      geom_point(color = "red") +
      ylim(0, 1500) +
      ylab("Population in MLN") +
      ggtitle("What was the China population?") +
      theme_light()
  })

  # plot of US population
  output$plot_pop_usa <- renderPlot({
    ggplot(usa_pop, aes(x = Year, y = Population / 1000000)) +
      geom_point(color = "blue") +
      ylim(0, 1500) +
      ylab("Population in MLN") +
      ggtitle("What was the USA population?") +
      theme_light()
  })

  # plot of migrants in China and US
  output$plot_migrants <- renderPlot({
    ggplot() +
      geom_line(
        data = usa_china_pop,
        aes(
          x = Year,
          y = Migrants_net.USA / 1000000,
          colour = "USA"
        )
      ) +
      geom_line(
        data = usa_china_pop,
        aes(
          x = Year,
          y = Migrants_net.China / 1000000,
          colour = "China"
        )
      ) +
      scale_color_manual(
        name = "Country",
        values = c(
          "USA" = "blue",
          "China" = "red"
        )
      ) +
      ylab("Migrants in MLN") +
      ggtitle("How many migrants where in given year?") +
      theme_light()
  })

  # plot of density in China and US
  output$plot_density <- renderPlot({
    ggplot() +
      geom_line(data = usa_china_pop, aes(
        x = Year,
        y = Density_p_km2.USA,
        colour = "USA"
      )) +
      geom_line(data = usa_china_pop, aes(
        x = Year,
        y = Density_p_km2.China,
        colour = "China"
      )) +
      scale_color_manual(
        name = "Country",
        values = c(
          "USA" = "blue",
          "China" = "red"
        )
      ) +
      ylab("Density [p/km2]") +
      ggtitle("What is the population to the size of the country?") +
      theme_light()
  })

  # plot of median age in China and US
  output$plot_median_age <- renderPlot({
    ggplot() +
      geom_line(data = usa_china_pop, aes(
        x = Year,
        y = Median_age.USA,
        colour = "USA"
      )) +
      geom_line(data = usa_china_pop, aes(
        x = Year,
        y = Median_age.China,
        colour = "China"
      )) +
      scale_color_manual(
        name = "Country",
        values = c(
          "USA" = "blue",
          "China" = "red"
        )
      ) +
      ylab("Median age") +
      ggtitle("Is it an aging society?") +
      theme_light()
  })
}
