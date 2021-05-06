module Messages exposing (..)
import Browser
import Url

type Msg
  = ForMain MainMsg
  | ForProduct ProductMsg
  | ChangedUrl Url.Url
  | ClickedLink Browser.UrlRequest

type MainMsg
  = Increment
  | Decrement
  | Change String

type ProductMsg
  = Quantity String
  | Purchase

