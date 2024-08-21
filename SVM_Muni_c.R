library(tidyverse)
library(e1071)
library(readxl)

#Levo <- read_excel("Levofloxacin.xlsx")
#Ery <- read_excel("Erythromycin.xlsx")
#Clin <- read_excel("Clindamycin.xlsx")

#Select Erythromycin
Ery_selected <- Ery %>%
  select(Erythromycin_I, Gender, Age.Group,Speciality,Source,Patient)
Ery_selected <- na.omit(Ery_selected)
Ery_selected$Erythromycin_I <- as.factor(Ery_selected$Erythromycin_I)
Ery_selected$Gender <- as.factor(Ery_selected$Gender)
Ery_selected$Age.Group <- as.factor(Ery_selected$Age.Group)
Ery_selected$Speciality <- as.factor(Ery_selected$Speciality)
Ery_selected$Source <- as.factor(Ery_selected$Source)
Ery_selected$Patient<- as.factor(Ery_selected$Patient)

#Tune SVM for each method
#tune_Ery <- tune.svm(Erythromycin_I ~., data = Ery_selected, gamma = 10^(-6:-1), cost = 10^(-1:1))
#tune_Ery$best.parameters
#

#Model SVM
model_Ery  <- svm(Erythromycin_I ~., data = Ery_selected, kernel="radial", gamma=0.000001, cost=0.1)
saveRDS(model_Ery, "model_Ery.RDS")

#Select Clindamycin_I
Clin_selected <- Clin %>%
  select(Clindamycin_I, Gender, Age.Group,Speciality,Source,Patient)
Clin_selected <- na.omit(Clin_selected)
Clin_selected$Clindamycin_I <- as.factor(Clin_selected$Clindamycin_I)
Clin_selected$Gender <- as.factor(Clin_selected$Gender)
Clin_selected$Age.Group <- as.factor(Clin_selected$Age.Group)
Clin_selected$Speciality <- as.factor(Clin_selected$Speciality)
Clin_selected$Source <- as.factor(Clin_selected$Source)
Clin_selected$Patient<- as.factor(Clin_selected$Patient)

#Tune SVM for each method
#tune_Clin <- tune.svm(Clindamycin_I ~., data = Clin_selected, gamma = 10^(-6:-1), cost = 10^(-1:1))
#tune_Clin$best.parameters
#0.000001, 0.1

#Model SVM
model_Clin  <- svm(Clindamycin_I ~., data = Clin_selected, kernel="radial", gamma=0.000001, cost=0.1)
saveRDS(model_Clin, "model_Clin.RDS")

#Select Levofloxacin_I
Levo_selected <- Levo %>%
  select(Levofloxacin_I, Gender, Age.Group,Speciality,Source,Patient)
Levo_selected <- na.omit(Levo_selected)
Levo_selected$Levofloxacin_I <- as.factor(Levo_selected$Levofloxacin_I)
Levo_selected$Gender <- as.factor(Levo_selected$Gender)
Levo_selected$Age.Group <- as.factor(Levo_selected$Age.Group)
Levo_selected$Speciality <- as.factor(Levo_selected$Speciality)
Levo_selected$Source <- as.factor(Levo_selected$Source)
Levo_selected$Patient<- as.factor(Levo_selected$Patient)

#Tune SVM for each method

#tune_Levo <- tune.svm(Levofloxacin_I ~., data = Levo_selected, gamma = 10^(-6:-1), cost = 10^(-1:1))
#tune_Levo$best.parameters
#0.1, 10

#Model SVM
model_Levo  <- svm(Levofloxacin_I ~., data = Levo_selected, kernel="radial", gamma=0.1, cost=10)
saveRDS(model_Levo, "model_Levo.RDS")


