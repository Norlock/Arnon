module Main exposing (..)

import Browser
import Browser.Navigation as Nav

import Models 
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Components.Product as Product
import Components.ProductList as ProductList

import Pages.Home as Home
import Pages.Product as Product
import Pages.NotFound as NotFound

import Messages exposing (..)
import Url
import Route
import Url exposing (Protocol(..))
import Http
import Messages exposing (FetchMsg(..))
import Json.Decode exposing (Decoder)
import Json.Decode exposing (field)
import Json.Decode exposing (string)

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

init : () -> Url.Url -> Nav.Key -> (Models.Shared, Cmd msg )
init _ url key = 
  ((initModel url key)
  , Http.get 
      { url = "http:localhost:8000/products"
      , expect = Http.expectJson FetchProducts productsDecoder
      }
  ) 

productsDecoder : Decoder String
productsDecoder =
  field "data" (field "image_url" string)

initModel : Url.Url -> Nav.Key -> Models.Shared
initModel url key =
  { product = Product.init, products = ProductList.init, home = Home.init, url = url
  , key = key } 

update : Msg -> Models.Shared -> (Models.Shared, Cmd Msg)
update msg model =
  case msg of
    ForHome forHome ->
      ({ model | home = (Home.update forHome model.home) }
      , Cmd.none)
    ForProduct forProduct ->
      ({ model | product = (Product.update forProduct model.product) }
      , Cmd.none)
    ChangedUrl url ->
      ({ model | url = url }, Cmd.none)
    ClickedLink urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )
        Browser.External href ->
          ( model, Nav.load href )


subscriptions : Models.Shared -> Sub Msg
subscriptions _ =
  Sub.none

-- VIEW
view : Models.Shared -> Browser.Document Msg
view model =
  case (Route.parseUrl model.url) of
    Route.Home -> 
      Home.document model
    Route.Product _ ->
      Product.document model
    Route.NotFound ->
      NotFound.document
