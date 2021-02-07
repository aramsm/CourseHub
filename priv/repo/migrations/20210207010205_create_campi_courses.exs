defmodule CourseHub.Repo.Migrations.CreateCampiCourses do
  use Ecto.Migration

  def change do
    create(table(:campi_courses, primary_key: false)) do
      add(:id, :binary_id, primary_key: true)
      add(:campus_id, references(:campi, on_delete: :delete_all, type: :binary_id))
      add(:course_id, references(:courses, on_delete: :delete_all, type: :binary_id))

      timestamps()
    end

    create(index(:campi_courses, :campus_id))
    create(index(:campi_courses, :courses_id))
    create(unique_index(:campi_courses, [:campus_id, :courses_id]))
  end
end
