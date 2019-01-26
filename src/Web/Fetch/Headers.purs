module Web.Fetch.Headers
  ( Headers, Key, Value, new, new'
  , append, set, delete, get, has, entries, keys, values
  ) where

import Data.Tuple.Native (T2)
import Data.Nullable (Nullable, toMaybe)
import Data.Iterable (Iterator)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, runEffectFn1, runEffectFn2, runEffectFn3)


foreign import data Headers :: Type
type Key = String
type Value = String


foreign import newImpl :: forall a. EffectFn1 a Headers

new :: Object Value -> Effect Headers
new = runEffectFn1 newImpl

new' :: Array (T2 Key Value) -> Effect Headers
new' = runEffectFn1 newImpl

foreign import appendImpl :: EffectFn3 Headers Key Value Unit
foreign import setImpl :: EffectFn3 Headers Key Value Unit
foreign import deleteImpl :: EffectFn2 Headers Key Unit
foreign import getImpl :: EffectFn2 Headers Key (Nullable Value)
foreign import hasImpl :: EffectFn2 Headers Key Boolean
foreign import entriesImpl :: EffectFn1 Headers (Iterator (T2 Key Value))
foreign import keysImpl :: EffectFn1 Headers (Iterator Key)
foreign import valuesImpl :: EffectFn1 Headers (Iterator Value)

append :: Headers -> Key -> Value -> Effect Unit
append = runEffectFn3 appendImpl
set :: Headers -> Key -> Value -> Effect Unit
set = runEffectFn3 setImpl
delete :: Headers -> Key -> Effect Unit
delete = runEffectFn2 deleteImpl
get :: Headers -> Key -> Effect (Maybe Value)
get h k = toMaybe <$> runEffectFn2 getImpl h k
has :: Headers -> Key -> Effect Boolean
has = runEffectFn2 hasImpl
entries :: Headers -> Effect (Iterator (T2 Key Value))
entries = runEffectFn1 entriesImpl
keys :: Headers -> Effect (Iterator Key)
keys = runEffectFn1 keysImpl
values :: Headers -> Effect (Iterator Value)
values = runEffectFn1 valuesImpl

