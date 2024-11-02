install.packages("arules")
library(arules)

data <- read.csv('D:\\MYNOR\\USAC\\MAESTRIA\\4TO SEMESTRE\\Introducción a la minería de datos\\db_csv_\\db_csv_\\MIGRACION_BDP.csv',sep=",")


data

reglas <- apriori(data, parameter = list(support=0.2, confidence=0.5))

inspect(reglas[300:400])

inspect(reglas[1500:1600])


