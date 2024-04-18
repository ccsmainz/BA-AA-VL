library(styler)
library(quarto)
library(tidyverse)

NAME = "BA-AA-VL"

list.files(".", ".qmd") |>
  walk(style_file)

list.files(".", ".qmd") |>
  discard(str_detect, pattern = "literatur.qmd|glossar.qmd|daten.qmd|index.qmd|ifpstats|SFConflict") |>
  walk(~ knitr::purl(
    input = .x, documentation = 2,
    output = str_c("code/", str_replace_all(.x, ".qmd", ".R"))
  ))


prepend <- function(x) {
  txt1 <- "# VL Anwendungsorientierte Analyseverfahren, Institut für Publizistik, Uni Mainz"
  tstamp <- strftime(Sys.time(), "# %Y-%m-%d")
  read_file(x) |>
    # str_remove_all("#' ") |>
    str_replace_all("#' ## ", "## ") |>
    str_remove_all("#'.*") |>
    str_remove_all("## --.*") |>
    str_remove_all("## Glossar|## Hausaufgabe|## Folien") %>%
    paste0(txt1, "\n", tstamp, "\n", .) |>
    str_replace_all("(\n){2,}", "\n\n") |>
    write_file(file = x)
}


list.files("code", "*.R", full.names = T) |>
  walk(prepend)

dir.create(NAME)
list.files("code", "*.R", full.names = T) |>
  walk(file.copy, to = NAME)
file.copy("data", NAME, recursive = T)
file.copy("BA-AA-VL.Rproj", NAME)
zip::zip("ba-aa-vl.zip", NAME)
unlink(NAME, recursive = T)
