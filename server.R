library(shiny)
library(dplyr)
library(quantmod)
library(ggplot2)

retrieveRemoteFile <- function(url, filename) {
    if(!file.exists(filename)) download.file(url, filename, method="libcurl")
}

getNasdaqTickers <- function() {
    filename <- "nasdaqlisted.txt"
    retrieveRemoteFile("nasdaqtrader.com/dynamic/SymDir/nasdaqlisted.txt", filename)
    symbols <- read.table(filename, header=T, sep="|", quote="\"")$Symbol
    symbols[1:length(symbols)-1]    
}

getNasdaqCompanies <- function() {
    filename <- "nasdaqlisted.txt"
    retrieveRemoteFile("nasdaqtrader.com/dynamic/SymDir/nasdaqlisted.txt", filename)
    companies <- read.table(filename, header=T, sep="|", quote="\"")$Security.Name
    as.character(companies[1:length(companies)-1])
}

getNYSETickers <- function() {
    filename <- "otherlisted.txt"
    retrieveRemoteFile("nasdaqtrader.com/dynamic/SymDir/otherlisted.txt", filename)
    symbols <- read.table(filename, header=T, sep="|", quote="\"", fill=T)$ACT.Symbol
    symbols[1:length(symbols)-1]
} 

getNYSECompanies <- function() {
    filename <- "otherlisted.txt"
    retrieveRemoteFile("nasdaqtrader.com/dynamic/SymDir/otherlisted.txt", filename)
    companies <- read.table(filename, header=T, sep="|", quote="\"", fill=T)$Security.Name
    as.character(companies[1:length(companies)-1])
} 

nyse_symbols <- getNYSETickers()
nasdaq_symbols <- getNasdaqTickers()
nasdaq_companies <- getNasdaqCompanies()
nyse_companies <- getNYSECompanies()

shinyServer(
    function(input, output, session) {        
        observe({
            x <- input$exchange
            symbols <- if(x==1) nasdaq_symbols else nyse_symbols
            updateSelectInput(session, "symbol", choices=symbols)
        })
        
        observe({
            s <- input$symbol
            x <- input$exchange
            if (x==1) {
                i <- match(s, nasdaq_symbols)
                output$company = renderText({nasdaq_companies[i]})
            } else {
                i <- match(s, nyse_symbols)
                output$company = renderText({nyse_companies[i]})
            }
        })
        
        p <- eventReactive(input$btnplot, {
            plotselections <- c(input$plot1box, input$plot2box, input$plot3box, input$plot4box)
            symbols <- toupper(c(input$plot1input, input$plot2input, input$plot3input, input$plot4input))
            symbols = subset(symbols, plotselections & (symbols %in% nasdaq_symbols | symbols %in% nyse_symbols))
            
            getSymbols(symbols, from=input$date, warnings=FALSE, auto.assign=TRUE)
            adjprices <- do.call(merge, lapply(symbols, function(x) Ad(get(x))))
            adjprices
        })
        output$plot <- renderPlot({
            autoplot(p(), xlab="Date", main="Daily Adjusted Stock Price Trends", geom="line") + facet_grid(Series ~ ., scales="free_y")
        }, height=600)
    } 
)    
