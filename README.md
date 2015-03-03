# Essentia Intregration with R

The built package tarball is RESS_1.0.tar.gz

Scripts for internal testing are located in testscripts/. The data for these scripts is also located in testscripts/ under the subfolder accesslogs/.

## Installing on Linux (possibly other systems too):

First install Essentia and install R. Then change into whichever directory you want this repository in and run:

git pull https://github.com/auriq/RIntegration.git

cd RIntegration

R CMD INSTALL RESS_1.0.tar.gz

      You can specify a library tree with the –l option.

## Running Apache Scripts

This package contains two R functions that can be used to capture the output of essentia commands into R, **essQuery** and **read.udb**.

* **essQuery** is used to directly query the database using a single statement. You can call essQuery multiple times to run different statements.
* **read.udb**, on the other hand, reads all of the statements in a file. Thus if you plan to run multiple statements
  that may be somewhat related to each other, it is recommended that you use **read.udb**.

Both functions require an Essentia Bash script to be executed that sets up the Essentia environment and optionally loads data into the UDB database. 
This script is called loadtimeapache.sh and thus we need to run:

sh loadtimeapache.sh

The only thing needed to complete the apache analysis is to run our scripts that call essQuery and read.udb. Thus we run

R –f callessquery.R

R -f callreadudb.R

R -f testquery.R

R -f secondtest.R

separately on the command line.


