defmodule CourseHubWeb.Universities.CourseController do
  use CourseHubWeb, :controller

  alias CourseHub.Universities

  def get_courses(conn, params) do
    results = Universities.get_courses(params)
    params |> IO.inspect()

    conn
    |> put_status(200)
    |> render("courses.json", %{results: results})
  end
end
