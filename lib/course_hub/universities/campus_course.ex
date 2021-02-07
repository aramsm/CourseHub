defmodule CourseHub.Universities.CampusCourse do
  use CourseHub, :schema

  alias CourseHub.Universities.{Course, Campus}

  @type t :: %__MODULE__{campus_id: binary(), course_id: binary()}

  schema "campi_courses" do
    belongs_to(:campus, Campus)
    belongs_to(:course, Course)

    timestamps()
  end

  @required_fields ~w(campus_id course_id)a
  @all_fields @required_fields

  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:campus_id)
    |> foreign_key_constraint(:course_id)
    |> unique_constraint(:campus_id, name: :campus_id_course_id_index)
  end
end
