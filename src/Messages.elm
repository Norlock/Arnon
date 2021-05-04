module Messages exposing (..)

type Msg
  = ForMain MainMsg
  | ForProduct ProductMsg

type MainMsg
  = Increment
  | Decrement
  | Change String
  | Hover

type ProductMsg
  = Quantity String
  | Purchase

