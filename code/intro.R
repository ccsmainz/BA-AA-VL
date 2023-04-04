# VL Anwendungsorientierte Analyseverfahren, Institut für Publizistik, Uni Mainz
# 2023-04-04

## Daten aus dem Internet laden 

library(tidyverse)
theme_set(theme_minimal())

## Beyoncé-Songs: Alles in einem Rutsch wie auf den Folien

read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/billboard.csv") %>%
  left_join(read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/audio_features.csv")) %>%
  mutate(year = as.numeric(str_sub(week_id, start = -4, end = -1))) %>%
  filter(performer == "Beyonce") %>%
  group_by(year) %>%
  summarise(mean_valence = mean(valence, na.rm = T)) %>%
  ggplot(aes(x = year, y = mean_valence)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Jahr", y = "Stimmung", title = "Stimmung von Beyoncés Singles im Zeitverlauf")

## Besser: in Einzelschritten

billboard100 <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/billboard.csv")
billboard100

audio <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/audio_features.csv")
audio

song_data <- billboard100 %>%
  left_join(audio) %>%
  mutate(year = as.numeric(str_sub(week_id, start = -4, end = -1)))

per_year <- song_data %>%
  filter(performer == "Beyonce") %>%
  group_by(year) %>%
  summarise(mean_valence = mean(valence, na.rm = T))
per_year

per_year %>%
  ggplot(aes(x = year, y = mean_valence)) +
  geom_point() + # Punktediagramm
  geom_smooth(method = "lm") + # Regressionsgerade
  labs(x = "Jahr", y = "Stimmung", title = "Stimmung von Beyoncés Singles im Zeitverlauf")

## BONUSAUFGABE:

