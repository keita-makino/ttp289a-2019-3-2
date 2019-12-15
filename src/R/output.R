output = function(model) {
  print(apollo_modelOutput(model))
  df = data.frame(
    model$estimate %>% round(3),
    model$se %>% round(3),
    (model$estimate / model$se) %>% round(3)
  )
  colnames(df) = c("est.", "se.", "t.")
  print(df)
  print(model$LLout)
}