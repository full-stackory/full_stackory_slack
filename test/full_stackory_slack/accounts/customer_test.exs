defmodule FullStackorySlack.Accounts.CustomerTest do
  use FullStackorySlack.DataCase
  alias FullStackorySlack.Accounts.Customer

  @valid %{email: "uniq@gmail.com", stripe_id: "123"}
  @invalid %{}

  test "valid changeset" do
    assert Customer.changeset(%Customer{}, @valid).valid?
  end

  test "invalid changeset" do
    cs = Customer.changeset(%Customer{}, @invalid)
    refute cs.valid?

    assert cs.errors[:email] == {"can't be blank", [validation: :required]}
    assert cs.errors[:stripe_id] == {"can't be blank", [validation: :required]}
  end
end
