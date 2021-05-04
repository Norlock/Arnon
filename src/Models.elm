module Models exposing (..)

type alias Main = 
  { count: Int, message: String }
    
type alias Product = 
  { quantity: Int, price: Int, purchase: Bool }

type alias Model =
  { main: Main,
    product: Product }
