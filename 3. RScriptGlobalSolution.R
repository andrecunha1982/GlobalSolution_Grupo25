dados <- read.csv(
  file = "tarifas-homologadas-distribuidoras-energia-eletrica.csv",
  sep = ";",
  encoding = "latin1"
)
# Carregar bibliotecas
library(dplyr)
library(tidyr)
library(ggplot2)

# Carregar os dados
dados <- read.csv("tarifas-homologadas-distribuidoras-energia-eletrica.csv", sep = ";", encoding = "latin1")
> # Selecionar colunas relevantes
  > dados_limpos <- dados %>%
  +     select(SigAgente, DatInicioVigencia, DatFimVigencia, DscModalidadeTarifaria, 
               +            NomPostoTarifario, VlrTUSD, VlrTE) %>%
  +     mutate(
    +         # Converter datas para formato Date
      +         DatInicioVigencia = as.Date(DatInicioVigencia, format = "%Y-%m-%d"),
    +         DatFimVigencia = as.Date(DatFimVigencia, format = "%Y-%m-%d"),
    +         # Converter valores de tarifa para numérico
      +         VlrTUSD = as.numeric(gsub(",", ".", VlrTUSD)),
    +         VlrTE = as.numeric(gsub(",", ".", VlrTE))
    +     ) %>%
  +     # Filtrar dados válidos
  +     filter(!is.na(VlrTUSD) & !is.na(VlrTE) & VlrTUSD > 0 & VlrTE > 0)
> # Análise descritiva
  > summary(dados_limpos)

#Gráfico de barras para modalidade tarifária
ggplot(dados_limpos, aes(x = DscModalidadeTarifaria, fill = DscModalidadeTarifaria)) +
  geom_bar() +
  labs(title = "Quantidade de Registros por Modalidade Tarifária", x = "Modalidade Tarifária", y = "Contagem") +
  theme_minimal()

#Gráfico de dispersão (scatter plot)
ggplot(dados_limpos, aes(x = VlrTUSD, y = VlrTE, color = DscModalidadeTarifaria)) +
  geom_point() +
  labs(title = "Relação entre VlrTUSD e VlrTE", x = "Tarifa TUSD (R$)", y = "Tarifa TE (R$)") +
  theme_minimal()

#Histograma para horários de tarifa
ggplot(dados_limpos, aes(x = NomPostoTarifario, fill = NomPostoTarifario)) +
  geom_bar() +
  labs(title = "Distribuição por Posto Tarifário", x = "Posto Tarifário", y = "Frequência") +
  theme_minimal()

#Para os valores de medidas, dispersão e separatrizes
# Medidas de tendência central e dispersão
summary(dados_limpos$VlrTUSD)
summary(dados_limpos$VlrTE)

#Cálculo de dispersão
sd_tusd <- sd(dados_limpos$VlrTUSD, na.rm = TRUE)  # Desvio padrão
var_tusd <- var(dados_limpos$VlrTUSD, na.rm = TRUE)  # Variância

sd_te <- sd(dados_limpos$VlrTE, na.rm = TRUE)
var_te <- var(dados_limpos$VlrTE, na.rm = TRUE)

print(sd_tusd)
print(var_tusd)
print(sd_te)
print(var_te)
 
#Separatrizes (quartis)
quantile(dados_limpos$VlrTUSD, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)  # Quartis TUSD
quantile(dados_limpos$VlrTE, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)  # Quartis TE

#AED
#Buscar relações entre variáveis com grafico
cor_tusd_te <- cor(dados_limpos$VlrTUSD, dados_limpos$VlrTE, use = "complete.obs")
print(cor_tusd_te)
ggplot(dados_limpos, aes(x = VlrTUSD, y = VlrTE)) +
  geom_point(alpha = 0.7, color = "blue") +
  labs(
    title = "Correlação entre TUSD e TE",
    x = "Tarifa TUSD",
    y = "Tarifa TE"
  ) +
  theme_minimal()

#identificando valores fora do padrão
ggplot(dados_limpos, aes(x = "", y = VlrTUSD)) +
  geom_boxplot() +
  labs(title = "Detecção de Outliers na Tarifa TUSD", y = "Tarifa TUSD") +
  theme_minimal()

#Analise séries temporais
ggplot(dados_limpos, aes(x = DatInicioVigencia, y = VlrTUSD, color = SigAgente)) +
  geom_line() +
  labs(
    title = "Evolução das Tarifas TUSD ao Longo do Tempo",
    x = "Data de Início de Vigência",
    y = "Tarifa TUSD"
  ) +
  theme_minimal()
