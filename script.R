raw_heart<-read.csv("Heart.csv")

library(tidyverse)
library(randomForest)
heart_clean<-select(raw_heart,-X)
heart_clean<-drop_na(heart_clean)
write.csv(heart_clean,"Clean_data/heart.clean.csv")
### slipt cohort in 2

train<-sample(1:nrow(heart_clean), nrow(heart_clean) * 0.7)
test<-train
fit<-randomForest(AHD ~.,data=heart_clean,subset=train,
                  importance=TRUE,keep.forest=TRUE,
                  xtest=heart_clean[test,-ncol(heart_clean)],
                  ytest=heart_clean[test,"AHD"])
saveRDS(fit,"results/random_forest_fit.rds")

dim(heart_clean)
p
print(fit)
