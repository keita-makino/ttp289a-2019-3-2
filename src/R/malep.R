malep = function(database) {
  apollo_beta = c(asc_tele = 0,
                  b_manconst = 0,
                  b_cso9ft2 = 0)
  
  apollo_fixed = c()
  
  apollo_control = list(modelName = "MNL",
                        modelDescr = "SimpleMNL",
                        indivID = "id")
  
  apollo_inputs = apollo_validateInputs(apollo_beta, apollo_fixed, database, apollo_control)
  
  model = apollo_estimate(apollo_beta,
                          apollo_fixed,
                          prob_malep,
                          apollo_inputs)
  source("./output.R")
  output(model)
  
  return(model)
}


prob_malep = function(apollo_beta,
                     apollo_inputs,
                     functionality = "estimate") {
  apollo_attach(apollo_beta,
                apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  P = list()
  V = list()
  
  V[["tele"]] = asc_tele + 
    b_cso9ft2 * cso9ft2 + 
    b_manconst * manconst
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