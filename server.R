library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {
  
  resultLog <- eventReactive(input$do2,{
    read.csv("Results_Log.csv",header=T,colClasses = rep("character",3))
  })
  
  datasetInput <- eventReactive(input$do,{
    inFile <- input$file1
    if(is.null(inFile)){ NULL}else{
      dat <- read.csv(inFile$datapath, header=T) 
      Ydat <- read.csv("Actuals.csv",header = T)
      mean((Ydat$Y - dat$Y)^2)
      }
    })      
      
  output$summary <- renderPrint({
      out <- datasetInput()
      if(is.null(out)){out <- "Upload valid File"}
      resultLog <- read.csv("Results_Log.csv",header=T,colClasses = rep("character",3))
      resultLog <- rbind(resultLog,c(Sys.time(),Sys.info()[6],out))
      write.csv(resultLog,file="Results_Log.csv",row.names=F)
      return(out)
    })
  
  output$Leaderboard <- renderTable({
    result <- resultLog() 
    result <- result[order(result$RMSE),]
    result[1:5,]
  })
  
  })
  
