#this is an example R script to demonstrate the parts of RStudio

#load packages
  library(dplyr)
  library(tidyr)
  library(ggplot2)

#set the working directory
  setwd("C:\\Users\\LMcCoy\\Desktop\\TreeMapNew2017")


#create a set of ecosite folder names, this is where the files are located
  parks <- c("AZRU_A","BAND_P","GRCA_M","GRCA_P","MEVE_L","MEVE_S","WUPA_L")

#for each ecosite folder, get the directory contents using a loop
  for(i in parks){
    cartesian <- dir(paste0(i,"\\",i,"_CartesianShapefile"))
    gridtiept <- dir(paste0(i,"\\",i,"_GridTiePoint"))
    utm <- dir(paste0(i,"\\",i,"_UTMShapefile"))
    tif <- dir(paste0(i,"\\",i,"_TIF"))

#convert each to a dataframe
    cartesian <- base::data.frame(Folder = 'cartesian', FullFileName = cartesian)
    gridtiept <- base::data.frame(Folder = 'gridtiept', FullFileName = gridtiept)
    utm <- base::data.frame(Folder = 'utm', FullFileName = utm)
    tif <- base::data.frame(Folder = 'tif', FullFileName = tif)
    
#combine together
    if(i %in% parks[1]){
      data <- rbind(cartesian, gridtiept, utm)
      tifdata <- tif
    }else{
      data <- rbind(data, cartesian, gridtiept, utm) 
      tifdata <- rbind(tifdata, tif)

    }
  }

#separate from the file name and make collapse to distinct
    data <- data %>%
      mutate(Plot = substr(FullFileName, 1, 8)) %>%
      separate(FullFileName, into=c("FileName","Extension"), extra = "drop", sep="\\.") %>%
      mutate(Extension = tolower(Extension)) %>%
      distinct()
    
#check for duplicates
    dups <- data %>%
      select(Plot, Folder, Extension) %>%
      mutate(Sampled = "Y") %>%
      group_by(Plot, Folder, Extension) %>%
      summarize(Count = n()) %>%
      ungroup() %>%
      filter(Count != 1)

    dups
    
 #spread to wide and back to long to see that each extension type exists
    extensioncheck <- data %>%
      select(Plot, Folder, Extension) %>%
      mutate(Sampled = "Y") %>%
      spread(Extension, Sampled) %>%
      as.data.frame() %>%
      gather(Extension, Sampled, cpg:shx)
    
#report missing extension files - we can ignore missing .sbn and .sbx files
    extensioncheck %>%
    filter(is.na(Sampled))

#spread extensioncheck to wide to make sure each file type exists    
  filecheck <- extensioncheck %>%
    select(Plot, Folder) %>%
    distinct() %>%
    mutate(Sampled = "Y") %>%
    spread(Folder, Sampled) %>%
    as.data.frame()
  
#report missing file types
  filecheck %>%
    filter(is.na(cartesian) | is.na(gridtiept) | is.na(utm))

#create a plot of the number of tree plots in each EcoSite
  test <- filecheck %>%
    mutate(EcoSite = factor(substr(Plot, 1,6))) %>%
    group_by(EcoSite) %>%
    summarize(Count = n()) %>%
    ungroup()
  
  ggplot(test) +
    geom_bar(aes(x=EcoSite, y=Count), stat='identity', fill="slategray")
