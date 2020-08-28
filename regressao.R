library(ggplot2)
setwd("C:\\Users\\rafae\\Documents\\JAI 2020\\covid\\output")

regiao = 0

dataset <- read.csv(paste("sum_regiao_", regiao, ".txt", sep=""))

x <- dataset$semana
y <- dataset$novos_casos
z <- dataset$bandeira

#bandeira <- c(paste(z[0*7+1]), paste(z[1*7+1]), paste(z[2*7+1]), paste(z[3*7+1]), paste(z[4*7+1]), paste(z[5*7+1]), paste(z[6*7+1]), paste(z[7*7+1]), paste(z[8*7+1]), paste(z[9*7+1]), paste(z[10*7+1]), paste(z[11*7+1]), paste(z[12*7+1]), paste(z[13*7+1]), paste(z[14*7+1]), paste(z[15*7+1]))

modelo <- lm(x ~ y, data=dataset)

qplot(x,
      y,
      data = modelo,
      geom = c("point", "smooth"),
      xlab = "Semana",
      ylab = "Novos casos",
      main = paste("Casos de coronavírus (R", regiao, ")", sep="")) +
# Plota bandeira de cada semana
  geom_rect(aes(xmin = 0, xmax = 1, ymin = -20, ymax = -10, fill = paste(z[0*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 1, xmax = 2, ymin = -20, ymax = -10, fill = paste(z[1*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 2, xmax = 3, ymin = -20, ymax = -10, fill = paste(z[2*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 3, xmax = 4, ymin = -20, ymax = -10, fill = paste(z[3*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 4, xmax = 5, ymin = -20, ymax = -10, fill = paste(z[4*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 5, xmax = 6, ymin = -20, ymax = -10, fill = paste(z[5*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 6, xmax = 7, ymin = -20, ymax = -10, fill = paste(z[6*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 7, xmax = 8, ymin = -20, ymax = -10, fill = paste(z[7*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 8, xmax = 9, ymin = -20, ymax = -10, fill = paste(z[8*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 9, xmax = 10, ymin = -20, ymax = -10, fill = paste(z[9*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 10, xmax = 11, ymin = -20, ymax = -10, fill = paste(z[10*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 11, xmax = 12, ymin = -20, ymax = -10, fill = paste(z[11*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 12, xmax = 13, ymin = -20, ymax = -10, fill = paste(z[12*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 13, xmax = 14, ymin = -20, ymax = -10, fill = paste(z[13*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 14, xmax = 15, ymin = -20, ymax = -10, fill = paste(z[14*7+1])), alpha = .2) +
  geom_rect(aes(xmin = 15, xmax = 16, ymin = -20, ymax = -10, fill = paste(z[15*7+1])), alpha = .2) +
  #scale_fill_manual(values = alpha(c("yellow", "orange", "red", "black"), 0.2)) +
  scale_fill_manual(values = alpha(c("orange", "red", "black"), 0.2)) +
  #scale_fill_manual(values = alpha(c("yellow", "red"), 0.2)) +
  theme_bw()

ggsave(paste("plots\\Casos de coronavírus (R", regiao, ").png", sep=""),
       device = "png",
       width = 8,
       height = 5)
