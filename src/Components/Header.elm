module Components.Header exposing (header)

import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Tuple exposing (first, second)
import Types exposing (..)


navbar : List ( String, String ) -> Html Msg
navbar tabs =
    tabs
        |> List.map
            (\tuple ->
                li []
                    [ a
                        [ href (second tuple), class "navbar-item" ]
                        [ text (first tuple)
                        ]
                    ]
            )
        |> ul [ class "navbar-list" ]


header : Model -> Html Msg
header model =
    div [ class "header" ]
        [ h1 [] [ text "Fashion store" ]
        , div [ class "navbar" ]
            [ navbar [ ( "Home", "/" ), ( "Fashion", "/" ), ( "Discount", "/" ), ( "Contact", "/" ) ]
            , div [ class "search" ]
                [ input
                    [ type_ "text"
                    , placeholder "search for a product"
                    , onInput (ForProductList << Filter)
                    ]
                    []
                ]
            , rightHeader model
            ]
        ]


rightHeader : Model -> Html Msg
rightHeader model =
    div [ class "header-right" ]
        [ div [ class "card-container" ]
            [ span [ class "icon fas fa-shopping-cart" ] []
            , span [ class "count" ] [ text (String.fromInt (quantityTotal model)) ]
            ]
        , span [ class "login-container" ] [ text "login" ]
        ]


quantityTotal : Model -> Int
quantityTotal model =
    model.shoppingCard
        |> Dict.values
        |> calculateSum 0


calculateSum : Int -> List ShoppingCardItem -> Int
calculateSum sum list =
    case list of
        [] ->
            sum

        element :: tail ->
            calculateSum (sum + element.quantity) tail
