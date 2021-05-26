module Pages.NotFound exposing (..)

import Browser
import Html exposing (text)
import Types


document : Browser.Document Types.Msg
document =
    { title = "Arnon shop framework"
    , body = [ text "404 Page not found" ]
    }
