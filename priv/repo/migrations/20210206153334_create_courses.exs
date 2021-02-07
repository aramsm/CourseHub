defmodule CourseHub.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create(table(:courses, primary_key: false)) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:kind, :string, null: false)
      add(:level, :string, null: false)
      add(:shift, :string, null: false)
      add(:university_id, references(:universities, on_delete: :delete_all, type: :binary_id))

      timestamps()
    end

    create(index(:courses, :universtity_id))
    create(unique_index(:courses, [:name, :university_id]))
  end
end
