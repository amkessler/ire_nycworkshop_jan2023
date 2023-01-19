# GWU Data Journalism - Grouping and Mutating

# Load the packages we'll need
library(tidyverse)
library(lubridate)
library(readxl)
library(writexl)
library(janitor)



#### PRESIDENTIAL CANDIDATE TRIPS  
#    
# Load in data of prez candidate campaign trips 

events <- readRDS("events_saved.rds") 

# Let's take a look at what we've got

events

# Remember how we can filter

events %>% 
  filter(state == "IA")

# Filtering for more than one value
# First way: using the "|" symbol to mean OR

events %>% 
  filter(state == "IA" | state == "TX")

# Second way: using the %in% command and using vector of values

events %>% 
  filter(state %in% c("IA", "TX"))

# And remember how we can sort

events %>% 
  filter(state %in% c("IA", "TX")) %>% 
  arrange(desc(date))



#### ADDING COLUMNS WITH MUTATE ####

# To add or modify a column, you give it a name, then a single equal sign (=), then define what's in it.  
# Test example:

events %>% 
  mutate(mycolumn = "hi there") #remember what happens with recycling here

events %>% 
  mutate(electioncycle = 2020)

# Now let's try adding our date-related columns.  First we'll try year.

events %>% 
  mutate(year = year(date))

# We can add multiple columns as part of one mutate call. Let's do year, month and day in one swoop.

events %>% 
  mutate(year = year(date),
         month = month(date),
         day = day(date))

# This is a good time to remind ourselves that if we want to save our new columns, need to *create new object* or *overwrite*

events <- events %>% 
  mutate(year = year(date),
         month = month(date),
         day = day(date))

# Now we can use our new columns to filter

events %>% 
  filter(year == 2019,
         month == 1)

# Show me just Kamala's events in January

events %>% 
  filter(year == 2019,
         month == 1,
         cand_lastname == "Harris")



#### GROUPING AND AGGREGATING  
#  
#  
# Able to aggregate our campaign trips would be helpful at this point, right?  
# Let's get into how to do it using the tidyverse and dplyr's `group_by()` and `summarise()` 
#   
# Have you all grouped before in other languages? In base R itself?  Let's discuss.  
#   
# Grouping to see how many trips each candidate have been on in our data  
# Getting used to `n()`

events %>% 
  group_by(cand_lastname) %>% 
  summarise(n())

# now let's add arrange to see who has the most trips
# (not run)  
# events %>% 
#   group_by(cand_lastname) %>% 
#   summarise(n()) %>% 
#   arrange(n)

# hmm - what's going on here? Look closely and see what the generated count column is called
# events %>% 
#   group_by(cand_lastname) %>% 
#   summarise(n()) %>% 
#   arrange("n()")

# that doesn't work either.  What about this.

events %>% 
  group_by(cand_lastname) %>% 
  summarise(n()) %>% 
  arrange()

# Ah - so that sort of works? But not really, how do we get desc
# events %>% 
#   group_by(cand_lastname) %>% 
#   summarise(n()) %>% 
#   arrange(desc)

# Oy - this is getting frustrating. How do we solve?  
# By doing this: giving the new column a NAME of our own.  
# Check it out:

events %>% 
  group_by(cand_lastname) %>% 
  summarise(n = n()) 

# Now we can do:

events %>% 
  group_by(cand_lastname) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

# Bingo  
# We can call the new columnn anything we want. "n" is a common thing for counts,  
# but can be anything

events %>% 
  group_by(cand_lastname) %>% 
  summarise(numtrips = n()) %>% 
  arrange(desc(numtrips))

# Now for the magic  
# Because this counting is such a common operation, and because the `n()` becomes a pain to deal with...  
# ...there is a special shortcut that we can use that collapses everything into one function

events %>% 
  count(cand_lastname)

events %>% 
  count(cand_lastname) %>% 
  arrange(desc(n))

# top states visited

events %>% 
  count(state) %>% 
  arrange(desc(n))

# top months

events %>% 
  count(month) %>% 
  arrange(desc(n))

# top single day for most trips

events %>% 
  count(date) %>% 
  arrange(desc(n))

# we can also group by **more than one** variable  
# which candidates have gone to which states?

events %>% 
  count(cand_lastname, state) %>% 
  arrange(state, desc(n))

# what about the most frequent types of events

events %>% 
  count(event_type) %>% 
  arrange(desc(n))




### Some more grouping practice: Baseball Salaries #####

# And how do we get data into R in the first place again??? Let's talk about it ####

# Remember our CSV imports from Excel? Kind of a similar concept, we can bring from CSV or EXCEL into R.

#import the data
salaries <- read_excel("MLB2018.xlsx") %>% 
  clean_names()

#let's see what we have
salaries 

#Grouping...

# What the total payroll paid out by each team?
salaries %>% 
  group_by(team) %>% 
  summarise(sum(salary)) 

#now let's give our new colum with the sums a NAME and sort by salary descending
salaries %>% 
  group_by(team) %>% 
  summarise(total_dollars = sum(salary)) %>% 
  arrange(desc(total_dollars))


# What the total paid in the league for each position?
salaries %>% 
  group_by(pos) %>%  # <--this is all that changed
  summarise(total_dollars = sum(salary)) %>% 
  arrange(desc(total_dollars))

# What about the average paid for each position?
salaries %>% 
  group_by(pos) %>% 
  summarise(average_paid = mean(salary)) %>% 
  arrange(desc(average_paid))

# And if you don't believe in the Designated Hitter?
salaries %>% 
  filter(pos != "DH") %>% 
  group_by(pos) %>% 
  summarise(average_paid = mean(salary)) %>% 
  arrange(desc(average_paid))

# Ah, much better.  :-)

### SAVING AND ITERATING ####

# let's say I want to save the results?
# we'll go back to the top team payrolls
# we can give it a name within R
teampayrolls <- salaries %>% 
  group_by(team) %>% 
  summarise(total_dollars = sum(salary)) %>% 
  arrange(desc(total_dollars))

teampayrolls


# export it to a spreadsheet to share with others
write_xlsx(teampayrolls, "teampayrolls.xlsx")

# what if we want to put it in a separate subfolder instead of our main area?
# create the new folder and then...
# write_xlsx(teampayrolls, "output/teampayrolls.xlsx")

