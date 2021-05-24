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

type alias Product = 
  { id: Int 
  , quantity: Int
  , title: String
  , description: String 
  , brand: String
  , size: String
  , price: Float
  , stock: Int
  }

type alias Model =
  { product: State Product
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
  | ChangedUrl Url.Url
  | ClickedLink Browser.UrlRequest
  | ReceivedProducts (Result Http.Error (List ProductItem))

type ProductMsg
  = Quantity String
  | Purchase
