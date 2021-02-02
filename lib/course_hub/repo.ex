defmodule CourseHub.Repo do
  use Ecto.Repo,
    otp_app: :course_hub,
    adapter: Ecto.Adapters.Postgres
end
