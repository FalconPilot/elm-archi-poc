import Browser

-- Local imports
import Model exposing (init, Model, Msg)
import View exposing (view)
import Update exposing (update)

-- Main application
main =
  Browser.sandbox
    { init = init
    , update = update
    , view = view
    }