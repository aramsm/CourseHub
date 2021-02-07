defmodule CourseHub.Repo.Migrations.CreateUniversities do
  use Ecto.Migration

  def change do
    create(table(:universities, primary_key: false)) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:score, :float, null: false)
      add(:logo_url, :string)

      timestamps()
    end

    create(unique_index(:universities, :name))
  end
end
