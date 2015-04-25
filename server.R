library(shiny)
library(caret)
data(cars)
set.seed(42)
rand <- sample(nrow(cars))
cars<-cars[rand,]

for(i in 2:4){
  cars[[paste0(names(cars)[i],".squared")]]<-cars[,i]^2
}




shinyServer(function(input, output) {
 
  
  
  
  
  # You can access the value of the widget with input$slider1, e.g.
  output$samplesize <- renderPrint({ paste0("using ",input$sample, "% of dataset to train model and ",100-input$sample,"% to test results.") })
  
  # You can access the values of the second widget with input$slider2, e.g.

  
  output$value <- renderPrint({ 
        if(input$intercept){
          "Using intercept in model"
        }else{
          "Model without intercept"
        }
        })
  
  output$MLSE <- renderPrint({ 
    
    features<-c(input$features, input$features.squared)
    if(length(features)==0){
      features <- "."
    } 
    
    rows<-nrow(cars)
    training <- cars[1:round(rows*(input$sample/100),0),] #indexing using partition split
    testing <- cars[(round(rows*(input$sample/100),0)+1):rows,] #indexing using partition split
    
    
    
    f<-as.formula(paste0("Price ~ ", paste(features, collapse = " + "),if(input$intercept){""}else{" - 1"}))
    fit<-glm(f,  data = training)
    
    pred <- predict(fit, testing)
    formatedMSE<-formatC(mean((pred - testing$Price)^2), decimal.mark=",", big.mark=" ", digits = 2, format = "f")
    
    paste0("MSE = ",formatedMSE)
    
  })
  
  output$fit <- renderPrint({ 
    
    features<-c(input$features, input$features.squared)
    if(length(features)==0){
      features <- "."
    } 
    
    rows<-nrow(cars)
    training <- cars[1:round(rows*(input$sample/100),0),] #indexing using partition split
    testing <- cars[(round(rows*(input$sample/100),0)+1):rows,] #indexing using partition split
    
    
    
    f<-as.formula(paste0("Price ~ ", paste(features, collapse = " + "),if(input$intercept){""}else{" - 1"}))
    fit<-glm(f,  data = training)
    varimp<-varImp(fit) 
    varimp[order(-varimp[,1]), , drop = FALSE]
    
    })
  
  output$residuals <- renderPlot({
    features<-c(input$features, input$features.squared)
    if(length(features)==0){
      features <- "."
    } 
    
    rows<-nrow(cars)
    training <- cars[1:round(rows*(input$sample/100),0),] #indexing using partition split
    testing <- cars[(round(rows*(input$sample/100),0)+1):rows,] #indexing using partition split
    
    
    
    f<-as.formula(paste0("Price ~ ", paste(features, collapse = " + "),if(input$intercept){""}else{" - 1"}))
    fit<-glm(f,  data = training)
    plot(fit)
  })
})