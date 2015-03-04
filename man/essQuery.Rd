\name{essQuery}
\alias{essQuery}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{essQuery
}
\description{Query the UDB database and return the results to R.}
\usage{
essQuery(essentia, aq="", flags="")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{essentia}{
The essentia command to run. The options are "ess task stream
category startdate enddate" and "ess task exec".

Each stream command can be used to stream any number of files
directly into your R analysis. Alternatively, each stream command
can save multiple files into separate R dataframes, one file per dataframe.

The default value for the essentia argument is "ess task
exec".

}
  \item{aq}{
This can be any combination of the aq_tools and standard UNIX
commands. However, the output MUST be in a csv format if you
want R to capture the output. If you only want to run the
command without R capturing the output, add "#Rignore" to the
flags argument.

}
  \item{flags}{
Any of the essentia flags can be used here in addition to any
of these RESS-specific flags:

\code{#Rignore} : Ignore an 'ess task exec statement. Do not
capture the output of the statement into R.

\code{#Rinclude} : Include an 'ess task stream' statement. Capture
the output of the statement into R.

\code{#-notitle} : Tell R not to use the first line of the output
as the header.

\code{#Rseparate} : Can be used when saving multiple files into an
R dataframe using an 'ess task stream' command. Saves each
file into a different R dataframe, entitled command1 to
commandN, where N is the number of files.

\code{#filelist} : Causes an extra dataframe to be stored in R that saves 
the list of files streamed into R when streaming multiple files.

\code{#R#name#R#} : Allows any automatically saved dataframe to be
renamed to whatever is entered in place of 'name'. This only
applies in essQuery when streaming multiple files with \code{#Rseparate}.

}
}
\details{
essQuery is used to directly query the database using a single
statement. You can call essQuery multiple times to run different
statements.

However, you can also use read.udb to read all of the statements
in a file instead.  Thus if you plan to run multiple statements
that may be somewhat related to each other, it is recommended that
you use read.udb.

}
\value{
The value returned is the output from querying the database. This
can be saved into an R dataframe or directly analyzed in R.

If you use essQuery to save multiple files into separate R dataframes
using a single stream command, the files are stored automatically
in R dataframes called command1 to commandN (where N is the number of files) 
and no value is returned. To change the name of the stored dataframes, use 
the #R#any_name#R# flag. The dataframes will then be stored as any_name1 to any_nameN.

With #filelist, the extra dataframe is saved as commandN+1 by default, or 
any_nameN+1 if #R#any_name#R# is also used.

}
\references{
See our website at www.auriq.net or our documentation at
www.auriq.net/documentation

}
\author{
Ben Waxer, Data Scientist with Auriq Systems.
}
\examples{
fullexec <- essQuery("ess task exec", "echo -e '11,12,13\\n4,5,6\\n7,8,9' ","#-notitle")
print(fullexec)
defaultexec <- essQuery("echo -e '11,12,13\\n4,5,6\\n7,8,9' ","#-notitle")
print(defaultexec)
essQuery("echo -e '11,12,13\\n4,5,6\\n7,8,9' ","#Rignore")
print("This last statement is ignored by R and just executed on the command line.")
\dontrun{For more extensive examples of how these functions can be used with the Essentia Database, please go through our documentation at http://www.auriq.com/documentation/source/tutorial/rtutorial.html}
}
