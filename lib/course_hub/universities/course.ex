defmodule CourseHub.Universities.Course do
  use CourseHub, :schema

  alias CourseHub.Universities.{Campus, University}

  @type t :: %__MODULE__{
          name: String.t(),
          kind: String.t(),
          level: String.t(),
          shift: String.t(),
          university_id: binary()
        }

  schema "courses" do
    field(:name, :string)
    field(:kind, :string)
    field(:level, :string)
    field(:shift, :string)

    belongs_to(:university, University)

    many_to_many(
      :campi,
      Campus,
      join_through: "campi_courses",
      on_replace: :delete
    )

    timestamps()
  end

  @required_fields ~w(kind level name shift university_id)a
  @all_fields @required_fields

  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:university_id)
    |> unique_constraint(:name, name: :courses_name_university_id_index)
  end
end
