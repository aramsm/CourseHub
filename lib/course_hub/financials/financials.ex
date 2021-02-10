defmodule CourseHub.Financials do
  use CourseHub, :context

  alias CourseHub.Financials.Offer
  alias CourseHub.Queries.{FilterBy, OrderBy}

  @spec get_offer(id :: binary) :: Offer.t()
  def get_offer(id) when is_binary(id) do
    Repo.get(Offer, id)
  end

  @spec get_offers(params :: map()) :: List.t()
  def get_offers(params \\ %{}) do
    limit = Map.get(params, "limit", 10)
    offset = Map.get(params, "offset", 0)

    Offer
    |> join(:inner, [schema], u in assoc(schema, :university))
    |> join(:inner, [schema, u], ca in assoc(schema, :campus))
    |> join(:inner, [schema, u, ca], c in assoc(schema, :course))
    |> FilterBy.filter_by(:offers, params)
    |> OrderBy.order_by(params)
    |> select([schema, u, ca, c], [schema, u, ca, c])
    |> limit(^limit)
    |> offset(^offset)
    |> where(enabled: true)
    |> Repo.all()
  end

  @spec create_offer(params :: map()) :: {:ok, Offer.t()} | {:error, Ecto.Changeset.t()}
  def create_offer(params) do
    %Offer{}
    |> Offer.changeset(params)
    |> Repo.insert()
  end

  @spec update_offer(offer :: Offer.t(), params :: map()) ::
          {:ok, Offer.t()} | {:error, Ecto.Changeset.t()}
  def update_offer(%Offer{} = offer, params) do
    offer
    |> Offer.changeset(params)
    |> Repo.update()
  end

  @spec delete_offer(offer :: Offer.t()) :: {:ok, Offer.t()} | {:error, Ecto.Changeset.t()}
  def delete_offer(%Offer{} = offer) do
    offer
    |> Offer.changeset()
    |> Repo.delete()
  end
end
