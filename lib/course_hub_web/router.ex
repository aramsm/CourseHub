defmodule CourseHubWeb.Router do
  use CourseHubWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CourseHubWeb do
    pipe_through :api
  end
end
