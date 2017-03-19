library(shiny)


#server part 


shinyServer(
        function(input, output, session) {
                
                # set output$predicted_word based on input$phrase
                
                observeEvent(input$phrase, {
                        output$predicted_word <- renderText(paste0(input$phrase, " .... ",
                                                "<prediction here>"))
                })
                
                 
        }
)

