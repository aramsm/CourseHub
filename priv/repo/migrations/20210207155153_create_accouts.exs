defmodule CourseHub.Repo.Migrations.CreateAccouts do
  use Ecto.Migration

  def change do
    create table(:accouts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:email, :string, null: false)
      add(:password_hash, :string, null: false)

      timestamps()
    end
  end
end