library(neuralnet)
library(e1071)
#library(glm2)


library(ggplot2)
library(shiny)
library(forecast)
library(e1071)
library(kernlab)
library(deepnet)
library(RSNNS)
library(neuralnet)
library(MASS)
library(Hmisc)
library(eegkit)
library(eegAnalysis)
library(shinyRGL)
#require(SMA)

shinyServer(
  
  function(input,output)
  {
    data <- reactive({
      file1 <- input$file
      
      if(is.null(file1))
      {return()}
      read.table(file=file1$datapath, sep=input$sep, header=input$header, stringsAsFactors=input$stringsasfactors) 
    })
    
    data2 <- reactive({
      file2 <- input$filealpha
      
      if(is.null(file2))
      {return()}
      read.table(file=file2$datapath, sep=input$sep, header=input$header, stringsAsFactors=input$stringsasfactors)
    })
    
    data3 <- reactive({
      file3 <- input$filebeta
      
      if(is.null(file3))
      {return()}
      read.table(file=file3$datapath, sep=input$sep, header=input$header, stringsAsFactors=input$stringsasfactors)
    })
    
    data4 <- reactive({
      file4 <- input$filegamma
      
      if(is.null(file4))
      {return()}
      read.table(file=file4$datapath, sep=input$sep, header=input$header, stringsAsFactors=input$stringsasfactors)
    })
    
    data5 <- reactive({
      file5 <- input$filetheta
      
      if(is.null(file5))
      {return()}
      read.table(file=file5$datapath, sep=input$sep, header=input$header, stringsAsFactors=input$stringsasfactors)
    })
    
    data6 <- reactive({
      file6 <- input$filetest
      
      if(is.null(file6))
      {return()}
      read.table(file=file6$datapath, sep=input$sep, header=input$header, stringsAsFactors=input$stringsasfactors)
    })
    
    
    output$filedf <- renderText({
      "                             
      
      ------------------------------------------------------------------------------------------------------------------
      
      In this project we are trying to classify the workload on various subjects using various non-linear deep learning 
      algorithms. We are using the Electroencephalographical Recordings (EEG) of both the subjects and then after feature 
      extraction applying various non-linear classifiers to analyze the features.
      
      We are implementing 5 deep learning algorithms - 
      
      1. Types of Artifical Neural Networks (+RBackprop, -RBackprop, etc)
      2. Support Vector Machines (SVMs)
      3. Stacked Autoencoders (SAEs)
      4. Radial Basic Function (RBFs)
      5. Linear Discriminant Analysis (LDAs) 
      
      The accuracy of each model is calculated and the final classification is produced in terms of the 3 classes-
      Base Line (BL), Low Work Load (LWL) and High Work Load (HWL).  
      The models designed, take the input as 14/64 channel data recordings and predict the outcome in form of these 3
      classes. 
      
      Furthermore, we are trying to analyze the affect of each individual feature of the signals (alpha, beta, etc)
      on the final result and find out the correlation between these features.
      The correlation is depicted using Pearson's correlation coefficient. 
      
      The models thus trained with the testing data will be capable of classifying the workload on any subject based 
      on the EEG recordings and predict whether the user is having high, low or no workload. 
      
      -------------------------------------------------------------------------------------------------------------------"
    })
    
    
    
    ####################################################################################################################################################
    ################################################# 14 channel functions #############################################################################
    ####################################################################################################################################################
    
    output$table <- renderTable({
      if(is.null(data())){return()}
      data()  
    })
    
    output$table1 <- renderTable({
      if(is.null(data())){return()}
      data()  
    })
    
    output$table2 <- renderTable({
      if(is.null(data())){return()}
      data()  
    })
    
    output$table3 <- renderTable({
      if(is.null(data())){return()}
      data()  
    })
    
    output$table4 <- renderTable({
      if(is.null(data())){return()}
      data()  
    })
    
    output$table5 <- renderTable({
      if(is.null(data())){return()}
      data2() 
    })
    #####################################################################################################################################################
    output$ann <- renderTable({
      file2 <- data()
      file2 <- data.frame(file2)
      
      x <- subset(file2, select = -c(BL, LWL, HWL))
      
      BL <- file2$BL
      LWL <- file2$LWL
      HWL <- file2$HWL
      
      y <- data.frame(BL, LWL, HWL)
      
      c1 <- as.numeric(input$c1)
      c2 <- as.numeric(input$c2)
      c3 <- as.numeric(input$c3)
      c4 <- as.numeric(input$c4)
      c5 <- as.numeric(input$c5)
      c6 <- as.numeric(input$c6)
      c7 <- as.numeric(input$c7)
      c8 <- as.numeric(input$c8)
      c9 <- as.numeric(input$c9)
      c10 <- as.numeric(input$c10)
      c11 <- as.numeric(input$c11)
      c12 <- as.numeric(input$c12)
      c13 <- as.numeric(input$c13)
      c14 <- as.numeric(input$c14)
      c <- data.frame(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14)
      
      net <- neuralnet(BL+LWL+HWL~AF3+F7+F3+FC5+T7+P7+O1+O2+P8+T8+FC6+F4+F8+AF4, file2, hidden=8, rep=10, algorithm = "rprop+", err.fct="ce", linear.output=FALSE)
      
      j <- compute(net, c)$net.result
      
      Base_Load <- j[1,1]
      Low_Work_Load <- j[1,2]
      High_Work_Load <- j[1,3]
      
      result <- data.frame(Base_Load, Low_Work_Load, High_Work_Load)
      
    })
    
    
    ########################################################################################################################################
    
    
    output$plotann <- renderPlot({
      file2 <- data()
      file2 <- data.frame(file2)
      
      x <- subset(file2, select = -c(BL, LWL, HWL))
      
      BL <- file2$BL
      LWL <- file2$LWL
      HWL <- file2$HWL
      
      y <- data.frame(BL, LWL, HWL)
      
      c1 <- as.numeric(input$c1)
      c2 <- as.numeric(input$c2)
      c3 <- as.numeric(input$c3)
      c4 <- as.numeric(input$c4)
      c5 <- as.numeric(input$c5)
      c6 <- as.numeric(input$c6)
      c7 <- as.numeric(input$c7)
      c8 <- as.numeric(input$c8)
      c9 <- as.numeric(input$c9)
      c10 <- as.numeric(input$c10)
      c11 <- as.numeric(input$c11)
      c12 <- as.numeric(input$c12)
      c13 <- as.numeric(input$c13)
      c14 <- as.numeric(input$c14)
      c <- data.frame(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14)
      
      net <- neuralnet(BL+LWL+HWL~AF3+F7+F3+FC5+T7+P7+O1+O2+P8+T8+FC6+F4+F8+AF4, file2, hidden=8, rep=10, algorithm = "rprop+",err.fct="ce", linear.output=FALSE)
      
      plot(net, rep = "best")
      
    })
    output$tb <- renderUI({
      if(is.null(data()))
      {h5(tags$img(src="brain.png"), height=150, width=300)}
      else{
        if(input$f14 == TRUE)
        {
          tabsetPanel(
            tabPanel("About the Project", verbatimTextOutput("filedf")),
            tabPanel("Artifical Neural Networks (ANN)", plotOutput("plotann"),  tableOutput("sample"), tableOutput("ann"), tableOutput("table"))
          )
        }
        else if(input$f64 == TRUE)
        {
          tabsetPanel(
            tabPanel("About the Project", verbatimTextOutput("filedf")),
            tabPanel("Artifical Neural Networks (ANN)", plotOutput("plotann64"),  tableOutput("sample64"), tableOutput("ann64"), tableOutput("table64"))
            
          )
        }
      }
    })
    
    })
