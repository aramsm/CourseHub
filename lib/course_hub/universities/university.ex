defmodule CourseHub.Universities.University do
  use CourseHub, :schema

  alias CourseHub.Universities.{Campus, Course}

  @type t :: %__MODULE__{name: String.t(), score: float(), logo_url: String.t()}

  schema "universities" do
    field(:name, :string)
    field(:score, :float)
    field(:logo_url, :string)

    has_many(:campi, Campus)
    has_many(:courses, Course)

    timestamps()
  end

  @required_fields ~w(name score)a
  @optional_fields ~w(logo_url)a
  @all_fields @required_fields ++ @optional_fields

  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
