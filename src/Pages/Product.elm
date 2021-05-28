module Pages.Product exposing (document, init, setProduct, update)

import Browser
import Components.Dialog as Dialog
import Components.Footer as Footer
import Components.Header as Header
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Maybe exposing (Maybe(..))
import Types exposing (..)


init : Maybe ProductLarge
init =
    Nothing


update : ProductMsg -> ProductLarge -> ProductLarge
update msg product =
    let
        basic =
            product.basic
    in
    case msg of
        Quantity value ->
            { product | quantity = String.toInt value |> Maybe.withDefault 1 }

        Purchase ->
            { product | basic = setStock basic (basic.stock - 1) }


setStock : ProductItem -> Int -> ProductItem
setStock product stock =
    { product | stock = stock }


document : Model -> Browser.Document Msg
document state =
    { title = "Arnon shop framework"
    , body = [ view state ]
    }


view : Model -> Html Msg
view model =
    case model.product of
        Success product ->
            div [ class "page-container" ]
                [ Header.header
                , breadcrumb
                , productView product model.dialog
                , Footer.footer
                ]

        _ ->
            div [ class "page-container" ]
                [ Header.header
                , breadcrumb
                , text "No product"
                , Footer.footer
                ]


productView : ProductLarge -> DialogId -> Html Msg
productView productLarge dialogId =
    let
        basic =
            productLarge.basic

        detail =
            productLarge.detail
    in
    div [ class "product" ]
        [ div [ class "left" ]
            [ span [] [ text basic.title ]
            , span [] [ text basic.description ]
            , img
                [ src "http://images6.fanpop.com/image/photos/41000000/38976356-cool-hd-wallpapers-bambidkar-41031277-2880-1800.jpg"
                , width 300
                , height 300
                ]
                []
            , div [ class "color-container" ]
                [ span [ class "color-label" ] [ text "Color" ]
                , showColors detail.colors
                ]
            ]
        , div [ class "right" ]
            [ span [] [ text ("Price: €" ++ String.fromFloat (calculatePrice productLarge)) ]
            , label [] [ text "Quantity" ]
            , input
                [ type_ "number"
                , value (String.fromInt productLarge.quantity)
                , onInput (ForProduct << Quantity)
                , Html.Attributes.min "1"
                ]
                []
            , button [ onClick (ToggleDialog ShoppingCard) ] [ text "Purchase" ]
            ]
        , dialog dialogId
        ]


dialog : DialogId -> Html Msg
dialog dialogId =
    let
        body =
            div []
                [ text "Order now for free delivery"
                ]

        data =
            { title = "Product is added to your shopping card"
            , body = body
            , dialog = ShoppingCard
            }
    in
    Dialog.dialog dialogId data


showColors : List String -> Html Msg
showColors colors =
    colors
        |> List.map
            (\color ->
                div [ class "product-color", style "background-color" color ] []
            )
        |> div [ class "product-color-bar" ]


breadcrumb : Html Msg
breadcrumb =
    ul [ class "breadcrumb" ]
        [ li []
            [ a [ href "/" ] [ text "> products" ]
            ]
        ]


calculatePrice : ProductLarge -> Float
calculatePrice model =
    toFloat model.quantity
        * model.basic.price
        |> (\n -> n * (10 ^ 2) / (10 ^ 2))


getElementById : List ProductItem -> Int -> Maybe ProductItem
getElementById productList id =
    case productList of
        element :: tail ->
            if element.id == id then
                Just element

            else
                getElementById tail id

        [] ->
            Nothing


setProduct : Model -> List ProductItem -> Int -> Model
setProduct model products id =
    case getElementById products id of
        Just res ->
            { model | product = Success (convertItemToProduct res) }

        Nothing ->
            model


convertItemToProduct : ProductItem -> ProductLarge
convertItemToProduct item =
    { basic = item
    , detail =
        { brand = ""
        , size = ""
        , colors = []
        }
    , quantity = 1
    }
