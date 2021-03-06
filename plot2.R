# #What this script does:

# - downloads the data, extracts and loads it into R
# - we assume the filtering will be made after data is loaded.
# - one could filter it before loading in linux bash, as follows:
#         $ sed -n "1,5p" dados.txt > newData.txt
#         $ grep -e "^[12]/2/2007" originalData.txt >> newData.txt
# 
# Then
# - loads the entire data throught fread(), which is the fastest way
# - measures the time needed to load the data, just to show that fread its a beast!
# - calculates the size of the data, just for info
# - mutates the data to criate cols dataN and dia, which are the time in a proper format
# - selects the colums needed in the plots
# - filters the data for the desired daysz
# - plots the 2nd plot it to a png file


fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      
download.file(fileUrl, "data.zip", method = "curl")

unzip("data.zip")

arquivo <- "household_power_consumption.txt"

# - loads the entire data throught fread(), which is the fastest way
# - measures the time needed to load the data, just to show that fread its a beast!

library(data.table)
system.time(cdata <- fread(arquivo, na.strings = "?"))
 
# Read 2075259 rows and 9 (of 9) columns from 0.124 GB file in 00:00:03
# usuário   sistema decorrido 
# 2.672     0.044     2.714 

# Calculates the size of the data

format(object.size(cdata), units = "auto")
# [1] "142.7 Mb"


# mutates the data to criate cols dataN and dia, which are the time in a proper format
# the selects the colums needed in the plots
# then filters the data for the desired days

library(lubridate)
library(dplyr)

dados <- tbl_df(cdata)
rm(cdata)

#desired days:
lowlimit <- as.Date("2007-02-01")
uperlimit <- as.Date("2007-02-02")

# mutates + filter for desired days
dadosN <- dados %>% mutate(dataN = parse_date_time(Date, "dmY"), timeN = hms(Time), 
                           dia = dataN+timeN) %>%
        filter(dataN >= lowlimit & dataN <= uperlimit) %>%                        
        select(dataN, timeN, dia, 3:9)
                        


# gráfico 2
# plots the second plot, which is a line plot
# then saves it to a png file

with(dadosN, {
        plot(dia, Global_active_power, type="n", xlab = "", 
                ylab="Global Active Power (kilowatts)")
        lines(dia, Global_active_power)   
})

dev.copy(png, file="plot2.png")
dev.off()

