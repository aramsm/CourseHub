# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :course_hub,
  ecto_repos: [CourseHub.Repo]

# Configures the endpoint
config :course_hub, CourseHubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a6GpY8G24olabrwNgz/e2/A1JizFc+fgaTLPKEuMZ8WtJNeoclLt8VF6PREmUcgh",
  render_errors: [view: CourseHubWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CourseHub.PubSub,
  live_view: [signing_salt: "TvVZ3tna"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :course_hub, CourseHubWeb.Guardian,
  issuer: "course_hub",
  secret_key: "gk6yiGTRDHbfXFVL7aXCbtIZ1s3D5EtOgE3aB6Z6L02xnzCdkC40irwcsH/WJ0jl"

config :course_hub, CourseHubWeb.AuthenticatePipeline,
  module: CourseHubWeb.Guardian,
  error_handler: CourseHubWeb.AuthErrorHandler
