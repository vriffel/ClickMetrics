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


#-----------------------------------------------------------------------
# Variáveis globais imutáveis a serem passadas para a aplicação.

setwd(getShinyOption(name = "wd", default = getwd()))

# Nome para o arquivo de registro.
file_CSV <- getShinyOption(name = "csv", default = NULL)
# unlink(file_CSV)

# Conjunto de imagens.
choices_IMAGEM <- getShinyOption(name = "files", default = NULL)

names(choices_IMAGEM) <-
    paste(basename(dirname(choices_IMAGEM)),
          basename(choices_IMAGEM),
          sep = "/")

# Nome dos tratamentos.
choices_COMPONENTE <- getShinyOption(name = "labels", default = NULL)

#-----------------------------------------------------------------------

# Bloco usado para desenvolver a aplicação.
# if (interactive() && Sys.info()["user"] == "walmes") {
#     choices_COMPONENTE <- c("Plate", "Mycelium")
#     choices_IMAGEM <- dir(system.file("images", package = "ClickMetrics"),
#                           full.names = TRUE)
#     file_CSV <- "mytable.csv"
# }

# Estilo para os botões.
style_btn <- ".btn {display: block; margin: 0.5em 0;}"

#-----------------------------------------------------------------------
# Frontend.

ui <- fluidPage(
    # theme = shinytheme("yeti"),
    headerPanel(title = "Diameter measurament"),
    sidebarPanel(
        width = 3,
        selectInput(
            inputId = "IMAGEM",
            label = "Image:",
            choices = choices_IMAGEM),
        radioButtons(
            inputId = "COMPONENTE",
            label = "Component:",
            choices = choices_COMPONENTE),
        textInput(
            inputId = "IDENTIFICACAO",
            label = "Observation:",
            value = getShinyOption(name = "obs", default = NA),
            placeholder = "Done by John Smith"),
        tags$head(tags$style(style_btn)),
        actionButton(
            inputId = "REGISTRAR",
            label = "Record clicks",
            width = "100%",
            icon = icon("file-import"),
            # icon = icon("sdcard"),
            # icon = icon("pen"),
            class = "btn btn-success"),
        fluidRow(
            column(
                width = 6,
                actionButton(
                    inputId = "DESFAZER",
                    label = "Undo",
                    width = "100%",
                    icon = icon("eraser"),
                    class = "btn btn-warning")),
            column(
                width = 6,
                actionButton(
                    inputId = "RESTAURAR",
                    label = "Restore",
                    width = "100%",
                    icon = icon("undo"),
                    class = "btn btn-info"))),
        actionButton(
            inputId = "EXIT",
            label = "Exit",
            width = "100%",
            icon = icon("times-circle"),
            class = "btn btn-danger"),
        verbatimTextOutput(outputId = "INFO")
    ), # sidebarPanel().
    mainPanel(
        plotOutput(
            outputId = "PLOT_IMAGEM",
            click = "IMAGE_CLICK",
            dblclick = "IMAGE_DBLCLICK",
            width = getShinyOption(name = "width", default = "800px"),
            height = getShinyOption(name = "height", default = "800px")),
        tableOutput(outputId = "TABELA")
    ) # mainPanel().
) # fluidPage().

server <- function(input, output) {
}

shinyApp(ui, server)

op_measurer("/home/vriffel/Downloads/pikolz.jpeg")
# diameter_measurer("/home/vriffel/Downloads/pikolz.jpeg")
