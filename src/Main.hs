module Main where

import System.Environment (getArgs)
import System.Exit (exitFailure)
import Text.Read (readMaybe)

import LiveTracing

main :: IO ()
main = putStrLn "Please use the library version for now"

oldmain :: IO ()
oldmain = do
  args <- getArgs
  case args of
    [progname, portString] -> do
      let portInt = readMaybe portString :: Maybe Int
      case portInt of
        Just portNo -> do
          -- we have progname and portsring
          _ <- runProcess progname
          putStrLn "not much is happening right now"
        _ -> print "port unparasble" >> exitFailure
    _ -> print "proram and/or port name not supplied" >> exitFailure
