#Hishgad plotting
library(tidyverse)
library(scales)


data <- as.tibble(read.csv("data.csv"))

data <- as_tibble(data)

data <- data %>% 
  select(!X.1)
getwd()

data




# Lets plot 
data
data %>% 
  filter(name=="חג שמח" & X == 1 | name == "מזל טוב" & X == 1)

mazal_data <- data %>% 
  filter(name =="חג שמח" | name =="מזל טוב")

#plotting two tickets of 100% 
ggplot(mazal_data,aes(x=chance,y=name, color=prize)) +
  geom_point(colour = "#64b004", size= 3) +
  scale_x_continuous(labels = percent_format()) +
  labs(title = "The chance to win a certain amount from each ticket", x = "Chance", y = "Ticket name")

# showing the -10 net win
mazal_data %>% 
  filter(X == 1) %>% 
  select(prize,price,net_win,chance,name)
  
#
highest_chance<- data %>% 
  filter(X==1)

highest_chance %>% 
  select(prize,price,net_win,chance,name)

ggplot(highest_chance, aes(x= net_win)) + geom_histogram() #plotting net win highest chance

# plotting without net wins = 0
no_lose<- data %>% 
  filter(net_win > 0)

ggplot(no_lose,aes(x=chance)) +
  geom_histogram(binwidth = 0.002) +
  ggtitle("The chance we end up with a positive return")

no_lose_mean <-  no_lose %>% 
  group_by(name) %>% 
  summarise(mean = mean(chance)) %>% 
   arrange(desc(mean))
   
no_lose_mean
ggplot(no_lose_mean,aes(x=mean)) +
  geom_histogram(binwidth = 0.0005) +
  ggtitle("The mean chance we end up with a positive return")
data

data %>% 
  group_by(name) %>% 
  filter(net_win > 0) %>% 
  aggregate(name max(chance))
 ?aggregate
