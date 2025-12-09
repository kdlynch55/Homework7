library(httr)

api_local_server <- 'http://127.0.0.1:8080'

# Combination of real data
test_df <- data.frame(
  id = c(1,2,3,1),
  provider_id = c(1, 2, 3, 3),
  address     = c(2, 1, 2, 1),
  age         = c(57, 39, 70, 45),
  specialty   = c(1, 1, 1, 1),
  appt_time   = c('2023-01-07T15:15:00Z', '2023-01-07T14:15:00Z', '2023-04-07T15:15:00Z', '2023-04-07T16:00:00Z'),
  appt_made   = c('2022-11-19', '2022-10-23', '2023-02-11', '2023-02-03'),
  days_ahead  = c(43.5833333333333, 70.59375, 55.625, 63.6354166666667)
)

raw_df <- serialize(test_df, connection = NULL)
# Gets predicted probs 
probs <- POST(paste(api_local_server, 'predict_prob', sep = '/'), 
              body = raw_df, 
              encode = "raw",
              content_type('application/rds')) 

# Unserialized 
probs <- content(probs, "raw") |> unserialize() 
print('The predicted probabilities: ') 
print(probs) 

# Gets binary predictions 
binary <- POST(paste(api_local_server, 'predict_class', sep = '/'), 
               body = raw_df, 
               encode = "raw",
               content_type('application/rds')) 

# Unserialized 
binary <- content(binary, "raw") |> unserialize() 
print('The binary predictions: ') 
print(binary)
