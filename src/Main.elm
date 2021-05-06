module Main exposing (..)

import Browser
import Browser.Navigation as Nav

import Styles
import Models 
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Debug exposing (log)
import Product.Product as Product
import Messages exposing (..)
import Url

-- MAIN
main =
  Browser.application { 
    init = init, 
    update = update, 
    view = view,
    subscriptions = subscriptions,
    onUrlChange = ChangedUrl,
    onUrlRequest = ClickedLink
  }

init : () -> Url.Url -> Nav.Key -> (Models.Model, Cmd msg )
init flags url key = 
  (rootModel, Cmd.none) 

rootModel : Models.Model
rootModel =
  { product = Product.init, main = initMain } 

update : Msg -> Models.Model -> (Models.Model, Cmd Msg)
update msg model =
  case msg of
    ForMain forMain ->
      ({ model | main = (updateMain forMain model.main) }
      , Cmd.none)
    ForProduct forProduct ->
      ({ model | product = (Product.update forProduct model.product) }
      , Cmd.none)
    ChangedUrl url ->
      (model, Cmd.none)
    ClickedLink req ->
      (model, Cmd.none)

subscriptions : Models.Model -> Sub Msg
subscriptions model =
  Sub.none

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

navbar : List String -> Html Msg
navbar tabTitles =
    tabTitles 
      |> List.map
        (\title ->
          li (Styles.navbarItem [class "nav-item"]) [ text title ]
        )
      |> ul (Styles.navbarList [])

header :  Html Msg
header = 
  div [] 
      [ h1 [] [text "Fashion store"]
      , div (Styles.navbar []) 
        [ navbar ["Home", "Fashion", "Discount", "Contact"] 
        , span (Styles.loginContainer []) [ text "login" ]
        ]
      ]

-- VIEW
view : Models.Model -> Browser.Document Msg
view model =
  { title = "Home"
  , body = [
    div (Styles.container [])
      [ header 
      , div [] [ text "Hello world!" ]
      , div [] [ Product.product model.product ]
      , node "link" [ rel "stylesheet", href "/css/index.css" ] []
      ]
    ]
  }

    --, button [ onClick Decrement ] [ text "-" ]
    --, div [] [ text (String.fromInt model.count) ]
    --, button [ onClick Increment ] [ text "+" ]
