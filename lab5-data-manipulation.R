#imports
library(ggplot2)

install.packages("dplyr")
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
Channel = Spotify_Youtube$Channel
comments = Spotify_Youtube$Comments
Album = Spotify_Youtube$Album
top_30 = Spotify_Youtube$Artist[order(Spotify_Youtube$Views)][0:30]

#filters
filter(Spotify_Youtube, Album.Type == "single")

filter(Spotify_Youtube, Channel == "Gorillaz")

filter(Spotify_Youtube, Comments <= 10000 )

#select
select(Spotify_Youtube, Channel)

#mutate
Spotify_Youtubemute = select(Spotify_Youtube, Views, Likes)
Spotify_Youtubemute
mutate(Spotify_Youtubemute, 
       Views_m = Views/600)

mutate(Spotify_Youtubemute,
      mean_views = mean(views, na.rm = T))

#summarize
summarize(Spotify_Youtube,
          mean_views = mean(views, na.rm = T))

#arrange
arrange(Spotify_Youtube, Album.Type)





