module Components.ProductList exposing(..)
import Models
import Html exposing (..)
import Messages exposing (Msg)
import Html.Attributes exposing (..)
import String exposing (fromFloat)
import String exposing (fromInt)


init : Models.ProductList
init = 
  []

view : Models.ProductList -> Html Msg
view model = 
  model 
    |> List.map
      (\product ->
        div [ class "product-item" ]
          [ a [ href ("/product/" ++ fromInt product.id) ] 
            [ img 
              [ src "http://images6.fanpop.com/image/photos/41000000/38976356-cool-hd-wallpapers-bambidkar-41031277-2880-1800.jpg" 
              , width 200
              , height 200] []
            , span [class "title"] [text product.title]
            , span [class "price"] [text (fromFloat product.price)]
            ]
          ]
        )
    |> div [ class "product-list"] 
