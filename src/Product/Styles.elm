module Product.Styles exposing (..)
import Styles exposing (AttrList)
import Html.Attributes exposing (style)

container : AttrList msg -> AttrList msg
container list =
      [ style "border-radius" "5px"
      , style "display" "flex"
      , style "background-color" "#e2e2f2"
      , style "padding" "20px"
      ] ++ list

left : AttrList msg -> AttrList msg
left list =
      [ style "display" "flex"
      , style "flex-direction" "column"
      , style "padding" "20px"
      ] ++ list

right : AttrList msg -> AttrList msg
right list =
      [ style "display" "flex"
      , style "flex-direction" "column"
      , style "padding" "20px"
      ] ++ list
