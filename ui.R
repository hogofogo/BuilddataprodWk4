
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict MPG based on horsepower, time to 1/4 mile, and type of transmission"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("SliderWeight",
                  "What is the weight of this car (in 1000 lbs)?",
                  min = 1.5,
                  max = 5.5,
                  value = 3.5),
      sliderInput("SliderQsec",
                  "How fast does this car does 1/4 mile (in sec)?",
                  min = 13,
                  max = 23,
                  value = 18),
      checkboxInput("auto_manual", "Check if transmission is automatic", value = TRUE),
      
      h3("Instructions"),
      h5("The regression analysis of mtcars dataset revealed that optimal regression parameters predicting gas mileage include weight (wt), time to 1/4 mile (qsec) and the type of transmission (auto or manual)."),
      h5("The application takes the input for these three parameters, plots the continuous predictors against mileage (two graphs: mpg against wt, and mpg against qsec) while showing factor transmission predictor as color, and predicts gas mileage for a vehicle with the parameters passed as input."),
      h5("All the vehicles in the dataset are plotted to indicate the relative position of the input parameters to those of real vehicles.")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot1"),
      plotOutput("Plot2"),
      h3("Predicted mpg:"),
      textOutput("pred1")
      
    )
  )
))
