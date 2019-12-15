female = function(database) {
  apollo_beta = c(asc_tele = 0,
                  asc_nontele = 0,
                  b_childlt6 = 0,
                  b_commtime = 0,
                  b_efact9 = 0,
                  b_manconst = 0,
                  b_jobconst = 0,
                  b_age = 0)
  
  apollo_fixed = c("asc_nontele")
  
  apollo_control = list(modelName = "MNL",
                        modelDescr = "SimpleMNL",
                        indivID = "id")
  
  apollo_inputs = apollo_validateInputs(apollo_beta, apollo_fixed, database, apollo_control)
  
  model = apollo_estimate(apollo_beta,
                          apollo_fixed,
                          prob_female,
                          apollo_inputs)
  source("./output.R")
  output(model)
  
  return(model)
}


prob_female = function(apollo_beta,
                     apollo_inputs,
                     functionality = "estimate") {
  apollo_attach(apollo_beta,
                apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  P = list()
  V = list()
  
  V[["tele"]] = asc_tele + b_childlt6 * childlt6 +
    b_commtime * commtime + b_efact9 * efact9 + 
     b_manconst * manconst + 
    b_jobconst * jobconst + b_age * age
  V[["nontele"]] = asc_nontele
  
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