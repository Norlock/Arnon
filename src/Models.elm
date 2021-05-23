module Models exposing (..)

import Browser.Navigation as Nav
import Url 

type alias Home = 
  { count: Int, message: String }
    
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

type alias ProductItem = 
  { id: Int
  , title: String
  , description: String
  , price: Float 
  , stock: Int 
  }

type alias ProductList = List ProductItem

type alias Shared =
  { home: Home,
    product: Maybe Product,
    products: ProductList,
    key: Nav.Key,
    url: Url.Url }

