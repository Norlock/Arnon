module Main exposing (..)

import Api
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Error(..))
import Pages.Home as Home
import Pages.NotFound as NotFound
import Pages.Product as Product
import Result exposing (Result(..))
import Route
import Types exposing (..)
import Url exposing (Protocol(..))



-- MAIN


main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( initModel url key
    , Api.fetchProductList
    )


initModel : Url.Url -> Nav.Key -> Model
initModel url key =
    { product = Loading
    , products = Loading
    , url = url
    , key = key
    , dialog = None
    , shoppingCard = []
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ForProduct subMsg ->
            ( updateProduct model subMsg, Cmd.none )

        ForProductList subMsg ->
            ( updateProductList model subMsg, Cmd.none )

        ChangedUrl url ->
            { model | url = url }
                |> pageAction

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ReceivedProductList (Ok products) ->
            { model | products = Success products }
                |> pageAction

        ReceivedProductList (Err _) ->
            ( { model | products = Failed }, Cmd.none )

        ReceivedProduct (Ok product) ->
            ( { model | product = Success product }, Cmd.none )

        ReceivedProduct (Err _) ->
            ( { model | product = Failed }, Cmd.none )

        ToggleDialog dialogId ->
            ( { model | dialog = dialogId }, Cmd.none )


updateProduct : Model -> ProductMsg -> Model
updateProduct model msg =
    case model.product of
        Success product ->
            { model | product = Success (Product.update msg product) }

        _ ->
            model



-- Todo make filter function


updateProductList : Model -> ProductListMsg -> Model
updateProductList model msg =
    case msg of
        Filter _ ->
            model


pageAction : Model -> ( Model, Cmd Msg )
pageAction model =
    case model.products of
        Success products ->
            case Route.parseUrl model.url of
                Route.Product id ->
                    ( Product.setProduct model products id, Api.fetchProduct id )

                _ ->
                    ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


initProduct : Model -> Model
initProduct model =
    case model.products of
        Success products ->
            case Route.parseUrl model.url of
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
    case Route.parseUrl model.url of
        Route.Home ->
            Home.document model

        Route.Product _ ->
            Product.document model

        Route.NotFound ->
            NotFound.document
