module Types exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html)
import Http
import Url


type alias ShoppingCardItem =
    { id : Int
    , title : String
    , description : String
    , price : Float
    , quantity : Int
    }


type alias ProductItem =
    { id : Int
    , title : String
    , description : String
    , price : Float
    , stock : Int
    }



-- TODO impl variants


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
    , dialog : DialogId
    , shoppingCard : List ProductItem
    }


type alias DialogData =
    { dialog : DialogId
    , title : String
    , body : Html Msg
    }


type alias Title =
    String


type DialogId
    = ShoppingCard
    | None


type alias Id =
    Int


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
    | ToggleDialog DialogId


type ProductListMsg
    = Filter String


type ProductMsg
    = Quantity String
    | Purchase
