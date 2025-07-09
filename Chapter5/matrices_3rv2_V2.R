#####Main codes########
library(tidyverse)
library(dplyr)
library(readr)
library(openxlsx)
library(reshape2)
library(readxl)

rm(list = ls())

setwd("//Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis")
country_codes_V202401b  <- read_csv("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/country_codes_V202401b.csv")

hs1992 <- read_excel("products_twin_transition/Table_Lall_Products.xlsx", 
                     sheet = "HS1992")
hs1996 <- read_excel("products_twin_transition/Table_Lall_Products.xlsx", 
                     sheet = "HS1996")
hs2002 <- read_excel("products_twin_transition/Table_Lall_Products.xlsx", 
                     sheet = "HS2002")
hs2007 <- read_excel("products_twin_transition/Table_Lall_Products.xlsx", 
                     sheet = "HS2007")
hs2012 <- read_excel("products_twin_transition/Table_Lall_Products.xlsx", 
                     sheet = "HS2012")
hs2017 <- read_excel("products_twin_transition/Table_Lall_Products.xlsx", 
                     sheet = "HS2017")
LallHS1992 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/LallHS.xlsx", 
                         sheet = "1992")
LallHS1996 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/LallHS.xlsx", 
                         sheet = "1996")
LallHS2002 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/LallHS.xlsx", 
                         sheet = "2002")
LallHS2007 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/LallHS.xlsx", 
                         sheet = "2007")
LallHS2012 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/LallHS.xlsx", 
                         sheet = "2012")
LallHS2017 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/LallHS.xlsx", 
                         sheet = "2017")

#1995====
#load the data
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/1995")

BACI_HS92_V202401b <- read_csv("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/BACI_HS92_V202401b/BACI_HS92_Y1995_V202401b.csv")
unique(BACI_HS92_V202401b$k)
length(unique(BACI_HS92_V202401b$i)) # 2 countries
BACI_HS92_V202401b <- BACI_HS92_V202401b[!is.na(BACI_HS92_V202401b$v), ]
BACI_HS92_V202401b$new_column <- BACI_HS92_V202401b$v
BACI_HS92_V202401b$new_column <- BACI_HS92_V202401b$v
##check intra trade###
BACI_HS92_V202401b_filtered <- BACI_HS92_V202401b %>%
  filter(j == i)
BACI_HS92_V202401b <- BACI_HS92_V202401b %>%
  filter(j != i)

products_1995 <- c("k") 
products_1995 <- BACI_HS92_V202401b[products_1995] 

# Drop duplicate rows
products_1995 <- unique(products_1995)

class(products_1995$k)
class(hs1992$k)
products_1995$k <- as.numeric(products_1995$k)
# Find values of 'k' that are not shared between df1 and df2
unshared_df <- anti_join(hs1992,products_1995,by = "k")
print(unshared_df)
valores_a_eliminar1995=c(999999)
hs1992 <- subset(hs1992, !k %in% valores_a_eliminar1995)
write.xlsx(hs1992, "hs1992.xlsx", rowNames = FALSE)
Lall1995=merge(hs1992, LallHS1992, by="k")
write.xlsx(Lall1995, "Lall1995.xlsx", rowNames = FALSE)

ict_unctad_1992 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/ict_unctad.xlsx", 
                              sheet = "1992")
digital_products_92<-merge(Lall1995, ict_unctad_1992, by ="k", all=TRUE)
digital_products_92$is_ict_1992[is.na(digital_products_92$is_ict_1992)] <- 0
digital_products_92$new_column <- 11
# Replace values with Lall2000 where is_year == 1
digital_products_92$new_column[digital_products_92$is_ict_1992 == 1] <- digital_products_92$Lall[digital_products_92$is_ict_1996 == 1]

write.xlsx(digital_products_92, "digital_products_92.xlsx", rowNames = FALSE)

DPTs_1992 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/DPTS_products_list.xlsx", 
                              sheet = "k1992")
colnames(DPTs_1992)[colnames(DPTs_1992) == "k1992"] <- "k"
danilo_1992<-merge(Lall1995, DPTs_1992, by ="k", all=TRUE)
danilo_1992$is_year[is.na(danilo_1992$is_year)] <- 0
write.xlsx(danilo_1992, "danilo_products_92.xlsx", rowNames = FALSE)

#green_1992 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_list_293v2.xlsx", 
 #                        sheet = "1992")
#green_1992<-merge(Lall1995, green_1992, by ="k", all=TRUE)
#green_1992$is_green[is.na(green_1992$is_green)] <- 0
#green_1992 <- unique(green_1992)
#write.xlsx(green_1992, "green_products_92.xlsx", rowNames = FALSE)

green_1992 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Green_Products_List.xlsx", 
                        sheet = "k1992")
colnames(green_1992)[colnames(green_1992) == "k1992"] <- "k"
green_1992<-merge(Lall1995, green_1992, by ="k", all=TRUE)
green_1992$is_year[is.na(green_1992$is_year)] <- 0
green_1992 <- unique(green_1992)
write.xlsx(green_1992, "green_products_92.xlsx", rowNames = FALSE)

#brown_1992 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_Brown.xlsx", 
 #                        sheet = "92")
#brown_1992<-merge(Lall1995, brown_1992, by ="k",all=TRUE)
#brown_1992$is_brown[is.na(brown_1992$is_brown)] <- 0
#brown_1992 <- brown_1992[!is.na(brown_1992$Lall), ]
#write.xlsx(brown_1992, "brown_92.xlsx", rowNames = FALSE)

brown_1992 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Brown_products_by_hs.xlsx", 
                         sheet = "k1992")
colnames(brown_1992)[colnames(brown_1992) == "k1992"] <- "k"
brown_1992<-merge(Lall1995, brown_1992, by ="k",all=TRUE)
brown_1992$is_year[is.na(brown_1992$is_year)] <- 0
brown_1992 <- brown_1992[!is.na(brown_1992$Lall), ]
write.xlsx(brown_1992, "Brown_Products_1992.xlsx", rowNames = FALSE)

decarbonization_technologies_products_92 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Decarbonization_technologies_List.xlsx", 
                                                       sheet = "k1992")
colnames(decarbonization_technologies_products_92)[colnames(decarbonization_technologies_products_92) == "k1992"] <- "k"
decarbonization_technologies_products_92<-merge(Lall1995, decarbonization_technologies_products_92, by ="k", all=TRUE)
decarbonization_technologies_products_92$is_year[is.na(decarbonization_technologies_products_92$is_year)] <- 0
decarbonization_technologies_products_92 <- unique(decarbonization_technologies_products_92)
write.xlsx(decarbonization_technologies_products_92, "decarbonization_technologies_products_92.xlsx", rowNames = FALSE)

Lall1995=merge(hs1992, LallHS1992, by="k")

unshared_df2 <- anti_join(products_1995,hs1992,by = "k")
print(unshared_df2)

# Define the vector of countries you want to extract (exports)
countries_X_1995 <- c("i") 
countries_X_1995 <- BACI_HS92_V202401b[countries_X_1995] 

# Drop duplicate rows
countries_X_1995 <- unique(countries_X_1995)
names(countries_X_1995)[names(countries_X_1995) == "i"] <- "country_code"
countries_X_1995=merge(countries_X_1995, country_codes_V202401b,by="country_code")
write.xlsx(countries_X_1995, "countries1995.xlsx", rowNames = FALSE)

# Define the vector of countries you want to extract (exports)
countries_M_1995 <- c("j") 
countries_M_1995 <- BACI_HS92_V202401b[countries_M_1995] 

# Drop duplicate rows
countries_M_1995 <- unique(countries_M_1995)

names(countries_M_1995)[names(countries_M_1995) == "j"] <- "country_code"
countries_M_1995=merge(countries_M_1995, country_codes_V202401b,by="country_code")
write.xlsx(countries_M_1995, "countries1995_M.xlsx", rowNames = FALSE)

# Reshape the data into a matrix for exports
matrix_df_1995 <- dcast(BACI_HS92_V202401b, k ~ i, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS92_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_1995)
write.xlsx(matrix_df_1995, "exptot1995.xlsx", rowNames = FALSE)

# Reshape the data into a matrix for imports
matrix_df_1995_M <- dcast(BACI_HS92_V202401b, k ~ j, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS92_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_1995_M)
write.xlsx(matrix_df_1995_M, "imptot1995.xlsx", rowNames = FALSE)

#2000 ====
#load the data
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2000")
BACI_HS96_V202401b <- read_csv("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/BACI_HS96_V202401b/BACI_HS96_Y2000_V202401b.csv")
unique(BACI_HS96_V202401b$k)
length(unique(BACI_HS96_V202401b$i)) # 222 countries
BACI_HS96_V202401b <- BACI_HS96_V202401b[!is.na(BACI_HS96_V202401b$v), ]
BACI_HS96_V202401b$new_column <- BACI_HS96_V202401b$v
##check intra trade###
BACI_HS96_V202401b_filtered <- BACI_HS96_V202401b %>%
  filter(j == i)
BACI_HS96_V202401b <- BACI_HS96_V202401b %>%
  filter(j != i)

products_2000 <- c("k") 
products_2000 <- BACI_HS96_V202401b[products_2000] 

# Drop duplicate rows
products_2000 <- unique(products_2000)

class(products_2000$k)
class(hs1996$k)
products_2000$k <- as.numeric(products_2000$k)
# Find values of 'k' that are not shared between df1 and df2
unshared_df <- anti_join(hs1996,products_2000,by = "k")
print(unshared_df)
valores_a_eliminar2000=c(999999)
hs1996 <- subset(hs1996, !k %in% valores_a_eliminar2000)
write.xlsx(hs1996, "hs1996.xlsx", rowNames = FALSE)
Lall2000=merge(hs1996, LallHS1996, by="k")
write.xlsx(Lall2000, "Lall2000.xlsx", rowNames = FALSE)

#####ICT########
ict_unctad_1996 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/ict_unctad.xlsx", 
                              sheet = "1996")
digital_products_96<-merge(Lall2000, ict_unctad_1996, by ="k", all=TRUE)
digital_products_96$is_ict_1996[is.na(digital_products_96$is_ict_1996)] <- 0
digital_products_96$new_column <- 11
# Replace values with Lall2000 where is_year == 1
digital_products_96$new_column[digital_products_96$is_ict_1996 == 1] <- digital_products_96$Lall[digital_products_96$is_ict_1996 == 1]
write.xlsx(digital_products_96, "digital_products_96.xlsx", rowNames = FALSE)

#####DPT########
DPTs_1996 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/DPTS_products_list.xlsx", 
                        sheet = "k1996")
colnames(DPTs_1996)[colnames(DPTs_1996) == "k1996"] <- "k"
danilo_1996<-merge(Lall2000, DPTs_1996, by ="k", all=TRUE)
danilo_1996$is_year[is.na(danilo_1996$is_year)] <- 0
# Initialize a new column 'new_column' with zeros
danilo_1996$new_column <- 11
# Replace values with Lall2000 where is_year == 1
danilo_1996$new_column[danilo_1996$is_year == 1] <- danilo_1996$Lall[danilo_1996$is_year == 1]
write.xlsx(danilo_1996, "danilo_products_96.xlsx", rowNames = FALSE)

#####GREEN########
green_1996 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Green_Products_List.xlsx", 
                         sheet = "k1996")
colnames(green_1996)[colnames(green_1996) == "k1996"] <- "k"
green_1996<-merge(Lall2000, green_1996, by ="k", all=TRUE)
green_1996$is_year[is.na(green_1996$is_year)] <- 0
green_1996 <- unique(green_1996)
green_1996$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_1996$new_column[green_1996$is_year == 1] <- green_1996$Lall[green_1996$is_year == 1]
write.xlsx(green_1996, "green_products_96.xlsx", rowNames = FALSE)

#####BROWN########
brown_1996 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Brown_products_by_hs.xlsx", 
                         sheet = "k1996")
colnames(brown_1996)[colnames(brown_1996) == "k1996"] <- "k"
brown_1996<-merge(Lall2000, brown_1996, by ="k",all=TRUE)
brown_1996$is_year[is.na(brown_1996$is_year)] <- 0
brown_1996 <- brown_1996[!is.na(brown_1996$Lall), ]
brown_1996$new_column <- 11
# Replace values with Lall2000 where is_year == 1
brown_1996$new_column[brown_1996$is_year == 1] <- brown_1996$Lall[brown_1996$is_year == 1]
write.xlsx(brown_1996, "Brown_Products_1996.xlsx", rowNames = FALSE)

#####DECARBONISATION TECHNLOGIES########
decarbonization_technologies_products_96 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Decarbonization_technologies_List.xlsx", 
                                                       sheet = "k1996")
colnames(decarbonization_technologies_products_96)[colnames(decarbonization_technologies_products_96) == "k1996"] <- "k"
decarbonization_technologies_products_96<-merge(Lall2000, decarbonization_technologies_products_96, by ="k", all=TRUE)
decarbonization_technologies_products_96$is_year[is.na(decarbonization_technologies_products_96$is_year)] <- 0
decarbonization_technologies_products_96 <- unique(decarbonization_technologies_products_96)
decarbonization_technologies_products_96$new_column <- 11
# Replace values with Lall2000 where is_year == 1
decarbonization_technologies_products_96$new_column[decarbonization_technologies_products_96$is_year == 1] <- decarbonization_technologies_products_96$Lall[decarbonization_technologies_products_96$is_year == 1]
write.xlsx(decarbonization_technologies_products_96, "decarbonization_technologies_products_96.xlsx", rowNames = FALSE)

#####4IR########
fourIR_products_96 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/fourIR_year_data.xlsx", 
                                 sheet = "k1996")
colnames(fourIR_products_96)[colnames(fourIR_products_96) == "k1996"] <- "k"
fourIR_products_96<-merge(Lall2000, fourIR_products_96, by ="k", all=TRUE)
fourIR_products_96$is_year[is.na(fourIR_products_96$is_year)] <- 0
fourIR_products_96 <- unique(fourIR_products_96)
fourIR_products_96$new_column <- 11
# Replace values with Lall2000 where is_year == 1
fourIR_products_96$new_column[fourIR_products_96$is_year == 1] <- fourIR_products_96$Lall[fourIR_products_96$is_year == 1]
write.xlsx(fourIR_products_96, "fourIR_products_96.xlsx", rowNames = FALSE)

#####GREEN DPTS########
library(readxl)
green_DPTS_96 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Green_Data.xlsx", 
                                 sheet = "Danilo_Green_1996")
colnames(green_DPTS_96)[colnames(green_DPTS_96) == "Danilo_Green_1996"] <- "k"
green_DPTS_96$is_year <- as.integer(!is.na(green_DPTS_96$k)) 
green_DPTS_96<-merge(Lall2000, green_DPTS_96, by ="k", all=TRUE)
green_DPTS_96$is_year[is.na(green_DPTS_96$is_year)] <- 0
green_DPTS_96 <- unique(green_DPTS_96)
green_DPTS_96$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_DPTS_96$new_column[green_DPTS_96$is_year == 1] <- green_DPTS_96$Lall[green_DPTS_96$is_year == 1]

write.xlsx(green_DPTS_96, "green_DPTS_96.xlsx", rowNames = FALSE)

library(readxl)
greentech_DPTS_96 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Decarbtech_Data.xlsx", 
                               sheet = "Danilo_Decarbtech_1996")
colnames(greentech_DPTS_96)[colnames(greentech_DPTS_96) == "Danilo_Decarbtech_1996"] <- "k"
greentech_DPTS_96$is_year <- as.integer(!is.na(greentech_DPTS_96$k)) 
greentech_DPTS_96<-merge(Lall2000, greentech_DPTS_96, by ="k", all=TRUE)
greentech_DPTS_96$is_year[is.na(greentech_DPTS_96$is_year)] <- 0
greentech_DPTS_96 <- unique(greentech_DPTS_96)
greentech_DPTS_96$new_column <- 11
# Replace values with Lall2000 where is_year == 1
greentech_DPTS_96$new_column[greentech_DPTS_96$is_year == 1] <- greentech_DPTS_96$Lall[greentech_DPTS_96$is_year == 1]
write.xlsx(greentech_DPTS_96, "greentech_DPTS_96.xlsx", rowNames = FALSE)



Lall2000=merge(hs1996, LallHS1996, by="k")

unshared_df2 <- anti_join(products_2000,hs1996,by = "k")
print(unshared_df2)

# Define the vector of countries you want to extract (exports)
countries_X_2000 <- c("i") 
countries_X_2000 <- BACI_HS96_V202401b[countries_X_2000] 

# Drop duplicate rows
countries_X_2000 <- unique(countries_X_2000)
names(countries_X_2000)[names(countries_X_2000) == "i"] <- "country_code"
countries_X_2000=merge(countries_X_2000, country_codes_V202401b,by="country_code")
write.xlsx(countries_X_2000, "countries2000.xlsx", rowNames = FALSE)

# Define the vector of countries you want to extract (exports)
countries_M_2000 <- c("j") 
countries_M_2000 <- BACI_HS96_V202401b[countries_M_2000] 

# Drop duplicate rows
countries_M_2000 <- unique(countries_M_2000)

names(countries_M_2000)[names(countries_M_2000) == "j"] <- "country_code"
countries_M_2000=merge(countries_M_2000, country_codes_V202401b,by="country_code")
write.xlsx(countries_M_2000, "countries2000_M.xlsx", rowNames = FALSE)


# Reshape the data into a matrix for exports
matrix_df_2000 <- dcast(BACI_HS96_V202401b, k ~ i, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS96_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2000)
write.xlsx(matrix_df_2000, "exptot2000.xlsx", rowNames = FALSE)

# Reshape the data into a matrix for imports
matrix_df_2000_M <- dcast(BACI_HS96_V202401b, k ~ j, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS96_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2000_M)
write.xlsx(matrix_df_2000_M, "imptot2000.xlsx", rowNames = FALSE)




#2005====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2005")

BACI_HS02_Y2005_V202401b <- read_csv("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/BACI_HS02_V202401b/BACI_HS02_Y2005_V202401b.csv")
unique(BACI_HS02_Y2005_V202401b$k)
length(unique(BACI_HS02_Y2005_V202401b$i)) 
BACI_HS02_Y2005_V202401b <- BACI_HS02_Y2005_V202401b[!is.na(BACI_HS02_Y2005_V202401b$v), ]
BACI_HS02_Y2005_V202401b$new_column <- BACI_HS02_Y2005_V202401b$v
##check intra trade###
BACI_HS02_Y2005_V202401b_filtered <- BACI_HS02_Y2005_V202401b %>%
  filter(j == i)
BACI_HS02_Y2005_V202401b <- BACI_HS02_Y2005_V202401b %>%
  filter(j != i)

products_2005 <- c("k") 
products_2005 <- BACI_HS02_Y2005_V202401b[products_2005] 

# Drop duplicate rows
products_2005 <- unique(products_2005)

class(products_2005$k)
class(hs2002$k)
products_2005$k <- as.numeric(products_2005$k)
# Find values of 'k' that are not shared between df1 and df2
unshared_df <- anti_join(hs2002,products_2005,by = "k")
print(unshared_df)

valores_a_eliminar_2005=c(271011,271019,271091,271099)
hs2002 <- subset(hs2002, !k %in% valores_a_eliminar_2005)
write.xlsx(hs2002, "hs2002.xlsx", rowNames = FALSE)
Lall2005=merge(hs2002, LallHS2002, by="k")
write.xlsx(Lall2005, "Lall2005.xlsx", rowNames = FALSE)


ict_unctad_2002 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/ict_unctad.xlsx", 
                              sheet = "2002")
digital_products_02<-merge(Lall2005, ict_unctad_2002, by ="k", all=TRUE)
digital_products_02$is_ict_2002[is.na(digital_products_02$is_ict_2002)] <- 0
digital_products_02$new_column <- 11
# Replace values with Lall2000 where is_year == 1
digital_products_02$new_column[digital_products_02$is_ict_2002 == 1] <- digital_products_02$Lall[digital_products_02$is_ict_2002 == 1]
write.xlsx(digital_products_02, "digital_products_02.xlsx", rowNames = FALSE)


DPTs_2002 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/DPTS_products_list.xlsx", 
                        sheet = "k2002")
colnames(DPTs_2002)[colnames(DPTs_2002) == "k2002"] <- "k"
danilo_2002<-merge(Lall2005, DPTs_2002, by ="k", all=TRUE)
danilo_2002$is_year[is.na(danilo_2002$is_year)] <- 0
danilo_2002$new_column <- 11
# Replace values with Lall2000 where is_year == 1
danilo_2002$new_column[danilo_2002$is_year == 1] <- danilo_2002$Lall[danilo_2002$is_year == 1]
write.xlsx(danilo_2002, "danilo_products_02.xlsx", rowNames = FALSE)

green_2002 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Green_Products_List.xlsx", 
                         sheet = "k2002")
colnames(green_2002)[colnames(green_2002) == "k2002"] <- "k"
green_2002<-merge(Lall2005, green_2002, by ="k", all=TRUE)
green_2002$is_year[is.na(green_2002$is_year)] <- 0
green_2002 <- unique(green_2002)
green_2002$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_2002$new_column[green_2002$is_year == 1] <- green_2002$Lall[green_2002$is_year == 1]
write.xlsx(green_2002, "green_products_02.xlsx", rowNames = FALSE)


brown_2002 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Brown_products_by_hs.xlsx", 
                         sheet = "k2002")
colnames(brown_2002)[colnames(brown_2002) == "k2002"] <- "k"
brown_2002<-merge(Lall2005, brown_2002, by ="k",all=TRUE)
brown_2002$is_year[is.na(brown_2002$is_year)] <- 0
brown_2002 <- brown_2002[!is.na(brown_2002$Lall), ]
brown_2002$new_column <- 11
# Replace values with Lall2000 where is_year == 1
brown_2002$new_column[brown_2002$is_year == 1] <- brown_2002$Lall[brown_2002$is_year == 1]
write.xlsx(brown_2002, "Brown_Products_2002.xlsx", rowNames = FALSE)


decarbonization_technologies_products_02 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Decarbonization_technologies_List.xlsx", 
                                                       sheet = "k2002")
colnames(decarbonization_technologies_products_02)[colnames(decarbonization_technologies_products_02) == "k2002"] <- "k"
decarbonization_technologies_products_02<-merge(Lall2005, decarbonization_technologies_products_02, by ="k", all=TRUE)
decarbonization_technologies_products_02$is_year[is.na(decarbonization_technologies_products_02$is_year)] <- 0
decarbonization_technologies_products_02 <- unique(decarbonization_technologies_products_02)
decarbonization_technologies_products_02$new_column <- 11
# Replace values with Lall2000 where is_year == 1
decarbonization_technologies_products_02$new_column[decarbonization_technologies_products_02$is_year == 1] <- decarbonization_technologies_products_02$Lall[decarbonization_technologies_products_02$is_year == 1]
write.xlsx(decarbonization_technologies_products_02, "decarbonization_technologies_products_02.xlsx", rowNames = FALSE)


fourIR_products_02 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/fourIR_year_data.xlsx", 
                                 sheet = "k2002")
colnames(fourIR_products_02)[colnames(fourIR_products_02) == "k2002"] <- "k"
fourIR_products_02<-merge(Lall2005, fourIR_products_02, by ="k", all=TRUE)
fourIR_products_02$is_year[is.na(fourIR_products_02$is_year)] <- 0
fourIR_products_02 <- unique(fourIR_products_02)
fourIR_products_02$new_column <- 11
# Replace values with Lall2000 where is_year == 1
fourIR_products_02$new_column[fourIR_products_02$is_year == 1] <- fourIR_products_02$Lall[fourIR_products_02$is_year == 1]

write.xlsx(fourIR_products_02, "fourIR_products_02.xlsx", rowNames = FALSE)


library(readxl)
green_DPTS_02 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Green_Data.xlsx", 
                            sheet = "Danilo_Green_2002")
colnames(green_DPTS_02)[colnames(green_DPTS_02) == "Danilo_Green_2002"] <- "k"
green_DPTS_02$is_year <- as.integer(!is.na(green_DPTS_02$k)) 
green_DPTS_02<-merge(Lall2005, green_DPTS_02, by ="k", all=TRUE)
green_DPTS_02$is_year[is.na(green_DPTS_02$is_year)] <- 0
green_DPTS_02 <- unique(green_DPTS_02)
green_DPTS_02$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_DPTS_02$new_column[green_DPTS_02$is_year == 1] <- green_DPTS_02$Lall[green_DPTS_02$is_year == 1]

write.xlsx(green_DPTS_02, "green_DPTS_02.xlsx", rowNames = FALSE)

library(readxl)
greentech_DPTS_02 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Decarbtech_Data.xlsx", 
                                sheet = "Danilo_Decarbtech_2002")
colnames(greentech_DPTS_02)[colnames(greentech_DPTS_02) == "Danilo_Decarbtech_2002"] <- "k"
greentech_DPTS_02$is_year <- as.integer(!is.na(greentech_DPTS_02$k)) 
greentech_DPTS_02<-merge(Lall2005, greentech_DPTS_02, by ="k", all=TRUE)
greentech_DPTS_02$is_year[is.na(greentech_DPTS_02$is_year)] <- 0
greentech_DPTS_02 <- unique(greentech_DPTS_02)
greentech_DPTS_02$new_column <- 11
# Replace values with Lall2000 where is_year == 1
greentech_DPTS_02$new_column[greentech_DPTS_02$is_year == 1] <- greentech_DPTS_02$Lall[greentech_DPTS_02$is_year == 1]
write.xlsx(greentech_DPTS_02, "greentech_DPTS_02.xlsx", rowNames = FALSE)


unshared_df2 <- anti_join(products_2005,hs2002,by = "k")
print(unshared_df2)
#valores_a_eliminar2005_2=c(811259,811251,811252)
#products_2005 <- subset(products_2005, !k %in% valores_a_eliminar2005_2)
#BACI_HS02_Y2005_V202401b <- subset(BACI_HS02_Y2005_V202401b, !k %in% valores_a_eliminar2005_2)


# Define the vector of countries you want to extract (exports)
countries_X_2005 <- c("i") 
countries_X_2005 <- BACI_HS02_Y2005_V202401b[countries_X_2005] 

# Drop duplicate rows
countries_X_2005 <- unique(countries_X_2005)
names(countries_X_2005)[names(countries_X_2005) == "i"] <- "country_code"
countries_X_2005=merge(countries_X_2005, country_codes_V202401b,by="country_code")
write.xlsx(countries_X_2005, "countries2005.xlsx", rowNames = FALSE)

# Define the vector of countries you want to extract (exports)
countries_M_2005 <- c("j") 
countries_M_2005 <- BACI_HS02_Y2005_V202401b[countries_M_2005] 

# Drop duplicate rows
countries_M_2005 <- unique(countries_M_2005)

names(countries_M_2005)[names(countries_M_2005) == "j"] <- "country_code"
countries_M_2005=merge(countries_M_2005, country_codes_V202401b,by="country_code")
write.xlsx(countries_M_2005, "countries2005_M.xlsx", rowNames = FALSE)

# Reshape the data into a matrix exports
matrix_df_2005 <- dcast(BACI_HS02_Y2005_V202401b, k ~ i, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS02_Y2005_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2005)
write.xlsx(matrix_df_2005, "exptot2005.xlsx", rowNames = FALSE)

# Reshape the data into a matrix for imports
matrix_df_2005_M <- dcast(BACI_HS02_Y2005_V202401b, k ~ j, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS02_Y2005_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2005_M)
write.xlsx(matrix_df_2005_M, "imptot2005.xlsx", rowNames = FALSE)

#2010====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2010")

BACI_HS07_Y2010_V202401b <- read_csv("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/BACI_HS07_V202401b/BACI_HS07_Y2010_V202401b.csv")
unique(BACI_HS07_Y2010_V202401b$k)
BACI_HS07_Y2010_V202401b <- BACI_HS07_Y2010_V202401b[!is.na(BACI_HS07_Y2010_V202401b$v), ]
BACI_HS07_Y2010_V202401b$new_column <- BACI_HS07_Y2010_V202401b$v
##check intra trade###
BACI_HS07_Y2010_V202401b_filtered <- BACI_HS07_Y2010_V202401b %>%
  filter(j == i)
BACI_HS07_Y2010_V202401b <- BACI_HS07_Y2010_V202401b %>%
  filter(j != i)

products_2010 <- c("k") 
products_2010 <- BACI_HS07_Y2010_V202401b[products_2010] 
# Drop duplicate rows
products_2010 <- unique(products_2010)

class(products_2010$k)
class(hs2007$k)
products_2010$k <- as.numeric(products_2010$k)
# Find values of 'k' that are not shared between df1 and df2
unshared_df <- anti_join(hs2007,products_2010,by = "k")
print(unshared_df)

valores_a_eliminar_2010=c(271011,271019,271091,271099,999999)
hs2007 <- subset(hs2007, !k %in% valores_a_eliminar_2010)
write.xlsx(hs2007, "hs2007.xlsx", rowNames = FALSE)
Lall2010=merge(hs2007, LallHS2007, by="k")
write.xlsx(Lall2010, "Lall2010.xlsx", rowNames = FALSE)

ict_unctad_2007 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/ict_unctad.xlsx", 
                              sheet = "2007")
digital_products_07<-merge(Lall2010, ict_unctad_2007, by ="k", all=TRUE)
colnames(digital_products_07)
digital_products_07$is_ict_2007[is.na(digital_products_07$is_ict_2007)] <- 0
digital_products_07$new_column <- 11
# Replace values with Lall2000 where is_year == 1
digital_products_07$new_column[digital_products_07$is_ict_2007 == 1] <- digital_products_07$Lall[digital_products_07$is_ict_2007 == 1]
write.xlsx(digital_products_07, "digital_products_07.xlsx", rowNames = FALSE)

DPTs_2007 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/DPTS_products_list.xlsx", 
                        sheet = "k2007")
colnames(DPTs_2007)[colnames(DPTs_2007) == "k2007"] <- "k"
danilo_2007<-merge(Lall2010, DPTs_2007, by ="k", all=TRUE)
danilo_2007$is_year[is.na(danilo_2007$is_year)] <- 0
danilo_2007$new_column <- 11
# Replace values with Lall2000 where is_year == 1
danilo_2007$new_column[danilo_2007$is_year == 1] <- danilo_2007$Lall[danilo_2007$is_year == 1]
write.xlsx(danilo_2007, "danilo_products_07.xlsx", rowNames = FALSE)

green_2007 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Green_Products_List.xlsx", 
                         sheet = "k2007")
colnames(green_2007)[colnames(green_2007) == "k2007"] <- "k"
green_2007<-merge(Lall2010, green_2007, by ="k", all=TRUE)
green_2007$is_year[is.na(green_2007$is_year)] <- 0
green_2007 <- unique(green_2007)
green_2007$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_2007$new_column[green_2007$is_year == 1] <- green_2007$Lall[green_2007$is_year == 1]
write.xlsx(green_2007, "green_products_07.xlsx", rowNames = FALSE)

#green_2007 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_list_293v2.xlsx", 
 #                        sheet = "2007")
#green_2007<-merge(Lall2010, green_2007, by ="k", all=TRUE)
#green_2007$is_green[is.na(green_2007$is_green)] <- 0
#write.xlsx(green_2007, "green_products_07.xlsx", rowNames = FALSE)

brown_2007 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Brown_products_by_hs.xlsx", 
                         sheet = "k2007")
colnames(brown_2007)[colnames(brown_2007) == "k2007"] <- "k"
brown_2007<-merge(Lall2010, brown_2007, by ="k",all=TRUE)
brown_2007$is_year[is.na(brown_2007$is_year)] <- 0
brown_2007 <- brown_2007[!is.na(brown_2007$Lall), ]
brown_2007$new_column <- 11
# Replace values with Lall2000 where is_year == 1
brown_2007$new_column[brown_2007$is_year == 1] <- brown_2007$Lall[brown_2007$is_year == 1]
write.xlsx(brown_2007, "Brown_Products_2007.xlsx", rowNames = FALSE)

#brown_2007 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_Brown.xlsx", 
 #                        sheet = "07")
#brown_2007<-merge(Lall2010, brown_2007, by ="k", all=TRUE)
#brown_2007$is_brown[is.na(brown_2007$is_brown)] <- 0
#brown_2007 <- unique(brown_2007)
#brown_2007 <- brown_2007[!is.na(brown_2007$Lall), ]
#write.xlsx(brown_2007, "brown_07.xlsx", rowNames = FALSE)

decarbonization_technologies_products_07 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Decarbonization_technologies_List.xlsx", 
                                                       sheet = "k2007")
colnames(decarbonization_technologies_products_07)[colnames(decarbonization_technologies_products_07) == "k2007"] <- "k"
decarbonization_technologies_products_07<-merge(Lall2010, decarbonization_technologies_products_07, by ="k", all=TRUE)
decarbonization_technologies_products_07$is_year[is.na(decarbonization_technologies_products_07$is_year)] <- 0
decarbonization_technologies_products_07 <- unique(decarbonization_technologies_products_07)
decarbonization_technologies_products_07$new_column <- 11
# Replace values with Lall2000 where is_year == 1
decarbonization_technologies_products_07$new_column[decarbonization_technologies_products_07$is_year == 1] <- decarbonization_technologies_products_07$Lall[decarbonization_technologies_products_07$is_year == 1]

write.xlsx(decarbonization_technologies_products_07, "decarbonization_technologies_products_07.xlsx", rowNames = FALSE)

#decarbonization_technologies_products_07 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/decarbonization_technologies_products.xlsx", 
 #                                                      sheet = "2007")
#decarbonization_technologies_products_07<-merge(Lall2010, decarbonization_technologies_products_07, by ="k", all=TRUE)
#decarbonization_technologies_products_07$is_hs_07[is.na(decarbonization_technologies_products_07$is_hs_07)] <- 0
#decarbonization_technologies_products_07 <- unique(decarbonization_technologies_products_07)
#write.xlsx(decarbonization_technologies_products_07, "decarbonization_technologies_products_07.xlsx", rowNames = FALSE)

fourIR_products_07 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/fourIR_year_data.xlsx", 
                                 sheet = "k2007")
colnames(fourIR_products_07)[colnames(fourIR_products_07) == "k2007"] <- "k"
fourIR_products_07<-merge(Lall2010, fourIR_products_07, by ="k", all=TRUE)
fourIR_products_07$is_year[is.na(fourIR_products_07$is_year)] <- 0
fourIR_products_07 <- unique(fourIR_products_07)
fourIR_products_07$new_column <- 11
# Replace values with Lall2000 where is_year == 1
fourIR_products_07$new_column[fourIR_products_07$is_year == 1] <- fourIR_products_07$Lall[fourIR_products_07$is_year == 1]
write.xlsx(fourIR_products_07, "fourIR_products_07.xlsx", rowNames = FALSE)


##greendigital
library(readxl)
green_DPTS_07 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Green_Data.xlsx", 
                            sheet = "Danilo_Green_2007")
colnames(green_DPTS_07)[colnames(green_DPTS_07) == "Danilo_Green_2007"] <- "k"
green_DPTS_07$is_year <- as.integer(!is.na(green_DPTS_07$k)) 
green_DPTS_07<-merge(Lall2010, green_DPTS_07, by ="k", all=TRUE)
green_DPTS_07$is_year[is.na(green_DPTS_07$is_year)] <- 0
green_DPTS_07 <- unique(green_DPTS_07)
green_DPTS_07$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_DPTS_07$new_column[green_DPTS_07$is_year == 1] <- green_DPTS_07$Lall[green_DPTS_07$is_year == 1]

write.xlsx(green_DPTS_07, "green_DPTS_07.xlsx", rowNames = FALSE)

library(readxl)
greentech_DPTS_07 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Decarbtech_Data.xlsx", 
                                sheet = "Danilo_Decarbtech_2007")
colnames(greentech_DPTS_07)[colnames(greentech_DPTS_07) == "Danilo_Decarbtech_2007"] <- "k"
greentech_DPTS_07$is_year <- as.integer(!is.na(greentech_DPTS_07$k)) 
greentech_DPTS_07<-merge(Lall2010, greentech_DPTS_07, by ="k", all=TRUE)
greentech_DPTS_07$is_year[is.na(greentech_DPTS_07$is_year)] <- 0
greentech_DPTS_07 <- unique(greentech_DPTS_07)
greentech_DPTS_07$new_column <- 11
# Replace values with Lall2000 where is_year == 1
greentech_DPTS_07$new_column[greentech_DPTS_07$is_year == 1] <- greentech_DPTS_07$Lall[greentech_DPTS_07$is_year == 1]
write.xlsx(greentech_DPTS_07, "greentech_DPTS_07.xlsx", rowNames = FALSE)

unshared_df2 <- anti_join(products_2010,hs2007,by = "k")
print(unshared_df2)
#valores_a_eliminar_2010_2=c(811259,811251,811252)
#products_2010 <- subset(products_2010, !k %in% valores_a_eliminar_2010_2)
#BACI_HS07_Y2010_V202401b <- subset(BACI_HS07_Y2010_V202401b, !k %in% valores_a_eliminar_2010_2)


# Define the vector of countries you want to extract (exports)
countries_X_2010 <- c("i") 
countries_X_2010 <- BACI_HS07_Y2010_V202401b[countries_X_2010] 

# Drop duplicate rows
countries_X_2010 <- unique(countries_X_2010)
names(countries_X_2010)[names(countries_X_2010) == "i"] <- "country_code"
countries_X_2010=merge(countries_X_2010, country_codes_V202401b,by="country_code")
write.xlsx(countries_X_2010, "countries2010.xlsx", rowNames = FALSE)

# Define the vector of countries you want to extract (exports)
countries_M_2010 <- c("j") 
countries_M_2010 <- BACI_HS07_Y2010_V202401b[countries_M_2010] 

# Drop duplicate rows
countries_M_2010 <- unique(countries_M_2010)

names(countries_M_2010)[names(countries_M_2010) == "j"] <- "country_code"
countries_M_2010=merge(countries_M_2010, country_codes_V202401b,by="country_code")
write.xlsx(countries_M_2010, "countries2010_M.xlsx", rowNames = FALSE)


# Reshape the data into a matrix
matrix_df_2010 <- dcast(BACI_HS07_Y2010_V202401b, k ~ i, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS07_Y2010_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2010)
write.xlsx(matrix_df_2010, "exptot2010.xlsx", rowNames = FALSE)

# Reshape the data into a matrix for imports
matrix_df_2010_M <- dcast(BACI_HS07_Y2010_V202401b, k ~ j, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS07_Y2010_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2010_M)
write.xlsx(matrix_df_2010_M, "imptot2010.xlsx", rowNames = FALSE)


#2015====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2015")

BACI_HS12_Y2015_V202401b <- read_csv("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/BACI_HS12_V202401b/BACI_HS12_Y2015_V202401b.csv")
unique(BACI_HS12_Y2015_V202401b$k)
BACI_HS12_Y2015_V202401b <- BACI_HS12_Y2015_V202401b[!is.na(BACI_HS12_Y2015_V202401b$v), ]
BACI_HS12_Y2015_V202401b$new_column <- BACI_HS12_Y2015_V202401b$v

##check intra trade###
BACI_HS12_Y2015_V202401b_filtered <- BACI_HS12_Y2015_V202401b %>%
  filter(j == i)
BACI_HS12_Y2015_V202401b <- BACI_HS12_Y2015_V202401b %>%
  filter(j != i)

products_2015 <- c("k") 
products_2015 <- BACI_HS12_Y2015_V202401b[products_2015] 
# Drop duplicate rows
products_2015 <- unique(products_2015)

class(products_2015$k)
class(hs2012$k)
products_2015$k <- as.numeric(products_2015$k)
# Find values of 'k' that are not shared between df1 and df2
unshared_df <- anti_join(hs2012,products_2015,by = "k")
print(unshared_df)

valores_a_eliminar_2015=c(271012,271019,271020,271091,271099)
hs2012 <- subset(hs2012, !k %in% valores_a_eliminar_2015)
write.xlsx(hs2012, "hs2012.xlsx", rowNames = FALSE)
Lall2015=merge(hs2012, LallHS2012, by="k")
write.xlsx(Lall2015, "Lall2015.xlsx", rowNames = FALSE)

ict_unctad_2012 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/ict_unctad.xlsx", 
                              sheet = "2012")
digital_products_12<-merge(Lall2015, ict_unctad_2012, by ="k", all=TRUE)
colnames(digital_products_12)
digital_products_12$is_ict_2012[is.na(digital_products_12$is_ict_2012)] <- 0
digital_products_12$new_column <- 11
# Replace values with Lall2000 where is_year == 1
digital_products_12$new_column[digital_products_12$is_ict_2012 == 1] <- digital_products_12$Lall[digital_products_12$is_ict_2012 == 1]
write.xlsx(digital_products_12, "digital_products_12.xlsx", rowNames = FALSE)

DPTs_2012 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/DPTS_products_list.xlsx", 
                        sheet = "k2012")
colnames(DPTs_2012)[colnames(DPTs_2012) == "k2012"] <- "k"
danilo_2012<-merge(Lall2015, DPTs_2012, by ="k", all=TRUE)
danilo_2012$is_year[is.na(danilo_2012$is_year)] <- 0
danilo_2012$new_column <- 11
# Replace values with Lall2000 where is_year == 1
danilo_2012$new_column[danilo_2012$is_year == 1] <- danilo_2012$Lall[danilo_2012$is_year == 1]
write.xlsx(danilo_2012, "danilo_products_12.xlsx", rowNames = FALSE)

green_2012 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Green_Products_List.xlsx", 
                         sheet = "k2012")
colnames(green_2012)[colnames(green_2012) == "k2012"] <- "k"
green_2012<-merge(Lall2015, green_2012, by ="k", all=TRUE)
green_2012$is_year[is.na(green_2012$is_year)] <- 0
green_2012 <- unique(green_2012)
green_2012$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_2012$new_column[green_2012$is_year == 1] <- green_2012$Lall[green_2012$is_year == 1]
write.xlsx(green_2012, "green_products_12.xlsx", rowNames = FALSE)


#green_2012 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_list_293v2.xlsx", 
 #                        sheet = "2012")
#green_2012<-merge(Lall2015, green_2012, by ="k", all=TRUE)
#green_2012$is_green[is.na(green_2012$is_green)] <- 0
#write.xlsx(green_2012, "green_products_12.xlsx", rowNames = FALSE)

brown_2012 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Brown_products_by_hs.xlsx", 
                         sheet = "k2012")
colnames(brown_2012)[colnames(brown_2012) == "k2012"] <- "k"
brown_2012<-merge(Lall2015, brown_2012, by ="k",all=TRUE)
brown_2012$is_year[is.na(brown_2012$is_year)] <- 0
brown_2012 <- brown_2012[!is.na(brown_2012$Lall), ]
brown_2012$new_column <- 11
# Replace values with Lall2000 where is_year == 1
brown_2012$new_column[brown_2012$is_year == 1] <- brown_2012$Lall[brown_2012$is_year == 1]
write.xlsx(brown_2012, "Brown_Products_2012.xlsx", rowNames = FALSE)


#brown_2012 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_Brown.xlsx", 
 #                        sheet = "12")
#brown_2012<-merge(Lall2015, brown_2012, by ="k", all=TRUE)
#brown_2012$is_brown[is.na(brown_2012$is_brown)] <- 0
#brown_2012 <- unique(brown_2012)
#brown_2012 <- brown_2012[!is.na(brown_2012$Lall), ]
#write.xlsx(brown_2012, "brown_12.xlsx", rowNames = FALSE)


#decarbonization_technologies_products_12 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/decarbonization_technologies_products.xlsx", 
 #                                                      sheet = "2012")
#decarbonization_technologies_products_12<-merge(Lall2015, decarbonization_technologies_products_12, by ="k", all=TRUE)
#decarbonization_technologies_products_12$is_hs_12[is.na(decarbonization_technologies_products_12$is_hs_12)] <- 0
#decarbonization_technologies_products_12 <- unique(decarbonization_technologies_products_12)
#write.xlsx(decarbonization_technologies_products_12, "decarbonization_technologies_products_12.xlsx", rowNames = FALSE)

decarbonization_technologies_products_12 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Decarbonization_technologies_List.xlsx", 
                                                       sheet = "k2012")
colnames(decarbonization_technologies_products_12)[colnames(decarbonization_technologies_products_12) == "k2012"] <- "k"
decarbonization_technologies_products_12<-merge(Lall2015, decarbonization_technologies_products_12, by ="k", all=TRUE)
decarbonization_technologies_products_12$is_year[is.na(decarbonization_technologies_products_12$is_year)] <- 0
decarbonization_technologies_products_12 <- unique(decarbonization_technologies_products_12)
decarbonization_technologies_products_12$new_column <- 11
# Replace values with Lall2000 where is_year == 1
decarbonization_technologies_products_12$new_column[decarbonization_technologies_products_12$is_year == 1] <- decarbonization_technologies_products_12$Lall[decarbonization_technologies_products_12$is_year == 1]

write.xlsx(decarbonization_technologies_products_12, "decarbonization_technologies_products_12.xlsx", rowNames = FALSE)

fourIR_products_12 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/fourIR_year_data.xlsx", 
                                 sheet = "k2012")
colnames(fourIR_products_12)[colnames(fourIR_products_12) == "k2012"] <- "k"
fourIR_products_12<-merge(Lall2015, fourIR_products_12, by ="k", all=TRUE)
fourIR_products_12$is_year[is.na(fourIR_products_12$is_year)] <- 0
fourIR_products_12 <- unique(fourIR_products_12)
fourIR_products_12$new_column <- 11
# Replace values with Lall2000 where is_year == 1
fourIR_products_12$new_column[fourIR_products_12$is_year == 1] <- fourIR_products_12$Lall[fourIR_products_12$is_year == 1]
write.xlsx(fourIR_products_12, "fourIR_products_12.xlsx", rowNames = FALSE)


##greendigital
library(readxl)
green_DPTS_12 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Green_Data.xlsx", 
                            sheet = "Danilo_Green_2012")
colnames(green_DPTS_12)[colnames(green_DPTS_12) == "Danilo_Green_2012"] <- "k"
green_DPTS_12$is_year <- as.integer(!is.na(green_DPTS_12$k)) 
green_DPTS_12<-merge(Lall2015, green_DPTS_12, by ="k", all=TRUE)
green_DPTS_12$is_year[is.na(green_DPTS_12$is_year)] <- 0
green_DPTS_12 <- unique(green_DPTS_12)
green_DPTS_12$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_DPTS_12$new_column[green_DPTS_12$is_year == 1] <- green_DPTS_12$Lall[green_DPTS_12$is_year == 1]
write.xlsx(green_DPTS_12, "green_DPTS_12.xlsx", rowNames = FALSE)

library(readxl)
greentech_DPTS_12 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Decarbtech_Data.xlsx", 
                                sheet = "Danilo_Decarbtech_2012")
colnames(greentech_DPTS_12)[colnames(greentech_DPTS_12) == "Danilo_Decarbtech_2012"] <- "k"
greentech_DPTS_12$is_year <- as.integer(!is.na(greentech_DPTS_12$k)) 
greentech_DPTS_12<-merge(Lall2015, greentech_DPTS_12, by ="k", all=TRUE)
greentech_DPTS_12$is_year[is.na(greentech_DPTS_12$is_year)] <- 0
greentech_DPTS_12 <- unique(greentech_DPTS_12)
greentech_DPTS_12$new_column <- 11
# Replace values with Lall2000 where is_year == 1
greentech_DPTS_12$new_column[greentech_DPTS_12$is_year == 1] <- greentech_DPTS_12$Lall[greentech_DPTS_12$is_year == 1]

write.xlsx(greentech_DPTS_12, "greentech_DPTS_12.xlsx", rowNames = FALSE)


unshared_df2 <- anti_join(products_2015,hs2012,by = "k")
print(unshared_df2)
#valores_a_eliminar_2015_2=c(811259,811251,811252)
#products_2015 <- subset(products_2015, !k %in% valores_a_eliminar_2015_2)
#BACI_HS12_Y2015_V202401b <- subset(BACI_HS12_Y2015_V202401b, !k %in% valores_a_eliminar_2015_2)


# Define the vector of countries you want to extract (exports)
countries_X_2015 <- c("i") 
countries_X_2015 <- BACI_HS12_Y2015_V202401b[countries_X_2015] 

# Drop duplicate rows
countries_X_2015 <- unique(countries_X_2015)
names(countries_X_2015)[names(countries_X_2015) == "i"] <- "country_code"
countries_X_2015=merge(countries_X_2015, country_codes_V202401b,by="country_code")
write.xlsx(countries_X_2015, "countries2015.xlsx", rowNames = FALSE)

# Define the vector of countries you want to extract (exports)
countries_M_2015 <- c("j") 
countries_M_2015 <- BACI_HS12_Y2015_V202401b[countries_M_2015] 

# Drop duplicate rows
countries_M_2015 <- unique(countries_M_2015)

names(countries_M_2015)[names(countries_M_2015) == "j"] <- "country_code"
countries_M_2015=merge(countries_M_2015, country_codes_V202401b,by="country_code")
write.xlsx(countries_M_2015, "countries2015_M.xlsx", rowNames = FALSE)


# Reshape the data into a matrix
matrix_df_2015 <- dcast(BACI_HS12_Y2015_V202401b, k ~ i, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS12_Y2015_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2015)
write.xlsx(matrix_df_2015, "exptot2015.xlsx", rowNames = FALSE)

# Reshape the data into a matrix
matrix_df_2015_M <- dcast(BACI_HS12_Y2015_V202401b, k ~ j, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS12_Y2015_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2015_M)
write.xlsx(matrix_df_2015_M, "imptot2015.xlsx", rowNames = FALSE)


#2018====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2018")

BACI_HS17_Y2018_V202401b <- read_csv("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/BACI_HS17_V202401b/BACI_HS17_Y2018_V202401b.csv")
unique(BACI_HS17_Y2018_V202401b$k)
BACI_HS17_Y2018_V202401b <- BACI_HS17_Y2018_V202401b[!is.na(BACI_HS17_Y2018_V202401b$v), ]
BACI_HS17_Y2018_V202401b$new_column <- BACI_HS17_Y2018_V202401b$v
##check intra trade###
BACI_HS17_Y2018_V202401b_filtered <- BACI_HS17_Y2018_V202401b %>%
  filter(j == i)
BACI_HS17_Y2018_V202401b <- BACI_HS17_Y2018_V202401b %>%
  filter(j != i)


products_2018 <- c("k") 
products_2018 <- BACI_HS17_Y2018_V202401b[products_2018] 
# Drop duplicate rows
products_2018 <- unique(products_2018)

class(products_2018$k)
class(hs2017$k)
products_2018$k <- as.numeric(products_2018$k)
# Find values of 'k' that are not shared between df1 and df2
unshared_df <- anti_join(hs2017,products_2018,by = "k")
print(unshared_df)

valores_a_eliminar_2018=c(271012,271019,271020,271091,271099)
hs2017 <- subset(hs2017, !k %in% valores_a_eliminar_2018)
write.xlsx(hs2017, "hs2017.xlsx", rowNames = FALSE)
Lall2018=merge(LallHS2017, hs2017,by="k")
write.xlsx(Lall2018, "Lall2018.xlsx", rowNames = FALSE)

ict_unctad_2017 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/ict_unctad.xlsx", 
                              sheet = "2017")
digital_products_17<-merge(Lall2018, ict_unctad_2017, by ="k", all=TRUE)
colnames(digital_products_17)
digital_products_17$is_ict_2017[is.na(digital_products_17$is_ict_2017)] <- 0
digital_products_17$new_column <- 11
# Replace values with Lall2000 where is_year == 1
digital_products_17$new_column[digital_products_17$is_ict_2017 == 1] <- digital_products_17$Lall[digital_products_17$is_ict_2017 == 1]
write.xlsx(digital_products_17, "digital_products_17.xlsx", rowNames = FALSE)


DPTs_2017 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/DPTS_products_list.xlsx", 
                        sheet = "k2017")
colnames(DPTs_2017)[colnames(DPTs_2017) == "k2017"] <- "k"
danilo_2017<-merge(Lall2018, DPTs_2017, by ="k", all=TRUE)
danilo_2017$is_year[is.na(danilo_2017$is_year)] <- 0
danilo_2017$new_column <- 11
# Replace values with Lall2000 where is_year == 1
danilo_2017$new_column[danilo_2017$is_year == 1] <- danilo_2017$Lall[danilo_2017$is_year == 1]
write.xlsx(danilo_2017, "danilo_products_17.xlsx", rowNames = FALSE)

green_2017 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Green_Products_List.xlsx", 
                         sheet = "k2017")
colnames(green_2017)[colnames(green_2017) == "k2017"] <- "k"
green_2017<-merge(Lall2018, green_2017, by ="k", all=TRUE)
green_2017$is_year[is.na(green_2017$is_year)] <- 0
green_2017 <- unique(green_2017)
green_2017$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_2017$new_column[green_2017$is_year == 1] <- green_2017$Lall[green_2017$is_year == 1]
write.xlsx(green_2017, "green_products_17.xlsx", rowNames = FALSE)


#green_2017 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_list_293v2.xlsx", 
 #                        sheet = "2017")
#green_2017<-merge(Lall2018, green_2017, by ="k", all=TRUE)
#green_2017$is_green[is.na(green_2017$is_green)] <- 0
#write.xlsx(green_2017, "green_products_17.xlsx", rowNames = FALSE)

brown_2017 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Brown_products_by_hs.xlsx", 
                         sheet = "k2017")
colnames(brown_2017)[colnames(brown_2017) == "k2017"] <- "k"
brown_2017<-merge(Lall2018, brown_2017, by ="k",all=TRUE)
brown_2017$is_year[is.na(brown_2017$is_year)] <- 0
brown_2017 <- brown_2017[!is.na(brown_2017$Lall), ]
brown_2017$new_column <- 11
# Replace values with Lall2000 where is_year == 1
brown_2017$new_column[brown_2017$is_year == 1] <- brown_2017$Lall[brown_2017$is_year == 1]
write.xlsx(brown_2017, "Brown_Products_2017.xlsx", rowNames = FALSE)

#brown_2017 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/green_Brown.xlsx", 
 #                        sheet = "17")
#brown_2017<-merge(Lall2018, brown_2017, by ="k",all=TRUE)
#brown_2017$is_brown[is.na(brown_2017$is_brown)] <- 0
#brown_2017 <- unique(brown_2017)
#brown_2017 <- brown_2017[!is.na(brown_2017$Lall), ]
#write.xlsx(brown_2017, "brown_17.xlsx", rowNames = FALSE)


#decarbonization_technologies_products_17 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/decarbonization_technologies_products.xlsx", 
 #                                                      sheet = "2017")
#decarbonization_technologies_products_17<-merge(Lall2018, decarbonization_technologies_products_17, by ="k", all=TRUE)
#decarbonization_technologies_products_17$is_hs_17[is.na(decarbonization_technologies_products_17$is_hs_17)] <- 0
#decarbonization_technologies_products_17 <- unique(decarbonization_technologies_products_17)
#write.xlsx(decarbonization_technologies_products_17, "decarbonization_technologies_products_17.xlsx", rowNames = FALSE)
decarbonization_technologies_products_17 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Decarbonization_technologies_List.xlsx", 
                                                       sheet = "k2017")
colnames(decarbonization_technologies_products_17)[colnames(decarbonization_technologies_products_17) == "k2017"] <- "k"
decarbonization_technologies_products_17<-merge(Lall2018, decarbonization_technologies_products_17, by ="k", all=TRUE)
decarbonization_technologies_products_17$is_year[is.na(decarbonization_technologies_products_17$is_year)] <- 0
decarbonization_technologies_products_17 <- unique(decarbonization_technologies_products_17)
decarbonization_technologies_products_17$new_column <- 11
# Replace values with Lall2000 where is_year == 1
decarbonization_technologies_products_17$new_column[decarbonization_technologies_products_17$is_year == 1] <- decarbonization_technologies_products_17$Lall[decarbonization_technologies_products_17$is_year == 1]

write.xlsx(decarbonization_technologies_products_17, "decarbonization_technologies_products_17.xlsx", rowNames = FALSE)

fourIR_products_17 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/fourIR_year_data.xlsx", 
                                 sheet = "k2017")
colnames(fourIR_products_17)[colnames(fourIR_products_17) == "k2017"] <- "k"
fourIR_products_17<-merge(Lall2018, fourIR_products_17, by ="k", all=TRUE)
fourIR_products_17$is_year[is.na(fourIR_products_17$is_year)] <- 0
fourIR_products_17 <- unique(fourIR_products_17)
fourIR_products_17$new_column <- 11
# Replace values with Lall2000 where is_year == 1
fourIR_products_17$new_column[fourIR_products_17$is_year == 1] <- fourIR_products_17$Lall[fourIR_products_17$is_year == 1]
write.xlsx(fourIR_products_17, "fourIR_products_17.xlsx", rowNames = FALSE)


##greendigital
library(readxl)
green_DPTS_17 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Green_Data.xlsx", 
                            sheet = "Danilo_Green_2017")
colnames(green_DPTS_17)[colnames(green_DPTS_17) == "Danilo_Green_2017"] <- "k"
green_DPTS_17$is_year <- as.integer(!is.na(green_DPTS_17$k)) 
green_DPTS_17<-merge(Lall2018, green_DPTS_17, by ="k", all=TRUE)
green_DPTS_17$is_year[is.na(green_DPTS_17$is_year)] <- 0
green_DPTS_17 <- unique(green_DPTS_17)
green_DPTS_17$new_column <- 11
# Replace values with Lall2000 where is_year == 1
green_DPTS_17$new_column[green_DPTS_17$is_year == 1] <- green_DPTS_17$Lall[green_DPTS_17$is_year == 1]
write.xlsx(green_DPTS_17, "green_DPTS_17.xlsx", rowNames = FALSE)

library(readxl)
greentech_DPTS_17 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/products_twin_transition/Danilo_Decarbtech_Data.xlsx", 
                                sheet = "Danilo_Decarbtech_2017")
colnames(greentech_DPTS_17)[colnames(greentech_DPTS_17) == "Danilo_Decarbtech_2017"] <- "k"
greentech_DPTS_17$is_year <- as.integer(!is.na(greentech_DPTS_17$k)) 
greentech_DPTS_17<-merge(Lall2018, greentech_DPTS_17, by ="k", all=TRUE)
greentech_DPTS_17$is_year[is.na(greentech_DPTS_17$is_year)] <- 0
greentech_DPTS_17 <- unique(greentech_DPTS_17)
greentech_DPTS_17$new_column <- 11
# Replace values with Lall2000 where is_year == 1
greentech_DPTS_17$new_column[greentech_DPTS_17$is_year == 1] <- greentech_DPTS_17$Lall[greentech_DPTS_17$is_year == 1]

write.xlsx(greentech_DPTS_17, "greentech_DPTS_17.xlsx", rowNames = FALSE)

unshared_df2 <- anti_join(products_2018,hs2017,by = "k")
print(unshared_df2)

# Define the vector of countries you want to extract (exports)
countries_X_2018 <- c("i") 
countries_X_2018 <- BACI_HS17_Y2018_V202401b[countries_X_2018] 

# Drop duplicate rows
countries_X_2018 <- unique(countries_X_2018)

names(countries_X_2018)[names(countries_X_2018) == "i"] <- "country_code"
countries_X_2018=merge(countries_X_2018, country_codes_V202401b,by="country_code")
write.xlsx(countries_X_2018, "countries2018.xlsx", rowNames = FALSE)

# Define the vector of countries you want to extract (exports)
countries_M_2018 <- c("j") 
countries_M_2018 <- BACI_HS17_Y2018_V202401b[countries_M_2018] 

# Drop duplicate rows
countries_M_2018 <- unique(countries_M_2018)

names(countries_M_2018)[names(countries_M_2018) == "j"] <- "country_code"
countries_M_2018=merge(countries_M_2018, country_codes_V202401b,by="country_code")
write.xlsx(countries_M_2018, "countries2018_M.xlsx", rowNames = FALSE)

# Reshape the data into a matrix for EXPORTS!
matrix_df_2018 <- dcast(BACI_HS17_Y2018_V202401b, k ~ i, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS17_Y2018_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2018)
write.xlsx(matrix_df_2018, "exptot2018.xlsx", rowNames = FALSE)

# Reshape the data into a matrix for EXPORTS!
matrix_df_2018_M <- dcast(BACI_HS17_Y2018_V202401b, k ~ j, value.var = "new_column", fun.aggregate = sum)
class(BACI_HS17_Y2018_V202401b$new_column)
# Print the resulting matrix
print(matrix_df_2018_M)
write.xlsx(matrix_df_2018_M, "imptot2018.xlsx", rowNames = FALSE)




library(dplyr)
library(tidyr)
##TABLA RESUMEN====
# Count occurrences of new_column in each dataset
library(dplyr)
##DIGITAL====
# Count occurrences and add year column
digital_products_96_counts <- digital_products_96 %>% 
  count(new_column) %>% 
  mutate(year = 1996,label = "digital"
  )

digital_products_02_counts <- digital_products_02 %>% 
  count(new_column) %>% 
  mutate(year = 2002, label = "digital"
  )

digital_products_07_counts <- digital_products_07 %>% 
  count(new_column) %>% 
  mutate(year = 2007, label = "digital"
  )

digital_products_12_counts <- digital_products_12 %>% 
  count(new_column) %>% 
  mutate(year = 2012, label = "digital"
  )

digital_products_17_counts <- digital_products_17 %>% 
  count(new_column) %>% 
  mutate(year = 2017,  label = "digital"
)
##DPTS====
DPTs_1996_counts <- danilo_1996 %>% 
  count(new_column) %>% 
  mutate(year = 1996, label = "DPTs"
  )

DPTs_2002_counts <- danilo_2002 %>% 
  count(new_column) %>% 
  mutate(year = 2002, label = "DPTs"
  )

DPTs_2007_counts <- danilo_2007 %>% 
  count(new_column) %>% 
  mutate(year = 2007, label = "DPTs"
  )
  

DPTs_2012_counts <- danilo_2012 %>% 
  count(new_column) %>% 
  mutate(year = 2012, label = "DPTs"
  )

DPTs_2017_counts <- danilo_2017 %>% 
  count(new_column) %>% 
  mutate(year = 2017, label = "DPTs"
  )
##GREEN====
Green_96_counts <- green_1996 %>% 
  count(new_column) %>% 
  mutate(year = 1996,label = "green"
  )

Green_02_counts <- green_2002 %>% 
  count(new_column) %>% 
  mutate(year = 2002, label = "green"
  )

Green_07_counts <- green_2007 %>% 
  count(new_column) %>% 
  mutate(year = 2007, label = "green"
  )

Green_12_counts <- green_2012 %>% 
  count(new_column) %>% 
  mutate(year = 2012, label = "green"
  )

Green_17_counts <- green_2017 %>% 
  count(new_column) %>% 
  mutate(year = 2017, label = "green"
  )
##BROWN====
Brown_96_counts <- brown_1996 %>% 
  count(new_column) %>% 
  mutate(year = 1996, label = "brown"
  )

Brown_02_counts <- brown_2002 %>% 
  count(new_column) %>% 
  mutate(year = 2002, label = "brown"
  )

Brown_07_counts <- brown_2007 %>% 
  count(new_column) %>% 
  mutate(year = 2007, label = "brown"
  )

Brown_12_counts <- brown_2012 %>% 
  count(new_column) %>% 
  mutate(year = 2012 , label = "brown"
  )

Brown_17_counts <- brown_2017 %>% 
  count(new_column) %>% 
  mutate(year = 2017 , label = "brown"
  )
##4IR====
FourIR_products_96_counts <- fourIR_products_96 %>% 
  count(new_column) %>% 
  mutate(year = 1996, label = "4IR"
  )

FourIR_products_02_counts <- fourIR_products_02 %>% 
  count(new_column) %>% 
  mutate(year = 2002,label = "4IR"
  )

FourIR_products_07_counts <- fourIR_products_07 %>% 
  count(new_column) %>% 
  mutate(year = 2007 , label = "4IR"
  )

FourIR_products_12_counts <- fourIR_products_12 %>% 
  count(new_column) %>% 
  mutate(year = 2012, label = "4IR"
  )

FourIR_products_17_counts <- fourIR_products_17 %>% 
  count(new_column) %>% 
  mutate(year = 2017, label = "4IR"
  )
##GREENTECHDPTs====
Greentech_DPTS_96_counts <- greentech_DPTS_96 %>% 
  count(new_column) %>% 
  mutate(year = 1996, label = "Greentech_DPTS"
  )

Greentech_DPTS_02_counts <- greentech_DPTS_02 %>% 
  count(new_column) %>% 
  mutate(year = 2002, label = "Greentech_DPTS"
  )

Greentech_DPTS_07_counts <- greentech_DPTS_07 %>% 
  count(new_column) %>% 
  mutate(year = 2007, label = "Greentech_DPTS"
  )

Greentech_DPTS_12_counts <- greentech_DPTS_12 %>% 
  count(new_column) %>% 
  mutate(year = 2012, label = "Greentech_DPTS"
  )

Greentech_DPTS_17_counts <- greentech_DPTS_17 %>% 
  count(new_column) %>% 
  mutate(year = 2017, label = "Greentech_DPTS"
  )
##decarbonization tech ====
Decarbonization_technologies_products_96_counts <- decarbonization_technologies_products_96 %>% 
  count(new_column) %>% 
  mutate(year = 1996, label = "Decarbonization_technologies"
  )

Decarbonization_technologies_products_02_counts <- decarbonization_technologies_products_02 %>% 
  count(new_column) %>% 
  mutate(year = 2002, label = "Decarbonization_technologies"
  )

Decarbonization_technologies_products_07_counts <- decarbonization_technologies_products_07 %>% 
  count(new_column) %>% 
  mutate(year = 2007, label = "Decarbonization_technologies"
  )

Decarbonization_technologies_products_12_counts <- decarbonization_technologies_products_12 %>% 
  count(new_column) %>% 
  mutate(year = 2012, label = "Decarbonization_technologies"
  )

Decarbonization_technologies_products_17_counts <- decarbonization_technologies_products_17 %>% 
  count(new_column) %>% 
  mutate(year = 2017, label = "Decarbonization_technologies"
  )

##greendpts====

Green_DPTS_96_counts <- green_DPTS_96 %>% 
  count(new_column) %>% 
  mutate(year = 1996, label = "Green_DPTS"
  )

Green_DPTS_02_counts <- green_DPTS_02 %>% 
  count(new_column) %>% 
  mutate(year = 2002, label = "Green_DPTS"
  )

Green_DPTS_07_counts <- green_DPTS_07 %>% 
  count(new_column) %>% 
  mutate(year = 2007, label = "Green_DPTS"
  )

Green_DPTS_12_counts <- green_DPTS_12 %>% 
  count(new_column) %>% 
  mutate(year = 2012, label = "Green_DPTS"
  )

Green_DPTS_17_counts <- green_DPTS_17 %>% 
  count(new_column) %>% 
  mutate(year = 2017, label = "Green_DPTS"
  )

## Combine all datasets====
library(dplyr)

# Combine digital products counts
digital_products_counts <- bind_rows(
  digital_products_96_counts,
  digital_products_02_counts,
  digital_products_07_counts,
  digital_products_12_counts,
  digital_products_17_counts
)

# Combine DPTs counts
DPTs_counts <- bind_rows(
  DPTs_1996_counts,
  DPTs_2002_counts,
  DPTs_2007_counts,
  DPTs_2012_counts,
  DPTs_2017_counts
)

# Combine Green counts
Green_counts <- bind_rows(
  Green_96_counts,
  Green_02_counts,
  Green_07_counts,
  Green_12_counts,
  Green_17_counts
)

# Combine Brown counts
Brown_counts <- bind_rows(
  Brown_96_counts,
  Brown_02_counts,
  Brown_07_counts,
  Brown_12_counts,
  Brown_17_counts
)

# Combine FourIR products counts
FourIR_products_counts <- bind_rows(
  FourIR_products_96_counts,
  FourIR_products_02_counts,
  FourIR_products_07_counts,
  FourIR_products_12_counts,
  FourIR_products_17_counts
)

# Combine Greentech DPTS counts
Greentech_DPTS_counts <- bind_rows(
  Greentech_DPTS_96_counts,
  Greentech_DPTS_02_counts,
  Greentech_DPTS_07_counts,
  Greentech_DPTS_12_counts,
  Greentech_DPTS_17_counts
)

# Combine Green DPTS counts
Green_DPTS_counts <- bind_rows(
  Green_DPTS_96_counts,
  Green_DPTS_02_counts,
  Green_DPTS_07_counts,
  Green_DPTS_12_counts,
  Green_DPTS_17_counts
)

Decarbonization_technologies_products_counts <- bind_rows(
Decarbonization_technologies_products_96_counts,
Decarbonization_technologies_products_02_counts,
Decarbonization_technologies_products_07_counts,
Decarbonization_technologies_products_12_counts,
Decarbonization_technologies_products_17_counts)

# Combine all counts into a single dataset
all_counts <- bind_rows(
  digital_products_counts,
  DPTs_counts,
  Green_counts,
  Brown_counts,
  FourIR_products_counts,
  Greentech_DPTS_counts,
  Green_DPTS_counts,
  Decarbonization_technologies_products_counts
)

# View the combined dataset
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis")
write.xlsx(all_counts, "all_counts.xlsx", rowNames = FALSE)





#Indicators====
library(readxl)
library(readxl)
GDP <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/GDP.xls", 
                  sheet = "Data")
GDP_1995 <- GDP[, c("country_iso3", "1995")] 
GDP_1995$`1995` <- log(GDP_1995$`1995`)
GDP_2000 <- GDP[, c("country_iso3", "2000")] 
GDP_2000$`2000` <- log(GDP_2000$`2000`)
GDP_2005 <- GDP[, c("country_iso3", "2005")] 
GDP_2005$`2005` <- log(GDP_2005$`2005`)
GDP_2010 <- GDP[, c("country_iso3", "2010")] 
GDP_2010$`2010` <- log(GDP_2010$`2010`)
GDP_2015 <- GDP[, c("country_iso3", "2015")]
GDP_2015$`2015` <- log(GDP_2015$`2015`)
GDP_2018 <- GDP[, c("country_iso3", "2018")]
GDP_2018$`2018` <- log(GDP_2018$`2018`)

# Merge the datasets by country_iso3
GDP_combined <- Reduce(function(x, y) merge(x, y, by = "country_iso3"), 
                       list(GDP_1995, GDP_2000, GDP_2005, GDP_2010, GDP_2015, GDP_2018))

# Calculate CAGRs
GDP_combined$CAGR_1995_2000 <- ((GDP_combined$`2000` / GDP_combined$`1995`)^(1/5)) - 1 #2000
GDP_combined$CAGR_2000_2005 <- ((GDP_combined$`2005` / GDP_combined$`2000`)^(1/5)) - 1 #2005
GDP_combined$CAGR_2005_2010 <- ((GDP_combined$`2010` / GDP_combined$`2005`)^(1/5)) - 1 #2010
GDP_combined$CAGR_2010_2015 <- ((GDP_combined$`2015` / GDP_combined$`2010`)^(1/5)) - 1 #2015
GDP_combined$CAGR_2015_2018 <- ((GDP_combined$`2018` / GDP_combined$`2015`)^(1/3)) - 1 #2018

# Display the final dataframe with CAGRs
print(GDP_combined)

GDP_2000 <- merge(GDP_2000, GDP_combined[, c("country_iso3", "CAGR_1995_2000")], by = "country_iso3")
GDP_2005 <- merge(GDP_2005, GDP_combined[, c("country_iso3", "CAGR_2000_2005")], by = "country_iso3")
GDP_2010 <- merge(GDP_2010, GDP_combined[, c("country_iso3", "CAGR_2005_2010")], by = "country_iso3")
GDP_2015 <- merge(GDP_2015, GDP_combined[, c("country_iso3", "CAGR_2010_2015")], by = "country_iso3")
GDP_2018 <- merge(GDP_2018, GDP_combined[, c("country_iso3", "CAGR_2015_2018")], by = "country_iso3")



library(readxl)
CO2 <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/CO2.xls")
View(CO2)

library(readxl)
C02_edgar <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/C02_edgar.xlsx", 
                        sheet = "fossil_CO2_per_capita_by_countr")
View(C02_edgar)

CO2_1995 <- CO2[, c("country_iso3", "1995")] 
CO2_2000 <- CO2[, c("country_iso3", "2000")] 
CO2_2005 <- CO2[, c("country_iso3", "2005")] 
CO2_2010 <- CO2[, c("country_iso3", "2010")] 
CO2_2015 <- CO2[, c("country_iso3", "2015")]
CO2_2018 <- CO2[, c("country_iso3", "2018")]

CO2_1995_edgar <- C02_edgar[, c("country_iso3", "1995")] 
CO2_2000_edgar <- C02_edgar[, c("country_iso3", "2000")] 
CO2_2005_edgar <- C02_edgar[, c("country_iso3", "2005")] 
CO2_2010_edgar <- C02_edgar[, c("country_iso3", "2010")] 
CO2_2015_edgar <- C02_edgar[, c("country_iso3", "2015")]
CO2_2018_edgar <- C02_edgar[, c("country_iso3", "2018")]

library(readxl)
export_emissions_database <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/export_emissions_database.xlsx", 
                                        sheet = "Sheet4")

emissions_1995 <- export_emissions_database[, c("country_iso3", "1995")] 
emissions_2000 <- export_emissions_database[, c("country_iso3", "2000")] 
emissions_2005 <- export_emissions_database[, c("country_iso3", "2005")] 
emissions_2010 <- export_emissions_database[, c("country_iso3", "2010")] 
emissions_2015 <- export_emissions_database[, c("country_iso3", "2015")]
emissions_2018 <- export_emissions_database[, c("country_iso3", "2018")]


library(readxl)
Gini <- read_excel("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/Gini.xlsx", 
                   sheet = "gini")
View(Gini)

Gini_1995 <- Gini[, c("country_iso3", "1995")] 
Gini_2000 <- Gini[, c("country_iso3", "2000")] 
Gini_2005 <- Gini[, c("country_iso3", "2005")] 
Gini_2010 <- Gini[, c("country_iso3", "2010")] 
Gini_2015 <- Gini[, c("country_iso3", "2015")]
Gini_2018 <- Gini[, c("country_iso3", "2018")]

library(readxl)
mfa <- read_excel("~/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/mfa_dmc.xlsx", 
                      sheet = "MFA")
mfa_1995 <- mfa[, c("country_iso3", "1995")] 
mfa_2000 <- mfa[, c("country_iso3", "2000")] 
mfa_2005 <- mfa[, c("country_iso3", "2005")] 
mfa_2010 <- mfa[, c("country_iso3", "2010")] 
mfa_2015 <- mfa[, c("country_iso3", "2015")]
mfa_2018 <- mfa[, c("country_iso3", "2018")]

dmc <- read_excel("~/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/mfa_dmc.xlsx", 
                  sheet = "DMC")
dmc_1995 <- dmc[, c("country_iso3", "1995")] 
dmc_2000 <- dmc[, c("country_iso3", "2000")] 
dmc_2005 <- dmc[, c("country_iso3", "2005")] 
dmc_2010 <- dmc[, c("country_iso3", "2010")] 
dmc_2015 <- dmc[, c("country_iso3", "2015")]
dmc_2018 <- dmc[, c("country_iso3", "2018")]


individuals_internet5 <- read_excel("~/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/individuals_internet5.xlsx")
internet_1995 <- individuals_internet5[, c("country_iso3", "1995")] 
internet_2000 <- individuals_internet5[, c("country_iso3", "2000")] 
internet_2005 <- individuals_internet5[, c("country_iso3", "2005")] 
internet_2010 <- individuals_internet5[, c("country_iso3", "2010")] 
internet_2015 <- individuals_internet5[, c("country_iso3", "2015")]
internet_2018 <- individuals_internet5[, c("country_iso3", "2018")]

renew_energy <- read_excel("~/Downloads/API_EG.FEC.RNEW.ZS_DS2_en_excel_v2_1288873.xls")
renew_energy[renew_energy == 0.000000] <- NaN
renew_energy[] <- lapply(renew_energy, function(x) if(is.numeric(x)) x / 100 else x)
renew_energy_1995 <- renew_energy[, c("country_iso3", "1995")] 
renew_energy_2000 <- renew_energy[, c("country_iso3", "2000")] 
renew_energy_2005 <- renew_energy[, c("country_iso3", "2005")] 
renew_energy_2010 <- renew_energy[, c("country_iso3", "2010")] 
renew_energy_2015 <- renew_energy[, c("country_iso3", "2015")]
renew_energy_2018 <- renew_energy[, c("country_iso3", "2018")]

renew_energy_minus <- renew_energy
renew_energy_minus[] <- lapply(renew_energy_minus, function(x) if(is.numeric(x)) 1 - x else x)
renew_energy_minus_1995 <- renew_energy_minus[, c("country_iso3", "1995")] 
renew_energy_minus_2000 <- renew_energy_minus[, c("country_iso3", "2000")] 
renew_energy_minus_2005 <- renew_energy_minus[, c("country_iso3", "2005")] 
renew_energy_minus_2010 <- renew_energy_minus[, c("country_iso3", "2010")] 
renew_energy_minus_2015 <- renew_energy_minus[, c("country_iso3", "2015")]
renew_energy_minus_2018 <- renew_energy_minus[, c("country_iso3", "2018")]


#productivity
#productivity <- read_excel("~/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/productivity.xlsx", 
 #                          sheet = "Sheet2")
#productivity_2000 <- productivity[, c("country_iso3", "2000")] 
#productivity_2005 <- productivity[, c("country_iso3", "2005")] 
#productivity_2010 <- productivity[, c("country_iso3", "2010")] 
#productivity_2015 <- productivity[, c("country_iso3", "2015")]
#productivity_2018 <- productivity[, c("country_iso3", "2018")]

#governnace
voiceaccount <- read_excel("~/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/indicators/wgidataset.xlsx", 
                         sheet = "Sheet1")
voiceaccount_2000 <- voiceaccount[, c("country_iso3", "2000")] 
voiceaccount_2005 <- voiceaccount[, c("country_iso3", "2005")] 
voiceaccount_2010 <- voiceaccount[, c("country_iso3", "2010")] 
voiceaccount_2015 <- voiceaccount[, c("country_iso3", "2015")]
voiceaccount_2018 <- voiceaccount[, c("country_iso3", "2018")]


# Load necessary libraries
library(dplyr)
library(openxlsx)


#Merge EXPORTS

#2000====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2000")
# Merging GDP, CO2, Gini, and emissions data for 2000
library(dplyr)
library(openxlsx)
# List of data frames to merge
data_frames <- list(GDP_2000, 
                    CO2_2000_edgar,
                    Gini_2000, 
                    emissions_2000, 
                    mfa_2000, 
                    dmc_2000, 
                    internet_2000, 
                    renew_energy_2000, 
                   # productivity_2000,
                    voiceaccount_2000)
# Perform the merge using Reduce
merge2000 <- Reduce(function(x, y) merge(x, y, by = "country_iso3", all = TRUE), data_frames)
# Rename columns after merging
colnames(merge2000) <- c("country_iso3", 
                         "gdp",
                         "growth_gdp",
                         "co2",
                         "gini",
                         "emissions",
                         "mfa",
                         "dmc",
                         'internet',
                         'renew_energy',
                         #'productivity',
                         'voiceaccount')
# Merge with countries_X_2000 data
merge2000 <- merge(countries_X_2000, merge2000, by = "country_iso3", all = TRUE)
# Filter rows based on the presence of country_code
merge2000 <- merge2000 %>% filter(!is.na(country_code))
# Add dummy variable
merge2000 <- merge2000 %>%
  mutate(dummy = as.integer(rowSums(is.na(select(., gdp,
                                                 growth_gdp, 
                                                 co2, 
                                                 gini,
                                                 emissions,
                                                 mfa,
                                                 dmc,
                                                 internet,
                                                 renew_energy,
                                                 #productivity,
                                                 voiceaccount))) == 0))
# Order the data by country_code
merge2000 <- merge2000 %>% arrange(country_code)
# Save merged and filtered data to Excel files
write.xlsx(merge2000, "merge2000.xlsx", rowNames = FALSE)
Z_original_2000 <- merge2000 %>% filter(dummy == 1)
write.xlsx(Z_original_2000, "Z_original_2000.xlsx", rowNames = FALSE)

colnames(merge2000)
#2005====

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2005")
# Merging GDP, CO2, Gini, and emissions data for 2005
library(dplyr)
library(openxlsx)
# List of data frames to merge
data_frames <- list(GDP_2005, 
                    CO2_2005_edgar,
                    Gini_2005, 
                    emissions_2005, 
                    mfa_2005, 
                    dmc_2005, 
                    internet_2005, 
                    renew_energy_2005, 
                  #  productivity_2005,
                    voiceaccount_2005)
# Perform the merge using Reduce
merge2005 <- Reduce(function(x, y) merge(x, y, by = "country_iso3", all = TRUE), data_frames)
# Rename columns after merging
colnames(merge2005) <- c("country_iso3", "gdp",
                         "growth_gdp",
                         "co2",
                         "gini",
                         "emissions",
                         "mfa",
                         "dmc",
                         'internet',
                         'renew_energy',
                         #'productivity',
                         'voiceaccount')
# Merge with countries_X_2005 data
merge2005 <- merge(countries_X_2005, merge2005, by = "country_iso3", all = TRUE)
# Filter rows based on the presence of country_code
merge2005 <- merge2005 %>% filter(!is.na(country_code))
# Add dummy variable
merge2005 <- merge2005 %>%
  mutate(dummy = as.integer(rowSums(is.na(select(., gdp,
                                                 growth_gdp,
                                                 co2,
                                                 gini,
                                                 emissions,
                                                 mfa,
                                                 dmc,
                                                 internet,
                                                 renew_energy,
                                                 #productivity,
                                                 voiceaccount))) == 0))
# Order the data by country_code
merge2005 <- merge2005 %>% arrange(country_code)
# Save merged and filtered data to Excel files
write.xlsx(merge2005, "merge2005.xlsx", rowNames = FALSE)
Z_original_2005 <- merge2005 %>% filter(dummy == 1)
write.xlsx(Z_original_2005, "Z_original_2005.xlsx", rowNames = FALSE)

# Set working directory
#setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2005")
# Merging GDP and CO2 data for 2005
#merge2005_a <- merge(GDP_2005, CO2_2005_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2005
#merge2005_b <- merge(merge2005_a, Gini_2005, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2005
#merge2005_d <- merge(merge2005_b, emissions_2005, by = "country_iso3", all = TRUE)
# Renaming columns
#colnames(merge2005_d) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2005
#merge2005_e <- merge(countries_X_2005, merge2005_d, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
#merge2005_e <- merge2005_e[!is.na(merge2005_e$country_code), ]
# Adding a dummy variable to filter complete rows
#merge2005_e$dummy <- as.integer(!is.na(merge2005_e$gdp) & !is.na(merge2005_e$co2) & !is.na(merge2005_e$gini) & !is.na(merge2005_e$emissions))
# Ordering the data by 'country_code'
#merge2005_e <- merge2005_e[order(merge2005_e$country_code),]
# Saving merged data to an Excel file
#write.xlsx(merge2005_e, "merge2005_e.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
#Z_original_2005 <- merge2005_e[merge2005_e$dummy == 1, ]
# Saving filtered data to an Excel file
#write.xlsx(Z_original_2005, "Z_original_2005.xlsx", rowNames = FALSE)

#2010====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2010")
# Merging GDP, CO2, Gini, and emissions data for 2010
library(dplyr)
library(openxlsx)
# List of data frames to merge
data_frames <- list(GDP_2010, 
                    CO2_2010_edgar,
                    Gini_2010, 
                    emissions_2010, 
                    mfa_2010, 
                    dmc_2010, 
                    internet_2010, 
                    renew_energy_2010, 
                 #   productivity_2010,
                    voiceaccount_2010)
# Perform the merge using Reduce
merge2010 <- Reduce(function(x, y) merge(x, y, by = "country_iso3", all = TRUE), data_frames)
# Rename columns after merging
colnames(merge2010) <- c("country_iso3", "gdp", 
                         "growth_gdp",
                         "co2",
                         "gini",
                         "emissions",
                         "mfa",
                         "dmc",
                         'internet',
                         'renew_energy',
                         #'productivity',
                         'voiceaccount')
# Merge with countries_X_2010 data
merge2010 <- merge(countries_X_2010, merge2010, by = "country_iso3", all = TRUE)
# Filter rows based on the presence of country_code
merge2010 <- merge2010 %>% filter(!is.na(country_code))
# Add dummy variable
merge2010 <- merge2010 %>%
  mutate(dummy = as.integer(rowSums(is.na(select(., gdp, 
                                                 growth_gdp,
                                                 co2,
                                                 gini,
                                                 emissions,
                                                 mfa,
                                                 dmc,
                                                 internet,
                                                 renew_energy, 
                                                 #productivity, 
                                                 voiceaccount))) == 0))
# Order the data by country_code
merge2010 <- merge2010 %>% arrange(country_code)
# Save merged and filtered data to Excel files
write.xlsx(merge2010, "merge2010.xlsx", rowNames = FALSE)
Z_original_2010 <- merge2010 %>% filter(dummy == 1)
write.xlsx(Z_original_2010, "Z_original_2010.xlsx", rowNames = FALSE)

# Set working directory
#setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2010")
# Merging GDP and CO2 data for 2010
#merge2010_a <- merge(GDP_2010, CO2_2010_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2010
#merge2010_b <- merge(merge2010_a, Gini_2010, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2010
#merge2010_d <- merge(merge2010_b, emissions_2010, by = "country_iso3", all = TRUE)
# Renaming columns
#colnames(merge2010_d) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2010
#merge2010_e <- merge(countries_X_2010, merge2010_d, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
#merge2010_e <- merge2010_e[!is.na(merge2010_e$country_code), ]
# Adding a dummy variable to filter complete rows
#merge2010_e$dummy <- as.integer(!is.na(merge2010_e$gdp) & !is.na(merge2010_e$co2) & !is.na(merge2010_e$gini) & !is.na(merge2010_e$emissions))
# Ordering the data by 'country_code'
#merge2010_e <- merge2010_e[order(merge2010_e$country_code),]
# Saving merged data to an Excel file
#write.xlsx(merge2010_e, "merge2010_e.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
#Z_original_2010 <- merge2010_e[merge2010_e$dummy == 1, ]
# Saving filtered data to an Excel file
#write.xlsx(Z_original_2010, "Z_original_2010.xlsx", rowNames = FALSE)

#2015====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2015")
# Merging GDP, CO2, Gini, and emissions data for 2015
library(dplyr)
library(openxlsx)
# List of data frames to merge
data_frames <- list(GDP_2015, 
                    CO2_2015_edgar,
                    Gini_2015, 
                    emissions_2015, 
                    mfa_2015, 
                    dmc_2015, 
                    internet_2015, 
                    renew_energy_2015, 
                  #  productivity_2015,
                    voiceaccount_2015)
# Perform the merge using Reduce
merge2015 <- Reduce(function(x, y) merge(x, y, by = "country_iso3", all = TRUE), data_frames)
# Rename columns after merging
colnames(merge2015) <- c("country_iso3",
                         "gdp",
                         "growth_gdp",
                         "co2",
                         "gini",
                         "emissions",
                         "mfa",
                         "dmc",
                         'internet',
                         'renew_energy', 
                         #'productivity',
                         'voiceaccount')
# Merge with countries_X_2015 data
merge2015 <- merge(countries_X_2015, merge2015, by = "country_iso3", all = TRUE)
# Filter rows based on the presence of country_code
merge2015 <- merge2015 %>% filter(!is.na(country_code))
# Add dummy variable
merge2015 <- merge2015 %>%
  mutate(dummy = as.integer(rowSums(is.na(select(., gdp,
                                                 growth_gdp,
                                                 co2,
                                                 gini,
                                                 emissions,
                                                 mfa,
                                                 dmc,
                                                 internet,
                                                 renew_energy,
                                                 #productivity,
                                                 voiceaccount))) == 0))
# Order the data by country_code
merge2015 <- merge2015 %>% arrange(country_code)
# Save merged and filtered data to Excel files
write.xlsx(merge2015, "merge2015.xlsx", rowNames = FALSE)
Z_original_2015 <- merge2015 %>% filter(dummy == 1)
write.xlsx(Z_original_2015, "Z_original_2015.xlsx", rowNames = FALSE)

# Set working directory
#setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2015")
# Merging GDP and CO2 data for 2015
#merge2015_a <- merge(GDP_2015, CO2_2015_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2015
#merge2015_b <- merge(merge2015_a, Gini_2015, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2015
#merge2015_d <- merge(merge2015_b, emissions_2015, by = "country_iso3", all = TRUE)
# Renaming columns
#colnames(merge2015_d) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2015
#merge2015_e <- merge(countries_X_2015, merge2015_d, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
#merge2015_e <- merge2015_e[!is.na(merge2015_e$country_code), ]
# Adding a dummy variable to filter complete rows
#merge2015_e$dummy <- as.integer(!is.na(merge2015_e$gdp) & !is.na(merge2015_e$co2) & !is.na(merge2015_e$gini) & !is.na(merge2015_e$emissions))
# Ordering the data by 'country_code'
#merge2015_e <- merge2015_e[order(merge2015_e$country_code),]
# Saving merged data to an Excel file
#write.xlsx(merge2015_e, "merge2015_e.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
#Z_original_2015 <- merge2015_e[merge2015_e$dummy == 1, ]
# Saving filtered data to an Excel file
#write.xlsx(Z_original_2015, "Z_original_2015.xlsx", rowNames = FALSE)


#2018====
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2018")
# Merging GDP, CO2, Gini, and emissions data for 2018
library(dplyr)
library(openxlsx)
# List of data frames to merge
data_frames <- list(GDP_2018, 
                    CO2_2018_edgar,
                    Gini_2018, 
                    emissions_2018, 
                    mfa_2018, 
                    dmc_2018, 
                    internet_2018, 
                    renew_energy_2018, 
                 #   productivity_2018,
                    voiceaccount_2018)
# Perform the merge using Reduce
merge2018 <- Reduce(function(x, y) merge(x, y, by = "country_iso3", all = TRUE), data_frames)
# Rename columns after merging
colnames(merge2018) <- c("country_iso3", 
                         "gdp", 
                         "growth_gdp", 
                         "co2", 
                         "gini", 
                         "emissions",
                         "mfa", 
                         "dmc", 
                         'internet',
                         'renew_energy', 
                         #'productivity', 
                         'voiceaccount')
# Merge with countries_X_2018 data
merge2018 <- merge(countries_X_2018, merge2018, by = "country_iso3", all = TRUE)
# Filter rows based on the presence of country_code
merge2018 <- merge2018 %>% filter(!is.na(country_code))
# Add dummy variable
merge2018 <- merge2018 %>%
  mutate(dummy = as.integer(rowSums(is.na(select(., gdp, 
                                                 growth_gdp,
                                                 co2,
                                                 gini,
                                                 emissions,
                                                 mfa,
                                                 dmc,
                                                 internet,
                                                 renew_energy,
                                                 #productivity,
                                                 voiceaccount))) == 0))
# Order the data by country_code
merge2018 <- merge2018 %>% arrange(country_code)
# Save merged and filtered data to Excel files
write.xlsx(merge2018, "merge2018.xlsx", rowNames = FALSE)
Z_original_2018 <- merge2018 %>% filter(dummy == 1)
write.xlsx(Z_original_2018, "Z_original_2018.xlsx", rowNames = FALSE)

# Set working directory
#setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2018")
# Merging GDP and CO2 data for 2018
#merge2018_a <- merge(GDP_2018, CO2_2018_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2018
#merge2018_b <- merge(merge2018_a, Gini_2018, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2018
#merge2018_d <- merge(merge2018_b, emissions_2018, by = "country_iso3", all = TRUE)
# Renaming columns
#colnames(merge2018_d) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2018
#merge2018_e <- merge(countries_X_2018, merge2018_d, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
#merge2018_e <- merge2018_e[!is.na(merge2018_e$country_code), ]
# Adding a dummy variable to filter complete rows
#merge2018_e$dummy <- as.integer(!is.na(merge2018_e$gdp) & !is.na(merge2018_e$co2) & !is.na(merge2018_e$gini) & !is.na(merge2018_e$emissions))
# Ordering the data by 'country_code'
#merge2018_e <- merge2018_e[order(merge2018_e$country_code),]
# Saving merged data to an Excel file
#write.xlsx(merge2018_e, "merge2018_e.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
#Z_original_2018 <- merge2018_e[merge2018_e$dummy == 1, ]
# Saving filtered data to an Excel file
#write.xlsx(Z_original_2018, "Z_original_2018.xlsx", rowNames = FALSE)

#Merge IMPORTS====
#BE CAREFUL: THIS IS THE EXAMPLE FOR IMPORTS!
# Set working directory
setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2000")
# Merging GDP and CO2 data for 2000
merge2000_a1 <- merge(GDP_2000, CO2_2000_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2000
merge2000_b1 <- merge(merge2000_a1, Gini_2000, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2000
merge2000_d1 <- merge(merge2000_b1, emissions_2000, by = "country_iso3", all = TRUE)
# Renaming columns
colnames(merge2000_d1) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2000
merge2000_e1 <- merge(countries_M_2000, merge2000_d1, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
merge2000_e1 <- merge2000_e1[!is.na(merge2000_e1$country_code), ]
# Adding a dummy variable to filter complete rows
merge2000_e1$dummy <- as.integer(!is.na(merge2000_e1$gdp) & !is.na(merge2000_e1$co2) & !is.na(merge2000_e1$gini) & !is.na(merge2000_e1$emissions))
# Ordering the data by 'country_code'
merge2000_e1 <- merge2000_e1[order(merge2000_e1$country_code),]
# Saving merged data to an Excel file
write.xlsx(merge2000_e1, "merge2000_e1.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
Z_original_2000_M <- merge2000_e1[merge2000_e1$dummy == 1, ]
# Saving filtered data to an Excel file
write.xlsx(Z_original_2000_M, "Z_original_2000_M.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2005")
# Merging GDP and CO2 data for 2005
merge2005_a1 <- merge(GDP_2005, CO2_2005_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2005
merge2005_b1 <- merge(merge2005_a1, Gini_2005, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2005
merge2005_d1 <- merge(merge2005_b1, emissions_2005, by = "country_iso3", all = TRUE)
# Renaming columns
colnames(merge2005_d1) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2005
merge2005_e1 <- merge(countries_M_2005, merge2005_d1, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
merge2005_e1 <- merge2005_e1[!is.na(merge2005_e1$country_code), ]
# Adding a dummy variable to filter complete rows
merge2005_e1$dummy <- as.integer(!is.na(merge2005_e1$gdp) & !is.na(merge2005_e1$co2) & !is.na(merge2005_e1$gini) & !is.na(merge2005_e1$emissions))
# Ordering the data by 'country_code'
merge2005_e1 <- merge2005_e1[order(merge2005_e1$country_code),]
# Saving merged data to an Excel file
write.xlsx(merge2005_e1, "merge2005_e1.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
Z_original_2005_M <- merge2005_e1[merge2005_e1$dummy == 1, ]
# Saving filtered data to an Excel file
write.xlsx(Z_original_2005_M, "Z_original_2005_M.xlsx", rowNames = FALSE)


setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2010")
# Merging GDP and CO2 data for 2010
merge2010_a1 <- merge(GDP_2010, CO2_2010_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2010
merge2010_b1 <- merge(merge2010_a1, Gini_2010, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2010
merge2010_d1 <- merge(merge2010_b1, emissions_2010, by = "country_iso3", all = TRUE)
# Renaming columns
colnames(merge2010_d1) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2010
merge2010_e1 <- merge(countries_M_2010, merge2010_d1, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
merge2010_e1 <- merge2010_e1[!is.na(merge2010_e1$country_code), ]
# Adding a dummy variable to filter complete rows
merge2010_e1$dummy <- as.integer(!is.na(merge2010_e1$gdp) & !is.na(merge2010_e1$co2) & !is.na(merge2010_e1$gini) & !is.na(merge2010_e1$emissions))
# Ordering the data by 'country_code'
merge2010_e1 <- merge2010_e1[order(merge2010_e1$country_code),]
# Saving merged data to an Excel file
write.xlsx(merge2010_e1, "merge2010_e1.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
Z_original_2010_M <- merge2010_e1[merge2010_e1$dummy == 1, ]
# Saving filtered data to an Excel file
write.xlsx(Z_original_2010_M, "Z_original_2010_M.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2015")
# Merging GDP and CO2 data for 2015
merge2015_a1 <- merge(GDP_2015, CO2_2015_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2015
merge2015_b1 <- merge(merge2015_a1, Gini_2015, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2015
merge2015_d1 <- merge(merge2015_b1, emissions_2015, by = "country_iso3", all = TRUE)
# Renaming columns
colnames(merge2015_d1) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2015
merge2015_e1 <- merge(countries_M_2015, merge2015_d1, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
merge2015_e1 <- merge2015_e1[!is.na(merge2015_e1$country_code), ]
# Adding a dummy variable to filter complete rows
merge2015_e1$dummy <- as.integer(!is.na(merge2015_e1$gdp) & !is.na(merge2015_e1$co2) & !is.na(merge2015_e1$gini) & !is.na(merge2015_e1$emissions))
# Ordering the data by 'country_code'
merge2015_e1 <- merge2015_e1[order(merge2015_e1$country_code),]
# Saving merged data to an Excel file
write.xlsx(merge2015_e1, "merge2015_e1.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
Z_original_2015_M <- merge2015_e1[merge2015_e1$dummy == 1, ]
# Saving filtered data to an Excel file
write.xlsx(Z_original_2015_M, "Z_original_2015_M.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2018")
# Merging GDP and CO2 data for 2018
merge2018_a1 <- merge(GDP_2018, CO2_2018_edgar, by = "country_iso3", all = TRUE)
# Merging the previous data with Gini data for 2018
merge2018_b1 <- merge(merge2018_a1, Gini_2018, by = "country_iso3", all = TRUE)
# Merging with emissions data for 2018
merge2018_d1 <- merge(merge2018_b1, emissions_2018, by = "country_iso3", all = TRUE)
# Renaming columns
colnames(merge2018_d1) <- c("country_iso3", "gdp", "growth gdp","co2", "gini", "emissions")
# Merging with countries_X data for 2018
merge2018_e1 <- merge(countries_M_2018, merge2018_d1, by = "country_iso3", all = TRUE)
# Removing rows with NA in 'country_code' column
merge2018_e1 <- merge2018_e1[!is.na(merge2018_e1$country_code), ]
# Adding a dummy variable to filter complete rows
merge2018_e1$dummy <- as.integer(!is.na(merge2018_e1$gdp) & !is.na(merge2018_e1$co2) & !is.na(merge2018_e1$gini) & !is.na(merge2018_e1$emissions))
# Ordering the data by 'country_code'
merge2018_e1 <- merge2018_e1[order(merge2018_e1$country_code),]
# Saving merged data to an Excel file
write.xlsx(merge2018_e1, "merge2018_e1.xlsx", rowNames = FALSE)
# Filtering rows where dummy variable is 1
Z_original_2018_M <- merge2018_e1[merge2018_e1$dummy == 1, ]
# Saving filtered data to an Excel file
write.xlsx(Z_original_2018_M, "Z_original_2018_M.xlsx", rowNames = FALSE)




# Find common country codes among all five DataFrames====
common_country_codes <- Reduce(intersect, list(Z_original_2000$country_code, Z_original_2005$country_code, Z_original_2010$country_code, Z_original_2015$country_code, Z_original_2018$country_code))
common_country_codes3 <- Reduce(intersect, list(Z_original_2000_M$country_code, Z_original_2005_M$country_code, Z_original_2010_M$country_code, Z_original_2015_M$country_code, Z_original_2018_M$country_code))


# Filter each DataFrame to include only the common country codes====

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2000") 
filtered_df1 <- Z_original_2000[Z_original_2000$country_code %in% common_country_codes, ]
write.xlsx(filtered_df1, "Z_original_2000_V2.xlsx", rowNames = FALSE)
countries_X_2000$is_in_list <- ifelse(countries_X_2000$country_code %in% common_country_codes, 1, 0)
write.xlsx(countries_X_2000, "countries2000.xlsx", rowNames = FALSE)


setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2005") 
filtered_df2 <- Z_original_2005[Z_original_2005$country_code %in% common_country_codes, ]
write.xlsx(filtered_df2, "Z_original_2005_V2.xlsx", rowNames = FALSE)
countries_X_2005$is_in_list <- ifelse(countries_X_2005$country_code %in% common_country_codes, 1, 0)
write.xlsx(countries_X_2005, "countries2005.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2010") 
filtered_df3 <- Z_original_2010[Z_original_2010$country_code %in% common_country_codes, ]
write.xlsx(filtered_df3, "Z_original_2010_V2.xlsx", rowNames = FALSE)
countries_X_2010$is_in_list <- ifelse(countries_X_2010$country_code %in% common_country_codes, 1, 0)
write.xlsx(countries_X_2010, "countries2010.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2015") 
filtered_df4 <- Z_original_2015[Z_original_2015$country_code %in% common_country_codes, ]
write.xlsx(filtered_df4, "Z_original_2015_V2.xlsx", rowNames = FALSE)
countries_X_2015$is_in_list <- ifelse(countries_X_2015$country_code %in% common_country_codes, 1, 0)
write.xlsx(countries_X_2015, "countries2015.xlsx", rowNames = FALSE)


setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2018") 
filtered_df5 <- Z_original_2018[Z_original_2018$country_code %in% common_country_codes, ]
write.xlsx(filtered_df5, "Z_original_2018_V2.xlsx", rowNames = FALSE)
countries_X_2018$is_in_list <- ifelse(countries_X_2018$country_code %in% common_country_codes, 1, 0)
write.xlsx(countries_X_2018, "countries2018.xlsx", rowNames = FALSE)


# Filter each DataFrame to include only the common country codes IMPORTS ====

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2000") 
filtered_df11 <- Z_original_2000_M[Z_original_2000_M$country_code %in% common_country_codes3, ]
write.xlsx(filtered_df11, "Z_original_2000_V2_M.xlsx", rowNames = FALSE)
countries_M_2000$is_in_list <- ifelse(countries_M_2000$country_code %in% common_country_codes3, 1, 0)
write.xlsx(countries_M_2000, "countries2000_M.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2005") 
filtered_df22 <- Z_original_2005_M[Z_original_2005_M$country_code %in% common_country_codes3, ]
write.xlsx(filtered_df22, "Z_original_2005_V2_M.xlsx", rowNames = FALSE)
countries_M_2005$is_in_list <- ifelse(countries_M_2005$country_code %in% common_country_codes3, 1, 0)
write.xlsx(countries_M_2005, "countries2005_M.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2010") 
filtered_df33 <- Z_original_2010_M[Z_original_2010_M$country_code %in% common_country_codes3, ]
write.xlsx(filtered_df33, "Z_original_2010_V2_M.xlsx", rowNames = FALSE)
countries_M_2010$is_in_list <- ifelse(countries_M_2010$country_code %in% common_country_codes3, 1, 0)
write.xlsx(countries_M_2010, "countries2010_M.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2015") 
filtered_df44 <- Z_original_2015_M[Z_original_2015_M$country_code %in% common_country_codes3, ]
write.xlsx(filtered_df44, "Z_original_2015_V2_M.xlsx", rowNames = FALSE)
countries_M_2015$is_in_list <- ifelse(countries_M_2015$country_code %in% common_country_codes3, 1, 0)
write.xlsx(countries_M_2015, "countries2015_M.xlsx", rowNames = FALSE)

setwd("/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/Chapter4/correspondence_analysis/2018") 
filtered_df55 <- Z_original_2018_M[Z_original_2018_M$country_code %in% common_country_codes3, ]
write.xlsx(filtered_df55, "Z_original_2018_V2_M.xlsx", rowNames = FALSE)
countries_M_2018$is_in_list <- ifelse(countries_M_2018$country_code %in% common_country_codes3, 1, 0)
write.xlsx(countries_M_2018, "countries2018_M.xlsx", rowNames = FALSE)
