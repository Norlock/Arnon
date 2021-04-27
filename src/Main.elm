module Main exposing (..)
import Browser
import Card exposing (..)
import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model = 
  { count: Int, message: String }
    

init : Model
init = 
  { count = 0, message = "test" } 

-- UPDATE
type Msg
  = Increment
  | Decrement
  | Change String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model | count = model.count + 1 } 
    Decrement ->
      { model | count = model.count - 1 }
    Change newMessage -> 
      { model | message = newMessage }

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model.count) ]
    , button [ onClick Increment ] [ text "+" ]
    , div [] [ text "Hello world!" ]
    , div [] [ text ("Shop here! " ++ model.message) ]
    , input [ placeholder "shop name", value model.message, onInput Change] []
    ]

