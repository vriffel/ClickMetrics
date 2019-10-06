op_measurer <- function(files,
                        labels = "Plate",
                        obs = "Done with ClickMetrics",
                        csv = "myclick.csv",
                        width = "800px",
                        height = "800px",
                        app_path = NULL) {
        if (!requireNamespace(package = "shiny", quietly = TRUE)) {
        stop(paste("`shiny` package not found.",
                   "Please, install it."),
             call. = FALSE)
    }

    # if (!requireNamespace(package = "imager", quietly = TRUE)) {
    #     stop(paste("`imager` package not found.",
    #                "Please, install it."),
    #          call. = FALSE)
    # }

    if (is.null(app_path)) {
        # Endereço da aplicação shiny na raíz do pacote/projeto.
        app_path <- "ShinyApps/OPMeasurer"
        # appDir <- system.file(app_path, package = "ClickMetrics")
        appDir <- "/home/vriffel/ClickMetrics/inst/ShinyApps/OPMeasurer"
        ## Necessario apagar depois o appDir acima.
        # Verifica existência do diretório.
        if (!dir.exists(appDir)) {
            stop(paste(
                "Directory not found for `OPMeasurer`.",
                "Please, try to reinstall `ClickMetrics`."),
                call. = FALSE)
        }
    } else {
        appDir <- app_path
        if (!dir.exists(appDir)) {
            stop(paste(
                "Directory not found."),
                call. = FALSE)
        }
    }

    if (missing(files)) {
        stop(paste("`files` argument must be provided."))
    }

    if (!all(file.exists(files))) {
        stop("Some files were not found.")
    }

    if (!(length(labels) > 0 && is.character(labels))) {
        stop("`labels` must be non empty character vector.")
    }

    if (!(length(obs) > 0 && is.character(obs))) {
        stop("`obs` must be non empty character vector.")
    }

    if (is.null(csv)) {
        csv <- tempfile(fileext = ".csv")
    } else if (!(length(csv) == 1 && is.character(labels))) {
        stop("When provided, `csv` must be a length one character vector.")
    }

    # Passa parâmetros para a aplicação shiny.
    shiny::shinyOptions(files = files,
                        labels = labels,
                        obs = obs,
                        csv = csv,
                        wd = getwd())

    # Chama a aplicação.
    shiny::runApp(appDir, display.mode = "normal")

    # Lê a tabela que foi gerada.
    tb <- utils::read.csv(file = csv,
                          stringsAsFactors = FALSE)
    tb$ts <- base::as.POSIXct(tb$ts, origin = "1960-01-01")
    return(tb)
}
