defmodule Exercise.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :platform_id, :string
      add :name, :string
      add :price, :integer
    end
  end
end
