defmodule CourseHubWeb.Financials.OfferView do
  use CourseHubWeb, :view

  def render("offers.json", %{results: results}) do
    %{
      status: :ok,
      data:
        Enum.map(results, fn r ->
          [o, u, campus, c] = r

          %{
            full_price: o.full_price,
            price_with_discount: o.price_with_discount,
            discount_percentage: o.discount_percentage,
            start_date: o.start_date,
            enrollment_semester: o.enrollment_semester,
            enabled: o.enabled,
            course: %{
              name: c.name,
              kind: c.kind,
              level: c.level,
              shift: c.shift
            },
            university: %{
              name: u.name,
              score: u.score,
              logo_url: u.logo_url
            },
            campus: %{
              name: campus.name,
              city: campus.city
            }
          }
        end)
    }
  end
end
