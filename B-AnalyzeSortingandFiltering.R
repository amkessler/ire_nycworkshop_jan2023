# GWU Data Journalism - Transforming Data

# Load the packages we'll need
# Let's talk some more about libraries
library(tidyverse)
library(lubridate)


# Toy dataset to use, created manually with a "tibble" (fyi you'll almost never have to hand-create one like this) 

pollution <- tibble(city=c("New York", "New York", "London", "London", "Beijing", "Beijing"),
               size=c("large", "small", "large", "small", "large", "small"),
               amount=c(23, 14, 22, 16, 121, 56))

#*What are "tibbles"...?*    
#  
#They're dataframes, with some additional tidyverse-infused features. Returns more readable output in the console.
# 
 
#Let's see the data we just created, you'll see how a tibble view differs in the console

pollution

#Since there are only a handful of rows, a bit harder to see - let's try the built-in "iris" data

#(not run)
#iris

#That was a lot of output! Can limit rows with head()

head(iris)

#But let's see how tibbles differ in their output

as_tibble(iris)


#### FILTERING AND SORTING 

#The tidyverse's *dplyr* provides intuitive functions for exploring and analyzing dataframes  
#  

#Let's go back to our little pollution dataset

pollution

#Show me only the ones with a "large" size

filter(pollution, size == "large")

#Show me only the ones where the city is London

filter(pollution, city == "London")

#For numeric values, you can use boolean operators 

filter(pollution, amount > 20)
filter(pollution, amount <= 22)

#Now, let's try filtering based on two different variables

filter(pollution, amount > 20, size == "large") #note the comma separating the filtering terms


#This can still get a little confusing once you wind up with larger amounts of steps to string together.  
#  
#Enter a glorious feature of the tidyverse: **the PIPE** `%>%`  
#   
#The "pipe" (shortcut is CTRL/CMD + SHIFT + M) allows you to chain together commands  
#  
#Watch this, and see how much easier it becomes for a human to think through (and read later!)

pollution %>% 
  filter(size == "large")

#Voila! So what just happened there?  
#  
#Think of %>% as the equivalent of "and then do this"...  
##It takes the result and then applies something new to it, in sequential order  
#  

#This becomes easy to see when we add new functions - so let's talk about sorting with arrange()

pollution %>% 
  arrange(amount)

#To sort by highest value, add desc()

pollution %>% 
  arrange(desc(amount))

#Now let's go back to our filtering and add arranging, too

pollution %>% 
  filter(size == "large") %>% 
  arrange(desc(amount))

#Add another filter criteria

pollution %>% 
  filter(size == "large", amount < 100) %>% 
  arrange(desc(amount))

#This can be formatted this way as well, if it's even easier for you to read  
#Let's add another filter criteria

pollution %>% 
  filter(size == "large", 
         amount < 100) %>% 
  arrange(desc(amount))

#Think about what we just did here.  
#  
#You can read the code and it intuitively makes sense. 
#Each step sequentially listed and executes in order.  
#  
#  

# One more thing - what if we don't want all the columns? Just some.  
# This happens all the time.
# 
# Dplyr makes this easy using **select()`**
#   

pollution %>% 
  select(city, amount)

# You can pull out just certain variables as well  
# This results in the same thing as above

pollution %>% 
  select(-size)


#### PRESIDENTIAL CANDIDATE TRIPS  
#  
# Let's take a look at some more intersting data now and try out some of these methods  
#   
# Load in data of prez candidate campaign trips between midterms and end of Jan

events <- readRDS("events_saved.rds")

# Let's take a look at what we've got

events

# Even easier to see a dataset with `View()`  
# Click on its name under the environment tab in upper right, or:

View(events)

# Can also pipe the results of a chain if we wanted to

events %>% 
  view()


# Can you think of when we might find ourselves wanting to do that? (hint: think big)  
#   
# Now let's try out some of our filtering and arranging techniques.  
#   
# Show all events in Iowa:

events %>% 
  filter(state == "IA")

# Has Kamala Harris been to Iowa?

events %>% 
  filter(state == "IA",
         cand_lastname == "Harris")

# What about another candidate

events %>% 
  filter(state == "IA",
         cand_lastname == "Gillibrand")

# Let's talk about **date-specific** stuff.    
# If I have a properly formatted date in a dataframe, can I sort by it? *Yes.*

events %>% 
  filter(state == "IA") %>% 
  arrange(desc(date))

# What if I want to pull out only certain ranges of dates? *Several approaches.*   

# Specifiying a specific date using as.Date()

events %>% 
  filter(date < as.Date("2018-12-31"))

# Take advantage of the LUBRIDATE package - a tidyverse package specifically for dates  
# *Note: lubridate needs to be called separately at the top with library(lubridate) - it doesn't yet load with library(tidyverse)*    
#   
  
# Now watch what we can do:

events %>% 
  filter(year(date) == 2018)

# Just events in January 2019

events %>% 
  filter(year(date) == 2019,
         month(date) == 1)

# Events earlier than Dec 2018

events %>% 
  filter(year(date) == 2018,
         month(date) < 12)

# Also allows us to do things like, "I only want to see events the *first week of every month*" 

events %>% 
  filter(day(date) <= 7)

# Who's visiting Iowa the first week of a month? 

events %>% 
  filter(day(date) <= 7,
         state == "IA")

#  
# This is helpful but let's say you're doing this all the time.  
# It may be easier to create new columns to hold these values.
#     
# Next week we'll discuss how to do that with dpylr/tidyverse - **MUTATE**
#   
#  
