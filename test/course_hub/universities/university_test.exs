defmodule CourseHub.Universities.UniversityTest do
  use CourseHub.DataCase, async: true

  alias CourseHub.Universities.University

  describe "changeset/2" do
    test "is valid" do
      params = params_for(:university)

      assert {:ok, university} = University.changeset(%University{}, params) |> Repo.insert()

      assert university.id
      assert university.name == params.name
      assert university.score == params.score
    end

    test "is invalid without required fields" do
      changeset = University.changeset(%University{}, %{})

      refute changeset.valid?

      assert %{name: ["can't be blank"], score: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error for repeated name" do
      university = insert(:university)

      {:error, changeset} =
        University.changeset(
          %University{},
          params_for(:university, name: university.name)
        )
        |> Repo.insert()

      refute changeset.valid?
      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end
  end
end
