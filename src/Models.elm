module Models exposing (..)
import Url 

type alias Home = 
  { count: Int, message: String }
    
type alias Product = 
  { quantity: Int, price: Int, purchase: Bool }


-- Models split by entities, (product, productlist, user, etc) 
type alias Shared =
  { home: Home,
    product: Product,
    page: Url.Url }
