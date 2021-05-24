module Main exposing (..)

import Browser
import Browser.Navigation as Nav

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Pages.Home as Home
import Pages.Product as Product
import Pages.NotFound as NotFound

import Route
import Url exposing (Protocol(..))
import Api 
import Result exposing (Result(..))
import Json.Decode exposing (Error(..))
import Types exposing (..)

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

init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init _ url key = 
  ((initModel url key)
  , Api.fetchProducts
  ) 

initModel : Url.Url -> Nav.Key -> Model
initModel url key =
  { product = Loading, products = Loading , url = url
  , key = key } 

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ForProduct forProduct ->
      case model.product of 
        Success product ->
          ({ model | product = Success (Product.update forProduct product) }, Cmd.none)
        _ ->
          (model, Cmd.none)
    ChangedUrl url ->
      ({ model | url = url }
        |> initProduct, Cmd.none)
    ClickedLink urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )
        Browser.External href ->
          ( model, Nav.load href )
    ReceivedProducts (Ok result) ->
      (Product.setProductList model result 
        |> initProduct, Cmd.none)
    ReceivedProducts (Err _) ->
      ({ model | products = Failed}, Cmd.none)

initProduct : Model -> Model
initProduct model =
  case model.products of
    Success products -> 
      case (Route.parseUrl model.url) of
        Route.Product id -> 
          Product.setProduct model products id
        _ ->
          model
    _ -> 
      model


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

-- VIEW
view : Model -> Browser.Document Msg
view model =
  case (Route.parseUrl model.url) of
    Route.Home -> 
      Home.document model
    Route.Product _ ->
      Product.document model.product
    Route.NotFound ->
      NotFound.document
