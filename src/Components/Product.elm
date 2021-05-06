module Components.Product exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Components.Styles as Styles
import Models
import Messages exposing(..)
import String exposing (fromInt)

init : Models.Product
init = 
  { quantity = 1, price = 20, purchase = False } 

update : ProductMsg -> Models.Product -> Models.Product
update msg model =
  case msg of
    Quantity value ->
      { model | quantity = String.toInt value |> Maybe.withDefault 1 } 
    Purchase ->
      { model | purchase = True } 

calculatePrice : Models.Product -> Int
calculatePrice model =
  model.quantity * model.price

product : Models.Product -> Html Msg
product model = 
  div (Styles.container [])
    [ div (Styles.left []) 
      [ span [] [text "Shoes"]
      , span [] [text "Very good looking shoes"]
      , img 
        [ src "http://images6.fanpop.com/image/photos/41000000/38976356-cool-hd-wallpapers-bambidkar-41031277-2880-1800.jpg" 
        , width 300
        , height 300] []
      ]
    , div (Styles.right [])
      [ span [] [ text ("Price: " ++ fromInt (calculatePrice model)) ] 
      , label [] [ text "Quantity" ]
      , input [ type_ "number"
              , value (String.fromInt model.quantity)
              , onInput (ForProduct << Quantity)
              , Html.Attributes.min "1"] [ ]
      , button [] [ text "Purchase" ]
      ]
    ]

