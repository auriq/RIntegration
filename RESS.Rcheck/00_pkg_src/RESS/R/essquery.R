essQuery <- function(essentia, aq = "", flags = "") {
    commandcount <- 1
    if (substr(essentia, 1, 3) != "ess") {
      flags <- aq
      aq <- essentia
      essentia <- "ess task exec"
    }
    if (((substr(essentia, 1, 13) == "ess task exec") && (!grepl("#Rignore", flags))) || ((substr(essentia, 1, 15) == "ess task stream") && (grepl("#Rinclude", flags)))) {
      aq <- paste(aq, "; echo 'RSTOPHERE'", sep = "")
      line <- paste(essentia, "\"", aq, "\"", flags, sep = " ")
      colspec <- TRUE
      if (grepl("-notitle", line)) {
        colspec <- FALSE
      }
      varname <- ""
      if (grepl("#R#", line)) {
        titleindex <- grepRaw("#R#", line, all = TRUE)
        varname <- substr(line, titleindex[[1]] + 3, titleindex[[2]] - 1)
        remove(titleindex)
      }
      t2 <- read.csv(pipe(line, open = "r"), header = colspec, sep = ",", quote = "\"'", comment.char = "#", blank.lines.skip = FALSE, allowEscapes = TRUE, skip = 0)
      index <- 1
      t3 <- NULL
      separate <- grepl(" #Rseparate", line)
      for (file in seq(1, length(which(t2[,1] == "RSTOPHERE")),1)) {
        if (separate) {
          assign(sprintf("command%i", commandcount), t2[index:(which(t2[,1] == "RSTOPHERE")[[file]] - 1),1:ncol(t2)], inherits = TRUE)
          index <- which(t2[,1] == "RSTOPHERE")[[file]] +  1
          print(get(sprintf("command%i", commandcount)))
          commandcount <- commandcount + 1
        }
        else {
          t3 <- rbind(t3, t2[index:(which(t2[,1] == "RSTOPHERE")[[file]] - 1),1:ncol(t2)])
          index <- which(t2[,1] == "RSTOPHERE")[[file]] +  1
          if ((file == length(which(t2[,1] == "RSTOPHERE")))) {
            if ((length(which(t2[,1] == "RSTOPHERE")) == 1)) {
              commandcount <- commandcount + 1
              remove(t2)
              return(t3)
            }
            else {
              if (varname == "") {
                assign(sprintf("command%i", commandcount), t3, inherits = TRUE)
                print(get(sprintf("command%i", commandcount)))
                print(sprintf("---------------- Output Stored in command%i ----------------", commandcount))
              }
              else {
                assign(sprintf("%s", varname), t3, inherits = TRUE)
                print(get(sprintf("%s", varname)))
                print(sprintf("---------------- Output Stored in %s ----------------", varname))
              }
              commandcount <- commandcount + 1
            }
          }
        }
      }
      remove(t2)
      if ((file > 1) && (grepl(" #Rseparate", line))) {
        print(sprintf("---------------- Stream Completed: %i files stored in %i commands: command%i to command%i ----------------", file, file, commandcount - file, commandcount - 1))
        linepart1 <- unlist(strsplit(line, split = " "))
        t1 <- pipe(paste(linepart1[[1]], linepart1[[2]], linepart1[[3]], linepart1[[4]], linepart1[[5]], linepart1[[6]], "\"aq_pp -f,eok - -d %cols 2> /dev/null | echo %file \"", sep = " "), open = "r")
        t2 <- read.csv(t1, header = FALSE, sep = ",", quote = "\"'", comment.char = "#", blank.lines.skip = FALSE, allowEscapes = TRUE, skip = 0)
        assign(sprintf("command%i", commandcount), t2[1:file,1:ncol(t2)], inherits = TRUE)
        print(get(sprintf("command%i", commandcount)))
        print(sprintf("---------------- Filenames stored in command%i ----------------", commandcount))
        commandcount <- commandcount + 1
        close(t1)
        remove(t1)
        remove(t2)
      }
      remove(colspec, varname, index, separate, t3)
    }
    else {
      line <- paste(essentia, "\"", aq, "\"", flags, sep = " ")
      if (line != "") {
        system(line)
      }
    }
    remove(commandcount, line, essentia, aq, flags)
  }

