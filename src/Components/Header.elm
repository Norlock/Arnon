module Components.Header exposing (header)
import Html exposing (..)
import Html.Attributes exposing (..)
import Tuple exposing (first, second)
import Html.Events exposing (onInput)
import Types exposing (..)

navbar : List (String, String) -> Html Msg
navbar tabs =
    tabs 
      |> List.map
        (\tuple ->
          li [] 
          [ a 
            [ href (second tuple), class "navbar-item" ] [ text (first tuple) 
            ]
          ]
        )
      |> ul [ class "navbar-list" ]

header :  Html Msg
header = 
  div [ class "header" ] 
      [ h1 [] [text "Fashion store"]
      , div [ class "navbar" ]
        [ navbar [("Home", "/"), ("Fashion", "/"), ("Discount", "/"), ("Contact", "/")] 
        , div [ class "search" ] 
          [ input [ type_ "text"
                  , placeholder "search for a product"
                  , onInput (ForProductList << Filter) ] []
          ]
        , span [ class "login-container" ] [ text "login" ]
        ]
      ]

