defmodule Fungus.Runner do
  @moduledoc """
  In charge to run external commands in the safest way.
  """

  require Logger
  # We don’t want to restart a failed run
  use GenServer, restart: :temporary

  def start_link(args \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  # Callbacks

  @impl true
  def init(arg) do
    Port.open({:spawn, arg}, [:binary, :exit_status])

    {:ok, []}
  end

  @impl true
  def handle_info({port, {:data, line}}, state) do
    Logger.debug("got a message:")
    Logger.debug(line)

    {:noreply, state}
  end

  def handle_info({port, {:exit_status, status}}, state) do
    Logger.debug("Exit status: #{status}")

    {:stop, {:shutdown, %{status: status}}, state}
  end

  def handle_info(msg, state) do
    Logger.debug("Unsupported message: #{msg}")

    {:noreply, state}
  end
end
