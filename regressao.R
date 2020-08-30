library(ggplot2)
#setwd("absolute path to output folder")

# Regiao para analise
regiao <- 0

# Carrega dataset, atribui variaveis x e y
dataset <- read.csv(paste("sum_regiao_", regiao, ".txt", sep = ""))

x <- dataset$semana
y <- dataset$novos_casos

# Separa infos para plot de bandeiras
n <- length(dataset$semana)
xmin <- dataset$semana[1:n]
xmax <- c(dataset$semana[2:n], dataset$semana[n]) # Força ter n elementos
ymin <- rep(min(y), n)
ymax <- rep(max(y), n)
Risco <- bandeira[1:n]

# Obtem as bandeiras das semanas
bandeira <- dataset$bandeira[seq(1, length(dataset$bandeira), 7)]

bandeira <- dataset$bandeira
bandeira <- replace(bandeira, bandeira == 0, "Baixo")
bandeira <- replace(bandeira, bandeira == 1, "Médio")
bandeira <- replace(bandeira, bandeira == 2, "Alto")
bandeira <- replace(bandeira, bandeira == 3, "Altíssimo")

# Ajusta cores para plot das bandeiras
cores <- c()
if ("Altíssimo" %in% Risco) {
  cores <- c(cores, "black")
}
if ("Alto" %in% Risco) {
  cores <- c(cores, "red")
}
if ("Baixo" %in% Risco) {
  cores <- c(cores, "yellow")
}
if ("Médio" %in% Risco) {
  cores <- c(cores, "orange")
}

# Cria o modelo de regressao
modelo <- lm(x ~ y, data = dataset)

# Plota
ggplot() +
  # Background: cor das bandeiras
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = Risco), alpha = .75) +
  scale_fill_manual(values = cores) +
  # Modelo
  geom_point(data = modelo, aes(x = dataset$semana, y = dataset$novos_casos), colour = "black") + 
  geom_smooth(data = modelo, aes(x = dataset$semana, y = dataset$novos_casos), fill = "darkblue", colour = "darkblue", size=1.2) +
  # Labels
  xlab("Semana") + ylab("Novos casos") + ggtitle(paste("Casos de coronavírus (R", regiao, ")", sep = ""))

# Salva imagem
ggsave(paste("plots\\Casos de coronavírus (R", regiao, ").png", sep = ""),
       device = "png",
       width = 8,
       height = 5)

print(paste("Gráfico de R", regiao, " salvo.", sep = ""))
