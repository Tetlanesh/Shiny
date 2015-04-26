Tweaking regression model
========================================================
author: Marcin Strus
date: 2015.04.26
transition: rotate


<small>
This presentaion is part of grade project for Coursera course "Developing data products". Project consist of:
<font color=white>
<ul>
<li>Shiny application: <a href="https://tetlanesh.shinyapps.io/Shiny/">https://tetlanesh.shinyapps.io/Shiny/</a></li>
<li>This presentation</li>
</ul>
</font>
</small>

Introduction
========================================================

The goal of my project Shiny application was to combine knowledge we got trough other courses in this specialisation. So I choose to make a very simple model and let user tweek its parameters. 

- How much data will go into traqining and how much into test set
- Whetever or not model should include intercept
- Which features should be used in the model (including few squared feature for a little on non-linearity)

So what do we see?
========================================================

After getting input from user `glm()` model is calculated and results are printed for user to asses if given parameters give better or worse result. Model itself is very in-accurate so MSE goes into milions, but the main goal is to use Shiny application inputs to change model behaviour. 

User is presented with fillowing results from the model:
<small>
- MSE - Means Squared Error (`MSE = mean((y - yhat)^2 )`) calculated on the test set.
- Variable Importance - a meassure of how important for model prediction each feature used in model. List is sorted so best predictiors are at the top (using `varImp(fit)` funtion from `caret` package)
- Graph of residuals (using `plot(fit)` function)
</small>

Dynamic input values
========================================================

<small>
Asside from calculated conted displayed as result of model calculation there is also dynamic part in input part of application. List of features and second degree polynomial features available for user to select is calculated on the fly, including the `*.squared` features and put into `checkboxGroupInput` inputs:


```r
for(i in 2:4){
cars[[paste0(names(cars)[i],
             ".squared")]]<-cars[,i]^2
}
names(cars[19:21])
```

```
[1] "Mileage.squared"  "Cylinder.squared" "Doors.squared"   
```

```r
checkboxGroupInput("features", 
          label = h3("Features to include:"), 
          choices = names(cars[2:18]),
          selected = names(cars[2:18]))
```
</small>

Conclussion
========================================================

Combination of dynamic inpouts with calculations on server side can give powerfull presentation value to your data products. Tools like **Shiny** can be used for small project but also in large companies as information delivery systems. 

My little project is just a simple showcase of potential You can expect from **Shiny**.

Application is available at: <ahref="https://tetlanesh.shinyapps.io/Shiny/">https://tetlanesh.shinyapps.io/Shiny/</a>, go check it out and have fun tweaking the model. 

Can You get it below 7 000 000?


