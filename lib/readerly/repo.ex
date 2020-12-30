defmodule Readerly.Repo do
  use Ecto.Repo,
    otp_app: :readerly,
    adapter: Ecto.Adapters.Postgres
end
