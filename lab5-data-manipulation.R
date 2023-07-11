#imports
library(ggplot2)
library(scales)

install.packages(dplyr)
library(dplyr)

getwd()
Spotify_Youtube = read.csv("/Users/Cheryl/OneDrive/Desktop/Data2/Spotify_Youtube.csv")



#Statistics for the Top 10 songs of various spotify artists and their yt video.

View(Spotify_Youtube)


key = Spotify_Youtube$Key
energy = Spotify_Youtube$Energy
Artists = Spotify_Youtube$Artist
views = Spotify_Youtube$Views
Album.Type = Spotify_Youtube$Album_type
Duration = Spotify_Youtube$Duration_ms
likes = Spotify_Youtube$Likes
Streams = Spotify_Youtube$Stream
top_30 = Spotify_Youtube$Artist[order(Spotify_Youtube$Views)][0:30]


filter(Spotify_Youtube, Album.Type == "Album")










