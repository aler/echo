module Echo (echo) where

import Data.Text

echo :: Text -> Text
echo msg = "echo: " `append` msg
