install.packages("arules")
library(arules)

data <- read.csv('D:\\MYNOR\\USAC\\MAESTRIA\\4TO SEMESTRE\\Introducción a la minería de datos\\db_csv_\\db_csv_\\PERSONA_BDP.csv',sep=",")


data
data <- data[,-14]

data2 <- subset(data, DEPARTAMENTO==1)
data2 <- data2[,-1]
data2 <- data2[,-86]
data2 <- data2[,-85]
data2 <- data2[,-73]

data2 <- data2[,-76]

data3 <- subset(data2, COD_MUNICIPIO==1)

data3 <- data3[,-1]
data3 <- data3[,-7]
data3 <- data3[,-64]
reglas <- apriori(data3, parameter = list(support=0.2, confidence=0.5))

inspect(reglas[700:800])


