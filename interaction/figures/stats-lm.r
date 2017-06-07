library("gdata")

# setwd(dirname(sys.frame(1)$ofile))
# assuming current working dir is the file's dir. If the line above works for you, great.

results_csv <- read.csv("flashprog.cloudapp.csv")
results_csv_filtered <- subset(results_csv, startsWith(UserName, "user") & Scenario != "addresses" & Time < 1000)


print(summary(lm(Time ~ UserName + Scenario + Disambiguation + Program.Viewer, results_csv_filtered)))
print(summary(lm(Errors ~ UserName + Scenario + Disambiguation + Program.Viewer, results_csv_filtered)))
print(summary(lm(Errors ~ Time + UserName + Scenario + Disambiguation + Program.Viewer, results_csv_filtered)))
