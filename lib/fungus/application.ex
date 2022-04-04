defmodule Fungus.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Fungus.Runner.DynamicSupervisor, []}
    ]

    opts = [strategy: :one_for_one, name: Fungus.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
