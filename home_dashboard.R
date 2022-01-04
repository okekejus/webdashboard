library(shiny)
library(shinydashboard)
library(tidyverse)

dashdata <- read_csv("data/DashboardData.csv")

total_preg <- length(dashdata$OBSEnrolmentID) %>%
  as.character()

age <- mean(dashdata$Age, na.rm = TRUE) %>%
  signif(2)

quest <-  length(which(dashdata$LSQ1 == 1)) + length(which(dashdata$LSQ2 == 1)) +
  length(which(dashdata$LSQ3 == 1)) + length(which(dashdata$DHQ == 1)) %>%
  as.double()

samples <- length(which(dashdata$Blood1 == 1)) + length(which(dashdata$Blood2 == 1)) +
  length(which(dashdata$Blood3 == 1)) + length(which(dashdata$Blood4 == 1)) + 
  length(which(dashdata$BSc == 1)) + length(which(dashdata$Swab1 == 1)) + 
  length(which(dashdata$Swab2 == 1)) %>%
  as.double()


child <- 1665 # these numbers exist in a separate database, updated manually for now. 

child_follow <-  2553

header <- dashboardHeader(disable = TRUE)
sidebar <- dashboardSidebar(disable = TRUE)
body <-  dashboardBody(
  tags$head(tags$style(HTML('
      .content-wrapper {
        background-color: #fff;
      }
    '
  ))),
  
  fluidRow(
    valueBox( 
      total_preg, 
      "Total Pregnancies",
      icon = icon("baby"),
      width = 12
      )
    
    ), 
  
  fluidRow(
    valueBox(
      quest, 
      subtitle = "Questionnaires", 
      icon = icon("list"), 
      color = "teal", 
      width = 6
      ), 
    valueBox(
      age,
      "Average Participant Age",
      icon = icon("birthday-cake", lib = "font-awesome"), 
      color = "teal", 
      width = 6
    )
  ), 
  
  fluidRow(
    valueBox(
      child, 
      subtitle = "Children in follow-up", 
      icon = icon("child", lib = "font-awesome"),
      color = "teal", 
      width = 6
    ), 
    valueBox(
      samples, 
      subtitle = "Biospecimens", 
      icon = icon("vial", lib = "font-awesome"),
      color = "teal",
      width = 6
    )
  ),
  
  fluidRow(
    
    valueBox(
      child_follow, 
      subtitle = "Completed child follow-ups", 
      icon = icon("address-book", lib = "font-awesome"), 
      color = "teal", 
      width = 12
    )
  )
  )



ui <- dashboardPage(header, sidebar, body, skin = "blue")

server <- function(input, output) { }

shinyApp(ui, server)
