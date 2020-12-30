# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :readerly,
  ecto_repos: [Readerly.Repo]

config :readerly, ReaderlyWeb.Authentication,
  issuer: "readerly",
  secret_key: System.get_env("READERLY_GUARDIAN_SECRET")

# Configures the endpoint
config :readerly, ReaderlyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZlWzF6LyoMxecrG/96Y0zthKU1thDvkAXEun7AI2fRKtKPdIECqmhFVIaQ7ISCU8",
  render_errors: [view: ReaderlyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Readerly.PubSub,
  live_view: [signing_salt: "+gTi6PE2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Configures Ueberauth
config :ueberauth, Ueberauth,
  providers: [
    auth0: {Ueberauth.Strategy.Auth0, []}
  ]

# Configures Ueberauth's Auth0 auth provider
config :ueberauth, Ueberauth.Strategy.Auth0.OAuth,
  domain: System.get_env("AUTH0_DOMAIN"),
  client_id: System.get_env("AUTH0_CLIENT_ID"),
  client_secret: System.get_env("AUTH0_CLIENT_SECRET")
