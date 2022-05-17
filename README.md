### Final project in one of our Master's degree courses


<b>Project name:</b> "Comparison of changes taking place in the Chinese and US populations over the past 50 years"

<b>Course name:</b> "Development of data-driven products"

<b>Univeristy:</b> Adam Mickiewicz University

<b>Description:</b>

The project involves developing a Shiny application in R to visualize Chinese and US population data over the last 50 years and compare them. The project is intended to introduce Shiny, as well as good programming practices. 

<b>Authors:</b>
1. Adrianna Przybylska
2. Alex Drożdż

<b>Based on data from:</b>
1. China: https://www.kaggle.com/datasets/anandhuh/population-data-china
2. USA: https://www.kaggle.com/datasets/anandhuh/population-data-usa?select=population_usa.csv

<b>Instruction:</b>
1. Go to cloned repository in terminal
2. Run "docker build -t r-shiny ."
3. Run "docker run --rm -p 8080:8080 r-shiny"
4. Open in browser url "http://0.0.0.0:8080"