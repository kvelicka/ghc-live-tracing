#/bin/bash
./clean # remove old artefacts
$head -O -eventlog -rtsopts main.hs --make # compile using dev version of GHC
#./main +RTS -l # run the hello world
valgrind --dsymutil=yes ./main +RTS -l # run the hello world
#open -a Hex\ Fiend main.eventlog # open the resulting log
