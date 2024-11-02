# Instalación e importación de paquetes necesarios
install.packages("arules")
install.packages("ggplot2")

library(arules)
library(ggplot2)

# Carga de datos
data <- read.csv('D:\\MYNOR\\USAC\\MAESTRIA\\4TO SEMESTRE\\Introducción a la minería de datos\\db_csv_\\db_csv_\\MIGRACION_BDP.csv', sep=",")

# Generación de reglas de asociación
reglas <- apriori(data, parameter = list(support = 0.2, confidence = 0.5))

# Inspección de un subconjunto de las reglas generadas
inspect(reglas[300:400])
inspect(reglas[1500:1600])

# Selección de columnas numéricas para el clustering
data_numeric <- data[, sapply(data, is.numeric)]

# Manejo de valores NA de manera eficiente (columna por columna)
for (col in colnames(data_numeric)) {
  if (any(is.na(data_numeric[[col]]))) {
    data_numeric[[col]][is.na(data_numeric[[col]])] <- mean(data_numeric[[col]], na.rm = TRUE)
  }
}

# Selección de columnas relevantes para reducir el tamaño de los datos
# Cambia estos nombres por los de tus columnas numéricas más relevantes si es necesario
selected_columns <- c("Long", "Lat", "PCP28", "PCP29")
data_reduced <- data_numeric[, selected_columns]

# Escala los datos seleccionados para mejorar la precisión del KMeans
data_reduced_scaled <- scale(data_reduced)

# Definición del número de clústeres
k <- 4

# Aplicación de KMeans usando los datos escalados y seleccionados
set.seed(123) # Para reproducibilidad
kmeans_result <- kmeans(data_reduced_scaled, centers = k)

# Asegurarse de que `data_reduced` tiene el mismo número de filas que `kmeans_result$cluster`
# Crear un vector de clústeres para el conjunto original, inicializado en NA
data$cluster <- NA  # Inicializa la columna cluster con NA para todos

# Asignar los clústeres solo a las filas utilizadas en `data_reduced`
data$cluster[1:nrow(data_reduced)] <- kmeans_result$cluster

# Convertir la columna `cluster` a factor para asegurar su reconocimiento en ggplot
data$cluster <- as.factor(data$cluster)

# Filtrar los datos para eliminar filas con valores NA en Long, Lat o cluster
data_filtered <- data[!is.na(data$Long) & !is.na(data$Lat) & !is.na(data$cluster), ]

# Visualización de los clústeres
ggplot(data_filtered, aes(x = Long, y = Lat, color = cluster)) + 
  geom_point() + 
  labs(color = "Cluster") +
  theme_minimal() +
  ggtitle("Clustering de datos de migración")
