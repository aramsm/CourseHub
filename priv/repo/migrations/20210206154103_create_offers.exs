defmodule CourseHub.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create(table(:offers, primary_key: false)) do
      add(:id, :binary_id, primary_key: true)
      add(:full_price, :float, null: false)
      add(:price_with_discount, :float, null: false)
      add(:discount_percentage, :float, null: false)
      add(:start_date, :string, null: false)
      add(:enrollment_semester, :string, null: false)
      add(:enabled, :boolean, null: false)
      add(:course_id, references(:courses, on_delete: :delete_all, type: :binary_id))

      timestamps()
    end

    create(index(:offers, :courses_id))
  end
end
