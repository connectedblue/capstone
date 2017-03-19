library(shiny)




# UI for the map display

shinyUI(pageWithSidebar(
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
                                 actionButton("submit", 
                                           label = "Predict next word", 
                                           width = "100px"),
                                 textOutput("predicted_word")
                                 ),
                        tabPanel("About", includeHTML("instructions.html"))
                        
                )
        )
))

