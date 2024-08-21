library(flexdashboard)
library(shiny)
library(shinydashboard)
library(e1071)

# Load the pre-trained models
model_Ery <- readRDS("model_Ery.RDS")
model_Levo <- readRDS("model_Levo.RDS")
model_Clin <- readRDS("model_Clin.RDS")

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Antibiotic Resistance Prediction Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Instructions", tabName = "instructions", icon = icon("info-circle")),
      menuItem("Erythromycin Prediction", tabName = "erythromycin", icon = icon("medkit")),
      menuItem("Levofloxacin Prediction", tabName = "levofloxacin", icon = icon("medkit")),
      menuItem("Clindamycin Prediction", tabName = "clindamycin", icon = icon("medkit"))
    )
  ),
  dashboardBody(
    tabItems(
      # Instructions Tab
      tabItem(tabName = "instructions",
              h2("How to Use the Dashboard"),
              p("This dashboard allows you to predict antibiotic resistance for Erythromycin_I, Levofloxacin, and Clindamycin based on patient data. 
                 Follow these steps for each prediction:"),
              tags$ol(
                tags$li("Select the appropriate tab for the antibiotic you wish to predict."),
                tags$li("Fill in the patient information in the sidebar by selecting options for Gender, Age Group, Speciality, Source, and whether the patient is an In or Out Patient."),
                tags$li("Click the 'Predict' button to get the resistance prediction."),
                tags$li("The prediction result will be displayed in the main panel.")
              )
      ),
      
      # Erythromycin_I Prediction Tab
      tabItem(tabName = "erythromycin",
              sidebarLayout(
                sidebarPanel(
                  selectInput("Gender_Ery", "Gender", choices = c("Male", "Female")),
                  selectInput("Age.Group_Ery", "Age Group", choices = c(
                    "0 to 2 Years", "13 to 18 Years", "19 to 64 Years", "3 to 12 Years",
                    "65 to 84 Years", "85 and Over", "Unknown"
                  )),
                  selectInput("Speciality_Ery", "Speciality", choices = c(
                    "Clinic / Office", "Emergency Room", "General Unspecified ICU", "Medicine General",
                    "Medicine ICU", "None Given", "Nursing Home / Rehab", "Other", 
                    "Pediatric General", "Pediatric ICU", "Surgery General", "Surgery ICU"
                  )),
                  selectInput("Source_Ery", "Source", choices = c(
                    "Abdominal Fluid", "Abscess", "Appendix", "Aspirate", "Bladder", "Blood",
                    "Bodily Fluids", "Bone", "Bronchiole", "Bronchoalveolar lavage", "Bronchus", 
                    "Burn", "Carbuncle", "Catheters", "Cellulitis", "Cervix", "Circulatory: Other",
                    "CNS: Other", "Colon", "CSF", "Decubitus", "Ear", "Endotracheal aspirate", 
                    "Exudate", "Eye", "Furuncle", "Gall Bladder", "Gastric Abscess", "Genitourinary: Other", 
                    "Head", "Impetiginous lesions", "Instruments: Other", "Integumentary (Skin Nail Hair)", 
                    "Intestinal: Other", "Kidney", "Liver", "Lungs", "Lymph Nodes", "Mouth", 
                    "Muscle", "None Given", "Nose", "Pancreas", "Peripheral Nerves", "Peritoneal Fluid", 
                    "Pleural Fluid", "Prostate", "Respiratory: Other", "Skeletal: Other", "Skin", 
                    "Skin: Other", "Spinal Cord", "Sputum", "Stomach", "Synovial Fluid", "Thoracentesis Fluid", 
                    "Throat", "Tissue Fluid", "Trachea", "Ulcer", "Ureter", "Urethra", "Urine", 
                    "Uterus", "Vagina", "Wound"
                  )),
                  selectInput("Patient_Ery", "In or Out Patient", choices = c(
                    "Inpatient", "None Given", "Other", "Outpatient"
                  )),
                  actionButton("predict_Ery", "Predict")
                ),
                mainPanel(
                  verbatimTextOutput("prediction_Ery")
                )
              )
      ),
      
      # Levofloxacin Prediction Tab
      tabItem(tabName = "levofloxacin",
              sidebarLayout(
                sidebarPanel(
                  selectInput("Gender_Levo", "Gender", choices = c("Male", "Female")),
                  selectInput("Age.Group_Levo", "Age Group", choices = c(
                    "0 to 2 Years", "13 to 18 Years", "19 to 64 Years", "3 to 12 Years",
                    "65 to 84 Years", "85 and Over", "Unknown"
                  )),
                  selectInput("Speciality_Levo", "Speciality", choices = c(
                    "Clinic / Office", "Emergency Room", "General Unspecified ICU", "Medicine General",
                    "Medicine ICU", "None Given", "Nursing Home / Rehab", "Other", 
                    "Pediatric General", "Pediatric ICU", "Surgery General", "Surgery ICU"
                  )),
                  selectInput("Source_Levo", "Source", choices = c(
                    "Abdominal Fluid", "Abscess", "Appendix", "Aspirate", "Bladder", "Blood",
                    "Bodily Fluids", "Bone", "Bronchiole", "Bronchoalveolar lavage", "Bronchus", 
                    "Burn", "Carbuncle", "Catheters", "Cellulitis", "Cervix", "Circulatory: Other",
                    "CNS: Other", "Colon", "CSF", "Decubitus", "Ear", "Endotracheal aspirate", 
                    "Exudate", "Eye", "Furuncle", "Gall Bladder", "Gastric Abscess", "Genitourinary: Other", 
                    "Head", "Impetiginous lesions", "Instruments: Other", "Integumentary (Skin Nail Hair)", 
                    "Intestinal: Other", "Kidney", "Liver", "Lungs", "Lymph Nodes", "Mouth", 
                    "Muscle", "None Given", "Nose", "Pancreas", "Peripheral Nerves", "Peritoneal Fluid", 
                    "Pleural Fluid", "Prostate", "Respiratory: Other", "Skeletal: Other", "Skin", 
                    "Skin: Other", "Spinal Cord", "Sputum", "Stomach", "Synovial Fluid", "Thoracentesis Fluid", 
                    "Throat", "Tissue Fluid", "Trachea", "Ulcer", "Ureter", "Urethra", "Urine", 
                    "Uterus", "Vagina", "Wound"
                  )),
                  selectInput("Patient_Levo", "In or Out Patient", choices = c(
                    "Inpatient", "None Given", "Other", "Outpatient"
                  )),
                  actionButton("predict_Levo", "Predict")
                ),
                mainPanel(
                  verbatimTextOutput("prediction_Levo")
                )
              )
      ),
      
      # Clindamycin Prediction Tab
      tabItem(tabName = "clindamycin",
              sidebarLayout(
                sidebarPanel(
                  selectInput("Gender_Clin", "Gender", choices = c("Male", "Female")),
                  selectInput("Age.Group_Clin", "Age Group", choices = c(
                    "0 to 2 Years", "13 to 18 Years", "19 to 64 Years", "3 to 12 Years",
                    "65 to 84 Years", "85 and Over", "Unknown"
                  )),
                  selectInput("Speciality_Clin", "Speciality", choices = c(
                    "Clinic / Office", "Emergency Room", "General Unspecified ICU", "Medicine General",
                    "Medicine ICU", "None Given", "Nursing Home / Rehab", "Other", 
                    "Pediatric General", "Pediatric ICU", "Surgery General", "Surgery ICU"
                  )),
                  selectInput("Source_Clin", "Source", choices = c(
                    "Abdominal Fluid", "Abscess", "Appendix", "Aspirate", "Bladder", "Blood",
                    "Bodily Fluids", "Bone", "Bronchiole", "Bronchoalveolar lavage", "Bronchus", 
                    "Burn", "Carbuncle", "Catheters", "Cellulitis", "Cervix", "Circulatory: Other",
                    "CNS: Other", "Colon", "CSF", "Decubitus", "Ear", "Endotracheal aspirate", 
                    "Exudate", "Eye", "Furuncle", "Gall Bladder", "Gastric Abscess", "Genitourinary: Other", 
                    "Head", "Impetiginous lesions", "Instruments: Other", "Integumentary (Skin Nail Hair)", 
                    "Intestinal: Other", "Kidney", "Liver", "Lungs", "Lymph Nodes", "Mouth", 
                    "Muscle", "None Given", "Nose", "Pancreas", "Peripheral Nerves", "Peritoneal Fluid", 
                    "Pleural Fluid", "Prostate", "Respiratory: Other", "Skeletal: Other", "Skin", 
                    "Skin: Other", "Spinal Cord", "Sputum", "Stomach", "Synovial Fluid", "Thoracentesis Fluid", 
                    "Throat", "Tissue Fluid", "Trachea", "Ulcer", "Ureter", "Urethra", "Urine", 
                    "Uterus", "Vagina", "Wound"
                  )),
                  selectInput("Patient_Clin", "In or Out Patient", choices = c(
                    "Inpatient", "None Given", "Other", "Outpatient"
                  )),
                  actionButton("predict_Clin", "Predict")
                ),
                mainPanel(
                  verbatimTextOutput("prediction_Clin")
                )
              )
      )
    )
  )
)

# Server
server <- function(input, output) {
  
  # Prediction for Erythromycin_I
  output$prediction_Ery <- renderPrint({
    req(input$predict_Ery)
    new_data_Ery <- data.frame(
      Gender = input$Gender_Ery,
      Age.Group = input$Age.Group_Ery,
      Speciality = input$Speciality_Ery,
      Source = input$Source_Ery,
      Patient = input$Patient_Ery
    )
    prediction_Ery <- predict(model_Ery, new_data_Ery)
    prediction_Ery
  })
  
  # Prediction for Levofloxacin
  output$prediction_Levo <- renderPrint({
    req(input$predict_Levo)
    new_data_Levo <- data.frame(
      Gender = input$Gender_Levo,
      Age.Group = input$Age.Group_Levo,
      Speciality = input$Speciality_Levo,
      Source = input$Source_Levo,
      Patient = input$Patient_Levo
    )
    prediction_Levo <- predict(model_Levo, new_data_Levo)
    prediction_Levo
  })
  
  # Prediction for Clindamycin
  output$prediction_Clin <- renderPrint({
    req(input$predict_Clin)
    new_data_Clin <- data.frame(
      Gender = input$Gender_Clin,
      Age.Group = input$Age.Group_Clin,
      Speciality = input$Speciality_Clin,
      Source = input$Source_Clin,
      Patient = input$Patient_Clin
    )
    prediction_Clin <- predict(model_Clin, new_data_Clin)
    prediction_Clin
  })
}

# Run the app
shinyApp(ui, server)
