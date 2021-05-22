module Messages exposing (..)
import Browser
import Url
import Http
import Models exposing (ProductItem)

type Msg
  = ForHome HomeMsg
  | ForProduct ProductMsg
  | ChangedUrl Url.Url
  | ClickedLink Browser.UrlRequest
  | GotProducts (Result Http.Error (List ProductItem))

type HomeMsg
  = Increment
  | Decrement
  | Change String

type ProductMsg
  = Quantity String
  | Purchase
