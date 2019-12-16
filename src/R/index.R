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
source("./market.R")
fb = female(data[femaleIndex,] %>% .[, c(
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
fbm = market(data[femaleIndex,] %>% .[, c(
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
mb = male(data[maleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "commtime",
  "jobhome",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])
mbm = market(data[maleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "commtime",
  "jobhome",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])

source("./femalep.R")
fb2 = femalep(data[femaleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ])
fb2m = market(data[femaleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ])

source("./malep.R")
mb2 = malep(data[maleIndex,] %>% .[, c(
  "id",
  "c3h17m",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])
mb2m = market(data[maleIndex,] %>% .[, c(
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
fm = femalem(databasef[databasef$gender == 0,])
source("./femalep.R")
fp = femalep(databasef)
source("./females.R")
fs = females(databasef)
source("./markets.R")
fsm = markets(databasef)

indexm = data[, c(
  "id",
  "c3h17m",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ] %>% .$id
databasem = data[indexm,]

source("./malef.R")
fm = malef(databasem[databasem$gender == 1,])
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

