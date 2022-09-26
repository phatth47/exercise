defmodule ExerciseWeb.PageController do
  use ExerciseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
