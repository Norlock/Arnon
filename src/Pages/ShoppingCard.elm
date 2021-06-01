module Pages.ShoppingCard exposing (..)

import Browser
import Dict exposing (Dict)
import Html exposing (..)
import Types exposing (..)


update : Dict Id ShoppingCardItem -> ShoppingCardItem -> Dict Id ShoppingCardItem
update dict new =
    --Dict.update new.id
    --(Maybe.map (\item -> updateItem item))
    dict



--updateItem : Maybe ShoppingCardItem -> ShoppingCardItem -> ShoppingCardItem
--updateItem maybe new =
--case maybe of
--Just item ->
--{ item | quantity = item.quantity + new.quantity }
--Nothing ->
--new


document : Model -> Browser.Document Msg
document state =
    { title = "Arnon shop framework"
    , body = [ view state ]
    }


view : Model -> Html Msg
view model =
    if Dict.isEmpty model.shoppingCard then
        viewNoItems

    else
        div [] []



--viewItems : Model -> Html Msg
--viewItems model =
--model.shoppingCard
--|> Dict.map shoppingCardItem
--|> div []


shoppingCardItem : Int -> ShoppingCardItem -> Html Msg
shoppingCardItem _ product =
    div [] [ text ("product" ++ String.fromInt product.id) ]


viewNoItems : Html Msg
viewNoItems =
    div []
        [ text "No products yet in shopping card"
        ]
