defmodule Readerly.Accounts do
  @moduledoc """
  Retrieve the user information from an auth request
  """
  require Logger

  alias Ueberauth.Auth
  alias Readerly.{User, Repo}

  def find_or_create(%Auth{info: %{email: email}} = params) do
    if account = get_by_email(email) do
      {:ok, account}
    else
      register(params)
    end
  end

  def get_account(id) do
    Repo.get(User, id)
  end

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def register(%Auth{} = params) do
    %User{}
    |> User.oauth_changeset(extract_account_params(params))
    |> Repo.insert()
  end

  defp extract_account_params(%{credentials: %{other: other}, info: info}) do
    info
    |> Map.from_struct()
    |> Map.merge(other)
  end
end
