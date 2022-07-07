#!/usr/bin/env Rscript

library(dplyr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(usethis)
library(plotly)

source("data_processing.R")

server <- function(input, output) {
  # plot of China population
  output$plot_pop_china <- renderPlotly({
    ggplotly(
      ggplot(china_pop, aes(x = Year, y = Population / 1000000)) +
        geom_point(color = "red") +
        ylim(0, 1500) +
        ylab("Population in MLN") +
        ggtitle("What was the China population?") +
        theme_light()
    )
  })

  # plot of US population
  output$plot_pop_usa <- renderPlotly({
    ggplotly(
      ggplot(usa_pop, aes(x = Year, y = Population / 1000000)) +
        geom_point(color = "blue") +
        ylim(0, 1500) +
        ylab("Population in MLN") +
        ggtitle("What was the USA population?") +
        theme_light()
    )
  })

  # plot of migrants in China and US
  output$plot_migrants <- renderPlotly({
    ggplotly(
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
    )
  })

  # plot of density in China and US
  output$plot_density <- renderPlotly({
    ggplotly(
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
    )
  })

  # plot of median age in China and US
  output$plot_median_age <- renderPlotly({
    ggplotly(
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
    )
  })
  
  
  plot_forecast_population <- ggplotly(
      ggplot() +
        geom_line(data = usa_china_pop, aes(
          x = Year,
          y = Population.USA / 1000000,
          colour = "USA"
        )) +
        geom_line(data = usa_china_pop, aes(
          x = Year,
          y = Population.China / 1000000,
          colour = "China"
        )) +
        geom_line(data = usa_china_for, aes(
          x = Year,
          y = Population.USA / 1000000,
          colour = "USA"
        ),linetype="dashed"
        ) +
        geom_line(data = usa_china_for, aes(
          x = Year,
          y = Population.China / 1000000,
          colour = "China"
        ),linetype="dashed"
        ) +
        scale_color_manual(
          name = "Country",
          values = c(
            "USA" = "blue",
            "China" = "red"
          )
        ) +
        ylab("Population forecast") +
        ggtitle("How the population will probably look like in the future?") +
        theme_light()
    )
  
  plot_forecast_density <- ggplotly(
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
        geom_line(data = usa_china_for, aes(
          x = Year,
          y = Density_p_km2.USA,
          colour = "USA"
        ),linetype="dashed"
        ) +
        geom_line(data = usa_china_for, aes(
          x = Year,
          y = Density_p_km2.China,
          colour = "China"
        ),linetype="dashed"
        ) +
        scale_color_manual(
          name = "Country",
          values = c(
            "USA" = "blue",
            "China" = "red"
          )
        ) +
        ylab("Density forecast") +
        ggtitle("How the density will probably look like in the future?") +
        theme_light()
    )
  
  plot_forecast_median_age <-ggplotly(
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
        geom_line(data = usa_china_for, aes(
          x = Year,
          y = Median_age.USA,
          colour = "USA"
        ),linetype="dashed"
        ) +
        geom_line(data = usa_china_for, aes(
          x = Year,
          y = Median_age.China,
          colour = "China"
        ),linetype="dashed"
        ) +
        scale_color_manual(
          name = "Country",
          values = c(
            "USA" = "blue",
            "China" = "red"
          )
        ) +
        ylab("Median age forecast") +
        ggtitle("How the median age will probably look like in the future?") +
        theme_light()
    )
  
  output$plot <- renderPlotly({
    if(input$Parameter == "Population"){
      plot_forecast_population
    }else if(input$Parameter == "Density"){
      plot_forecast_density
    }else{
      plot_forecast_median_age
    }
  })
}

