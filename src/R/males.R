males = function(database) {
  apollo_beta = c(
    asc_tele_f = 0,
    asc_tele_m = 0,
    b_manconst_f = 0,
    b_manconst_m = 0,
    b_cso9ft2_f = 0,
    b_cso9ft2_m = 0
  )
  
  apollo_fixed = c()
  
  apollo_control = list(modelName = "MNL",
                        modelDescr = "SimpleMNL",
                        indivID = "id")
  
  apollo_inputs = apollo_validateInputs(apollo_beta, apollo_fixed, database, apollo_control)
  
  model = apollo_estimate(apollo_beta,
                          apollo_fixed,
                          prob_males,
                          apollo_inputs)
  source("./output.R")
  output(model)
  
  return(model)
}


prob_males = function(apollo_beta,
                        apollo_inputs,
                        functionality = "estimate") {
  apollo_attach(apollo_beta,
                apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  P = list()
  V = list()
  
  V[["tele"]] = asc_tele_f * gender_f +
    asc_tele_m * gender_m +
    b_manconst_f * manconst_f +
    b_manconst_m * manconst_m +
    b_cso9ft2_f * cso9ft2_f +
    b_cso9ft2_m * cso9ft2_m
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