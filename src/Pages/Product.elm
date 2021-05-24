module Pages.Product exposing (document, init, update, setProduct, setProductList)

import Components.Header as Header
import Types
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Maybe exposing (Maybe(..))
import Types exposing (..)

init : Maybe Types.Product
init = 
  Nothing

update : ProductMsg -> Product -> Product
update msg product =
  case msg of
    Quantity value ->
      { product | quantity = String.toInt value |> Maybe.withDefault 1 } 
    Purchase ->
      { product | stock = product.stock - 1 } 

document : Types.State Product -> Browser.Document Msg
document state =
  { title = "Arnon shop framework"
  , body = [ view state ]
  }

view : Types.State Product -> Html Msg
view state =
  case state of 
    Types.Success product ->
      div [ class "page-container" ]
        [ Header.header 
        , productView product
        ]
    _ -> 
      div [ class "page-container" ]
        [ Header.header 
        , text "No product"
        ]

productView : Product -> Html Msg
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
    
calculatePrice : Product -> Float
calculatePrice model =
  toFloat model.quantity * model.price

getElementById : List ProductItem -> Int -> Maybe ProductItem 
getElementById productList id =
    case productList of
      (element::tail) ->
        if element.id == id then
           Just element
        else
          getElementById tail id
      [] ->
        Nothing

setProductList : Model -> List ProductItem -> Model 
setProductList model products =
  { model | products = Success products }

setProduct : Model -> List ProductItem -> Int -> Model 
setProduct model products id =
  case (getElementById products id) of
    Just res -> 
      { model | product = Success (convertItemToProduct res) }
    Nothing ->
      model

convertItemToProduct : ProductItem -> Product 
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
