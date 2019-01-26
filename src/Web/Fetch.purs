module Web.Fetch where

foreign import fetchImpl :: forall a. Fn1 a (Promise Response)

type Url = String

fetch :: Url -> Aff Response

fetch' :: Request -> Aff Response

