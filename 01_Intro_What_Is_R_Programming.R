## WELCOME TO R! ##
## It's not too scary... ##


# R: developed by data analysts, for data analysts

# 1) First off, what's the deal with RStudio? What am I looking at - how does it work. Let's take a tour together.

# 2) What are "packages" and how to do I find them, install them

# 3) What is a "working directory" and why is it so important?
# (Should I use "projects" instead? YES, here's why.)

# 4) What is commenting? What's up with this hash marks (#)?




# SOME FUNDAMENTALS OF R ####

#It's a programming language, so think of it to start at its most basic

1+1

2*5

# Ok that worked, can it deal with text too?

"Billy"

# "Billy" + "Sallie"

#well that didn't work. What happened?

#the "c" - sear it in your brain for R, it comes up a lot. 
#it's for making a list (known as a "vector") of values.

c("Billy","Sallie")


#Other languages call them variables, R calls them objects...but they're the same idea
#Assigning something a name, so that you can use it

myobject <- 1

#now I can tell R to give me the value of myobject by referring to it by its name
myobject

#let's try another
mynames <- c("Billy","Sallie","Tony")

mynames


# What's a VECTOR?  
# In R, essentially almost everything. But think of it like an ordered list of values
# The brackets - another thing to know [] in R, though we won't be using this notation
# much in this workshop. 
# They are one way to pull out only a certain piece of something.

mynames[1]

mynames[3]


# Certain operations in R are "vectorized" - which means that unlike
# in other programming languages, you don't have to write a loop to
# iterate through the list.

# Let's see how this works:
# We'll create two vectors, one for monthly revenue one for expenses
revenue <- c(14574, 7606, 8611, 9175, 8058, 8105, 11496, 9766, 10305, 14379, 10713, 15433)
expenses <- c(12051, 5695, 12319, 12089, 8658, 840, 3285, 5821, 6976, 16618, 10054, 3803)

revenue

expenses

# Now let's calculate the profit: the difference between revenue and expenses
revenue - expenses

# can save the results as a new object
profit <- revenue - expenses

profit


### Now, let's start to actually look at some data.
# First, we're going to switch over from using regular R scripts
# to Quarto, the next generation of RMarkdown, which has some 
# special properties.
