module Pages.Home exposing (..)
import Models
import Messages exposing (HomeMsg(..))
import Html exposing (..)
import Messages exposing (Msg)
import Components.Product as Product
import Components.Header as Header
import Html.Attributes exposing (..)

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
    , div [] [ Product.product model.product ]
    ]
