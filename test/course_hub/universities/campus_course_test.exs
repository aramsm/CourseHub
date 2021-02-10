defmodule CourseHub.Universities.CampusCourseTest do
  use CourseHub.DataCase, async: true

  alias CourseHub.Universities.CampusCourse

  setup do
    campus = insert(:campus)
    course = insert(:course)

    %{campus: campus, course: course}
  end

  describe "changeset/2" do
    test "inserts a valid changeset", %{campus: campus, course: course} do
      params = params_for(:campus_course, campus: campus, course: course)

      assert {:ok, campus_course} =
               CampusCourse.changeset(%CampusCourse{}, params) |> Repo.insert()

      assert campus_course.id

      assert campus.id ==
               course |> Repo.preload(:campi) |> Map.get(:campi) |> hd() |> Map.get(:id)

      assert course.id ==
               campus |> Repo.preload(:courses) |> Map.get(:courses) |> hd() |> Map.get(:id)
    end

    test "is invalid without required fields" do
      changeset = CampusCourse.changeset(%CampusCourse{}, %{})

      refute changeset.valid?

      assert %{
               campus_id: ["can't be blank"],
               course_id: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "returns error for repeated course", %{campus: campus, course: course} do
      insert(:campus_course, campus: campus, course: course)

      {:error, changeset} =
        CampusCourse.changeset(
          %CampusCourse{},
          params_for(:campus_course, campus: campus, course: course)
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{course_id: ["has already been taken"]} = errors_on(changeset)
    end

    test "returns error for fake campus", %{course: course} do
      {:error, changeset} =
        CampusCourse.changeset(
          %CampusCourse{},
          params_for(:campus_course, campus_id: Ecto.UUID.generate(), course: course)
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{campus_id: ["does not exist"]} = errors_on(changeset)
    end

    test "returns error for fake course", %{campus: campus} do
      {:error, changeset} =
        CampusCourse.changeset(
          %CampusCourse{},
          params_for(:campus_course, campus: campus, course_id: Ecto.UUID.generate())
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{course_id: ["does not exist"]} = errors_on(changeset)
    end
  end
end
