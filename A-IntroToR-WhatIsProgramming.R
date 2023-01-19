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

class(c("Billy","Sallie"))
class(100)


#Other languages call them variables, R calls them objects...but they're the same idea
#Assigning something a name, so that you can use it

myobject <- 1
myobject

mynames <- c("Billy","Sallie","Tony")
mynames
class(mynames)

# What's a VECTOR?  In R, essentially almost everything. But think of it like an ordered list of values
myvector <- as.vector(mynames)
class(myvector)

#The brackets - another thing to know [] in R. They are one way to pull out only a certain piece of something.
myvector[1]

myvector[3]



#### SOME SAMPLE FINANCIAL DATA ####

#Data - We'll create two vectors, one for revenue one for expenses
revenue <- c(14574, 7606, 8611, 9175, 8058, 8105, 11496, 9766, 10305, 14379, 10713, 15433)
expenses <- c(12051, 5695, 12319, 12089, 8658, 840, 3285, 5821, 6976, 16618, 10054, 3803)

revenue

expenses

revenue[5] - expenses[5]

mayrevenue <- revenue[5] - expenses[5]


#This is where R really starts to show its usefulness for data analysis

#Many languages make you use LOOPS to go through lists.  Not R.  (Well you can use loops too but...)

#Check it out
#Calculate Profit As The Differences Between Revenue And Expenses
profit <- revenue - expenses
profit

#Whoa!  See what happened there?
