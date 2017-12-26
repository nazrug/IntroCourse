#this is an example R script to demonstrate the parts of RStudio

#install a few packages - this installs the packages on your system but does not load them
  install.packages('dplyr')
  install.packages('tidyr')
  install.packages('ggplot2')
  install.packages('DT')

#load a few packages   
  library(dplyr) #a package for working with data
  library(tidyr) #a package for transforming data
  library(ggplot2) #a package for making plots
  library(DT) #a package that creates cool tables
  
#R has a bunch of preloaded datasets to work with, see what datasets are available in R
  data()

#assign one of the datasets to the variable 'mw'
  mw <- midwest

#subset one of the columns
  mw1 <- mw$poppovertyknown

#check help for function "separate()"
  ?separate
  
#create a plot of area by county for Illinois where the white population is greater than 95%
  ggplot(mw[mw$state %in% 'IL' & mw$percwhite > 95,]) +
    geom_bar(aes(x=county[mw$state %in% 'IL' & mw$percwhite > 95], y=area[mw$state %in% 'IL' & mw$percwhite > 95]), stat='identity', fill="slategray") + #create barplot
    labs(x="County", y="Size") + #change labels
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) #rotate the xaxis labels

 
#create a table of the data
  datatable(mw[mw$state %in% 'IL' & mw$percwhite > 95,], filter="top", options = list(pageLength = 15), rownames=FALSE)
   