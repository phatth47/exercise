defmodule Exercise.Repo do
  use Ecto.Repo,
    otp_app: :exercise,
    adapter: Ecto.Adapters.Postgres
end
