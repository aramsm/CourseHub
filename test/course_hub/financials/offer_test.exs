defmodule CourseHub.Financials.OfferTest do
  use CourseHub.DataCase, async: true

  alias CourseHub.Financials.Offer

  setup do
    university = insert(:university)
    campus = insert(:campus, university: university)
    course = insert(:course, campus: campus, university: university)

    %{course: course}
  end

  describe "changeset/2" do
    test "inserts a valid changeset", %{course: course} do
      params = params_for(:offer, course_id: course.id)

      assert {:ok, offer} = Offer.changeset(%Offer{}, params) |> Repo.insert()

      assert offer.id
      assert offer.full_price == params.full_price
      assert offer.price_with_discount == params.price_with_discount
      assert offer.discount_percentage == params.discount_percentage
      assert offer.start_date == params.start_date
      assert offer.enrollment_semester == params.enrollment_semester
      assert offer.enabled == params.enabled
      assert offer.course_id == course.id
    end

    test "is invalid without required fields" do
      changeset = Offer.changeset(%Offer{}, %{})

      refute changeset.valid?

      assert %{
               course_id: ["can't be blank"],
               discount_percentage: ["can't be blank"],
               enabled: ["can't be blank"],
               enrollment_semester: ["can't be blank"],
               full_price: ["can't be blank"],
               price_with_discount: ["can't be blank"],
               start_date: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "returns error with fake course" do
      {:error, changeset} =
        Offer.changeset(
          %Offer{},
          params_for(:offer, course_id: Ecto.UUID.generate())
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{course_id: ["does not exist"]} = errors_on(changeset)
    end
  end
end
