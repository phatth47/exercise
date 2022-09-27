defmodule Exercise do
  use Tesla
  require Ecto.Query
  require Ecto.Changeset

  alias Exercise.Repo
  alias Exercise.Product

  plug(Tesla.Middleware.BaseUrl, "https://shopee.vn/api/v4")
  plug(Tesla.Middleware.Headers, [{"authority", "shopee.vn"}])
  plug(Tesla.Middleware.JSON)

  def get_product_list do
    {:ok, response} =
      get("recommend/recommend",
        query: [
          bundle: "shop_page_category_tab_main",
          item_card: 2,
          limit: 30,
          offset: 0,
          section: "shop_page_category_tab_main_sec",
          shopid: "88201679",
          sort_type: 1,
          tab_name: "popular"
        ]
      )

    res =
      Enum.map(
        response.body["data"]["sections"],
        &render_item/1
      )

    res |> List.flatten()
  end

  defp render_item(%{"data" => %{"item" => item}}) do
    Enum.map(item, fn i ->
      # map_item(i)
      save_item(i)
    end)
  end

  def map_item(item) do
    %{
      "itemId" => item["itemid"],
      "name" => item["name"],
      "price" => item["price"],
      "discount" => item["discount"],
      "stock" => item["stock"]
    }
  end

  def drawl_data do
    product_list = get_product_list()

    # json = %{
    #   "crawl_at" => DateTime.now!("Etc/UTC") |> DateTime.to_string() |> String.slice(0..-9),
    #   "total" => Enum.count(product_list),
    #   "produts" => product_list
    # }

    # content = Jason.encode!(json)

    # res =
    #   case File.write("data.json", content) do
    #     :ok ->
    #       "data.json"

    #     _ ->
    #       nil
    #       # {:error, reason} -> false
    #   end

    # res
  end

  def save_item(item) do
    product = %Product{
      platform_id: to_string(item["itemid"]),
      name: item["name"],
      price: item["price"]
    }

    Repo.insert(product)
  end

  def save do
    person = %Product{platform_id: "1", name: "abc", price: 1000}

    Repo.insert(person)
  end

  def get_product do
    # Exercise.Product |> Ecto.Query.first |> Exercise.Repo.one
    # Exercise.Product |> Exercise.Repo.get_by(id: 29) # -> element
    # Exercise.Product |> Ecto.Query.where(id: 29) |> Exercise.Repo.all # -> list
    Ecto.Query.from(p in Product, where: p.id == 29) |> Repo.all()
  end

  def update_product do
    product = Product |> Repo.get_by(id: 29)
    change = Product.changeset(product, %{name: "Apple AirPods with Charging Case 2nd"})
    Repo.update(change)
  end

  def delete_product do
    product = Repo.get(Product, 55)
    Repo.delete(product)
  end

  def get_all_product, do: Product |> Repo.all

end
