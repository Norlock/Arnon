module Messages exposing (..)
import Browser
import Url

type Msg
  = ForHome HomeMsg
  | ForProduct ProductMsg
  | ChangedUrl Url.Url
  | ClickedLink Browser.UrlRequest

type HomeMsg
  = Increment
  | Decrement
  | Change String

type ProductMsg
  = Quantity String
  | Purchase

