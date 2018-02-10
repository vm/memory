defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      # game = Memory.GameBackup.load(name) || Game.new()
      game = Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => game}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("reset", _, socket) do
    game = Game.new()
    {:reply, {:ok, %{ "game" => game}}, socket}
  end

  def handle_in("guess", %{"letter" => ll}, socket) do
    game = Game.guess(socket.assigns[:game], ll)
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
