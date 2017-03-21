#README

# Exploratory Data Analisys - week 1 Project

# What this script does:

- downloads the data, extracts and loads it into R
- we assume the filtering will be made after data is loaded.
- one could filter it before loading in linux bash, as follows:

        $ sed -n "1,2p" originalData.txt > newData.txt # this keeps the first 2 lines, for keeping the colnames
        $ grep -e "^[12]/2/2007" originalData.txt >> newData.txt 


Then

- loads the entire data throught fread(), which is the fastest way
- measures the time needed to load the data, just to show that fread its a beast!
- calculates the size of the data, just for info
- mutates the data to criate cols dataN and dia, which are the time in a proper format
- selects the colums needed in the plots
- filters the data for the desired daysz
- plots the throught the first to the fourth plot, while saving each one to a png file
