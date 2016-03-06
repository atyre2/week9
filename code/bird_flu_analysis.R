library(plyr)
library(tidyr)
library(ggplot2)

## load the bird flu cases data
bFluCases <- read.table("data/BirdFluCases.txt", header = TRUE, sep = "\t")
names(bFluCases)[8] <- "Indonesia"

#l_ply(bFluCases, .fun = is.numeric, .print = TRUE)

# total number of bird flu cases by country
#countries = names(bFluCases)[-1]
#data.frame(countries, totalCases = laply(bFluCases[,-1], .fun = sum))

# Total number of cases per year
totalbFlu <- ddply(bFluCases, .variables = "Year", 
      .fun = function(eggs) {
        c(totalCases = sum(eggs[-1]))
      })

# make long dataframe
longbFluCases <- gather(bFluCases, Countries, Cases, -Year)

q <- ggplot(longbFluCases, aes(x = Year, y = Cases)) + 
  geom_line(aes(group = Countries, color = Countries), size=2) + 
  geom_line(data=totalbFlu, mapping = aes(x = Year, y = totalCases), linetype = 2) +
  theme_bw() + 
  theme(legend.position="bottom", legend.key = element_blank())

print(q)
## make figure 7.2 Zuur et al 2009
bFluDeaths <- read.table("data/BirdFluDeaths.txt", header=TRUE, sep="\t")
names(bFluDeaths)[8] <- "Indonesia"

# 7.2A is total cases by year
ggplot(longbFluCases, aes(x = factor(Year), y = Cases)) + 
  geom_bar(stat="identity") + 
  labs(x = "") + 
  theme_classic()


# 7.2B - D require deaths and cases together
longbFluDeaths <- gather(bFluDeaths, Countries, Deaths, -Year)
# simple, but requires *exact* match in order
bFlu <- cbind(longbFluCases,Deaths = longbFluDeaths[,3])

# need one more gather ... 
bFlu <- gather(bFlu, Type, Count, 3:4)

ggplot(bFlu, aes(x = Type, y = Count)) + 
  geom_bar(aes(fill=factor(Year), group=Countries),stat = "sum") + 
  labs(x = "") + 
  theme_classic() + 
  theme(legend.position = "none")

ggplot(bFlu, aes(x = factor(Year), y = Count)) + 
  geom_bar(aes(fill=Type, group=Countries), stat = "sum") + 
  labs(x = "") + 
  theme_classic() + 
  theme(legend.position = "none") + 
  scale_fill_manual(values=c("grey","lightgrey"))

ggplot(bFlu, aes(x = factor(Year), y = Count)) + 
  geom_bar(aes(fill=Type, group=Type), stat = "sum", position = "dodge") + 
  labs(x = "") + 
  theme_classic() + 
  theme(legend.position = "none") + 
  scale_fill_manual(values=c("grey","lightgrey"))
