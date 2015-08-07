#/bin/bash
./clean # remove old artefacts
ghc -O -eventlog -rtsopts main.hs --make # compile using RELEASE version of GHC
./main +RTS -l # run the hello world
#valgrind --dsymutil=yes ./main +RTS -l # run the hello world
open -a Hex\ Fiend main.eventlog # open the resulting log
