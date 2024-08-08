
Atlas <- read.csv("D:/MUNI LAB DOC/AMR/Atlas.csv")
#Data over view on the data set
View(Atlas)
names(Atlas)  
length(Atlas)
head(Atlas)
tail(Atlas)
dim(Atlas) #135 Variables # 917050 Rows

#=============================================================
#Sorting by country 
Uganda <- subset(Atlas, 
             Country == "Uganda"
             )
Kenya <-subset(Atlas, 
               Country == "Kenya"
              ) 
Egypt <- subset(Atlas, 
             Country == "Egypt"
              )
#==============================================================

#Filtering information from 13 African countries 
#Base R

Africa <- Atlas [Atlas$Country %in% c("Uganda", 
                                      "Kenya",
                                      "Egypt", 
                                      "Cameroon", 
                                      "Ghana", 
                                      "Ivory Coast",
                                      "Malawi",
                                      "Mauritius",
                                      "Morocco",
                                      "Namibia",
                                      "Nigeria", 
                                      "South Africa", 
                                      "Tunisia"),] 

#=====================================================================
#WHO's GLASS Antibiotics /Variables 
Who_Antibiotics <- subset(Africa, select = c("Isolate.Id",
                                             "Study",
                                             "Species",
                                             "Family",
                                             "Country", 
                                             "State",
                                             "Gender", 
                                             "Age.Group",
                                             "Speciality",
                                             "Source", 
                                             "In...Out.Patient",
                                             "Year",
                                             "Phenotype",
                                             "Ceftriaxone",
                                             "Ceftriaxone_I",
                                             "Metronidazole",
                                             "Metronidazole_I",
                                             "Ciprofloxacin",
                                             "Ciprofloxacin_I",
                                             "Amoxycillin.clavulanate",
                                             "Amoxycillin.clavulanate_I"
                                             ))
#===============================================================================

 
