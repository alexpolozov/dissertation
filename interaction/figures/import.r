#Install all required packages.
install.packages(package, repos="http://cran.us.r-project.org")
for (package in c('RCurl', 'XML')) {
    if (!(require(package, character.only=T, quietly=T))) {
        install.packages(package)
        library(package, character.only=T)
    }
}

mainAnswers <- "https://docs.google.com/spreadsheets/d/1gaBthCvUpZhqdiR2OMzpNEo1npYl5uYqeQgHaYkb-Ko/pubhtml?gid=894673444&single=true"
#flashprog.cloudapp.net <- "https://docs.google.com/spreadsheets/d/1gaBthCvUpZhqdiR2OMzpNEo1npYl5uYqeQgHaYkb-Ko/pubhtml?gid=8585457&single=true"

mainAnswersURI <- getURLContent (mainAnswers ,.opts = list(ssl.verifypeer = FALSE, useragent = "R", timeout = 4))
tables <- readHTMLTable(mainAnswersURI)

#n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
#tables[[which.max(n.rows)]]

# Simple Horizontal Bar Plot with Added Labels 
# counts <- table(mtcars$gear)
# barplot(counts, main="Car Distribution", horiz=TRUE,
  names.arg=c("3 Gears", "4 Gears", "5 Gears"))

#