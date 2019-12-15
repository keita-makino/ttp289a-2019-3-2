setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("readr")
library("stats")
library("dplyr")
library("apollo")

data = read.csv("../data/data.csv")
femaleIndex = data$female == 1
maleIndex = data$female ==0


apollo_initialise()

source("./female.R")
bf = female(data[femaleIndex,] %>% .[, c(
  "id",
  "c3h17m" ,
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
  "c3h17m" ,
  "commtime",
  "jobhome",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])

source("./female2.R")
bf2 = female(data[femaleIndex,] %>% .[, c(
  "id",
  "c3h17m" ,
  "childlt6",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ])

source("./male2.R")
bm2 = male(data[maleIndex,] %>% .[, c(
  "id",
  "c3h17m" ,
  "commtime",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])

database = data[maleIndex,] %>% .[complete.cases(.), ]
femaleIndex = database$female == 1
maleIndex = database$female ==0

source("./female2.R")
bfm = female(database[maleIndex,] %>% .[, c(
  "id",
  "c3h17m" ,
  "childlt6",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ])
bfe = female(database[, c(
  "id",
  "c3h17m" ,
  "childlt6",
  "commtime",
  "efact9",
  "manconst",
  "jobconst",
  "age"
)] %>% .[complete.cases(.), ])


source("./male2.R")
bmf = male(database[femaleIndex,] %>% .[, c(
  "id",
  "c3h17m" ,
  "commtime",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])
bme = male(database[, c(
  "id",
  "c3h17m" ,
  "commtime",
  "manconst",
  "cso9ft2"
)] %>% .[complete.cases(.), ])
