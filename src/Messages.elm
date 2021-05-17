module Messages exposing (..)
import Browser
import Url
import Http

type Msg
  = ForHome HomeMsg
  | ForProduct ProductMsg
  | ChangedUrl Url.Url
  | ClickedLink Browser.UrlRequest
  | FetchMsg

type HomeMsg
  = Increment
  | Decrement
  | Change String

type ProductMsg
  = Quantity String
  | Purchase

type FetchMsg
  = FetchProducts (Result Http.Error String)
