defmodule RclexMini.Nif do
  @on_load {:load_nif, 0}

  def load_nif() do
    nif_binary = Application.app_dir(:rclex_mini, "priv/rclex_mini_nif")

    :erlang.load_nif(to_charlist(nif_binary), 0)
  end

  def create_node() do
    :erlang.nif_error(:nif_not_loaded)
  end

  def hello() do
    :erlang.nif_error(:nif_not_loaded)
  end
end
