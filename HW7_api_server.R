library(plumber2) 
library(randomForest) 

model <- readRDS("HW4_No_Show_Model.rds") 

#* Binary No Show Predictions 
#* @post /predict_class 
#* @parser rds 
#* @serializer rds 
function(req){ 
  body <- req$body
  df <- as.data.frame(body) 
  message(sprintf("Making binary predictions for %d rows of data", nrow(df))) 
  probs <- predict(model, newdata = df, type = 'prob')[,2] 
  pred <- as.integer(probs >= 0.5) 
  return(pred) 
} 

#* Probability No Show Predictions 
#* @post /predict_prob 
#* @parser rds 
#* @serializer rds 
function(req){ 
  body <- req$body
  df <- as.data.frame(body) 
  message(sprintf("Making probability predictions for %d rows of data", nrow(df))) 
  probs <- predict(model, newdata = df, type = 'prob')[,2] 
  return(probs) 
} 
