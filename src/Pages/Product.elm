module Pages.Product exposing (document, init, update, setProduct, setProductList)

import Components.Header as Header
import Models
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe exposing (Maybe(..))
import Messages exposing (ProductMsg(..))
import Messages exposing (Msg(..))
import Html.Events exposing (onInput)
import Maybe exposing (Maybe(..))
import Route 

init : Maybe Models.Product
init = 
  Nothing

update : ProductMsg -> Models.Product -> Models.Product
update msg product =
  case msg of
    Quantity value ->
      { product | quantity = String.toInt value |> Maybe.withDefault 1 } 
    Purchase ->
      { product | stock = product.stock - 1 } 

document : Models.Shared -> Browser.Document Msg
document model =
    { title = "Arnon shop framework"
    , body = [ view model ]
    }

view : Models.Shared -> Html Msg
view model =
  case model.product of 
    Just product -> 
      div [ class "page-container" ]
        [ Header.header 
        , productView product
        ]
    Nothing -> 
      div [ class "page-container" ]
        [ Header.header 
        , text "No product"
        ]

productView : Models.Product -> Html Msg
productView model = 
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
      [ span [] [ text ("Price: " ++ String.fromFloat (calculatePrice model)) ] 
      , label [] [ text "Quantity" ]
      , input [ type_ "number"
              , value (String.fromInt model.quantity)
              , onInput (ForProduct << Quantity)
              , Html.Attributes.min "1"] [ ]
      , button [] [ text "Purchase" ]
      ]
    ]
    
calculatePrice : Models.Product -> Float
calculatePrice model =
  toFloat model.quantity * model.price

getElementById : Models.ProductList -> Int -> Maybe Models.ProductItem 
getElementById productList id =
    case productList of
      (element::tail) ->
        if element.id == id then
           Just element
        else
          getElementById tail id
      [] ->
        Nothing

setProductList : Models.Shared -> List Models.ProductItem -> Models.Shared 
setProductList model products =
  { model | products = products }

setProduct : Models.Shared -> Models.Shared 
setProduct model =
  case Route.parseUrl model.url of 
    Route.Product id -> 
      case (getElementById model.products id) of
        Just res -> 
          { model | product = Just (convertItemToProduct res) }
        Nothing ->
          model
    _ ->
      model

convertItemToProduct : Models.ProductItem -> Models.Product 
convertItemToProduct item =
  { id = item.id
  , quantity = 1
  , title = item.title
  , description = item.description
  , brand = ""
  , size = ""
  , price = item.price
  , stock = item.stock
  }
