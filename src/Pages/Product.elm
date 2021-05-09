module Pages.Product exposing (..)

import Components.Product as Product
import Components.Header as Header
import Models
import Messages exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (class)
import Browser

view : Models.Shared -> Html Msg
view model =
  div [ class "page-container" ]
    [ Header.header 
    , Product.view model.product
    ]

document : Models.Shared -> Browser.Document Msg
document model =
    { title = "Arnon shop framework"
    , body = [ view model ]
    }
