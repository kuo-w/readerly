defmodule ReaderlyWeb.Authentication.ErrorHandler do
  use ReaderlyWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, "Authentication error.")
    |> redirect(to: Routes.auth_path(conn, :request, "auth0"))
  end
end
