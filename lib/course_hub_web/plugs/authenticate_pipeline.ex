defmodule CourseHubWeb.AuthenticatePipeline do
  use Guardian.Plug.Pipeline, otp_app: :course_hub

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
