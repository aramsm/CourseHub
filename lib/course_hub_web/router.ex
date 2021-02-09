defmodule CourseHubWeb.Router do
  use CourseHubWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", CourseHubWeb do
    pipe_through :api

    post("/sign_in", Accounts.AccountController, :sign_in)
  end
end
