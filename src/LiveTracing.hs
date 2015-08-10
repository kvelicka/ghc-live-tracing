module LiveTracing (

  runProcess
) where

import Network.Socket
import System.IO (Handle)
import System.Posix.IO
import System.Posix.Types
import System.Process (spawnProcess)

-- | Runs an executable in the same dir and returns the socket's handle
-- to be passed to ghc-events.
-- The executable should have been compiled with
--     ghc -O -eventlog -rtsopts <FILENAME> --make
-- and will only work with Karolis's modified ghc.
-- Currently will connect to 127.0.0.1:44444 but will be generalised later
runProcess :: String -> IO Handle
runProcess procname = do
  eventlogFd <- connectFdSocket "127.0.0.1" 44444
  print $ "fd is " ++ show eventlogFd
  _ <- spawnProcess ("./" ++ procname) (flags eventlogFd)
  fdToHandle (Fd $ fromIntegral eventlogFd)

-- Connects to a socket to stream the event log and returns the fd of it
connectFdSocket :: String -> Int -> IO Int
connectFdSocket host portno = withSocketsDo $ do
  addrInfo <- getAddrInfo Nothing (Just host) (Just $ show portno)
  let serverAddr = head addrInfo
  sock <- socket (addrFamily serverAddr) Stream defaultProtocol
  let sockFd = fromIntegral $ fdSocket sock
  connect sock (addrAddress serverAddr)
  return sockFd

-- compiles the list of necessary arguments to run the program
flags :: Int -> [String]
flags fdno = ["+RTS", "-l", "-m" ++ show fdno]
