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
    belongs_to(:campus, Campus)

    timestamps()
  end

  @required_fields ~w(kind level name shift university_id campus_id)a
  @all_fields @required_fields

  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:campus_id)
    |> foreign_key_constraint(:university_id)
    |> unique_constraint(:name, name: :courses_name_university_id_index)
    |> validate_campus()
  end

  defp validate_campus(%{valid?: false} = changeset), do: changeset

  defp validate_campus(changeset) do
    with_changes = changeset |> apply_changes()
    campus = with_changes |> Repo.preload(:campus) |> Map.get(:campus)

    if not is_nil(campus) and campus.university_id == with_changes.university_id do
      changeset
    else
      add_error(changeset, :campus, "from other university")
    end
  end
end
