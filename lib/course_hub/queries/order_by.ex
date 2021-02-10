defmodule CourseHub.Queries.OrderBy do
  require Ecto.Query

  @doc """
  Orders a query using a map with the orientation (asc or desc) and the field.
  Ignores the call if no

  Example:

    iex> CourseHub.Queries.OrderBy.order_by(offers_query, %{"asc" => "price_with_discount"})
    [%Offer{price_with_discount: 1, ...}, %Offer{price_with_discount: 2, ...}]

  """
  def order_by(queryable, %{"asc" => "price_with_discount"}) do
    queryable
    |> Ecto.Query.order_by(asc: :price_with_discount)
  end

  def order_by(queryable, %{"desc" => "price_with_discount"}) do
    queryable
    |> Ecto.Query.order_by(desc: :price_with_discount)
  end

  def order_by(queryable, _), do: queryable
end
