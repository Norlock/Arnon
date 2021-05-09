module Components.ProductList exposing(..)
import Models
import Html exposing (..)
import Messages exposing (Msg)
import Html.Attributes exposing (..)
import String exposing (fromFloat)
import String exposing (fromInt)


init : Models.ProductList
init = 
  [ { id = 1, price = 20, title = "Shoes" } 
  , { id = 2, price = 25, title = "Dress" } 
  , { id = 3, price = 3.95, title = "Socks" } 
  , { id = 4, price = 15, title = "Shirts" } 
  , { id = 5, price = 45.95, title = "Pants" } 
  , { id = 6, price = 25, title = "Hats" } 
  , { id = 7, price = 15, title = "Bra's" } 
  , { id = 8, price = 15, title = "Underwear" } 
  , { id = 9, price = 25.95, title = "Polo's" } 
  , { id = 11, price = 25, title = "Sweaters" } 
  , { id = 12, price = 25, title = "Jackets" } 
  , { id = 13, price = 25, title = "Dress" } 
  , { id = 14, price = 25, title = "Dress" } 
  , { id = 15, price = 25, title = "Dress" } 
  , { id = 16, price = 25, title = "Dress" } 
  ]

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
