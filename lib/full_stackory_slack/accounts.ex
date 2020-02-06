defmodule FullStackorySlack.Accounts do
  @moduledoc """
  Module defining the Accounts context.
  """

  alias FullStackorySlack.Accounts.Customer
  alias FullStackorySlack.Repo

  @type ecto_result() :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Function that inserts a customer into the database.

  ## Examples

    iex> Accounts.create_customer(%{email: "uniq@gmail.com", stripe_id: "123"})
  {:ok, %Customer{}}

    iex> Accounts.create_customer(%{})
    {:error, Ecto.Changeset}
  """
  @spec create_customer(map) :: ecto_result()
  def create_customer(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_customer(map) :: ecto_result()
  def update_customer(attrs) do
    Customer
    |> Repo.get_by(stripe_id: attrs.stripe_id)
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @spec mark_for_deletion(map) :: ecto_result()
  def mark_for_deletion(attrs) do
    Customer
    |> Repo.get_by(stripe_id: attrs.stripe_id)
    |> Customer.mark_for_deletion_changeset(%{marked_for_deletion: true})
    |> Repo.update()
  end
end
