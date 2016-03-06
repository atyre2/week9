Veg <- read.table("data/Vegetation2.txt", header=TRUE)

library(ggplot2)
# this part the same
q <- ggplot(Veg, aes(x=BARESOIL, y = R)) + 
  theme_classic() +
  labs(x = "Exposed Soil", y = "Species Richness") + 
  theme(axis.text.y = element_text(angle = 90, hjust = 0.5)) +
  scale_y_continuous(breaks = seq(6,18,2))
  
# 5.2a
  q + geom_point(shape=1)
  
# 5.2b
  q + geom_point(shape = 16)
ggsave("graphs/RbySoil.png")
  # reproducing figure 5.2c
  q + geom_point(aes(shape=factor(Transect))) + 
    scale_shape_manual(name = "Transect", values=1:8)
  ggsave("graphs/RbySoil.png")
# now 5.2d
  q + geom_point(aes(shape=Time>1974)) + 
    scale_shape_manual(name = "Period", values=c(1,16),
                       labels = c("Year<=1974","Year > 1974")) + 
    theme(legend.position = "bottom")
  ggsave("graphs/RbySoil.png")
  
# 5.4
  q + geom_point(aes(shape=Time>1974, color = Time>1974)) + 
    scale_shape_manual(name = "Period", values=c(15,16),
                       labels = c("Year<=1974","Year > 1974")) + 
    scale_color_manual(name = "Period", values=c(1,2),
                       labels = c("Year<=1974","Year > 1974")) 

  q + geom_point(aes(size=SprPrec/40))

  q + geom_path(mapping = aes(color=Time), 
                arrow = arrow(length=unit(0.1,"inches"),type="closed")) +
    geom_point(shape=16) + 
    facet_wrap(~Transect)
  
