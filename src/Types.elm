module Types exposing (..)

import Browser
import Browser.Navigation as Nav
import Http
import Url


type alias ProductItem =
    { id : Int
    , title : String
    , description : String
    , price : Float
    , stock : Int
    }


type alias ProductDetail =
    { brand : String
    , size : String
    , colors : List String
    }


type alias ProductLarge =
    { basic : ProductItem
    , detail : ProductDetail
    , quantity : Int
    }


type alias Model =
    { product : State ProductLarge
    , products : State (List ProductItem)
    , key : Nav.Key
    , url : Url.Url
    }


type State a
    = Loading
    | Failed
    | Success a


type Msg
    = ForProduct ProductMsg
    | ForProductList ProductListMsg
    | ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | ReceivedProductList (Result Http.Error (List ProductItem))
    | ReceivedProduct (Result Http.Error ProductLarge)


type ProductListMsg
    = Filter String


type ProductMsg
    = Quantity String
    | Purchase
