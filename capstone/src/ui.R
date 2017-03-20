library(shiny)

shinyUI(fluidPage(
        headerPanel("Next Word Predictor"),
        
        mainPanel(
                tabsetPanel(
                        tabPanel("Word Predictor", 
                                 p("Type in a phrase below"),
                                 textInput("phrase",
                                           label="", 
                                           value = "", 
                                           width = "500px", 
                                           placeholder = "Type the beginning of a phrase"),
                                 
                                 htmlOutput("predicted_word")
                               
                                 
                                 ),
                        tabPanel("About", includeHTML("instructions.html"))
                        
                )
        )
))

