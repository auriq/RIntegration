read.essentia <- function(file) {
  pipedline <- pipe(sprintf("bash %s",file), open = "r")
  t2 <- read.csv(pipedline, header = TRUE, sep = ",", 
                 quote = "\"'", comment.char = "#", blank.lines.skip = FALSE, 
                 allowEscapes = TRUE, skip = 0)
  close(pipedline)
  return(t2)
}