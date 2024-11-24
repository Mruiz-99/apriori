install.packages("randomForest")
library(randomForest)

data <- read.csv('D:\\MYNOR\\USAC\\MAESTRIA\\4TO SEMESTRE\\Introducción a la minería de datos\\db_csv_\\db_csv_\\MIGRACION_BDP.csv', sep=",")
data <- na.omit(data)



data$DEPARTAMENTO <- as.factor(data$DEPARTAMENTO)

set.seed(100)
data <- data[sample(1:nrow(data)), ]

index <- sample(1:nrow(data), 0.8 * nrow(data))
train <- data[index, ]
test <- data[-index, ]

bosque <- randomForest(DEPARTAMENTO ~ PEI3 + PEI4 + PEI5,
                       data = train,
                       ntree = 40,
                       mtry = 3)

entreno <- predict(bosque, test)

dato_nuevo <- data.frame(PEI3=1, PEI4=50, PEI5=2004)

prediccion <- predict(bosque,dato_nuevo)
prediccion
