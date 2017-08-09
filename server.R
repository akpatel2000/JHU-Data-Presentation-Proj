library(ggplot2)

shinyServer(function(input, output) {

    ##  Load data from comma delimited files
    year2Y <- read.csv("https://raw.githubusercontent.com/akpatel2000/Projects/master/DGS2.csv", header = TRUE, stringsAsFactors = FALSE)
    year5Y <- read.csv("https://raw.githubusercontent.com/akpatel2000/Projects/master/DGS5.csv", header = TRUE, stringsAsFactors = FALSE)
    year7Y <- read.csv("https://raw.githubusercontent.com/akpatel2000/Projects/master/DGS7.csv", header = TRUE, stringsAsFactors = FALSE)
    year10Y <- read.csv("https://raw.githubusercontent.com/akpatel2000/Projects/master/DGS10-2.csv", header = TRUE, stringsAsFactors = FALSE)
    year30Y <- read.csv("https://raw.githubusercontent.com/akpatel2000/Projects/master/DGS30.csv", header = TRUE, stringsAsFactors = FALSE)

    ## Format data to remove errors and incomplete data
    year2Y <- year2Y[-which(year2Y$DGS2=="."),]
    year5Y <- year5Y[-which(year5Y$DGS5=="."),]
    year7Y <- year7Y[-which(year7Y$DGS7=="."),]
    year10Y <- year10Y[-which(year10Y$DGS10=="."),]
    year30Y <- year30Y[-which(year30Y$DGS30=="."),]

    ## Merge datasets into one dataframe
    ratesRecord <- merge(year2Y, year5Y, by = "DATE")
    ratesRecord <- merge(ratesRecord, year7Y, by = "DATE")
    ratesRecord <- merge(ratesRecord, year10Y, by = "DATE")
    ratesRecord <- merge(ratesRecord, year30Y, by = "DATE")

    ## Format data to proper data types
    ratesRecord$DATE <- as.Date(ratesRecord$DATE)
    ratesRecord$DGS2 <- as.numeric(ratesRecord$DGS2)
    ratesRecord$DGS5 <- as.numeric(ratesRecord$DGS5)
    ratesRecord$DGS7 <- as.numeric(ratesRecord$DGS7)
    ratesRecord$DGS10 <- as.numeric(ratesRecord$DGS10)
    ratesRecord$DGS30 <- as.numeric(ratesRecord$DGS30)


  df <- reactive({
      ## two inputs a slider and date
      slider1 <- as.numeric(input$slider1)
      date1 <- as.Date(input$date1)

      ## get record for date to plot
      ratesRecordPlot <- subset(ratesRecord, DATE == date1)

      if (nrow(ratesRecordPlot)==0) {return(NULL)}

      ## build curve using spline function
      muniCurve <- spline(c(2,5,7,10,30),
                          c(ratesRecordPlot$DGS2,
                            ratesRecordPlot$DGS5,
                            ratesRecordPlot$DGS7,
                            ratesRecordPlot$DGS10,
                            ratesRecordPlot$DGS30),
                          n=30, method = "natural")

      ## now get historical date to which we compare by looking back
      ## slider will tell you how many trading days to look back
      ## if they look back more than the number of days available
      ## then stop at the very first record.  Ideally you would msg this fact
      w1 <- which(ratesRecord$DATE==date1)
      w1 <- w1 - slider1
      ifelse(w1 < 1, w1 <- 1, w1)
      ratesRecordPlot <- ratesRecord[w1,]
      muniCurve2 <- spline(c(2,5,7,10,30),
                          c(ratesRecordPlot$DGS2,
                            ratesRecordPlot$DGS5,
                            ratesRecordPlot$DGS7,
                            ratesRecordPlot$DGS10,
                            ratesRecordPlot$DGS30),
                          n=30, method = "natural")

      ## build final data frame which will be used to plot
      df <- data.frame(muniCurve, muniCurve2)
      df <- df[,-3]
      names(df) <- c("Maturity", "AAA_Yield","Comp_AAA_Yield")
      df
  })

  g2 <- reactive({
      d1 <- df()

      ## if we got null that means there was some error in buidling curve
      ifelse(is.null(d1),return(NULL),0)


      ## plot using ggplot
      ggplot(data=d1, aes(x=Maturity)) +
        geom_point(aes(y=AAA_Yield), col="green", size = 5) +
        geom_point(aes(y=Comp_AAA_Yield), col="blue", size = 5) +
        geom_vline(xintercept = c(5,10,15,20,25,30), col = "black", alpha = .5) +
        ylab("Yield") + xlab("Maturity") +
        theme(axis.title.x = element_text(color="red", face="bold", size=12)) +
        theme(axis.title.y = element_text(color="red",face="bold", size = 12))
  })

    output$plot1 <- renderPlot(g2())

})
