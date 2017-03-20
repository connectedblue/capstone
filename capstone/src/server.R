library(shiny)


#server part 


shinyServer(
        function(input, output, session) {
                
                # set output$predicted_word based on input$phrase
                
                observeEvent(input$phrase, {
                        
                        output$predicted_word <- renderUI(HTML(paste0(input$phrase, 
                                                                   " .... ",
                                                                   predict_next_word(input$phrase)[1]
                                                                   )))
                })
                
                 
        }
)

