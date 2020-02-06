defmodule FullStackorySlack.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :email, :string
      add :stripe_id, :string
      add :name, :string
      add :description, :text

      timestamps()
    end

    create unique_index(:customers, [:email])
    create unique_index(:customers, [:stripe_id])
  end
end
