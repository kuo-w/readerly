defmodule ReaderlyWeb.ProfileLive do
  use ReaderlyWeb, :live_view

  @impl true
  def mount(_params, %{"current_user" => user}, socket) do
    {:ok, assign(socket, user: user)}
  end
end
