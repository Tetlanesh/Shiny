library(shiny)
library(caret)
data(cars)
set.seed(42)
rand <- sample(nrow(cars))
cars<-cars[rand,]

for(i in 2:4){
  cars[[paste0(names(cars)[i],".squared")]]<-cars[,i]^2
}


shinyUI(pageWithSidebar(
  headerPanel("Try to get the model as precise as possible"),
  sidebarPanel(
    fluidRow(
      
    p("Use below sliders and checkboxes to change input for glm model."),
    br(),
    p("The goal is to train model on a training set and test it on testing set and present results (plots of residual, Variable Importance from model and MSE calculated on test set). Our model will try to predict price of car based on list of features of each car. We are using `cars` dataset from `caret` package."),
    br(),
    p("List of inputs You can change:"),
    tags$ol(
      tags$li("Percentage of data that go into training set. Remaining goes into test set."),
      tags$li("Whetever or not to use intercept"),
      tags$li("List of features to include in the model"),
      tags$li("List of features to use as second degree polynomial")
    )
    ),
  fluidRow(

           sliderInput("sample", label = h3("Sample size [%]"), min = 10, 
                       max = 90, value = 70),
           
           checkboxInput("intercept", label = "Use Intercept?", value = TRUE),

           checkboxGroupInput("features", label = h3("Features to include:"), 
                              choices = names(cars[2:18]),
                              selected = names(cars[2:18])),
           checkboxGroupInput("features.squared", label = h3("2nd degree features:"), 
                              choices = names(cars[19:21]))
    )
    
  ),
  
  
  mainPanel(
    verbatimTextOutput("samplesize"),

    verbatimTextOutput("value"),
    
    verbatimTextOutput("MLSE"),

    verbatimTextOutput("fit"),
    
    plotOutput("residuals")
  )
  
))

