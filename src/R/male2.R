male = function(database) {
  apollo_beta = c(asc_tele = 0,
                  asc_nontele = 0,
                  b_commtime = 0,
                  b_manconst = 0,
                  b_cso9ft2 = 0)
  
  apollo_fixed = c("asc_nontele")
  
  apollo_control = list(modelName = "MNL",
                        modelDescr = "SimpleMNL",
                        indivID = "id")
  
  apollo_inputs = apollo_validateInputs(apollo_beta, apollo_fixed, database, apollo_control)
  
  model = apollo_estimate(apollo_beta,
                          apollo_fixed,
                          prob_male,
                          apollo_inputs)
  source("./output.R")
  output(model)
  
  return(model)
}


prob_male = function(apollo_beta,
                     apollo_inputs,
                     functionality = "estimate") {
  apollo_attach(apollo_beta,
                apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  P = list()
  V = list()
  
  V[["tele"]] = asc_tele + 
    b_commtime * commtime + b_cso9ft2 * cso9ft2 + 
    b_manconst * manconst
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