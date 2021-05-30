module Pages.ShoppingCard exposing (..)

import Browser
import Html exposing (..)
import Types exposing (..)


document : Model -> Browser.Document Msg
document state =
    { title = "Arnon shop framework"
    , body = [ view state ]
    }


view : Model -> Html Msg
view model =
    if List.length model.shoppingCard == 0 then
        viewNoItems

    else
        viewItems model


viewItems : Model -> Html Msg
viewItems model =
    model.shoppingCard
        |> List.map shoppingCardItem
        |> div []


shoppingCardItem : ProductItem -> Html Msg
shoppingCardItem product =
    div [] [ text ("product" ++ String.fromInt product.id) ]


viewNoItems : Html Msg
viewNoItems =
    div []
        [ text "No products yet in shopping card"
        ]
