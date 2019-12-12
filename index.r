setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("readr")
library("stats")
library("dplyr")
library("apollo")

database = read.csv("data.csv")

apollo_initialise()

source("./market.R")
market(database)

source("./base.R")
base(database %>% .[complete.cases(.), ])
market(database %>% .[complete.cases(.), ])

source("./reduced.R")
reduced(database %>% .[.$choice != 2, ] %>% .[complete.cases(.), ], "el", "auto")
reduced(database %>% .[.$choice != 4, ] %>% .[complete.cases(.), ], "train", "auto")
reduced(database %>% .[.$choice != 7, ] %>% .[complete.cases(.), ], "auto", "train")
