
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

 