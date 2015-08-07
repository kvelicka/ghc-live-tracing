#/bin/bash
echo "Cleaning..."
./clean # remove old artefacts
echo "Done."
echo "Compiling..."
$head -O -eventlog -rtsopts main.hs --make # compile using dev version of GHC
echo "Done."
echo "Running..."
./main +RTS -l # run the hello world
echo "Done."
#valgrind --dsymutil=yes ./main +RTS -l # run the hello world
open -a Hex\ Fiend main.eventlog # open the resulting log
