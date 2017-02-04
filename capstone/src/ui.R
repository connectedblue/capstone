library(shiny)
library(leaflet)
library(plotly)



# UI for the map display

shinyUI(pageWithSidebar(
        headerPanel("Next Word Predictor"),
        sidebarPanel(
                p('Select the number of predictions for next word'),
               
                sliderInput("words", "Number", min=1, max=5,
                            value = 3, step = 1)
                
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel("Word Predictor", 
                                 p("The circles are the centre of each route.
                                   Click to show detailed route information for this time"),
                                 leafletOutput("map")
                                 ),
                        tabPanel("About", includeHTML("instructions.html"))
                        
                )
        )
))

