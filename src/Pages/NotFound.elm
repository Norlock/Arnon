module Pages.NotFound exposing(..)
import Html exposing (text)
import Browser
import Types

document : Browser.Document Types.Msg
document =
    { title = "Arnon shop framework"
    , body = [ text "404 Page not found" ]
    }
