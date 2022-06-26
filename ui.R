#!/usr/bin/env Rscript

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "China vs. USA Pop."),
  dashboardSidebar(sidebarMenu(
    # this tab contain overall business inforation
    menuItem("Population overall compare", tabName = "population"),
    # this tab contain inforation about migrants
    menuItem("Detail information", tabName = "detail")
  )),
  dashboardBody(tabItems(
    tabItem(
      "population",
      fluidRow(
        box(
          plotOutput("plot_pop_china", height = 350)
        ),
        box(
          plotOutput("plot_pop_usa", height = 350)
        )
      ),
      fluidRow(
        box(
          background = "light-blue",
          width = 12,
          "From the two graphs above, you can see that China population is
            greater then USA. Additionaly, you can see that the grow of China
            population is much faster than in US. China in given 70 years
            inceases almost 3 times their population. USA has growth is
            linear but almost invisible."
        )
      )
    ),
    tabItem(
      "detail",
      fluidRow(
        box(plotOutput("plot_median_age", height = 250)),
        box(
          background = "light-blue",
          "Median age in US was almost 2 times higher in year 1950.
              But the difference was getting smaller. China population is aging
              very fast. Now their median age is on the same level as US."
        )
      ),
      fluidRow(
        box(plotOutput("plot_migrants", height = 250)),
        box(
          background = "light-blue",
          "Number of people who migrate from US is growing. There was
              hight peak in 2000 year, and it was 1.75 MLN migrants in this year.
              After that the level got smaller, and for now it is about 1.5 mln
              migrants per year. It is slowly getting smaller.
              In China the number of migrants is below 0 and it is contantly declining."
        )
      ),
      fluidRow(
        box(plotOutput("plot_density", height = 250)),
        box(
          background = "light-blue",
          "In China the density in 1950 year was about 2 times higher
              than US. Population densities increased in both
              countries. However, in the China this increase was much faster."
        )
      )
    )
  ))
)
