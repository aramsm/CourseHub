defmodule CourseHub.Repo.Migrations.CreateCampi do
  use Ecto.Migration

  def change do
    create(table(:campi, primary_key: false)) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:city, :string, null: false)
      add(:university_id, references(:universities, on_delete: :delete_all, type: :binary_id))

      timestamps()
    end

    create(index(:campi, :university_id))
    create(unique_index(:campi, :name))
  end
end
