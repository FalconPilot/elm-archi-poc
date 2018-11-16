module Update exposing (update)

-- Imports
import Model exposing (init, Model, Msg(..), Step, FormData)

-- Application update
update: Msg -> Model -> Model
update msg model =
  let
    oldForm: FormData
    oldForm = model.formData
  in
    case msg of
      SetName name ->
        { model | steps = nextStep model.steps, formData = { oldForm | name = Just name } }
      
      SetAge age ->
        { model | steps = nextStep model.steps, formData = { oldForm | age = Just age } }
      
      NextStep ->
        { model | steps = nextStep model.steps }

-- Next step
nextStep: List (Maybe Step) -> List (Maybe Step)
nextStep =
  List.drop 1
