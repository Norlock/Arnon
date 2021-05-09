module Example exposing (..)

import Expect 
import Fuzz exposing (string)
import Test exposing (..)
import Url exposing (fromString)
import Maybe exposing (Maybe(..))
import Route

matchesProductRoute : Url.Url -> Expect.Expectation
matchesProductRoute url =
  case (Route.parseUrl url) of 
    Route.Product _ ->
      Expect.pass
    Route.Home ->
      Expect.fail "wrong route"
    Route.NotFound ->
      Expect.fail "wrong route"


suite : Test
suite =
    describe "The Route module "
        [ test "It parses the url" <|
            \_ ->
                let url = fromString "http://localhost.com/product/1"
                in
                  case url of 
                    Just route ->
                      matchesProductRoute route
                    Nothing ->
                      Expect.fail "Incorrect test route"

        -- Expect.equal is designed to be used in pipeline style, like this.
        , test "reverses a known string" <|
            \_ ->
                "ABCDEFG"
                    |> String.reverse
                    |> Expect.equal "GFEDCBA"

        -- fuzz runs the test 100 times with randomly-generated inputs!
        , fuzz string "restores the original string if you run it again" <|
            \randomlyGeneratedString ->
                randomlyGeneratedString
                    |> String.reverse
                    |> String.reverse
                    |> Expect.equal randomlyGeneratedString
        ]
