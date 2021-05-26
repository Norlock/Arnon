module Api exposing(..)
import Url exposing (Protocol(..))
import Http
import Types exposing (..)

import Json.Decode as Decode exposing (Decoder, int, string, float, list)
import Json.Decode.Pipeline exposing (required, hardcoded)

fetchProductList : Cmd Msg 
fetchProductList =
  Http.get 
    { url = "http://localhost:8000/products"
    , expect = Http.expectJson ReceivedProducts productListDecoder
    }

fetchProduct : Int -> Cmd Msg 
fetchProduct id =
  Http.get 
    { url = ("http://localhost:8000/product/" ++ String.fromInt id)
    , expect = Http.expectJson ReceivedProducts productListDecoder
    }

productDecoder : Decoder ProductItem
productDecoder = 
  Decode.succeed ProductItem
    |> required "id" int
    |> required "title" string
    |> required "description" string
    |> required "price" float
    |> required "stock" int

productDetailDecoder : Decoder ProductDetail
productDetailDecoder = 
  Decode.succeed ProductDetail
    |> required "brand" string
    |> required "size" string
    |> required "color" string

productListDecoder : Decoder (List ProductItem)
productListDecoder =
  list productDecoder

productLargeDecoder : Decoder ProductLarge
productLargeDecoder =
  Decode.succeed ProductLarge
    |> required "basic" productDecoder
    |> required "detail" productDetailDecoder
    |> hardcoded 1
