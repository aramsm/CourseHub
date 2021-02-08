defmodule CourseHubWeb.Guardian do
  use Guardian, otp_app: :course_hub

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = CourseHub.Accounts.get_account(%{id: id})
    {:ok, resource}
  end
end
