# Essentia Intregration with R

The built package tarball is RESS_1.0.tar.gz

Scripts for internal testing are located in testscripts/. To run these scripts successfully, you need to copy the testscripts directory into the directory where you pulled EssentiaPublic (see below).

## Installing on Linux (possibly other systems too):

First install Essentia and install R. Then change into whichever directory you want this repository in and run:

git pull https://github.com/auriq/RIntegration.git

R CMD INSTALL RESS_1.0.tar.gz

      You can specify a library tree with the –l option.

cp –R testscripts/ EssentiaPublicDirectory/

cd EssentiaPublicDirectory/testscripts/

bash loadtimeapache.sh

R –f <EACH_TEST_SCRIPT>

