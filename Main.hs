module Main where

import Control.Monad (forever)
import qualified Data.Text          as T
import qualified Network.WebSockets as WS

main :: IO ()
main = do
  putStrLn "started echo on port 9160"
  WS.runServer "0.0.0.0" 9160 $ application

application :: WS.ServerApp
application pending = WS.acceptRequest pending >>= talk

talk :: WS.Connection -> IO ()
talk conn = forever $ do
  msg <- WS.receiveData conn
  WS.sendTextData conn $ "echo: " `T.append` msg
