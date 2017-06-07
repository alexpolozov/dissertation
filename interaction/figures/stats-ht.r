for (package in c('gdata')) {
    if (!(require(package, character.only=T, quietly=T))) {
        install.packages(package)
        library(package, character.only=T)
    }
}

# setwd(dirname(sys.frame(1)$ofile))
# assuming current working dir is the file's dir. If the line above works for you, great.

results_csv <- read.csv("flashprog.cloudapp.csv")
results_csv_filtered <- subset(results_csv, startsWith(UserName, "user") & Scenario != "addresses" & Time < 1000)


# print(summary(lm(Time ~ UserName + Scenario + Disambiguation + Program.Viewer, results_csv_filtered)))
#
# print(summary(lm(Errors ~ UserName + Scenario + Disambiguation + Program.Viewer, results_csv_filtered)))
# print(summary(lm(Errors ~ Time + UserName + Scenario + Disambiguation + Program.Viewer, results_csv_filtered)))

valsNone = subset(results_csv_filtered, Disambiguation == "FALSE" & Program.Viewer == "FALSE")
valsDisambiguation = subset(results_csv_filtered, Disambiguation == "TRUE")
valsProgramViewer = subset(results_csv_filtered, Program.Viewer == "TRUE")



printtest <- function (testname, testresult) {
  if (testresult$p.value < 0.05) {
    s = " TRUE"
  }
  else {
    s = " FALSE"
  }
  s = paste("testing ", testname, " ... ", s, " p-value:", testresult$p.value, " W=", testresult$statistic )
  print(s)
}

res = wilcox.test(valsDisambiguation$Time, valsProgramViewer$Time, "less")
printtest("H1a", res)

res = wilcox.test(valsDisambiguation$Time, valsProgramViewer$Time, "greater")
printtest("H1c", res)


res = wilcox.test(valsProgramViewer$Time, valsNone$Time, "greater")
printtest("H1d", res)

res = wilcox.test(valsDisambiguation$Time, valsNone$Time, "greater")
printtest("H1e", res)


res = wilcox.test(valsDisambiguation$Errors, valsNone$Errors, "less")
printtest("H3a", res)

res = wilcox.test(valsProgramViewer$Errors, valsNone$Errors, "less")
printtest("H4a", res)

res = wilcox.test(valsDisambiguation$Errors, valsProgramViewer$Errors, "less")
printtest("H5a", res)


res = wilcox.test(valsDisambiguation$Future.trust, valsNone$Future.trust, "greater")
printtest("H6a", res)

res = wilcox.test(valsDisambiguation$Future.trust, valsNone$Future.trust, "less")
printtest("H6b", res)

res = wilcox.test(valsProgramViewer$Future.trust, valsNone$Future.trust, "greater")
printtest("H7a", res)

res = wilcox.test(valsProgramViewer$Future.trust, valsNone$Future.trust, "less")
printtest("H7b", res)


res = wilcox.test(valsDisambiguation$Confidence, valsNone$Confidence, "greater")
printtest("H8a", res)

res = wilcox.test(valsDisambiguation$Confidence, valsNone$Confidence, "less")
printtest("H8b", res)

res = wilcox.test(valsProgramViewer$Confidence, valsNone$Confidence, "greater")
printtest("H9a", res)

res = wilcox.test(valsProgramViewer$Confidence, valsNone$Confidence, "less")
printtest("H9b", res)


res = wilcox.test(valsDisambiguation$Easiness, valsNone$Easiness, "greater")
printtest("H10a", res)

res = wilcox.test(valsDisambiguation$Easiness, valsNone$Easiness, "less")
printtest("H10b", res)

res = wilcox.test(valsProgramViewer$Easiness, valsNone$Easiness, "greater")
printtest("H11a", res)

res = wilcox.test(valsProgramViewer$Easiness, valsNone$Easiness, "less")
printtest("H11b", res)

print("correlation:")
print(cor.test(results_csv_filtered$Perceived.correctness, results_csv_filtered$Errors, method="spearman"))


# produce boxplot
results_csv_filtered["Mode"] = "BI"
results_csv_filtered$Mode[results_csv_filtered$Disambiguation == "TRUE"] = "BI+CC"
results_csv_filtered$Mode[results_csv_filtered$Program.Viewer == "TRUE"] = "BI+PN"


colors = c("#8BC3EA", "#DBD3FF", "#2B83BA")
png("error_plot1_400.png", width=400, height=100)
par(mar=c(2.5,3.5,0.2,0.2))
boxplot(Errors ~ Mode, data = results_csv_filtered, horizontal=T, las=T, col=colors)
dev.off()

png("error_plottrust_400.png", width=400, height=100)
par(mar=c(2.5,3.5,0.2,0.2))
boxplot(Future.trust ~ Mode, data = results_csv_filtered, horizontal=T, las=T, col=colors)
dev.off()

png("error_ploteasiness_400.png", width=400, height=100)
par(mar=c(2.5,3.5,0.2,0.2))
boxplot(Easiness ~ Mode, data = results_csv_filtered, horizontal=T, las=T, col=colors)
dev.off()

png("error_plotConfidence_400.png", width=400, height=100)
par(mar=c(2.5,3.5,0.2,0.2))
boxplot(Confidence~ Mode, data = results_csv_filtered, horizontal=T, las=T, col=colors)
dev.off()

png("error_plotConfidenceTrust_400.png", width=400, height=100)
par(mar=c(2.5,3.5,0.2,0.2))
plot(Confidence~ Future.trust, data = results_csv_filtered, las=T, col=colors)
dev.off()

svg("error_plot1_s.svg", width=4, height=1.4)
par(mar=c(2,3.5,0.2,0.2), mgp=c(0,0.7,0))
boxplot(Errors ~ Mode, data = results_csv_filtered, horizontal=T, las=T, col=colors)
dev.off()
