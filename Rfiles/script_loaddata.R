

env <-read.table("data/Env.csv", sep = ",", header = TRUE) # site and time, plant scale
aph <-read.table("data/APH.csv", sep = ",", header = TRUE) # site and time, plant scale
data <- cbind(env, aph)