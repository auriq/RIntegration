# Essentia Intregration with R

The built package tarball is RESS_1.0.tar.gz

Scripts for internal testing are located in testscripts/.

## Installing on Linux (possibly other systems too):

First install Essentia and install R. Then:

git pull https://github.com/auriq/RIntegration.git

R CMD INSTALL RESS_1.0.tar.gz

      You can specify a library tree with the –l option.

cp –R testscripts/ PublicRepoDirectory/

cd PublicRepoDirectory/testscripts/

bash loadtimeapache.sh

R –f <EACH_TEST_SCRIPT>


