defmodule CourseHubWeb.Financials.OfferController do
  use CourseHubWeb, :controller

  alias CourseHub.Financials

  def get_offers(conn, params) do
    results = Financials.get_offers(params)

    conn
    |> put_status(200)
    |> render("offers.json", %{results: results})
  end
end
