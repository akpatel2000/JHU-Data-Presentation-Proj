library(shiny)
library(lubridate)

shinyUI(fluidPage(
  titlePanel("Compare Treasury Yield Curve from Two Different Dates"),
  sidebarLayout(
    sidebarPanel(
      h4("Yield Curve 1", style = "color:#8DFF33"),
      dateInput("date1", "Enter Date:", value = as.Date("2016-12-21")),
      h4("Yield Curve 2", style = "color:blue"),
      sliderInput("slider1", "Use Slider to look back # of days", 1, 1000, 200)



    ),
    mainPanel(

      plotOutput("plot1")

      # tableOutput("table1")

    )
  )
))
