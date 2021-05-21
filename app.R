
library(shiny)
library(dplyr)

ui <- fluidPage(
    titlePanel("Heart Attack Predictor"),
    sidebarLayout(
        sidebarPanel(
            
            #get User Input
            
            sliderInput(inputId="age",label="Choose your Age (Move The Slider):",value=21,min=1,max=100),
            radioButtons(inputId = "sex",label="Specify your Gender: ",c("Female"="Female","Male"="Male")),
            radioButtons(inputId = "exang",label="Did you experience chest pain during exercise? ",c("Yes"="Yes","No"="No")),
            selectInput(inputId = "cp","Chest Pain Type: ",c("Typical Angina"="Typical Angina","Atypical Angina"="Atypical Angina",
                                                             "Non-Anginal Pain"="Non-Anginal Pain","Asymptomatic"="Asymptomatic")),
            numericInput(inputId = "chol",label="Enter your total blood cholesterol level (mg/dl): ", value=150, min=50,max=280),
            numericInput(inputId = "fbsInput",label = "Enter your fasting blood sugar value (mg/dl): ", value=110, min=40,max=300),
            numericInput(inputId = "thalachh",label = "Enter your maximum heart rate achieved (bpm): ", value=180, min=100, max=220),
            numericInput(inputId = "trtbps",label = "Enter your Resting Blood Pressure (mm Hg): ", value=120 ,min=70 ,max=200 ),
            selectInput(inputId = "restecg","Rest ECG:",c("Normal"="Normal","Slightly abnormality"="Slightly abnormality","Left ventricular hypertrophy"="Left ventricular hypertrophy")),
            br(),
            actionButton("enter", label = "Predict")
        ),
        mainPanel(
            tabsetPanel(type="tabs",
                        
                        #Tab 1 - show user input details and comments based on input
                        
                        tabPanel("Details & Comments",br(), 
                                 h2("Your Input Details & Comments: "),
                                 h3("Age:"),verbatimTextOutput("age"),
                                 h3("Gender:"),verbatimTextOutput("sex"),
                                 h3("Chest Pain during Exercise:"),verbatimTextOutput("exang"),textOutput("exangComment"),
                                 h3("Chest Pain Type: "), verbatimTextOutput("cp"),textOutput("cpComment"),
                                 h3("Total Blolod Cholesterol Level:"),verbatimTextOutput("chol"),textOutput("cholComment"),
                                 h3("Fasting Blood Sugar:"),verbatimTextOutput("fbsInput"),textOutput("fbsComment"),
                                 h3("Maximum Heart Rate Achieved: "),verbatimTextOutput("thalachh"),textOutput("thalachhComment"),
                                 h3("Resting Blood Pressure (mm Hg):"),verbatimTextOutput("trtbps"), textOutput("trtbpsComment"),
                                 h3("Rest ECG:"),verbatimTextOutput("restecg")
                        ),
                        
                        #Tab 2 - provide help / guideline to user when input details
                        
                        tabPanel("Description & Documentation",br(),
                                 h3("Chest Pain Type: "),
                                 h4("Typical Angina"),p("Chest pain or discomfort that was caused by exertion or emotional stress"),
                                 h4("Atypical Angina"),p("Experience discomfort or pain in chest, back or neck, shortness of breath, feel tired, nauseous or have indigestion."),
                                 h4("Non-Anginal Pain"),p("Non cardiac pain"),
                                 h4("Asymptomatic"),p("Non frequent pain."),
                                 
                                 br(),
                                 h3("Total Cholesterol Level (mg/dl) :"),
                                 h4("Desirable"),p("Less than 200 "),
                                 h4("Boderline High Risk"),p("200 - 239 "),
                                 h4("High Risk"),p("240 and above"),
                                 
                                 
                                 br(),
                                 h3("Normal Blood Sugar Value for Fasting: "),
                                 h4("Below 120 mg/dl"),
                                 
                                 br(),
                                 h3("Ideal Maximum Heart Rate: "),
                                 h4("Calculation: "), h4("Maximum Heart rate = 220 - Age"),
                                 p("Maximum heart rate will be vary 15 to 20 bpm in either direction. "),
                                 
                                 br(),
                                 h3("Resting Blood Pressure (mm Hg): "),
                                 h4("Desirable"),p("Less than 120"),
                                 h4("Elevated"),p("121 - 129 "),
                                 h4("High Blood Pressure (Hypertension) - Stage 1"),p("130 - 139"),
                                 h4("High Blood Pressure (Hypertension) - Stage 2"),p("140 - 179"),
                                 h4("Hypertensive Crisis"),p("180 and above"),
                                 
                                 
                                 br(),
                                 h3("Rest ECG: "),
                                 h4("Normal"),p("Chest pain or discomfort that was caused by exertion or emotional stress"),
                                 h4("Slightly abnormality"),p("Have ST-T wave abnormality (T wave inversions and/or ST elevation or depression of > 0.05 mV)"),
                                 h4("Left ventricular hypertrophy"),p("Show probable or definite left ventricular hypertrophy by Estes' criteria")
                        ),
                        
                        #Tab 3 - show predicted result and suggestions
                        
                        tabPanel("Result & Suggestion",br(),
                                 h2("Predicted Result: "),
                                 verbatimTextOutput("predicted"),br(),
                                 
                                 h2("Here are some tips to Prevent Heart Diseases: "),br(),
                                 h4("1. Get more fibre Into Your Diet"),p("- Take more vegetabls and fruits"),
                                 h4("2. Watch Your Weight"),p("- Maintain normal BMI"),
                                 h4("3. Exercise Regularly"),p("- Reduce stress"),
                                 h4("4. Wear a Pedometer or other Fitness Tracker "),p("- Have a goal for 10,000 steps count everyday"),
                                 h4("5. Read nutrition Lables"),p("- Follow a heart healthy diet. "),
                                 h4("6. Get a Good Night Sleep "), 
                                 h4("7. Find Ways to Reduce Stress"),p("- Maintain a healthy lifestyle"),
                                 h4("8. Stop smoking"),
                                 
                                 br(),p("The information is retrieved from Everyday Health on Ways to Prevent Heart Diseases "),
                                 p("Updated on: 25 February 2021"),
                                 p("Medically reviewed by Dr. Michael Cutler, PhD in Cardiovascular Physiology. "),
                                 p("Reference Link: https://www.everydayhealth.com/heart-health-pictures/heart-disease-prevention.aspx")
                        ),
                        
                        #Tab 4 - list of the dataset used
                        
                        tabPanel("Dataset",br(),
                                 h3("Heart Attack Analysis and Prediction Dataset"),
                                 dataTableOutput("dataset")
                        ),
                        
                        #Tab 5 - Summary nad source of the dataset used
                        
                        tabPanel("Summary",br(),
                                h3("Source of the Dataset: "),
                                h4("The dataset used is taken from Kaggle - Heart Attack Analysis and Prediction Dataset"),
                                h4("Size of the dataset: 303 observations and 10 variables"),
                                br(),
                                h3("Summary of the Dataset: "),
                                verbatimTextOutput("summary")
                        ),
                        
                        #Tab 6 - About the app
        
                        tabPanel("About",br(),
                                 h2("Problem Statement: "),
                                 h4(" People do not know that they are at risk for Heart Attack"),br(),
                                 h2("Solution: "),
                                 h4("Heart Attack Predictor to enable users to predict their risk of Heart Attack and take further actions."),
                                 h4("Tips to prevent Heart Diseases also provided for user references."),
                                 
            )))))

# transform user input to align with dataset

transformSEX<-function(sex){
    if(sex=="Female"){
        new=0
    }else
        new=1
    new
}

transformEXANG<-function(exang){
    if(exang=="Yes"){
        new=1
    }else
        new=0
    new
}

transformCP<-function(cp){
    if(cp=="Asymptomatic"){
        new=3
    }else if(cp=="Non-Anginal Pain"){
        new=2
    }else if(cp=="Atypical Angina"){
        new=1
    }else
        new=0
    new
}

transformFBS<-function(fbs){
    if(fbs>=120){
        new=1
    }else
        new=0
    new
}

transformRESTECG <- function(restecg){
    if(restecg=="Normal"){
        new=0
    }else if(restecg=="Slightly abnormality"){
        new=1
    }else
        new=2
    new
}

# give comments on each particular details based on user input

commentCP <- function(cp){
    if(cp=="Typical Angina"||cp=="Atypical Angina"){
        print("***Chest Pain occured due to blockages in the blood vessels leading to your heart. Consult to your doctor if possible.")
    }
}

commentChol <- function(chol){
    if(chol<200){
        print("***Desirable Cholesterol Level")
    }else if(chol>=200&&chol<=239){
        print("Boderline High Risk Cholesterol Level")
    }else
        print("***High Risk")
}

commentFbs <-function(fbs){
    if(fbs>=120){
        print("***Your Fasting Blood sugar value is high")
    }else
        print("***Your Fasting Blood sugar value is normal")
}

commentThalachh <- function(thalachh,age){
    max=220-age
    if(thalachh>=max+15||thalachh<=max-15){
        print("***Ideal Maximum Heart Rate")
    }else{
        print("***Not Ideal Maximum Heart Rate")
    }
}

commentTrtbps <- function(trtbps){
    if(trtbps<=120){
        print("***Desirable Resting Blood Pressure ")
    }else if(trtbps>=121&&trtbps<=129){
        print("***Elevated Resting Blood Pressure ")
    }else if(trtbps>=130&&trtbps<=139){ 
        print("***You are at the Stage 1 of High Blood Pressure (Hypertension)")
    }else if(trtbps>=140&&trtbps<=179){
        print("***You are at the Stage 2 of High Blood Pressure (Hypertension)")
    }else{
        print("Hypertensive Crisis. Your Blood Pressure is too high. Consult to doctor if possible. ")
    }
}

commentExang <-function(exang){
    if(exang=="Yes"){
        print("***Chest Pain during exercise is one of the symptoms of heart attack.")
    }
}

finalResult<-function(value){
    if(value>=0.5){
        print(paste("Risk for Heart Attack: High","***Consult your doctor for further details",sep="\n"))
    }else{
        print("Risk for Heart Attack: Low")
    }
}

#read the heart data
heart.data<-read.csv("heart2.csv",header=TRUE)

server <- function(input, output) {
    output$age <- renderText(input$age)
    output$sex <- renderText(input$sex)
    output$exang <- renderText(input$exang)
    output$exangComment <- renderText({commentExang(input$exang)})
    output$cp <- renderText(input$cp)
    output$cpComment <- renderText({commentCP(input$cp)})
    output$chol <- renderText(input$chol)
    output$cholComment <- renderText({commentChol(input$chol)})
    output$fbsInput <- renderText(input$fbsInput)
    output$fbsComment <- renderText({commentFbs(input$fbsInput)})
    output$thalachh <- renderText(input$thalachh)
    output$thalachhComment <- renderText({commentThalachh(input$thalachh,input$age)})
    output$trtbps <- renderText(input$trtbps)
    output$trtbpsComment <- renderText({commentTrtbps(input$trtbps)})
    output$restecg <- renderText(input$restecg)
    
    output$value <- renderText({check(input$age,transformSEX(input$sex),transformCP(input$cp),
                                      input$trtbps,input$chol,transformFBS(input$fbsInput),
                                      transformRESTECG(input$restecg),input$thalachh,transformEXANG(input$exang))})
    
    #prediction based on user input
    
    output$dataset <- renderDataTable({heart.data})
    
    output$summary <- renderPrint({summary(heart.data)})
    
    heartmod <- glm(output ~ ., data = heart.data, family = binomial)
    
    val <- eventReactive(
        
        input$enter, {
            data.frame(
                age = as.integer(input$age),
                sex = as.integer({transformSEX(input$sex)}),
                cp = as.integer({transformCP(input$cp)}),
                trtbps = as.integer(input$trtbps),
                chol = as.integer(input$chol),
                fbs = as.integer({transformFBS(input$fbsInput)}),
                restecg = as.integer({transformRESTECG(input$restecg)}),
                thalachh = as.integer(input$thalachh),
                exang = as.integer({transformEXANG(input$exang)}),
                stringsAsFactors = F
            )}
    )
  
    output$predicted <- renderText({finalResult({predict(heartmod, val(), type = "response")})})
    
}

shinyApp(ui = ui, server = server)