defmodule Readerly.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end

  def oauth_changeset(struct, params) do
    params2 =
      Enum.reduce(params, %{}, fn {k, v}, acc ->
        if is_atom(k) do
          Map.put(acc, k, v)
        else
          acc
        end
      end)

    struct
    |> cast(params2, [:email, :first_name, :last_name])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
