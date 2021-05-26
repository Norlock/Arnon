module Pages.Product exposing (document, init, update, setProduct)

import Components.Header as Header
import Components.Footer as Footer
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Maybe exposing (Maybe(..))
import Types exposing (..)

init : Maybe ProductLarge
init = 
  Nothing

update : ProductMsg -> ProductLarge -> ProductLarge
update msg productLarge =
  let basic = productLarge.basic
  in
  case msg of
    Quantity value ->
      { productLarge | quantity = String.toInt value |> Maybe.withDefault 1 } 
    Purchase ->
      { productLarge | basic = setStock basic (basic.stock - 1) } 

setStock : ProductItem -> Int -> ProductItem
setStock product stock =
  { product | stock = stock } 

document : Types.State ProductLarge -> Browser.Document Msg
document state =
  { title = "Arnon shop framework"
  , body = [ view state ]
  }

view : Types.State ProductLarge -> Html Msg
view state =
  case state of 
    Types.Success product ->
      div [ class "page-container" ]
        [ Header.header 
        , breadcrumb
        , productView product
        , Footer.footer
        ]
    _ -> 
      div [ class "page-container" ]
        [ Header.header 
        , breadcrumb
        , text "No product"
        , Footer.footer
        ]

productView : ProductLarge -> Html Msg
productView productLarge = 
  let basic = productLarge.basic 
  in
  div [ class "product" ]
    [ div [ class "left" ]
      [ span [] [text basic.title]
      , span [] [text basic.description]
      , img 
        [ src "http://images6.fanpop.com/image/photos/41000000/38976356-cool-hd-wallpapers-bambidkar-41031277-2880-1800.jpg" 
        , width 300
        , height 300] []
      ]
    , div [ class "right" ]
      [ span [] [ text ("Price: " ++ String.fromFloat (calculatePrice productLarge)) ] 
      , label [] [ text "Quantity" ]
      , input [ type_ "number"
              , value (String.fromInt productLarge.quantity)
              , onInput (ForProduct << Quantity)
              , Html.Attributes.min "1"] [ ]
      , button [] [ text "Purchase" ]
      ]
    ]

breadcrumb : Html Msg
breadcrumb =
  ul [ class "breadcrumb" ] 
    [ li [] 
      [ a [ href "/" ] [ text "> products" ]
      ]
    ]
    
calculatePrice : ProductLarge -> Float
calculatePrice model =
  toFloat model.quantity * model.basic.price
    |> (\n -> n * (10 ^ 2)  / (10 ^ 2))

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

setProduct : Model -> List ProductItem -> Int -> Model 
setProduct model products id =
  case (getElementById products id) of
    Just res -> 
      { model | product = Success (convertItemToProduct res) }
    Nothing ->
      model

convertItemToProduct : ProductItem -> ProductLarge 
convertItemToProduct item =
  { basic = item
  , detail = 
    { brand = ""
    , size = ""
    , color = ""
    }
  , quantity = 1
  }
