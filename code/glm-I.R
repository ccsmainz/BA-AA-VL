# VL Anwendungsorientierte Analyseverfahren, Institut für Publizistik, Uni Mainz
# 2023-04-04

## Pakete und Daten laden

library(tidyverse)
theme_set(theme_minimal())

autylewis04 <- haven::read_sav("data/AutyLewis2004.sav")
autylewis04

## Häufigkeiten und Prozentwerte in den beiden Gruppen

autylewis04 %>%
  group_by(pepsi_placement) %>%
  count(pepsi_chosen)

autylewis04 %>%
  group_by(pepsi_placement) %>%
  summarise(n = n(), m = mean(pepsi_chosen))

table(autylewis04$pepsi_placement, autylewis04$pepsi_chosen) |>
  chisq.test(correct = FALSE)

cor.test(autylewis04$pepsi_placement, autylewis04$pepsi_chosen)

t.test(pepsi_chosen ~ pepsi_placement, data = autylewis04, var.equal = TRUE)

aov(pepsi_chosen ~ pepsi_placement, data = autylewis04) |>
  summary()

lm(pepsi_chosen ~ pepsi_placement, data = autylewis04) |>
  summary()

