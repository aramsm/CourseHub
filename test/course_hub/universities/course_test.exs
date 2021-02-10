defmodule CourseHub.Universities.CourseTest do
  use CourseHub.DataCase, async: true

  alias CourseHub.Universities.Course

  setup do
    university = insert(:university)
    campus = insert(:campus, university: university)

    %{university: university, campus: campus}
  end

  describe "changeset/2" do
    test "inserts a valid changeset", %{university: university, campus: campus} do
      params =
        params_for(:course) |> Map.merge(%{university_id: university.id, campus_id: campus.id})

      assert {:ok, course} = Course.changeset(%Course{}, params) |> Repo.insert()

      assert course.id
      assert course.name == params.name
      assert course.kind == params.kind
      assert course.level == params.level
      assert course.shift == params.shift
      assert course.university_id == university.id
      assert course.campus_id == campus.id
    end

    test "is invalid without required fields" do
      changeset = Course.changeset(%Course{}, %{})

      refute changeset.valid?

      assert %{
               kind: ["can't be blank"],
               level: ["can't be blank"],
               name: ["can't be blank"],
               shift: ["can't be blank"],
               university_id: ["can't be blank"],
               campus_id: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "returns error for repeated course", %{university: university, campus: campus} do
      course = insert(:course, university: university, campus: campus)

      {:error, changeset} =
        Course.changeset(
          %Course{},
          params_for(:course, name: course.name, university: university, campus: campus)
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end

    test "returns error when university hasn't the same campus", %{campus: campus} do
      {:error, changeset} =
        Course.changeset(
          %Course{},
          params_for(:course, university_id: Ecto.UUID.generate(), campus_id: campus.id)
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{campus: ["from other university"]} = errors_on(changeset)
    end
  end
end
