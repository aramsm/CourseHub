defmodule CourseHubWeb.Universities.CourseView do
  use CourseHubWeb, :view

  def render("courses.json", %{results: results}) do
    %{
      status: :ok,
      data:
        Enum.map(results, fn r ->
          [c, u, campus] = r

          %{
            name: c.name,
            kind: c.kind,
            level: c.level,
            shift: c.shift,
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
