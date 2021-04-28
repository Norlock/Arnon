module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Styles
import Debug exposing (log)

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
  | Hover


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model | count = model.count + 1 } 
    Decrement ->
      { model | count = model.count - 1 }
    Change newMessage -> 
      { model | message = newMessage }
    Hover -> 
      log "test"
      model

headerItem : String -> Html Msg
headerItem val =
    li (Styles.navbarItem [onMouseOver Hover]) [ text val ]

header : Model -> Html Msg
header model = 
  div []
    [ h1 [] [text "Fashion store"]
      , ul (Styles.navbar []) 
          [ headerItem "Home"
          , headerItem "Fashion" 
          , headerItem "Discount"
          , headerItem "Contact"
        ]
    ]

-- VIEW
view : Model -> Html Msg
view model =
  div (Styles.container [])
    [ header model
    , button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model.count) ]
    , button [ onClick Increment ] [ text "+" ]
    , div [] [ text "Hello world!" ]
    , div [] [ text ("Shop here! " ++ model.message) ]
    , input [ placeholder "shop name", value model.message, onInput Change] []
    , img [ 
      src "http://images6.fanpop.com/image/photos/41000000/38976356-cool-hd-wallpapers-bambidkar-41031277-2880-1800.jpg" 
      , width 500
      , height 500] []
    ]

