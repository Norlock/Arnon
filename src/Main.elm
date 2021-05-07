module Main exposing (..)

import Browser
import Browser.Navigation as Nav

import Models 
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Debug exposing (log)
import Components.Product as Product
import Pages.Home as Home
import Messages exposing (..)
import Url

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
  { product = Product.init, home = Home.init, page = url } 

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
-- 
view : Models.Shared -> Browser.Document Msg
view model =
  let _ = Debug.log model.page.path
  in
  if model.page.path == "src/Home.elm" then
    { title = "Home"
    , body = [ Home.view model ]
    }
  else
    { title = "Not Found"
    ,  body = [ Home.view model ]
    }
  --{ title = "Home"
  --, body = [
    --div (Styles.container [])
      --[ header 
      --, div [] [ text "Hello world!" ]
      --, div [] [ Product.product model.product ]
      --, node "link" [ rel "stylesheet", href "/css/index.css" ] []
      --]
    --]
  --}
