module Models exposing (..)
import Url 

type alias Home = 
  { count: Int, message: String }
    
type alias Product = 
  { quantity: Int, price: Int, purchase: Bool, title: String, description: String }

type alias ProductItem = { id: Int, title: String, price: Float }

type alias ProductList = List ProductItem


-- Models split by entities, (product, productlist, user, etc) 
type alias Shared =
  { home: Home,
    product: Product,
    products: ProductList,
    page: Url.Url }
