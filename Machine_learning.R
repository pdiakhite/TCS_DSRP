##Unsupervised Learning####
## Principal Components Analysis
head(iris)

## remove any non-numeric variables

iris_num <- select(iris, -Species)

# do PCA
pcas <- prcomp(iris_num, scale. = T)

summary(pcas)
pcas$rotation

pca_vals <- as.data.frame(pcas$x)
pca_vals$Speceis <- iris$Species

#the reason why we added color is to see the catagorical distrabution between the characters. I could do this with album type and stream
ggplot(pca_vals, aes(PC1, PC2, color = Speceis)) +
  geom_point() +
  theme_minimal()










