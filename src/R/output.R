output = function(model) {
  print(apollo_modelOutput(model))
  print(model$estimate %>% round(3))
  print(model$se %>% round(3))
  print((model$estimate / model$se) %>% round(3))
  print(model$LLout)
}