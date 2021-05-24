module Components.Footer exposing (..)
import Html exposing (..)
import Types exposing (Msg)
import Html.Attributes exposing (..)
import Tuple exposing (first, second)

infobar : List (String, String) -> Html Msg
infobar tabs =
    tabs 
      |> List.map
        (\tuple ->
          li [] 
          [ a 
            [ href (second tuple), class "infobar-item" ] [ text (first tuple) 
            ]
          ]
        )
      |> ul [ class "infobar-list" ]

footer :  Html Msg
footer = 
  Html.footer 
    [ class "footer" ] 
    [ infobar [("Terms and Conditions", "/"), ("Privacy", "/"), ("Cookies", "/")] 
    ]
