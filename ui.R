library(shiny)

shinyUI(fluidPage(
  titlePanel("Upload Your Output File"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      actionButton("do", "Submit"),
      actionButton("do2", "Refresh Leaderboard")
    ),
    mainPanel(
      h4('Your RMSE Score:'),
      verbatimTextOutput("summary"),
      h4("Leaderboard"),
      tableOutput("Leaderboard")
    )
  )
))