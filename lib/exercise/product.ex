defmodule Exercise.Product do
  use Ecto.Schema
  # import Ecto
  import Ecto.Changeset
  # import Ecto.Query

  schema "product" do
    field :platform_id, :string
    field :name, :string
    field :price, :integer
  end

  @default_fields [
    :id,
  ]

  @required_fields [
    :name,
  ]
  def changeset(product, attrs) do
    product
    |> cast(attrs, __MODULE__.__schema__(:fields) -- @default_fields)
    |> validate_required(@required_fields)
  end

end
