library(shiny)
library(shinydashboard)
library(tidyverse)

dashdata <- read_csv("data/dashdata.csv")
kids <- read_csv("data/kids.csv")[1, ]

total_preg <- length(dashdata$OBSEnrolmentID) %>%
  as.character()

age <-  mean(dashdata$Age, na.rm = TRUE) %>%
  signif(2)

quest <- length(which(dashdata$LSQ1 ==1)) + length(which(dashdata$LSQ2 ==1)) +
  length(which(dashdata$LSQ3 ==1)) + length(which(dashdata$DHQ ==1)) %>%
  as.double()

samples <- length(which(dashdata$Blood1 == 1)) + length(which(dashdata$Blood2 == 1)) +
  length(which(dashdata$Blood3 == 1)) + length(which(dashdata$Blood4 == 1)) + 
  length(which(dashdata$BSc == 1)) + length(which(dashdata$Swab1 == 1)) + 
  length(which(dashdata$Swab2 == 1)) %>%
  as.double()


header = dashboardHeader(disable = TRUE)
sidebar = dashboardSidebar(disable = TRUE)
body = dashboardBody(
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
      width = 12, 
      color = "blue"
    )
    
  ), 
  
  fluidRow(
     
    
    valueBox(
      quest, 
      subtitle = "Questionnaires", 
      icon = icon("list"),
      width = 4
    ), 
    
    valueBox(
      samples, 
      subtitle = "Biospecimens", 
      icon = icon("vial", lib = "font-awesome"),
      width = 4
    ), 
    
    valueBox(
      age,
      "Average Participant Age",
      icon = icon("birthday-cake", lib = "font-awesome"), 
      width = 4
    )
    
  ), 
  
  fluidRow(
    tabBox(
      title = tagList(shiny::icon("list", lib = "font-awesome"), "Questionnaire Breakdown"),
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset1", height = "100px",
      selected = "11-16 wks. GA",
      tabPanel("6-10 wks Post", length(which(dashdata$LSQ3 == 1)), " (6-10 weeks)"), 
      tabPanel("28-34 wks. GA", length(which(dashdata$LSQ2 == 1)), " (28 weeks gestational age)"),
      tabPanel("11-16 wks. GA", paste0(length(which(dashdata$LSQ1 == 1))), " (12-16 weeks gestational age)"),
      side = "right",
      width = 12
    )
  ),
  fluidRow(
    tabBox(
      title = tagList(shiny::icon("vial", lib = "font-awesome"), "Maternal Biopecimens"),
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset2", height = "100px",
      selected = "12 weeks",
      tabPanel("Vaginal Swabs", paste0(length(which(dashdata$Swab1 == 1)) + length(which(dashdata$Swab2 == 1)))," (routinely collected at 12-13 and 32-36 weeks gestational age)"),
      tabPanel("Delivery", length(which(dashdata$Blood4 == 1))), 
      tabPanel("28 weeks", length(which(dashdata$Blood3 == 1))),
      tabPanel("16 weeks", length(which(dashdata$Blood2 == 1))),
      tabPanel("12 weeks", length(which(dashdata$Blood1 == 1))),
      width = 12, 
      side = "right"
    )
  ),
  
  fluidRow(
    valueBox(
      kids$total_child, 
      subtitle = "Children in follow-up", 
      icon = icon("child", lib = "font-awesome"),
      color = "teal", 
      width = 4
    ), 
    
    valueBox(
      kids$follow_ups, 
      subtitle = "Completed follow-ups", 
      icon = icon("address-book", lib = "font-awesome"), 
      color = "teal", 
      width = 4
    ), 
    
    valueBox(
      kids$nih, 
      subtitle = "NIH Toolbox cognitive assessments", 
      icon = icon("toolbox", lib = "font-awesome"), 
      color = "teal", 
      width = 4
    )
  ), 
  
  fluidRow(
    tabBox(
      title = tagList(shiny::icon("child", lib = "font-awesome"), "Follow-up Schedule"),
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset3", height = "100px",
      selected = "8 months",
      tabPanel("4.5 years", kids$fourptfv),
      tabPanel("36 months", kids$thrtysx),
      tabPanel("24 months", kids$twntyfour),
      tabPanel("8 months", kids$eight),
      width = 12,
      side = "right"
    )
  ), 
  
  fluidRow(
    tabBox(
      title = tagList(shiny::icon("vial", lib = "font-awesome"), "Child Biopecimens"),
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset4", height = "100px",
      selected = "Infant Blood Card",
      tabPanel("Child Saliva", paste0(kids$saliva, " (collected at 24 months and 4.5 years)")),
      tabPanel("Infant Blood Card", paste0(length(which(dashdata$BSc == 1)), " (collected approx. 24h after birth)")),
      width = 12,
      side = "right"
    )
  )
)



ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {

}

shinyApp(ui, server)
