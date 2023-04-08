#web scraping project of "חישגד"
library("dplyr")
library("rvest")
library("readr")
library("stringr")
## url scraped: https://www.pais.co.il/hishgad/cards.aspx?cardId=



agrala <- function(x ,data,link, name, Nof.tickets, price, winning.tickets, page) {
  link = "https://www.pais.co.il/hishgad/cards.aspx?cardId="
  link <- paste(link,x,sep="")
  saver <- ".csv"
  page = read_html(link)
  name = page %>% html_nodes(".cat_tlist_itle") %>% html_text()
  
  Nof.tickets = page %>% html_nodes(".game_info_group:nth-child(5) .game_info_txt") %>% html_text()
  price = page %>% html_nodes(".game_info_group:nth-child(1) .game_info_txt:nth-child(1)") %>% html_text()
  winning.tickets = page %>% html_nodes(".members .sr-only+ div") %>% html_text()
  winning.tickets <<- gsub(",","",winning.tickets)
  Nof.tickets <<- gsub(",","",Nof.tickets)
  price <<- price
  name <<- name
  print(winning.tickets)
  ##############
  winning.tickets <<- winning.tickets[seq(2,length(winning.tickets), by=2)]
  No.winning.tickets <<- winning.tickets[seq(2,length(winning.tickets), by=2)]
  win.price <<- winning.tickets[seq(1,length(winning.tickets), by=2)]

  Table <<- data.frame(win.price,No.winning.tickets,price,name,Nof.tickets)
  
  #Table <<- data.frame(win.price,No.winning.tickets,price,Nof.tickets,name)
}

#“Get your data, and then use function1 on it, and then use function2 on it, and then merge it with data2.”
ze <- data.frame(read.csv("ze.csv")) #ze contains the link numbers available on the website
ze <- ze[!(ze$agrala.number==38),] #removes the problematic url
ze


#scraping urls
url <- "https://www.pais.co.il/hishgad/"
html_content <- read_html(url)
urls <- html_content %>%
  html_nodes("a") %>%
  html_attr("href")
lists<- urls[c(103:195,103:195)]
lists

#locating the number of urls that related
nana<- str_locate(lists, "=")[1,1]
agrala.number<- substr(lists,nana+1,nchar(lists))
agrala.number <- data.frame(agrala.number)
agrala.number <- unique(agrala.number)
write.csv(agrala.number,"ze.csv")
agrala.number
agrala(38)
#CSV creator 
for (i in 1:78) {
  if(i %in% ze$agrala.number) {
  agrala(i)
  write.csv(Table, paste0(i,".csv"))
  } else {print(paste("No",i))}
}


full.list <- data.frame() #Creating a data frame before loop

##Csv combine
for (i in 1:78) {
  if(i %in% ze$agrala.number) {
    generator <- read.csv(paste(i,".csv",sep = ""))
   full.list <- rbind(full.list,generator) # adding all tickets together
  } else {print(paste("No",i))
    }
}








              