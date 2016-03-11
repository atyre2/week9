## example plot from James Han

cornwater <- read.csv("data/CornWaterFinalResultsMerged.csv")

library(ggplot2)
# check for missing values
sum(is.na(cornwater$allTWsim))
sum(is.na(cornwater$totalSoilMoistureMeasure))
sum(is.na(cornwater$topPorosity))
sum(is.na(cornwater$porosity))
sum(!complete.cases(cornwater))
pick = complete.cases(cornwater)
# graph totalSoilMoistureMeasure vs. allTWsim
gg <- ggplot(cornwater[pick,], aes(x=allTWsim, y=totalSoilMoistureMeasure))
gg + geom_point(alpha = 0.1, mapping = aes(color=DOY)) + 
  facet_grid(topPorosity~year, labeller = "label_both") +
  geom_abline(slope = 1, intercept = 0, color="red", size=2, linetype = 2) + 
  labs(x = "Simulated soil moisture", y = "Observed Soil Moisture") + 
  geom_smooth(col="grey", method="loess")

