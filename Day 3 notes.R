####Visualization/plots####
#we will be using packages to visualize charts
#data set packages like iris

#install the required packages
install.packages("ggplot2")
#now we have to load in the package to use it

#load required packages
library(ggplot2)
 ## gg in ggplots stands for grammer of graphics, its about the organization of graphics
##aesthetics tell us where the opbects would go, postioning gemetric data (circles, lines) are based on the data

#Grammar of Graphics
#geom are the geomertys of our data (circles and stuff)
#labels are "labs" for titles and things of that nature

# we do

#commas spearct peramets +'s sepreatre if you are declaring fuction calls

str(mpg)
ggplot(data = mpg, aes(x = hwy, y = cty)) + 
  geom_point() + 
  labs(x = "highway mpg",
       y = "city mpg",
       title = " car city vs highway milage")
#histogram####
#histogram example with iris dataset
# each bin is gonna hold the data thats within its boarders
#the smaller the bins the fatter the bars
# we can set the number of bars with bins
#we can set the size of the bars with "binwidth

head(iris)
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 35) +
  labs(x = "Sepal Length",
       y = "count",
       title = " Iris count vs Sepal Length ")


ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 0.25) +
  labs(x = "Sepal Length",
       y = "count",
       title = " Iris count vs Sepal Length ")

#Density plots####

ggplot(data = iris, aes(x = Sepal.Length, 
       y = after_stat(count))) +
  geom_density()

#boxplot####
#also called box and whisker plots
#deals with IQR anf outliers


ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_boxplot()

#if you want the aes of y to be the sepall length and make it horozontial

ggplot(data = iris, aes(y = Sepal.Length)) +
  geom_boxplot()

#or we can calucate multiplue at once

ggplot(data = iris, aes(x = Sepal.Length, y = Species)) +
  geom_boxplot()


#violin plot####
#can be used to compare across diffrent variables 
#they are specifically meant to compare things
#one has to be a cartagorical varible and one has to be a numeric variable
# the importance of violin plots are to reveal the distrabution of our data.
#SOmetimes we just want more visual represention which is why violin plots can be ideal

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin()

#to add a box plot which will show the mean, median and IQR use this

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin() + geom_boxplot(width = 0.2) +
  labs(title = "Distribution of Iris Sepal Lengths by Species", 
       x = "Species", 
       y = "Sepal Length")

#Adding color to our box plots####
#Single lines and dots will be colors
#if we want to fill in the violins we can use fill
#make sure the color goes inside the parenthesis of the geom

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(color = "pink", fill = "violet") + geom_boxplot(width = 0.2) +
  labs(title = "Distribution of Iris Sepal Lengths by Species", 
       x = "Species", 
       y = "Sepal Length")

#Bar Plot####
#we only get one numeric value per catagory
#stat summary is needed bc we are using summary statistics (meann, meadian, max etc)

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_bar(stat = "summary",
           fun = "mean")

#Scatter Plot ####
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_point()

#jitter will jitter the point ramdomly on the x-axis givin them a random x postion
# NOTE, EVERYTIME that you run jitter it will look a bit diffrent bc its randomized so just keep running until you get one that you like
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + 
  geom_jitter(width = 0.25)

#if you wanna save plots use can use ggsave to save the current plot
ggsave("plots/Exampleofjitterplot.png")


#Line plots####

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point()
  geom_line(stat = "summary",
           fun = "mean")
  #make the spread of data smooth
  
  ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
    geom_point() + 
    geom_smooth()

  #want the line but no smooth?
  
  ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
    geom_point()
  geom_smooth(se = F)


#How to add themes with scale color (use the website)####
#must add values and the values have to add to the same amount of plots that you have

  ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
    geom_point(aes(color = Species)) +
    scale_color_manual(values = c("violet", "lightpink", "red"))


#when R reads numbers, it thinks its all numeric data, so we use factorsa as another variable type

mpg$year < as.factor(mpg$year)
  
  #how to reorder the flower names
iris$Species <- factor(iris$Species, levels = c("versicolor", "setosa", "virginica"))

  
  
  
  
  
  
  
ggplot(data = Spotify_Youtube, aes(x = energy, y = key)) + 
  geom_histogram(fill = "blue", binwidth = 0.25) + theme_light() + 
  labs(x = "energy",
       y = "key",
       title = "Energy vs Key")
  
  
  
  #good
ggplot(data = Spotify_Youtube, aes(x = Album.Type, y = Duration)) + 
  geom_bar(stat = "summary",
           fun = "mean")
  
  
ggplot(data = Spotify_Youtube, aes(x = views, y = Artists )) +
  geom_histogram()




#plot that works
ggplot (data = Spotify_Youtube, aes(x = views, y = likes)) +
  geom_point(color = "purple") +
  theme_light() +
  scale_x_continuous(labels = label_number(scale = 1e-9, suffix = "b")) +
  scale_y_continuous(labels = label_number(scale = 1e-6, suffix = "m")) +
  labs(
    title = "Views v.s Likes",
    x = "Views",
    y = "Likes"
  ) 

#plot I want

ggplot (data = Spotify_Youtube, aes(x = views, y = likes)) +
  geom_point(aes(color = Artists[1:30, 2])) +
  scale_color_manual(values = c("violet", "lightpink", "red"))
theme_light() +
  scale_x_continuous(labels = label_number(scale = 1e-9, suffix = "b")) +
  scale_y_continuous(labels = label_number(scale = 1e-6, suffix = "m")) +
  labs(
    title = "Views v.s Likes",
    x = "Views",
    y = "Likes"
  ) 


