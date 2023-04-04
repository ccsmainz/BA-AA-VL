# VL Anwendungsorientierte Analyseverfahren, Institut für Publizistik, Uni Mainz
# 2023-04-04

set.seed(123)

library(tidyverse)
theme_set(theme_minimal())

## Alpha-Fehler

iq_population <- rnorm(n = 220000, mean = 100, sd = 15)
summary(iq_population)

sample_a <- sample(iq_population, size = 20)
summary(sample_a)

sample_b <- sample(iq_population, size = 20)
summary(sample_b)

t.test(sample_a, sample_b, var.equal = T)

p_vals <- replicate(n = 1000, {
  t.test(
    x = sample(iq_population, 20),
    y = sample(iq_population, 20),
    var.equal = T
  )$p.value
})

head(p_vals)

#| fig-cap: "Histogranm von 1000 p-Werten aus der Simulation"
qplot(p_vals)

sum(p_vals <= .05)

p_vals_1000 <- replicate(n = 1000, {
  t.test(
    x = sample(iq_population, 1000),
    y = sample(iq_population, 1000),
    var.equal = T
  )$p.value
})
qplot(p_vals_1000)

sum(p_vals_1000 <= .05)

## Beta-Fehler

iq_jgu <- rnorm(n = 31000, mean = 110, sd = 15)
summary(iq_jgu)

t.test(sample(iq_jgu, size = 20),
  sample(iq_population, size = 20),
  var.equal = T
)

p_vals2 <- replicate(n = 100, {
  t.test(
    x = sample(iq_jgu, 20),
    y = sample(iq_population, 20),
    var.equal = T
  )$p.value
})

p_vals2
qplot(p_vals2)

sum(p_vals2 > .05)

p_vals2 <- replicate(n = 100, {
  t.test(
    x = sample(iq_jgu, 300),
    y = sample(iq_population, 300),
    var.equal = T
  )$p.value
})

p_vals2
qplot(p_vals2)

sum(p_vals2 > .05)

