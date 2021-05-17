module Components.Product exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Models
import Messages exposing(..)
import String exposing (fromInt)

init : Models.Product
init = 
  { quantity = 1, price = 20, stock = 3, title = "Shoes", description = "Very good looking shoes" } 

update : ProductMsg -> Models.Product -> Models.Product
update msg model =
  case msg of
    Quantity value ->
      { model | quantity = String.toInt value |> Maybe.withDefault 1 } 
    Purchase ->
      { model | stock = model.stock - 1 } 

calculatePrice : Models.Product -> Int
calculatePrice model =
  model.quantity * model.price

view : Models.Product -> Html Msg
view model = 
  div [ class "product" ]
    [ div [ class "left" ]
      [ span [] [text model.title]
      , span [] [text model.description]
      , img 
        [ src "http://images6.fanpop.com/image/photos/41000000/38976356-cool-hd-wallpapers-bambidkar-41031277-2880-1800.jpg" 
        , width 300
        , height 300] []
      ]
    , div [ class "right" ]
      [ span [] [ text ("Price: " ++ fromInt (calculatePrice model)) ] 
      , label [] [ text "Quantity" ]
      , input [ type_ "number"
              , value (String.fromInt model.quantity)
              , onInput (ForProduct << Quantity)
              , Html.Attributes.min "1"] [ ]
      , button [] [ text "Purchase" ]
      ]
    ]

