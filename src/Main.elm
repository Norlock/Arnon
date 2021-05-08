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
import Url.Parser as P exposing ((</>))
import Route exposing (Route)

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
init _ url _ = 
  ((initModel url), Cmd.none) 

initModel : Url.Url -> Models.Shared
initModel url =
  { product = Product.init, products = ProductList.init, home = Home.init, page = url } 

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
      let _ = Debug.log url.path 
      in
      ({ model | page = url }, Cmd.none)
    ClickedLink _ ->
      (model, Cmd.none)

subscriptions : Models.Shared -> Sub Msg
subscriptions _ =
  Sub.none

-- VIEW
view : Models.Shared -> Browser.Document Msg
view model =
  let _ = Debug.log "Route" (Route.parseUrl model.page)
  in
  case (Route.parseUrl model.page) of
    Route.Home -> 
      Home.document model
    Route.Product _ ->
      Product.document model
    Route.NotFound ->
      NotFound.document
