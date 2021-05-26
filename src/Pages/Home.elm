module Pages.Home exposing (document)

import Browser
import Components.Footer as Footer
import Components.Header as Header
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


view : Types.Model -> Html Types.Msg
view model =
    div [ class "page-container" ]
        [ Header.header
        , productsView model
        , Footer.footer
        ]


document : Types.Model -> Browser.Document Types.Msg
document model =
    { title = "Arnon shop framework"
    , body = [ view model ]
    }


productsView : Types.Model -> Html Msg
productsView model =
    case model.products of
        Success list ->
            list
                |> List.map
                    (\product ->
                        div [ class "product-item" ]
                            [ a [ href ("/product/" ++ String.fromInt product.id) ]
                                [ img
                                    [ src "http://images6.fanpop.com/image/photos/41000000/38976356-cool-hd-wallpapers-bambidkar-41031277-2880-1800.jpg"
                                    , width 200
                                    , height 200
                                    ]
                                    []
                                , span [ class "title" ] [ text product.title ]
                                , span [ class "price" ] [ text (String.fromFloat product.price) ]
                                ]
                            ]
                    )
                |> div [ class "product-list" ]

        Loading ->
            div [ class "product-list" ] [ text "Products are loading" ]

        Failed ->
            div [ class "product-list" ] [ text "No products received" ]
