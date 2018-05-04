

ggplot(the.data, aes(year, value ) ) +
geom_point(aes(colour = source )) +
geom_smooth(aes(group = 1 )) +
geom_hline(yintercept = 50) +
annotate("text", min(the.data$year), 50, vjust = -1, label = "Cutoff")

ggtitle("Plot of length \n by dose")
theme(plot.title = element_text(hjust=0.5))  ## Centering title

annotate("text", x = 4, y = 25, label = "Some text")
geom_text(aes(x=4, y=.4, label="correct color", color="#FFFF00"))

ylab(label)


ggtitle(label)


#################################
#XXX: save to pdf
ggsave("myplot.pdf")
# or
pdf("myplot.pdf")
print(myplot)
dev.off()



###################
# multiple subplots
library(gridExtra)
grid.arrange(p1, p2, nrow = 1)
