#ininstall.packages("shiny")
library("shiny")
options(shiny.maxRequestSize=9*1024^2)

#install.packages("igraph")
#install.packages("network") 
#install.packages("sna")
#install.packages("ndtv")
#install.packages("extrafont")


library(igraph)
library(network)
library(sna)
library(ndtv)
library(extrafont)

#install.packages("networkD3")
library(networkD3)



shinyUI(fluidPage(
  titlePanel(title=h3("Brain Informatics",
             align="right")
             ),
  
  sidebarLayout(
    sidebarPanel(
      h3("InputPanel",align="left"),
      br(),
      br(),
      h4(helpText("Upload required files"),align="left"),
      fileInput("training","Upload train file in csv format"),
      fileInput("alpha","Upload alpha file in csv format"),
      fileInput("beta","Upload beta file in csv format"),
      fileInput("gamma","Upload gamma file in csv format"),
      fileInput("theta","Upload theta file in csv format"),
      h4(helpText("DO the files contain headers "),align="left"),
      checkboxInput("headers","Yes",value = TRUE),
      checkboxInput("headers","No",value = FALSE),
      
      h4(helpText("Enter the EEG signal values for predicting :"), align="left"),
      textInput("c1", "Enter the value for AF3", value = 3.609134, width = '350px'),
      textInput("c2", "Enter the value for F7", value = 0.428535, width = '350px'),
      textInput("c3", "Enter the value for F3", value = 1.288644, width = '350px'),
      textInput("c4", "Enter the value for FC5", value = 1.820404, width = '350px'),
      textInput("c5", "Enter the value for T7", value = 0.283729, width = '350px'),
      textInput("c6", "Enter the value for P7", value = 0.293612, width = '350px'),
      textInput("c7", "Enter the value for O1", value = 1.157706, width = '350px'),
      textInput("c8", "Enter the value for O2", value = 1.728738, width = '350px'),
      textInput("c9", "Enter the value for P8", value = 1.068931, width = '350px'),
      textInput("c10", "Enter the value for T8", value = 0.883266, width = '350px'),
      textInput("c11", "Enter the value for FC6", value = 1.240695, width = '350px'),
      textInput("c12", "Enter the value for F4", value = 2.452375, width = '350px'),
      textInput("c13", "Enter the value for F8", value = 0.072686, width = '350px'),
      textInput("c14", "Enter the value for AF4", value = 1.446363, width = '350px'),
      submitButton("Run")
      ),
    mainPanel("mainpanel")
  )
  
))