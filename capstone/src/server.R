library(shiny)


#server part 


shinyServer(
        function(input, output, session) {
                
                # Filter data based on user input
                filteredData <- reactive({
                        hourly_summary %>% filter(day==input$day, hour==input$hour)
                })
                
                # show the static map without the circle markers and mean city speed
                
                output$map <- renderLeaflet({
                        leaflet(hourly_summary) %>% addTiles() %>%
                        fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat)) 
                        
                })
                
                
                
                 
        }
)

