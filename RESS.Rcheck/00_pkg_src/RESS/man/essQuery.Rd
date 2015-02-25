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

Each stream command can only be used to stream one file
directly into your R analysis.  However, each stream command
can save multiple files into a single R dataframe.

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

\code{#R#name#R#} : Allows any automatically saved dataframe to be
renamed to whatever is entered in place of 'name'. This only
applies in essQuery when streaming multiple files.

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

If you use essQuery to save multiple files into an R dataframe
using a single stream command, the files are stored automatically
in an R dataframe called command1 and no value is returned. To
change the name of the stored dataframe, use the #R#NAME#R# flag.

}
\references{
See our website at www.auriq.net or our documentation at
www.auriq.net/documentation

}
\author{
Ben Waxer, Data Scientist with Auriq Systems.
}
