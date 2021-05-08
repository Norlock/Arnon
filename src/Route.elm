module Route exposing (Route(..), parseUrl)

import Url.Parser exposing (..)
import Url exposing (Url)

type Route 
  = Home
  | Product Int
  | NotFound

parseUrl : Url -> Route
parseUrl url =
    case parse matchRoute url of
        Just route ->
            route
        Nothing ->
            NotFound


matchRoute : Parser (Route -> a) a
matchRoute =
  oneOf
    [ map Home top
    , map Product (s "product" </> int)
    ]

