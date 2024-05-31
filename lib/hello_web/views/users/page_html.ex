defmodule HelloWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use HelloWeb, :html

  embed_templates "../../templates/users/page_html/*"
end
