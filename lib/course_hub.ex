defmodule CourseHub do
  @moduledoc """
  CourseHub keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def context do
    quote do
      alias CourseHub.Repo

      import Ecto.Query
    end
  end


  def schema do
    quote do
      alias CourseHub.Repo
      alias Ecto.Changeset

      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :naive_datetime_usec]

      # Specs

      @type changeset_data ::
              Ecto.Schema.t()
              | Ecto.Changeset.t()
              | {Ecto.Changeset.data(), Ecto.Changeset.types()}
      @type changeset_params :: %{binary => term} | %{atom => term} | :invalid
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
