ps1 = function(database) {
  apollo_beta = c(
    asc_tele_f = 0,
    asc_tele_m = 0,
    b_commtime = 0,
    b_efact9 = 0,
    b_manconst = 0,
    b_jobconst_f = 0,
    b_jobconst_m = 0,
    b_age_f = 0,
    b_age_m = 0,
    b_cso9ft2 = 0
  )
  
  apollo_fixed = c()
  
  apollo_control = list(modelName = "MNL",
                        modelDescr = "SimpleMNL",
                        indivID = "id")
  
  apollo_inputs = apollo_validateInputs(apollo_beta, apollo_fixed, database, apollo_control)
  
  model = apollo_estimate(apollo_beta,
                          apollo_fixed,
                          prob_ps1,
                          apollo_inputs)
  source("./output.R")
  output(model)
  
  return(model)
}


prob_ps1 = function(apollo_beta,
                        apollo_inputs,
                        functionality = "estimate") {
  apollo_attach(apollo_beta,
                apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  P = list()
  V = list()
  
  V[["tele"]] = asc_tele_f * gender_f +
    asc_tele_m * gender_m +
    b_commtime * commtime +
    b_efact9 * efact9 +
    b_manconst * manconst +
    b_jobconst_f * jobconst_f +
    b_jobconst_m * jobconst_m +
    b_age_f * age_f +
    b_age_m * age_m +
    b_cso9ft2 * cso9ft2
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