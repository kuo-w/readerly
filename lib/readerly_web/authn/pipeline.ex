defmodule ReaderlyWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :readerly,
    error_handler: ReaderlyWeb.Authentication.ErrorHandler,
    module: ReaderlyWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
