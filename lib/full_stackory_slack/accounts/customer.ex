defmodule FullStackorySlack.Accounts.Customer do
  @moduledoc """
  Module defining the customer schema. 
  """

  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum
  defenum(StatusEnum, :status, [:registered, :active, :inactive])

  schema "customers" do
    field :description, :string
    field :email, :string
    field :name, :string
    field :stripe_id, :string
    field :status, StatusEnum
    field :marked_for_deletion, :boolean

    timestamps()
  end

  @doc false
  @spec changeset(map, map) :: term()
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :stripe_id, :name, :description])
    |> validate_required([:email, :stripe_id])
    |> unique_constraint(:email)
    |> unique_constraint(:stripe_id)
  end

  @doc false
  @spec mark_for_deletion_changeset(map, map) :: term()
  def mark_for_deletion_changeset(customer, attrs) do
    customer
    |> cast(attrs, [:marked_for_deletion])
    |> validate_required([:marked_for_deletion])
  end
end
