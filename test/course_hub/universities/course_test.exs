defmodule CourseHub.Universities.CourseTest do
  use CourseHub.DataCase, async: true

  alias CourseHub.Universities.Course

  setup do
    university = insert(:university)

    %{university: university}
  end

  describe "changeset/2" do
    test "inserts a valid changeset", %{university: university} do
      params = params_for(:course, university_id: university.id)

      assert {:ok, course} = Course.changeset(%Course{}, params) |> Repo.insert()

      assert course.id
      assert course.name == params.name
      assert course.kind == params.kind
      assert course.level == params.level
      assert course.shift == params.shift
      assert course.university_id == university.id
    end

    test "is invalid without required fields" do
      changeset = Course.changeset(%Course{}, %{})

      refute changeset.valid?

      assert %{
               kind: ["can't be blank"],
               level: ["can't be blank"],
               name: ["can't be blank"],
               shift: ["can't be blank"],
               university_id: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "returns error for repeated course", %{university: university} do
      course = insert(:course, university: university)

      {:error, changeset} =
        Course.changeset(
          %Course{},
          params_for(:course, name: course.name, university: university)
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end

    test "returns error for fake university" do
      {:error, changeset} =
        Course.changeset(%Course{}, params_for(:course, university_id: Ecto.UUID.generate()))
        |> Repo.insert()

      refute changeset.valid?
      assert %{university_id: ["does not exist"]} = errors_on(changeset)
    end
  end
end
