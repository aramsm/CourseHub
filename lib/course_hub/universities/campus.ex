defmodule CourseHub.Universities.Campus do
  use CourseHub, :schema

  alias CourseHub.Universities.{Course, University}

  @type t :: %__MODULE__{name: String.t(), city: String.t(), university_id: binary()}

  schema "campi" do
    field(:city, :string)
    field(:name, :string)

    belongs_to(:university, University)

    many_to_many(
      :courses,
      Course,
      join_through: "campi_courses",
      on_replace: :delete
    )

    timestamps()
  end

  @required_fields ~w(city name university_id)a
  @all_fields @required_fields

  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:university_id)
    |> unique_constraint(:name)
  end
end
