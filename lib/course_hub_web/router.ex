defmodule CourseHubWeb.Router do
  use CourseHubWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated_account do
    plug :accepts, ["json"]
    plug CourseHubWeb.AuthenticatePipeline
  end

  scope "/api/v1", CourseHubWeb do
    pipe_through :api

    post("/sign_in", Accounts.AccountController, :sign_in)
  end

  scope "/api/v1", CourseHubWeb do
    pipe_through :authenticated_account

    get("/courses", Universities.CourseController, :get_courses)
    get("/offers", Financials.OfferController, :get_offers)
  end
end
