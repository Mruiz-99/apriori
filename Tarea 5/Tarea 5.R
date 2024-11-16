install.packages("rpart")
install.packages("rpart.plot")

library(rpart)
library(rpart.plot)

data <- read.csv('D:\\MYNOR\\USAC\\MAESTRIA\\4TO SEMESTRE\\Introducción a la minería de datos\\db_csv_\\db_csv_\\VIVIENDA_BDP.csv', sep=",")
vivienda <- data
arbol <- rpart(DEPARTAMENTO ~
                 PCV1+
                 PCV2+
                 PCV3+
                 PCV4+
                 PCV5,
               data = vivienda, method = "class")


rpart.plot(arbol, type=2,extra=0,under=TRUE, fallen.leaves = TRUE, box.palette = "BuGn",
           main = "Prediccion de area",cex = 0.45)

casa <- data.frame(
  PCV1=c(1),
  PCV2=c(2),
  PCV3=c(5),
  PCV4=c(1),
  PCV5=c(8)
)

result <- predict(arbol,casa, type="class")

result
