module Pages.NotFound exposing(..)
import Html exposing (text)
import Browser
import Messages exposing (Msg)

document : Browser.Document Msg
document =
    { title = "Arnon shop framework"
    , body = [ text "404 Page not found" ]
    }
