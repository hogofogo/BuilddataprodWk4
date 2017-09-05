
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  model1 <- lm(mpg ~ wt + qsec + am, data = mtcars)
  cars <- mtcars
  cars$am <- as.factor(cars$am)
  
  model1pred <- reactive({
    wtInput <- input$SliderWeight
    qsecInput <- input$SliderQsec
    amInput <- ifelse(input$auto_manual, 0, 1)
    predict(model1, newdata = data.frame(wt = wtInput, qsec = qsecInput, am = amInput))
  })
  
  
  output$Plot1 <- renderPlot({
    wtInput <- input$SliderWeight
    qsecInput <- input$SliderQsec
    amInput <- ifelse(input$auto_manual, 1, 0)
    plot(mtcars$wt, mtcars$mpg, main = "MPG dependency on weight", xlab = "weight", ylab = "mpg", pch = 16, xlim = c(1.5, 5.5),
         ylim = c(10, 35), col = cars$am)
    points(wtInput, model1pred(), col = ifelse(amInput == 1, "red", "black"), pch = 16, cex = 4)
    legend("topright", legend = c("manual", "auto"), fill = c("black", "red"), box.lty = 0)
  })
  
  output$Plot2 <- renderPlot({
    wtInput <- input$SliderWeight
    qsecInput <- input$SliderQsec
    amInput <- ifelse(input$auto_manual, 1, 0)
    plot(mtcars$qsec, mtcars$mpg, main = "MPG dependency on time to 1/4 mile", xlab = "qsec", ylab = "mpg", pch = 16, xlim = c(13, 23),
         ylim = c(10, 35), col = cars$am)
    points(qsecInput, model1pred(), col = ifelse(amInput == 1, "red", "black"), pch = 16, cex = 4)
    legend("topright", legend = c("manual", "auto"), fill = c("black", "red"), box.lty = 0)
  })
  
  output$pred1 <- renderText({model1pred()})
  
})
