defmodule CourseHub.Financials.Offer do
  use CourseHub, :schema

  alias CourseHub.Universities.Course

  @type t :: %__MODULE__{
          full_price: float(),
          price_with_discount: float(),
          discount_percentage: float(),
          start_date: String.t(),
          enrollment_semester: String.t(),
          enabled: boolean(),
          course_id: binary()
        }

  schema "offers" do
    field(:full_price, :float)
    field(:price_with_discount, :float)
    field(:discount_percentage, :float)
    field(:start_date, :string)
    field(:enrollment_semester, :string)
    field(:enabled, :boolean)

    belongs_to(:course, Course)

    has_one(:university, through: [:course, :university])

    has_one(:campus, through: [:course, :campus])

    timestamps()
  end

  @required_fields ~w(enabled enrollment_semester price_with_discount discount_percentage full_price start_date course_id)a
  @all_fields @required_fields

  def changeset(%__MODULE__{} = struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:course_id)
  end
end
