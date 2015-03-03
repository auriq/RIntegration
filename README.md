# Essentia Intregration with R

The built package tarball is RESS_1.0.tar.gz

Scripts for internal testing are located in testscripts/. The data for these scripts is also located in testscripts/ under the subfolder accesslogs/.

## Installing on Linux (possibly other systems too):

First install Essentia and install R. Then change into whichever directory you want this repository in and run:

git pull https://github.com/auriq/RIntegration.git

cd RIntegration

R CMD INSTALL RESS_1.0.tar.gz

      You can specify a library tree with the –l option.

sh loadtimeapache.sh

R –f **EACH_TEST_SCRIPT**


