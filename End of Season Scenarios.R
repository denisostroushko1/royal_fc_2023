
library(tidyverse)

# missing / not-entered scores from MRSL website
# Iguana vs Galacticos on 6/19 -- assumed 3-0 win for Iguana's 
# MacPherson vs Beer Engines on 7/17 -- game on grass field, assumed 2-0 win for MacP
# MacPherson vs Knights on 7/26 - actual score was 4-2 

current_table <- 
  data.frame(
    team = c("Iguanas", "MacPherson", "Knights", "Loons"), 
    points = c(24,22,23,20), 
    games_played = c(11,11,11,11), 
    wins = c(8,7,7,6), 
    losses = c(3,3,2,3), 
    ties = c(0,1,2,2), 
    goals_for = c(20, 37, 37, 29), 
    goals_against = c(10, 18, 12, 27)
  ) %>% mutate(goal_differential = goals_for - goals_against) %>% 
  arrange(-points, -goals_for, -goal_differential)

current_table

remaining_games <- 
  data.frame(
    date = c(
      rep(c("7/31/23", "8/7/23", "8/14/23"), 4)
    ), 
    team_1 = c(
      rep("Knights", 3), 
      rep("MacPherson", 3), 
      rep("Iguanas", 3), 
      rep("Loons", 3)
    ), 
    team_2 = c(
      "Iguanas",	"Team Awesome",	"Dunesday", # Knights oppoennts 
      "Team Awesome", "Dunesday", "Loons", # MacPherson Oppoennts 
      "Knights", "ManChes","Beer Engines", # Iguanas opponents
      'Galacticos',	'Rovers', 	'MacPherson'
    )
    
  ) %>% 
   mutate(duplicate_games = paste(date, 
                             pmap_chr(list(team_1, team_2), ~ paste(sort(c(..1, ..2)), collapse = " ")))
   )
# Explanation by ChatGPT 3.5 :
# - pmap_chr is used to apply the paste function to each row of column1 and column2.
# - list(column1, column2) provides the two columns as input to the pmap function.
# - The ~ function creates an anonymous function that takes two arguments (..1 and ..2), representing values from column1 and column2.
# - Inside the anonymous function, we use sort() to sort the values alphabetically.
# - Then, we use paste() to combine the sorted values into a single string.
# - collapse = "" specifies that the sorted values should be concatenated without any separator.
# - The result is stored in a new column called 'new_column'.

remaining_games <- distinct(remaining_games, duplicate_games, .keep_all = TRUE)

remaining_games

