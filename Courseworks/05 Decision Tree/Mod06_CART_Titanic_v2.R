#########################################################
##  Purpose: Create pretty classification tree
##  Developer: KD         
##
#########################################################

#########################################################
##  Step 0: Clear the environment
##           
##
#########################################################
rm(list=ls())


#########################################################
##  Step 1: Load the relavent packages
##           
##
#########################################################
installed.packages()

install.packages("rpart")  # CART standard package
?install.packages()

 install.packages("rpart",dependencies = TRUE)
 install.packages("rpart.plot",dependencies = TRUE)     # Enhanced tree plots
 install.packages("rattle",dependencies = TRUE)         # Fancy tree plot
 install.packages("RColorBrewer",dependencies = TRUE)   # colors needed for rattle
library(rpart)
library(rpart.plot)  			# Enhanced tree plots
library(rattle)           # Fancy tree plot
library(RColorBrewer)     # colors needed for rattle
  
#########################################################
 
##  Step 2:  example
##           
##
#########################################################
 

filename<-file.choose()
dsn<-  read.csv(filename )
View(dsn)
library(rpart)
#View(dsn) 
#attach(dsn)
#detach(dsn)

set.seed(222)
?ifelse


index<-sort(sample(nrow(dsn),round(.25*nrow(dsn))))
training<-dsn[-index,]
test<-dsn[index,]

?rpart()
#Grow the tree 
dev.off()

CART_class<-rpart( Survived~.,data=training)
rpart.plot(CART_class)
CART_predict2<-predict(CART_class,test, type="class") 
View(CART_predict2)
print(test[,4])
table(Actual=test[,4],CART=CART_predict2)



CART_predict<-predict(CART_class,test)
str(CART_predict)
View(CART_predict)
CART_predict_cat<-ifelse(CART_predict[,1]<=.5,'Yes','No')
View(CART_predict_cat)


table(Actual=test[,4],CART=CART_predict_cat)
CART_wrong<-sum(test[,4]!=CART_predict_cat)
CART_error_rate<-CART_wrong/length(test[,4])
CART_error_rate
CART_predict2<-predict(CART_class,test, type="class")
CART_wrong2<-sum(test[,4]!=CART_predict2)
CART_error_rate2<-CART_wrong2/length(test[,4])
CART_error_rate2 

library(rpart.plot)
?prp()
prp(CART_class)


# much fancier graph
fancyRpartPlot(CART_class)



