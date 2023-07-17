?ifelse
case_when()
#saving plots

library(dplyr)


x <- 7
X <- c(1,3,5,7,9)
ifelse(x < 5, "small number", "big number")

head(iris)
mean(iris$Petal.Width)
iris_new <- iris

#add categorical column
iris_new < mutate(iris_new,
                  petal.size = ifelse(Petal.Width > 1, "big", "small"))


iris_new < mutate(iris_new,
                  petal_size = case_when(
                    Petal.Width < 1 ~ "small",
                    Petal.Width < 2 ~ "medium",
                    Petal.Width >= 2 ~ "big",
                    .default ~ "big")

                  

                  
library(ggplot2) 
pcas <- prcomp(iris_new, scale. = T)
summary(pcas)
pca_vals <- as.data.frame(pcas$x)

pca_vals$Species <- iris$Species

ggplot(pca_vals, aes(PC1, PC2, color = Species)) +
  geom_point()


