femalem = function(database) {
  apollo_beta = c(
    asc_tele_m = 0,
    b_commtime_m = 0,
    b_efact9_m = 0,
    b_manconst_m = 0,
    b_jobconst_m = 0,
    b_age_m = 0
  )
  
  apollo_fixed = c()
  
  apollo_control = list(modelName = "MNL",
                        modelDescr = "SimpleMNL",
                        indivID = "id")
  
  apollo_inputs = apollo_validateInputs(apollo_beta, apollo_fixed, database, apollo_control)
  
  model = apollo_estimate(apollo_beta,
                          apollo_fixed,
                          prob_femalem,
                          apollo_inputs)
  source("./output.R")
  output(model)
  
  return(model)
}


prob_femalem = function(apollo_beta,
                        apollo_inputs,
                        functionality = "estimate") {
  apollo_attach(apollo_beta,
                apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  P = list()
  V = list()
  
  V[["tele"]] = 
    asc_tele_m * gender_m +
    b_commtime_m * commtime_m +
    b_efact9_m * efact9_m +
    b_manconst_m * manconst_m +
    b_jobconst_m * jobconst_m +
    b_age_m * age_m
  V[["nontele"]] = 0
  
  mnl_settings = list(
    alternatives = c(tele = 1, nontele = 0),
    avail = list(tele = 1, nontele = 1),
    choiceVar = c3h17m,
    V = V
  )
  
  P[["model"]] = apollo_mnl(mnl_settings, functionality)
  # P = apollo_panelProd(P, apollo_inputs, functionality)
  P = apollo_prepareProb(P, apollo_inputs, functionality)
  return(P)
}