module Main where

import Echo
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "echo" $ do
    it "should add echo prefix" $ do
      echo "message" `shouldBe` "echo: message"
