library(shiny)

d <- as.POSIXlt(Sys.Date())
d$year <- d$year - 1
d <- as.Date(d)

shinyUI(fluidPage(
    tags$head(
        tags$link(rel="stylesheet", type="text/css", href="style.css")
    ),
    div(id="header",
        headerPanel(h2("Stock Price Plotter"), "Compare and plot historical stock prices")
    ),
    div(id="documentation",
        h4("Documentation"),
        p("Use the Symbol lookup and Exchange radio buttons to look up a stock symbol in one of the available stock exchanges."),
        p("At the bottom you can display up to four time series plots of the daily adjusted stock prices for a valid stock symbol. Enter a symbol in the text input box and enable the checkbox above it."),
        p("Above the plot area is a Start Date control where you can select the starting date for the time series. By default it starts one year ago from today's date."),
        p("After entering the symbols, checking the boxes to enable the plot, and setting a start date, click Display Plots to show the time series graphs."),
    ),
    sidebarLayout(
        sidebarPanel(
            div(id="stocks",
                fluidRow(
                    column(6, selectInput("symbol", label="Symbol lookup", choices="", selectize=F)),                    
                    column(3, radioButtons("exchange", label="Exchange", choices=list("Nasdaq"=1, "NYSE"=2), selected=1))
                ),
                fluidRow(
                    column(12, verbatimTextOutput("company"))
                )
            ),
            hr(),
            div(id="plotselector",
                fluidRow(
                    column(3, checkboxInput("plot1box", label="Plot 1", value=T)),
                    column(3, checkboxInput("plot2box", label="Plot 2", value=F)),
                    column(3, checkboxInput("plot3box", label="Plot 3", value=F)),
                    column(3, checkboxInput("plot4box", label="Plot 4", value=F))
                )
            ),
            div(id="plotinputs",
                fluidRow(
                    column(3, textInput("plot1input", label="")),
                    column(3, textInput("plot2input", label="")),
                    column(3, textInput("plot3input", label="")),
                    column(3, textInput("plot4input", label=""))
                )
            ),
            div(id="row2",
                fluidRow(
                    column(6, selectInput("symbol2", label="Choose a stock symbol", choices="", selectize=F)),
                    column(3, radioButtons("exchange2", label="Exchange", choices=list("Nasdaq"=1, "NYSE"=2), selected=1)),
                    column(1, actionButton("add2", label="+"), offset=1)
                )
            ),
           div(id="confirm",
               actionButton("btnplot", label="Display Plots")
           )
        ),
        mainPanel(
            dateInput("date", "Start Date", d, format="yyyy-mm-dd"),
            plotOutput("plot")
        ),
        fluid=TRUE
    )
))