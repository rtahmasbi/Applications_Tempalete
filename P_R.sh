
# rbind and cbind make the program very slow, try to allocate size at the begining



#################################################################
Rscript myscript.R arg1 arg2 arg3

args <- commandArgs(TRUE)
a <- as.numeric(args[1])




assign("not_conerged", T, envir = .GlobalEnv)

####################################################################################################
####################################################################################################
# download from specific repository
install.packages('mvtnorm', repos='http://cran.us.r-project.org')
install.packages('ggplot2', repos='http://cran.us.r-project.org')
install.packages('mixtools', repos='http://cran.us.r-project.org')
install.packages('gridExtra', repos='http://cran.us.r-project.org')
install.packages('nleqslv', repos='http://cran.us.r-project.org')
install.packages('glmnet', repos='http://cran.us.r-project.org')



####################################################################################################
####################################################################################################
# to add the installed libraries
.libPaths( c( .libPaths(), "/home/rata8212/R/x86_64-unknown-linux-gnu-library/3.2") )



####################################################################################################
####################################################################################################
# install data.table
https://github.com/Rdatatable/data.table/wiki/Installation

remove.packages("data.table")
install.packages("data.table", type = "source",
repos = "http://Rdatatable.github.io/data.table")


# test
DF = data.frame(A=1:3, B=c("foo","A,Name","baz"))
fwrite(DF)
write.csv(DF, row.names=FALSE, quote=FALSE)  # same

fwrite(DF,file="ab.txt")



####################################################################################################
####################################################################################################
# fread

library(data.table)
prm <- fread("gunzip -c out1.PRM_PO.grm.gz",header=F, sep="\t", colClasses=c("numeric","numeric","numeric","numeric"))

GRM_file <- data.frame(GRM_file)
fwrite(GRM_file, file=paste0(fname,".grm"), quote=F, row.names=F, col.names=F, sep="\t") # with data.table package

system(paste0("gzip -f ",fname_ret,".grm"))



####################################################################################################
####################################################################################################
# plots
abline(a = NULL, b = NULL, h = NULL, v = NULL, reg = NULL, coef = NULL, untf = FALSE, ...)



####################################################################################################
####################################################################################################
# doParallel
library(doParallel)
registerDoParallel(cores=20)
All.freqs  <-  foreach(i = 1:10,.combine='rbind') %dopar% {


    return(comm)

} #end dopar



####################################################################################################
####################################################################################################
# interaction
lm(y~x1*x2) # means y ~ x1 + x2 + x1:x2 (x1:x2 means interaction)
lm(y~x1:x2) # means y ~ x1:x2 (just interaction)



####################################################################################################
####################################################################################################
# random effect

# null model, grouping by school but not fixed effects.
Norm1 <- lmer(normexam ~ 1 + (1|school), data=Exam, REML = FALSE)
summary(Norm1)


mod.grp1 <- lmer(WBEING ~ HRS + LEAD + (1 | GRP), data = bh1996)
summary(mod.grp1)

# add a random effect of average number of hours worked (“HRS”) to the model and interpret your output. Test the significance of this random term.
mod.grp2 <- lmer(WBEING ~ HRS + LEAD + (1 + HRS | GRP), data = bh1996)
anova(mod.grp1, mod.grp2)


####################################################################################################
# attributes
attributes(ret)$names <- c("s2_A_hat","s2_E_hat")



####################################################################################################
pos = grep('pattern', x)  # grep is in array

# in a string
pos = regexpr('pattern', x) # Returns position of 1st match in a string
pos = gregexpr('pattern', x) # Returns positions of every match in a string


keep = substr(x, first, last)

sub('pattern', replacement, input) # Changes only the 1st pattern match per string
gsub('pattern', replacement, input) # Changes every occurrence of a pattern match
