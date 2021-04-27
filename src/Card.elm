module Card exposing (..)
import Browser
import Html exposing (Html, div, text)

-- MAIN
card =
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

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model | count = model.count + 1 } 
    Decrement ->
      { model | count = model.count - 1 }

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ div [] [ text "Hello world!" ]
    ]
