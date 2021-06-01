module Api exposing (..)

import Http
import Json.Decode as Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline exposing (hardcoded, required)
import Types exposing (..)
import Url exposing (Protocol(..))


fetchProductList : Cmd Msg
fetchProductList =
    Http.get
        { url = "http://localhost:8000/products"
        , expect = Http.expectJson ReceivedProductList productListDecoder
        }


fetchProduct : Id -> Cmd Msg
fetchProduct id =
    Http.get
        { url = "http://localhost:8000/product/" ++ String.fromInt id
        , expect = Http.expectJson ReceivedProduct productLargeDecoder
        }


productDecoder : Decoder ProductItem
productDecoder =
    Decode.succeed ProductItem
        |> required "id" int
        |> required "title" string
        |> required "description" string
        |> required "price" float
        |> required "stock" int


sizeVariantDecoder : Decoder SizeVariant
sizeVariantDecoder =
    Decode.succeed SizeVariant
        |> required "id" int
        |> required "size" string
        |> required "stock" int
        |> required "product_id" int
        |> required "price" float


colorVariantDecoder : Decoder ColorVariant
colorVariantDecoder =
    Decode.succeed ColorVariant
        |> required "id" int
        |> required "color" string
        |> required "stock" int
        |> required "product_id" int
        |> required "price" float


productDetailDecoder : Decoder ProductDetail
productDetailDecoder =
    Decode.succeed ProductDetail
        |> required "brand" string
        |> required "size" string
        |> required "size_variants" (list sizeVariantDecoder)
        |> required "color" string
        |> required "color_variants" (list colorVariantDecoder)


productListDecoder : Decoder (List ProductItem)
productListDecoder =
    list productDecoder


productLargeDecoder : Decoder ProductLarge
productLargeDecoder =
    Decode.succeed ProductLarge
        |> required "basic" productDecoder
        |> required "detail" productDetailDecoder
        |> hardcoded 1
