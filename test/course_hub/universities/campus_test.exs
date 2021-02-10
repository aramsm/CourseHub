defmodule CourseHub.Universities.CampusTest do
  use CourseHub.DataCase, async: true

  alias CourseHub.Universities.Campus

  setup do
    university = insert(:university)

    %{university: university}
  end

  describe "changeset/2" do
    test "inserts a valid changeset", %{university: university} do
      params = params_for(:campus, university_id: university.id)

      assert {:ok, campus} = Campus.changeset(%Campus{}, params) |> Repo.insert()

      assert campus.id
      assert campus.name == params.name
      assert campus.city == params.city
      assert campus.university_id == university.id
    end

    test "is invalid without required fields" do
      changeset = Campus.changeset(%Campus{}, %{})

      refute changeset.valid?

      assert %{
               name: ["can't be blank"],
               university_id: ["can't be blank"],
               city: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "returns error for repeated campus", %{university: university} do
      campus = insert(:campus, university: university)

      {:error, changeset} =
        Campus.changeset(
          %Campus{},
          params_for(:campus, name: campus.name, university: university)
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end

    test "returns error for fake university" do
      {:error, changeset} =
        Campus.changeset(%Campus{}, params_for(:campus, university_id: Ecto.UUID.generate()))
        |> Repo.insert()

      refute changeset.valid?
      assert %{university_id: ["does not exist"]} = errors_on(changeset)
    end
  end
end
