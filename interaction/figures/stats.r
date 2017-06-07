library("gdata")

# setwd(dirname(sys.frame(1)$ofile))
# assuming current working dir is the file's dir. If the line above works for you, great.

telemetry_2015.04.12 <- read.csv("telemetry_2015-04-12.csv")
telemetry_filtered <- subset(telemetry_2015.04.12, startsWith(User, "user") & Scenario != "addresses")

bi <- subset(telemetry_filtered, Disambiguation == F & Viewer == F)
bi_pn <- subset(telemetry_filtered, Disambiguation == F & Viewer == T)
bi_cc <- subset(telemetry_filtered, Disambiguation == T & Viewer == F)

wilcox.test(bi$Errors, bi_cc$Errors)
