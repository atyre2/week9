## expressions in labels
Whales <- read.table("data/TeethNitrogen.txt", header=TRUE)

library(ggplot2)

q <- ggplot(Whales,
       aes(x = Age, y = X15N)) + 
  geom_point() + 
  labs(y = expression(paste(delta^{15},"N"))) + 
  facet_wrap(~Tooth)

print(q)