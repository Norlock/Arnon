module Types exposing (..)

import Browser
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Html exposing (Html)
import Http
import Url


type alias ShoppingCardItem =
    { id : Id
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


type alias ColorVariant =
    { id : Id
    , color : String
    , stock : Int
    , productId : Int
    , price : Float
    }


type alias SizeVariant =
    { id : Id
    , size : String
    , stock : Int
    , productId : Int
    , price : Float
    }


type alias ProductDetail =
    { brand : String
    , size : String
    , sizes : List SizeVariant
    , color : String
    , colors : List ColorVariant
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
    , shoppingCard : Dict Id ShoppingCardItem
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
    | Purchase ShoppingCardItem


type ProductListMsg
    = Filter String


type ProductMsg
    = Quantity String
