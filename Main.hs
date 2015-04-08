module Main where

import Control.Monad (forever)
import Network.HTTP.Types (status200)
import qualified Data.Text                      as T
import qualified Network.WebSockets             as WS
import qualified Network.Wai                    as Wai
import qualified Network.Wai.Handler.Warp       as Warp
import qualified Network.Wai.Handler.WebSockets as WaiWS

main :: IO ()
main = do
  putStrLn "started echo on port 9160"
  Warp.run 9160 $
    WaiWS.websocketsOr WS.defaultConnectionOptions wsapp backapp

wsapp :: WS.ServerApp
wsapp pending = WS.acceptRequest pending >>= talk

backapp :: Wai.Application
backapp _ respond = respond $
  Wai.responseLBS status200 [("Content-Type", "text/plain")] "Hello World"

talk :: WS.Connection -> IO ()
talk conn = forever $ do
  msg <- WS.receiveData conn
  WS.sendTextData conn $ "echo: " `T.append` msg
