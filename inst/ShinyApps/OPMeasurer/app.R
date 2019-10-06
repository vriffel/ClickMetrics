#-----------------------------------------------------------------------
#                                            Vinicius Ricardo Riffel
#                                leg.ufpr.br/~vinicius · github.com/vriffel
#                                        viniciusriffel@ufpr.br
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2019-out-6 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Pacotes.
require(imager)
require(shiny)
source("/home/vriffel/ClickMetrics/R/op_measurer.R")

ui <- fluidPage(
    mainPanel(textOutput("mytxt"))
)

server <- function(input, output) {
    output$mytxt <- renderText( {
        print("This is my test")
    })
}

shinyApp(ui, server)

# op_measurer("/home/vriffel/Downloads/pikolz.jpeg")
# diameter_measurer("/home/vriffel/Downloads/pikolz.jpeg")
