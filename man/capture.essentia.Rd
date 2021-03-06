\name{capture.essentia}
\alias{capture.essentia}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{capture.essentia
%%  ~~function to do ... ~~
}
\description{
Read the essentia commands in the stated file, query the Essentia
database, and save the results into R as dataframes.

}
\usage{
capture.essentia(scriptcall = "", linenumber = "all", separator = " ")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{scriptcall}{
The file containing the essentia commands you want to run and any 
arguments you want to pass into the bash script. 

'ess stream' and 'ess query' statements will have their output ignored
by R unless there is a '#Rinclude' flag somehwere in the
statement line. 'ess exec' statements will have their
output included unless there is a '#Rignore' flag somewhere
in the statement line.

The file should contain primarily the query commands but can
contain the entire essentia script including loading the Essentia
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
  \item{separator}{
The character that should be used to split the script name and 
arguments you are passing into that script. The default is set
to a space in the style of the linux command line; however, you
can set it to whatever you want. This can be useful if one or 
more of the arguments you are trying to pass into your script 
contains an unquoted space.
}
}
\details{
capture.essentia reads all of the statements in a file (unless linenumber
is specified, see above) and captures the output of the specified
commands into R dataframes. By default only the output of 'ess
exec' statements is captured and it's stored in R dataframes
command1 to commandN, where N is the number of captured
statements.

You can include 'ess stream' or 'ess query' statements by adding a
'#Rinclude' flag. This method can be used to stream multiple files
into R for data exploration or analysis.  If you plan to run
multiple statements that may be somewhat related to each other,
it is recommended that you use capture.essentia.

}
\value{
If there is only one statement that is having its output captured
and this statement does not contain a \code{#R#name#R#} flag,
capture.essentia will simply return the data in R so you can save it
however you want or stream it directly into additional analysis.

If there is more than one statement that is having its output 
captured, there is no value returned. This command creates a
set of R dataframes containing the output from the specified essentia
commands in the file specified in scriptcall.

}
\references{
See our website at www.auriq.com or our documentation at
www.auriq.com/documentation.

}
\author{
Ben Waxer, Data Scientist with Auriq Systems.
}
\note{
The flags added to the essentia commands in file can include:

\code{#Rignore} : Ignore an 'ess exec' statement. Do not
capture the output of the statement into R.

\code{#Rinclude} : Include an 'ess stream' or 'ess query' statement. Capture
the output of the statement into R.

\code{#-notitle} : Tell R not to use the first line of the output
as the header.

\code{#Rseparate} : Can be used when saving multiple files into an
R dataframe using an 'ess stream' command. Saves each
file into a different R dataframe.

\code{#filelist} : Causes an extra dataframe to be stored in R that saves
the list of files streamed into R when streaming multiple files.

\code{#R#name#R#} : Allows any automatically saved dataframe to be
renamed to whatever is entered in place of 'name'. When used with 
#Rseparate, saves the files as name1 to nameN, where N is the number of files. 
Since this still counts as a statement, the next default dataframe saved will 
be stored as command followed by the number of previous statements run plus one. 

}
\examples{
\dontrun{
--------------------------------------------------------------------------------------------------

These examples require Essentia to be installed:

queryfile <- file("examplequery.sh","w")
cat("ess exec \"echo -e '11,12,13\\n4,5,6\\n7,8,9'\" #-notitle \n",file=queryfile)
cat("ess exec \"echo -e '11,12,13\\n4,5,6\\n7,8,9'\" \n", file=queryfile)
cat("ess exec \"echo -e '11,12,13\\n4,5,6\\n7,8,9'\" #Rignore \n", file=queryfile)
capture.essentia("examplequery.sh")
print(command1)
print(command2)
print("The last statement is ignored by R and just executed on the command line.")

--------------------------------------------------------------------------------------------------

This example requires Essentia to have selected a datastore containing purchase log data:

Store these lines as querypurchase.sh:

ess query "select count(refID) from purchase:2014-09-01:2014-09-15 \
where articleID>=46 group by price" #Rinclude
ess query "select count(distinct userID) from purchase:2014-09-01:2014-09-15 \
where articleID>=46" #Rinclude
ess query "select count(refID) from purchase:2014-09-01:2014-09-15 \
where articleID>=46 group by userID" #Rinclude
ess query "select * from purchase:*:* where articleID <= 20" #Rinclude #R#querystream#R# #-notitle

-----------------------------------------------

Then run these commands in R:

library(RESS)
capture.essentia("querypurchase.sh")
print(command1)
print(command2)
print(command3)
print(querystream)

--------------------------------------------------------------------------------------------------

The following example requires Essentia to be installed with apache log data stored in it.

Store the following lines as queryapache.sh:

# Query the Essentia database logsapache3 and save the contents of vector3 in R as command1.
ess exec "aq_udb -exp logsapache3:vector3" --debug

# Query the Essentia database logsapache1 and save the sorted contents of vector1 in R as command2.
ess exec "aq_udb -exp logsapache1:vector1 -sort pagecount -dec" --debug

# Stream the last five lines of the file in category 125accesslogs between dates 2014-12-07 and
# 2014-12-07, convert them to csv, return them to R, and store them into an R dataframe singlefile.
ess stream 125accesslogs '2014-12-07' '2014-12-07' "tail -5 \
| logcnv -f,eok - -d ip:ip sep:' ' s:rlog sep:' ' s:rusr sep:' [' i,tim:time sep:'] \"' \
s,clf:req_line1 sep:' ' s,clf:req_line2 sep:' ' s,clf:req_line3 sep:'\" ' i:res_status sep:' ' \
i:res_size sep:' \"' s,clf:referrer sep:'\" \"' \
s,clf:user_agent sep:'\"' X | cat -" #Rinclude #R#singlefile#R#

# Stream the last five lines of the files in category 125accesslogs between dates 2014-11-30 and
# 2014-12-07, convert them to csv, and save them into R dataframes apachefiles1 and apachefiles2.
ess stream 125accesslogs '2014-11-30' '2014-12-07' "tail -5 \
| logcnv -f,eok - -d ip:ip sep:' ' s:rlog sep:' ' s:rusr sep:' [' i,tim:time sep:'] \"' \
s,clf:req_line1 sep:' ' s,clf:req_line2 sep:' ' s,clf:req_line3 sep:'\" ' i:res_status sep:' ' \
i:res_size sep:' \"' s,clf:referrer sep:'\" \"' s,clf:user_agent sep:'\"' X -notitle | cat -" \
#Rinclude #R#apachefiles#R# #Rseparate

-----------------------------------------------

Then run these commands in R:

library(RESS)
capture.essentia("queryapache.sh")

print(command1)
print(command2)
print(singlefile)
print(apachefiles1)
print(apachefiles2)

The references contain more extensive examples that
fully walkthrough how to load and query the Essentia Database.

}
}
