###########################################################################
###########################################################################
###                                                                     ###
###                    ANIMATION PLOT WITH GGANIMATE                    ###
###                                                                     ###
###########################################################################
###########################################################################

##----------------------------------------------------------------
##  Load the library                                            --
##----------------------------------------------------------------
library(tidyverse)    # data wrangling    
library(gganimate)    # data visualization
library(ggthemes)     # set plot theme
library(gapminder)    # the dataset

##---------------------------------------------------------------
##  EDA                                                        --
##---------------------------------------------------------------
data <- gapminder
glimpse(data)

##---------------------------------------------------------------
##  Creating basic static plot                                 --
##---------------------------------------------------------------
# Make a ggplot, but add frame=year: one image per year
graph1 <- gapminder %>% 
  # plot the data with scatterplots
  ggplot(aes(gdpPercap, lifeExp, size = pop, color = continent)) +
  geom_point() +
  # axis transformations 
  scale_x_log10() +
  theme_bw()
graph1

##---------------------------------------------------------------
##  Transition through distinct states in time                 --
##---------------------------------------------------------------
graph1_animation = graph1 +
  transition_time(year) +
  labs(subtitle = "Year: {frame_time}")
graph1_animation

##----------------------------------------------------------------
##  Display preceding frames with a gradual decrease in size    --
##----------------------------------------------------------------
graph1_animation <- graph1 +
  transition_time(year) +
  labs(subtitle = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1, alpha = FALSE)
graph1_animation

##---------------------------------------------------------------
##  Make the label more visible                                --
##---------------------------------------------------------------
graph1_animation_2 <- graph1 +
  geom_text(aes(x = min(gdpPercap), y = min(lifeExp), label = as.factor(year)) , 
            hjust=-1.5, vjust = -0.2, alpha = 0.2,  col = "gray", size = 20) +
  transition_states(as.factor(year), state_length = 0)
#display the graph
graph1_animation_2