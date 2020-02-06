defmodule FullStackorySlack.Repo.Migrations.AddFieldsToCustomer do
  use Ecto.Migration
  alias FullStackorySlack.Accounts.Customer

  def change do
    Customer.StatusEnum.create_type()

    alter table(:customers) do
      add :marked_for_deletion, :boolean, default: false
      add :status, Customer.StatusEnum.type(), default: "registered"
    end
  end
end
