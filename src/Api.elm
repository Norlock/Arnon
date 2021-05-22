module Api exposing(..)
import Url exposing (Protocol(..))
import Http
import Messages exposing (Msg(..))
import Json.Decode exposing (Decoder, string, list, float, field, int, map5)
import Models exposing (ProductItem)

fetchProducts : Cmd Msg 
fetchProducts =
  Http.get 
    { url = "http://localhost:8000/products"
    , expect = Http.expectJson GotProducts productListDecoder
    }

productDecoder: Decoder ProductItem
productDecoder = 
  map5 ProductItem
    (field "id" int)
    (field "title" string)
    (field "description" string)
    (field "price" float)
    (field "stock" int)

productListDecoder: Decoder (List ProductItem)
productListDecoder =
  list productDecoder
