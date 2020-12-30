defmodule ReaderlyWeb.Authentication do
  use Guardian, otp_app: :readerly
  alias Readerly.{Accounts}

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    IO.puts("ID")
    IO.inspect(id)

    case Accounts.get_account(id) do
      nil -> {:error, :resource_not_found}
      account -> {:ok, account}
    end
  end

  def get_current_account(conn) do
    __MODULE__.Plug.current_resource(conn)
  end

  def log_in(conn, account) do
    IO.puts("LOGIN")
    IO.inspect(account)

    __MODULE__.Plug.sign_in(conn, account)
  end
end
