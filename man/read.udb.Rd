\name{read.udb}
\alias{read.udb}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{read.udb
%%  ~~function to do ... ~~
}
\description{
Read the essentia commands in the stated file, query the UDB
database, and save the results into R as dataframes.

}
\usage{
read.udb(file, linenumber = "all")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{
The file containing the essentia commands you want to run.
'ess task stream' statements will have their output ignored
by R unless there is a '#Rinclude' flag somehwere in the
statement line. 'ess task exec' statements will have their
output included unless there is a '#Rignore' flag somewhere
in the statement line.

The file should contain primarily the query commands but can
contain the entire essentia script including loading the UDB
database if desired. Any command that you want to capture the
output from must have its output in csv format.

}
  \item{linenumber}{
This is set to default to all line numbers so that every
command in the file is executed. You can specify the line
number of the command you wish to run if you dont want to run
the entire set of commands in the file. If your statement spans
multiple lines, you can specify each line using the syntax
c(first_line_number, second_line_number, ....).

}
}
\details{
read.udb reads all of the statements in a file (unless linenumber
is specified, see above) and captures the output of the specified
commands into R dataframes. By default only the output of 'ess
task exec' statements is captured and it's stored in R dataframes
command1 to commandN, where N is the number of captured
statements.

You can include 'ess task stream' statements by adding a
'#Rinclude' flag. This method can be used to stream multiple files
into R for data exploration or analysis.  Thus if you plan to run
multiple statements that may be somewhat related to each other,
it is recommended that you use read.udb.

}
\value{
There is no value returned. This command creates a set of R
dataframes containing the output from the specified essentia
commands in file.

}
\references{
See our website at www.auriq.net or our documentation at
www.auriq.net/documentation.

}
\author{
Ben Waxer, Data Scientist with Auriq Systems.
}
\note{
The flags added to the essentia commands in file can include:

\code{#Rignore} : Ignore an 'ess task exec statement. Do not
capture the output of the statement into R.

\code{#Rinclude} : Include an 'ess task stream' statement. Capture
the output of the statement into R.

\code{#-notitle} : Tell R not to use the first line of the output
as the header.

\code{#Rseparate} : Can be used when saving multiple files into an
R dataframe using an 'ess task stream' command. Saves each
file into a different R dataframe.

\code{#filelist} : Causes an extra dataframe to be stored in R that saves
the list of files streamed into R when streaming multiple files.

\code{#R#name#R#} : Allows any automatically saved dataframe to be
renamed to whatever is entered in place of 'name'. When used with 
#Rseparate, saves the files as name1 to nameN, where N is the number of files. 
Since this still counts as a statement, the next default dataframe saved will 
be stored as command followed by the number of previous statements run plus one. 

}
