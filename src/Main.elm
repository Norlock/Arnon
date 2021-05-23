module Main exposing (..)

import Browser
import Browser.Navigation as Nav

import Models 
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Components.ProductList as ProductList

import Pages.Home as Home
import Pages.Product as Product
import Pages.NotFound as NotFound

import Route
import Url exposing (Protocol(..))
import Messages exposing (..)
import Api 
import Result exposing (Result(..))
import Json.Decode exposing (Error(..))
import Maybe exposing (andThen)

-- MAIN
main =
  Browser.application { 
    init = init, 
    update = update, 
    view = view,
    subscriptions = subscriptions,
    onUrlChange = ChangedUrl,
    onUrlRequest = ClickedLink
  }

init : () -> Url.Url -> Nav.Key -> (Models.Shared, Cmd Msg)
init _ url key = 
  ((initModel url key)
  , Api.fetchProducts
  ) 

initModel : Url.Url -> Nav.Key -> Models.Shared
initModel url key =
  { product = Product.init, products = ProductList.init, home = Home.init, url = url
  , key = key } 

update : Msg -> Models.Shared -> (Models.Shared, Cmd Msg)
update msg model =
  case msg of
    ForHome forHome ->
      ({ model | home = Home.update forHome model.home }
      , Cmd.none)
    ForProduct forProduct ->
      case model.product of 
        Just product ->
          ({ model | product = Just (Product.update forProduct product) }, Cmd.none)
        Nothing ->
          (model, Cmd.none)
    ChangedUrl url ->
      ({ model | url = url }
        |> Product.setProduct, Cmd.none)
    ClickedLink urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )
        Browser.External href ->
          ( model, Nav.load href )
    ReceivedProducts (Ok result) ->
      (Product.setProductList model result 
        |> Product.setProduct, Cmd.none)
    ReceivedProducts (Err _) ->
      ( model, Cmd.none)

subscriptions : Models.Shared -> Sub Msg
subscriptions _ =
  Sub.none

-- VIEW
view : Models.Shared -> Browser.Document Msg
view model =
  case (Route.parseUrl model.url) of
    Route.Home -> 
      Home.document model
    Route.Product id ->
      Product.document model id
    Route.NotFound ->
      NotFound.document
