#!/usr/bin/env Rscript

library(dplyr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(usethis)


#read data
#
#@param path
#
#@return dataframe
read_data <- function(path) {
  df <- read.csv(path)
  return(df)
}

#check if there is any null
#
#@param x
#
#@return int

check_null <- function(x) {
  sum(is.null(x))
}

china_pop <- read_data("data/China/china_population.csv")
usa_pop <- read_data("data/USA/population_usa.csv")

#check nulls
check_null(china_pop)
check_null(usa_pop)


#merge dataframes
#
#@params df1, df2, key, suffixes
#
#@return dataframe
merge_dfs <- function(df1, df2, key, suffixes) {
  merged_dfs <- merge(
    x = df1,
    y = df2,
    by = key,
    all = TRUE,
    suffixes = suffixes
  )
  return(merged_dfs)
}

usa_china_pop <-
  merge_dfs(usa_pop, china_pop, 'Year', c('.USA', '.China'))

#check nulls
check_null(usa_china_pop)

ui <- dashboardPage(
  dashboardHeader(title = 'China vs. USA Pop.'),
  dashboardSidebar(sidebarMenu(
    #this tab contain overall business inforation
    menuItem("Population overall compare", tabName = 'population'),
    #this tab contain inforation about migrants
    menuItem('Detail information', tabName = 'detail')
  )),
  dashboardBody(tabItems(
    tabItem('population',
            fluidRow(box(
              plotOutput('plot_pop_china', height = 350)
            ),
            
            box(
              plotOutput('plot_pop_usa', height = 350)
            )),
            fluidRow(
              box(
                background = 'light-blue',
                width = 12,
                'From the two graphs above, you can see that China population is
            greater then USA. Additionaly, you can see that the grow of China
            population is much faster than in US. China in given 70 years
            inceases almost 3 times their population. USA has growth is
            linear but almost invisible.'
              )
            )),
    tabItem(
      'detail',
      fluidRow(
        box(plotOutput('plot_median_age', height = 250)),
        
        box(
          background = 'light-blue',
          "Median age in US was almost 2 times higher in year 1950.
              But the difference was getting smaller. China population is aging
              very fast. Now their median age is on the same level as US."
        )
      ),
      
      fluidRow(
        box(plotOutput('plot_migrants', height = 250)),
        
        box(
          background = 'light-blue',
          "Number of people who migrate from US is growing. There was
              hight peak in 2000 year, and it was 1.75 MLN migrants in this year.
              After that the level got smaller, and for now it is about 1.5 mln
              migrants per year. It is slowly getting smaller.
              In China the number of migrants is below 0 and it is contantly declining."
        )
      ),
      
      fluidRow(
        box(plotOutput('plot_density', height = 250)),
        
        box(
          background = 'light-blue',
          "In China the density in 1950 year was about 2 times higher
              than US. Population densities increased in both
              countries. However, in the China this increase was much faster."
        )
      )
    )
  ))
)

server <- function(input, output) {
  #plot of China population
  output$plot_pop_china <- renderPlot({
    ggplot(china_pop, aes(x = Year, y = Population / 1000000)) +
      geom_point(color = 'red') +
      ylim(0, 1500) +
      ylab('Population in MLN') +
      ggtitle('What was the China population?') +
      theme_light()
  })
  
  #plot of US population
  output$plot_pop_usa <- renderPlot({
    ggplot(usa_pop, aes(x = Year, y = Population / 1000000)) +
      geom_point(color = 'blue') +
      ylim(0, 1500) +
      ylab('Population in MLN') +
      ggtitle('What was the USA population?') +
      theme_light()
  })
  
  #plot of migrants in China and US
  output$plot_migrants <- renderPlot({
    ggplot() +
      geom_line(data = usa_china_pop,
                aes(
                  x = Year,
                  y = Migrants_net.USA / 1000000,
                  colour = 'USA'
                )) +
      geom_line(data = usa_china_pop,
                aes(
                  x = Year,
                  y = Migrants_net.China / 1000000,
                  colour = 'China'
                )) +
      scale_color_manual(name = 'Country',
                         values = c('USA' = 'blue',
                                    'China' = 'red')) +
      ylab('Migrants in MLN') +
      ggtitle('How many migrants where in given year?') +
      theme_light()
  })
  
  #plot of density in China and US
  output$plot_density <- renderPlot({
    ggplot() +
      geom_line(data = usa_china_pop, aes(x = Year,
                                          y = Density_p_km2.USA,
                                          colour = 'USA')) +
      geom_line(data = usa_china_pop, aes(x = Year,
                                          y = Density_p_km2.China,
                                          colour = 'China')) +
      scale_color_manual(name = 'Country',
                         values = c('USA' = 'blue',
                                    'China' = 'red')) +
      ylab('Density [p/km2]') +
      ggtitle('What is the population to the size of the country?') +
      theme_light()
  })
  
  #plot of median age in China and US
  output$plot_median_age <- renderPlot({
    ggplot() +
      geom_line(data = usa_china_pop, aes(x = Year,
                                          y = Median_age.USA,
                                          colour = 'USA')) +
      geom_line(data = usa_china_pop, aes(x = Year,
                                          y = Median_age.China,
                                          colour = 'China')) +
      scale_color_manual(name = 'Country',
                         values = c('USA' = 'blue',
                                    'China' = 'red')) +
      ylab('Median age') +
      ggtitle('Is it an aging society?') +
      theme_light()
  })
}


options(shiny.host = '0.0.0.0')
options(shiny.port = 8080)

shinyApp(ui = ui, server = server)