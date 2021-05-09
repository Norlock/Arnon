module Pages.Home exposing (init, update, document)
import Models
import Messages exposing (HomeMsg(..))
import Html exposing (..)
import Messages exposing (Msg)
import Components.ProductList as ProductList
import Components.Header as Header
import Html.Attributes exposing (..)
import Browser

init : Models.Home
init = 
  { count = 0, message = "test" } 

update : HomeMsg -> Models.Home -> Models.Home
update msg model =
  case msg of
    Increment ->
      { model | count = model.count + 1 } 
    Decrement ->
      { model | count = model.count - 1 }
    Change newMessage -> 
      { model | message = newMessage }

view : Models.Shared -> Html Msg
view model =
  div [ class "page-container" ]
    [ Header.header 
    , ProductList.view model.products
    ]

document : Models.Shared -> Browser.Document Msg
document model =
    { title = "Arnon shop framework"
    , body = [ view model ]
    }
