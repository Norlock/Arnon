module Api exposing(..)
import Url exposing (Protocol(..))
import Http
import Json.Decode exposing (Decoder, string, list, float, field, int, map5)
import Types exposing (ProductItem)
import Types exposing (Msg(..))

fetchProducts : Cmd Msg 
fetchProducts =
  Http.get 
    { url = "http://localhost:8000/products"
    , expect = Http.expectJson ReceivedProducts productListDecoder
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
