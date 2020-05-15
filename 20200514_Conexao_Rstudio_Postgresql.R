# SCRIPT R PARA CONEXAO EM BANCO DE DADOS POSTGRESQL


#   NAO UTILIZADOS 
# install.packag"RPostgreSQL")
# install.packages("RPostgres")



# package para conexao com banco de dados utilizando ODBC
#install.packages("DBI")


# CONSULTA UMA TABELA INTEIRA E COLOCA OS VALORES NUM DATAFRAME
library(DBI)
con <- dbConnect(odbc::odbc(), "PostgreSQL35W", timeout = 10)
con
df <- dbReadTable(con,"Test2")

print(df)


################################################################

## Carregando o dataset iris para realizar uma carga do banco de dados postgresql

# loading
data("iris")

# imprime as 10 primeiras linhas 
head(iris,10)


# cria uma datafame 
dfiris = as.data.frame(iris)

# analise dos valores centrais
summary(dfiris)


# a bomba do postgresql tem limitacao na nomeacao das colunas, nao aceita letra maiuscula e pontos
# dessa forma termos que criar uma function para tirar 

dbSafeNames = function(names) {
  names = gsub('[^a-z0-9]+','_',tolower(names))
  names = make.names(names, unique=TRUE, allow_=TRUE)
  names = gsub('.','_',names, fixed=TRUE)
  names
  }

# nomeia as colunas do datafram
colnames(dfiris) = dbSafeNames(colnames(dfiris))

# # analise dos valores centrais
summary(dfiris)


# efetua a escrota mp bamcp de dadps Postgresql atraves da conexao ODBC ,com configuracao para 
# o banco de dados EDS
dbWriteTable(con, "iris", dfiris)




