# Hecho con gusto por Leislie Rocio Manjarrez Olmos (UAEH)

# T1_03_ESPACIO PRODUCTO(2) - RELACIONAMIENTO "CASO REAL": EXPORTACIONES HIDALGUENSES

# Objetivo: Estimar el relacionamiento (relatedness, proximidad, metrica de distancia entre productos)
# ------------------------------------------------------------------------------------------------------
# En este ejercicio vamos a:
# 1. Cargar nuestra matriz de datos
# 2. Calcular co ocurrencias entre lugares y productos 
# 3. Estimar el relacionamiento, teniendo como input las co-ocurrencias
# 4. Graficar
# 5. Exportar los resultados para trabajarlos con cytoscape o gephi

#######################################
# practica 2: exportaciones hidalguenses #
#######################################

# Primero llamar la libreria de EconGeo
library (EconGeo)

# Seleccionar el archivo desde la ruta del ordenador, utilizando el panel Data y el icono Import Dataset. Considerar el archivo como From Text (base). Seleccionar en Heading la opcion Yes en la pantalla que aparece y dar clic en Importar.
# Copiar la ruta que aparece en la consola una vez cargados los datos y pegar en read.csv ("RUTA"). Al correr el comando aparece la matriz en el panel Data
M = as.matrix(
  read.csv("C:/Users/leisl/OneDrive/Doctorado/Semestre-3/Temas-Selectos-1-Complejidad-Económica/Modulo2/Semana4-Labs-Salas/Lab-9/rca_2014.csv" , 
           sep = ",", 
           header = T, 
           row.names = 1))

# Para visualizar los primeros 10 datos de la matriz y que es una matriz de 83X429
head (M[,1:10])
dim (M)

# Ejecuta la co-ocurrencias en en este caso de los municipios (lugares)
co.occurrence (M)

# Para sacar la co-ocurrencia entre productos t debe ser transpuesta y crear un objeto denominado c
c = co.occurrence (t(M))

# estima el relacionamiento o proximidad pero normalizado, para asegurar que el numero de co ocurrencias que observamos
# es mayor al numero de co ocurrencias probables (probailidad condicional)
r = relatedness(c)

# Teniendo el numero de co-ocurrencia hay que transformar a matriz binaria con el comando siguiente
r[r<1] = 0
r[r>1] = 1

# Graficar en un primer momento aunque sera muy sucia
library (igraph)
g1 = graph_from_adjacency_matrix(r, mode = "undirected")
plot(g1)

# Exportar resultados del relacionamiento no binario
write.csv (r, file="relatedness.csv")
write.csv (c, file="cocurrences.csv")