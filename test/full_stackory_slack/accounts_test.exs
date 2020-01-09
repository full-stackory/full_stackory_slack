defmodule FullStackorySlack.AccountsTest do
  use FullStackorySlack.DataCase
  alias FullStackorySlack.Accounts

  @valid %{email: "unique@gmail.com", stripe_id: "asd"}
  @invalid %{}

  test "successfully creates a customer" do
    {:ok, customer} = Accounts.create_customer(@valid)
    assert customer.email == @valid.email
    assert customer.stripe_id == @valid.stripe_id
  end

  test "does not successfully create a customer" do
    {:error, changeset} = Accounts.create_customer(@invalid)
    assert is_list(changeset.errors)
  end
end
