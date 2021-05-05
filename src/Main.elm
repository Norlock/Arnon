module Main exposing (..)

import Browser
import Styles
import Models 
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Debug exposing (log)
import Product.Product as Product
import Messages exposing (..)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

init : Models.Model
init = 
  { product = Product.init, main = initMain } 

update : Msg -> Models.Model -> Models.Model
update msg model =
  case msg of
    ForMain forMain ->
      { model | main = (updateMain forMain model.main) }
    ForProduct forProduct ->
      { model | product = (Product.update forProduct model.product) }

initMain : Models.Main
initMain = 
  { count = 0, message = "test" } 

updateMain : MainMsg -> Models.Main -> Models.Main
updateMain msg model =
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
headerItem tabTitle =
    li (Styles.navbarItem [onMouseOver (ForMain Hover), class "nav-item"]) [ text tabTitle ]

header :  Html Msg
header = 
  div [] 
      [ h1 [] [text "Fashion store"]
      , node "link" [ rel "stylesheet", href "/css/index.css" ] []
      , div (Styles.navbar []) 
        [ ul (Styles.navbarList []) 
          [ headerItem "Home"
          , headerItem "Fashion" 
          , headerItem "Discount"
          , headerItem "Contact" 
          ]
        , span (Styles.loginContainer []) [ text "login" ]
        ]
      ]

-- VIEW
view : Models.Model -> Html Msg
view model =
  div (Styles.container [])
    [ header 
    , div [] [ text "Hello world!" ]
    , div [] 
      [ Product.product model.product ]
    ]

    --, button [ onClick Decrement ] [ text "-" ]
    --, div [] [ text (String.fromInt model.count) ]
    --, button [ onClick Increment ] [ text "+" ]
