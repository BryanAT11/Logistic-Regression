setwd("C:\\Users\\Bryan Aurelius\\Downloads")
###################### Admit Example Starts####################################
# Read in the data from a comma-separated file
graddata <-read.csv("gradadmissions.csv")
# Display the first few rows of the data
head(graddata)

# First moodel is to relate admit decision to gre and gpa 
admitmodel <- admit ~ gre+gpa
# Use a generalized linear model in the binomial family
admitresult <- glm(admitmodel,family=binomial,data=graddata)
# Summarize the results
summary(admitresult)


# What if we treat school_rank as continuous?  
admitmodel <- admit ~ gre+gpa+school_rank
# Use a generalized linear model in the binomial family
admitresult <- glm(admitmodel,family=binomial,data=graddata)
# Summarize the results
summary(admitresult)

# Second moldel is to relate admit decision to gre, gpa and school rank
#convert school_rank to a factor to indicate that school_rank should be treated as a categorical variable
graddata$school_rank <- factor(graddata$school_rank)
admitmodel <- admit ~ gre+gpa+school_rank
# Use a generalized linear model in the binomial family
admitresult <- glm(admitmodel,family=binomial,data=graddata)
# Summarize the results
summary(admitresult)
###################### Admit Example Ends####################################


###################### Ingot Example Starts####################################
#Read the ingot data
ingotdata <- read.csv("ingots.csv")
head(ingotdata)
# Calculate the observed proportions
ingotdata$frac_not_ready <- ingotdata$Num_Not_ready/ingotdata$Num_Ingots

# First model is to relate fraction of ingots not ready to soak and heat
ingotmodel <- frac_not_ready ~ Soak+Heat
# Use a generalized linear model in the binomial family. 
# The maximum counts (a.k.a. weights) for each observation are given by Num_Ingots
ingotresult <- glm(ingotmodel,family=binomial,data=ingotdata,weights=Num_Ingots)
#Get the results
summary(ingotresult)
####################################

# To compare the actural and fitted value 
# plot actural value of frac_not_ready against heat 
plot(ingotdata$Heat,ingotdata$frac_not_ready,xlab = "Heat",
ylab = "Ingot_not_ready_faction", main="Actural (in black) vs Fitted (in red)")

# plot fitted value of frac_not_ready against heat
sampleheat <- seq(min(ingotdata$Heat),max(ingotdata$Heat),by=0.5)
ingotpre <- predict(ingotresult, type="response", list(Heat = sampleheat))
points(sampleheat, ingotpre ,col="red")
###################### Ingot Example Ends####################################

