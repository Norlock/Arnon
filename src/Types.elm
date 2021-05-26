module Types exposing (..)

import Browser.Navigation as Nav
import Url 
import Browser
import Http

type alias ProductItem = 
  { id: Int
  , title: String
  , description: String
  , price: Float 
  , stock: Int 
  }

type alias ProductDetail = 
  { brand: String
  , size: String
  , color: String
  }

type alias ProductLarge = 
  { basic: ProductItem
  , detail: ProductDetail
  , quantity: Int
  }

type alias Model =
  { product: State ProductLarge
  , products: State (List ProductItem)
  , key: Nav.Key
  , url: Url.Url 
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
  | ReceivedProducts (Result Http.Error (List ProductItem))

type ProductListMsg 
  = Filter String

type ProductMsg
  = Quantity String
  | Purchase
