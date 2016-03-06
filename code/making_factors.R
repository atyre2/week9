isit <- read.table("data/isit.txt", header=TRUE, sep = "\t")
isit$Month <- NULL 
isit$Year <- NULL
with(isit,table(Station))

# create the variables, pick out subsets, set the values
isit$Month <- factor(NA,levels=c("Jan","Feb","Mar","Apr","May","Jun","Jul", "Aug", "Sep","Oct","Nov","Dec"))
isit$Year <- factor(NA, levels=2001:2002)

pick <- isit$Station %in% 1:5
isit[pick, "Month"] <- "Apr"
isit[pick, "Year"] <- "2001"

pick <- isit$Station %in% 6:11
isit[pick, "Month"] <- "Aug"
isit[pick, "Year"] <- "2001"

pick <- isit$Station %in% 12:15
isit[pick, "Month"] <- "Mar"
isit[pick, "Year"] <- "2002"

pick <- isit$Station %in% 16:19
isit[pick, "Month"] <- "Oct"
isit[pick, "Year"] <- "2002"

with(isit,table(Month,Year))
