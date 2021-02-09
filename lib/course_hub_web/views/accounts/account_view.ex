defmodule CourseHubWeb.Accounts.AccountView do
  use CourseHubWeb, :view

  def render("sign_in.json", %{account: account, token: token}) do
    %{
      status: :ok,
      data: %{name: account.name, token: token}
    }
  end
end
