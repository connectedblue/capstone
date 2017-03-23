library(shiny)

shinyUI(fluidPage(
        headerPanel("R O B O W O R D"),
        
        mainPanel(
                tabsetPanel(
                        tabPanel("Word Predictor", 
                                 
                                 fluidRow(
                                         column(10, align="left", 
                                                h4("Hi!  I'm RoboWord and I love to try and guess what 
                                                   what word you might be thinking of next.")
                                         )     
                                 ),
                                 HTML("<br/><br/>"),
                                 fluidRow(
                                         column(6, align="center", offset = 5,
                                                h4("Feel free to challenge me.  Just start typing in the box below, and I'll have a
                                                   think about a word that is most likely to come next")
                                         )     
                                 ),
                                 fluidRow(
                                         column(6, align="center", offset = 5,
                                 textInput("phrase",
                                           label="", 
                                           value = "", 
                                           width = "500px", 
                                           placeholder = "Type an english  phrase ...")
                                         )
                                 ),
                                 fluidRow(
                                         column(6, align="center", offset = 5,
                                                h3(htmlOutput("predicted_word")),
                                                tags$style(type='text/css', "#button { vertical-align: middle; height: 50px; width: 100%; font-size: 30px;}")
                                         )
                                 )
                                 
                               
                                 
                                 ),
                        tabPanel("About", includeHTML("instructions.html"))
                        
                )
        )
))

