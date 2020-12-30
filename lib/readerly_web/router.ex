defmodule ReaderlyWeb.Router do
  use ReaderlyWeb, :router
  require Ueberauth

  pipeline :guardian do
    plug ReaderlyWeb.Authentication.Pipeline
  end

  pipeline :browser_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ReaderlyWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", ReaderlyWeb do
    pipe_through [:browser, :guardian]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/", ReaderlyWeb do
    pipe_through :browser

    live "/", PageLive, :index

    get "/logout", AuthController, :logout
  end

  scope "/profile", ReaderlyWeb do
    pipe_through [:browser, :guardian, :browser_auth]

    live "/", ProfileLive, :index
  end

  scope "/hide", ReaderlyWeb do
    pipe_through [:browser, :guardian, :browser_auth]

    live "/", ProfileLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReaderlyWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ReaderlyWeb.Telemetry
    end
  end
end
