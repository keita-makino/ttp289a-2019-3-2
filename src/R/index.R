setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("readr")
library("stats")
library("dplyr")
library("apollo")

data = read.csv("../data/data.csv")
femaleIndex = data$gender == 1
maleIndex = data$gender ==0

apollo_initialise()

source("./female.R")
bf = female(data[femaleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "childlt6",
  "commtime",
  "efact9",
  "jobhome",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ])

source("./male.R")
bm = male(data[maleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "commtime",
  "jobhome",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])

source("./femalep.R")
bf2 = femalep(data[femaleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ])

source("./malep.R")
bm2 = malep(data[maleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])

indexf = data[, c(
  "id",
  "c3h17m",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ] %>% .$id
databasef = data[indexf,]

source("./femalem.R")
fm = femalem(databasef)
source("./femalep.R")
fp = femalep(databasef)
source("./females.R")
fs = females(databasef)

indexm = data[, c(
  "id",
  "c3h17m",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ] %>% .$id
databasem = data[indexm,]

source("./malef.R")
mf = malef(databasem)
source("./malep.R")
mp = malep(databasem)
source("./males.R")
ms = males(databasem)

indexp = data[, c(
  "id",
  "c3h17m",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "cso9ft2",
  "age"
)] %>% .[complete.cases(.), ] %>% .$id
databasep = data[indexp,]

source("./ps1.R")
ps1 = ps1(databasep)
source("./ps2.R")
ps2 = ps2(databasep)

