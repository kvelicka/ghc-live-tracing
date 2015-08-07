import GHC.RTS.Trace
import Foreign.C

foreign import ccall "getTraceFd"
    c_getTraceFd :: IO ()

foreign import ccall "getEventLogState"
    c_getEventLogState :: IO Bool

foreign import ccall "dec_flag"
    c_dec_flag :: IO ()

foreign import ccall "inc_flag"
    c_inc_flag :: IO ()

foreign import ccall "inspect_flag"
    c_inspect_flag :: IO CInt

main = do
    c_getTraceFd
    state <- c_getEventLogState
    if state
      then print "got state!"
      else print "no state"
    c_inc_flag
    c_inc_flag
    c_inc_flag
    c_inc_flag
    c_inc_flag
    c_inc_flag
    value <- c_inspect_flag
    print value
